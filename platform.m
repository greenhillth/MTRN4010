classdef platform < handle
    %UNTITLED2 Summary of this class goes here
    %   Detailed explanation goes here

    properties
        api
        menu interface
        loadedFile string
        params table
        kinematicModel function_handle
        imuReading (2, 1) double
        readTime (2, 1) double
        positionRegister (4, :) double
        lidarRegister (1, :) double
        index double
        status string

        lidarIndex uint16
        pathVector (:,:)double

    end

    methods
        function obj = platform(parameters)
            arguments
                parameters.position (3,1) double = [0; 0; 0]
                parameters.kinematicModel function_handle = @(v, phi, omega) ...
                    [v*cos(phi); v*sin(phi); omega]
                parameters.length double = 1;
                parameters.gain double {mustBePositive} = 1;
                parameters.bias double = 0;
            end
            obj.api = APImtrn4010_v02();
            obj.loadedFile = "";
            obj.status = "initialising";
            % setting params
            p = [parameters.length, parameters.gain, parameters.bias];
            obj.params = array2table(p, "VariableNames", ["length", "gain", "bias"]);
            obj.kinematicModel = parameters.kinematicModel;
            obj.imuReading = [0;0];
            obj.readTime = [0;0];

            % initialising remaining fields
            obj.positionRegister = zeros(4, 4096);
            obj.lidarRegister = zeros(1, 4096);
            obj.positionRegister(:,1) = [parameters.position; 0];
            obj.index = 1;
            obj.lidarIndex = 0;
        end

        function configureParameters(obj, parameters)
            arguments
                obj                 platform
                parameters.length   double
                parameters.gain     double
                parameters.bias     double
            end
            obj.params.length = parameters.length;
            obj.params.gain = parameters.gain;
            obj.params.bias = parameters.bias;

        end

        function loadFile(obj, dataFile)
            arguments
                obj platform
                dataFile (1, :) char
            end

            %obj.updateStatus("Loading path");
            obj.loadedFile = string(dataFile);
            obj.api.b.LoadDataFile(char("./datasets/" + obj.loadedFile));
            obj.api.b.Rst();
            %obj.updateStatus("Loaded path");
        end 

        function run(obj)
            obj.loadFile('aDataUsr_007b.mat');

            % get struct defining initial parameters (file, position) 
            envInfo = obj.api.b.GetInfo();
            initPos = envInfo.pose0;
            obj.initialiseMenu('file', obj.loadedFile, 'initPos', initPos);
            
            % grab and apply modified params
            %obj.menu.


            % set initial pose
            obj.positionRegister(:, 1) = [initPos;0];

            
            % compute cycle
            while (obj.processEvent())

            end
            obj.eventLoop;

            % interpolate DR
            DRpathData = obj.interpolatePathVectors(obj.lidarRegister);
            groundTruth = obj.api.b.GetGroundTruth();

            OOIpoints = envInfo.Context.Landmarks;

            obj.menu.loadPathData('deadReckoning', DRpathData, ...
                'groundTruth',groundTruth(1:2, :), 'ooiCoords', OOIpoints(1:2, :));
            obj.menu.startPlaybackSession();
            %obj.playbackSession();
            
            % playback session
            %obj.plotPath(obj.menu.GCFAxes);

            %  exit


        end

        function inProgress = processEvent(obj)
            
            nextEvent = obj.api.RdE;
            event = nextEvent();


            t = double(event.t)*1e-4;
            
            switch (event.ty)
                case 0  % end case
                    disp('End of event');
                    inProgress = false;
                    
                    return;
                case 1  % lidar case
                    %%TODO - implement
                    obj.updateStatus("Processing Lidar");
                    
                    obj.processLidar(event.d);
                    obj.plotJawn();
                    lidarScan = event.d;
                    lidarScans = lidarScans+1;
                    obj.lidarRegister(lidarScans) = t;
                case 2
                    obj.updateStatus("Processing IMU");
                    obj.processIMU(event);
                otherwise
                        
            end


            
            inProgress = true;
            
            
        end

        function plotJawn(obj, vecs) 
            % GCF Plot
            obj.menu.updatePathVectors(vecs, [0;0], obj.lidarIndex);
            %Lidar plot

            
        end
        
        function processLidar(obj, eventData)
            % do lidar shit
            
            
            
            % plot on interface
            obj.lidarIndex = obj.lidarIndex + 1;
            computedPos = platform.predictBalls([obj.readTime(2);event.t],...
             obj.positionRegister(1:3, obj.index), obj.imuReading, obj.kinematicModel);

            obj.plotJawn(computedPos);

            
            % update lidar time
            obj.readTime(1) = event.t;
        end

        function processIMU(obj, eventData)
            % add IMU reading to register
            imu = eventData.d;
            obj.imuReading = [
                imu(1)*obj.params.gain;
                imu(2)+obj.params.bias];

            % generate pose estimate and store in position register
            computedPos = platform.predictBalls([obj.readTime(2);event.t],...
             obj.positionRegister(1:3, obj.index), obj.imuReading, obj.kinematicModel);
            
            obj.addMeasurement(computedPos(1:4));

            % update imu read time
            obj.readTime(2) = event.t;

        end

        function f = initialiseMenu(obj, params)
            arguments
                obj platform
                params.file string = 'aDataUsr_007b.mat'
                params.initPos (3,1) double = [0;0;0]
            end
            obj.menu = interface();
            UsefulInfo = obj.api.b.GetInfo();
            Context=UsefulInfo.Context;
            
            wallsData = Context.Walls;
            obj.menu.initialise('directory', dir('datasets/*.mat'), ...
                'loadedFile', params.file, ...
                'walls', wallsData, ...
                'position', params.initPos);
            % 
            % % initialise dataset selection menu  
            % datasets = platform.getFiles('datasets/*.mat');
            % obj.menu.ActiveFileDropDown.ItemsData = datasets;
            % obj.menu.ActiveFileDropDown.Items = datasets;

            obj.menu.setActiveTab(obj.menu.ParameterControlTab);
            f = obj.menu.MTRN4010ControlCentreUIFigure;

        end
        
        function eventLoop(obj, dataFile)
            arguments
                obj platform
                dataFile (1, :) char = 'aDataUsr_007b.mat'
            end

            if ((nargin == 2) || (obj.loadedFile == "")) 
                obj.loadFile(dataFile); % load default file if none already set
            end
            
            nextEvent = obj.api.RdE;
            imu = [0;0];
            gain = obj.params.gain;
            bias = obj.params.bias;

            lidarScans = 0;
            
            for i = 1:32000      %%TODO - change (only reading 1k events)
                event = nextEvent();
                t = double(event.t)*1e-4;
                
                switch (event.ty)
                    case 0  %end case
                        disp('End of event');
                        break;
                    case 1  %% lidar case
                        %%TODO - implement
                        obj.updateStatus("Processing Lidar");
                        lidarScan = event.d;
                        lidarScans = lidarScans+1;
                        obj.lidarRegister(lidarScans) = t;
                    case 2
                        obj.updateStatus("Processing IMU");
                        imu = event.d;
                        obj.predictPose(t, imu(1)*gain, imu(2)+bias, 1);
                    otherwise
                            
                end
            end

            obj.lidarRegister = resize(obj.lidarRegister, lidarScans);

            

        end

        function predictPose(obj, time, vt, yaw, precision)
            arguments
                obj platform
                time double
                vt double
                yaw double
                precision double = 1;
            end
            t0 = obj.lastMeasuredTime;
            dt = (time - t0)/precision;
            
            if obj.index+precision > length(obj.positionRegister)
                obj.positionRegister = resize(obj.positionRegister, ...
                    [4, length(obj.positionRegister)+4096]);
            end
                
            for i = 1:precision
                X0 = obj.lastPos();
                computedVal = [X0(1:3)+dt*obj.kinematicModel(vt, X0(3), yaw);t0+dt*i];
                obj.addMeasurement(computedVal);
            end
        end

        function playbackSession(obj)
            
    
        end

        function plots = plotPath(obj, ax, plotObj, path, n)
            arguments
                obj
                ax
                plotObj
                path    (4, :) double
                n              double
            end

            delete(plotObj(1));
            plotObj(1) = platform.plotArrow(ax, path(1:3, n), 'lineWidth', 1.5);

            plotObj(3) = plot(ax, path(1,1:n),path(2,1:n),'-', LineWidth=1.5, Color=[0 204 0]/255);
            
            plots = plotObj;
        end
    end
    methods (Access = private)
        function setVisibility(obj, lines, flags)
            for i=1:length(flags)
                if(flags(i)) lines(i).LineStyle = '-';
                else lines(i).LineStyle = 'none';
                end
            end
        end
        function m = lastPos(obj)
            arguments
                obj platform
            end
            m = obj.positionRegister(:, obj.index);
        end
        function t = lastMeasuredTime(obj)
            t = obj.positionRegister(4, obj.index);
        end

        function addMeasurement(obj, measurement)
            arguments
            obj platform
            measurement (4, 1) double
            end
            obj.index = obj.index + 1;
            obj.positionRegister(:, obj.index) = measurement;
        end

        function path = getPathVectors(obj)
            path = obj.positionRegister(:, 1:obj.index);
        end

        function interpolated = interpolatePathVectors(obj, time)
            arguments
                obj platform
                time (1, :) double
            end
            % Linearly interpolate trajectory for faster and more uniform plotting
            obj.updateStatus("Interpolating data")
            data = obj.getPathVectors;
            interpolated = zeros(8, length(time)-1);
            interpolated(1:4, 1) = data(:, 1);
            i = 2;
            for N = 1:length(time)
                currentTime = time(N);
                while (data(4, i) < currentTime) 
                    i = i+1;
                    if (i > length(data))
                        interpolated = resize(interpolated, [8 N]);
                        return
                    end
                end                
                deltat = data(4, i) - data(4, i-1);
                m = (data(1:3, i) - data(1:3, i-1))./deltat;
                interpolated(:,N+1) = [ ...
                    m*(currentTime-data(4, i-1))+data(1:3, i-1);
                    currentTime; deltat; m];
            end
            interpolated = resize(interpolated, [8 N]);
        end
            function updateStatus(obj, status)
                obj.status = status;
                obj.menu.Status.Value=status;
            end
    end
    methods (Static)

        
        function computedVal = predictBalls(time, x0, imu, model, precision)
            arguments
                time (2, 1) uint32
                x0 (3, 1) double
                imu (2, 1) double
                model function_handle
                precision double = 1
            end
            time = double(time)*1e-4;
            t0 = time(1);
            dt = (time(2) - t0)/precision;
                
            for i = 1:precision
                m = model(imu(1), x0(3), imu(2));
                computedVal = [x0(1:3)+dt*m;t0+dt*i;dt*i;m];
            end
        end

        function files = getFiles(path)
            contents = dir(path);
            files = {};
            for i=1:length(contents)
                files{i} = contents(i).name;
            end
        end
    end
end
