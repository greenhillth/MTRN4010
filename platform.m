classdef platform < handle
    %UNTITLED2 Summary of this class goes here
    %   Detailed explanation goes here

    properties
        api
        menu interface
        loadedFile string
        params table
        kinematicModel function_handle
        positionRegister (4, :) double
        lidarRegister (1, :) double
        index double
        status string

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
            % setting params
            p = [parameters.length, parameters.gain, parameters.bias];
            obj.params = array2table(p, "VariableNames", ["length", "gain", "bias"]);
            obj.kinematicModel = parameters.kinematicModel;

            % initialising remaining fields
            obj.positionRegister = zeros(4, 4096);
            obj.lidarRegister = zeros(1, 4096);
            obj.positionRegister(:,1) = [parameters.position; 0];
            obj.index = 1;
            obj.status = "initialised";
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

            obj.loadedFile = "./datasets/" + string(dataFile);
            obj.api.b.LoadDataFile(char(obj.loadedFile));
            obj.api.b.Rst();
        end 

        function run(obj)
            obj.initialiseMenu;
            obj.eventLoop;
            obj.menu.Lamp4.Color = 'red';
            obj.plotPath(obj.menu.UIAxes);



        end

        function f = initialiseMenu(obj)
            obj.menu = interface();
            f = obj.menu.UIFigure;

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
                        lidarScan = event.d;
                        lidarScans = lidarScans+1;
                        obj.lidarRegister(lidarScans) = t;
                    case 2
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

        function plotPath(obj, ax)
            timeArray = obj.lidarRegister;
            path = obj.interpolatePathVectors(timeArray);
            env = obj.api.b.GetInfo();
            hold(ax, "on");
            plot(ax, env.Context.Walls(1, :), env.Context.Walls(2, :),'LineWidth', 2, 'color', [205, 127, 50]/255);
            for n = 1:length(path)
                plot(ax, path(1,1:n),path(2,1:n),'-', LineWidth=1.5, Color=[0 204 0]/255);
                if (n>1) delete(arrow); end
                arrow = platform.plotArrow(ax, path(1:3, n), 'lineWidth', 1.5);
                %plot() plot arrow and instantaneous velocity?? use
                %pol2cart - might have to modify positionRegister to
                %include velocity
                pause(0.05);
            end
            hold(ax, "off");
        end
    end
    methods (Access = private)
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
            data = obj.getPathVectors;
            interpolated = zeros(4, length(time)-1);
            interpolated(:, 1) = data(:, 1);
            i = 2;
            for N = 1:length(time)
                currentTime = time(N);
                while (data(4, i) < currentTime) 
                    i = i+1;
                    if (i > length(data))
                        interpolated = resize(interpolated, [4 N-1]);
                        return
                    end
                end                
                deltat = data(4, i) - data(4, i-1);
                m = (data(1:3, i) - data(1:3, i-1))./deltat;
                interpolated(:,N) = [ ...
                    m*(currentTime-data(4, i-1))+data(1:3, i-1);
                    currentTime];
            end
            interpolated = resize(interpolated, [4 N-1]);
            disp('balls')
        end
    end
    methods (Static)
        function arr = plotArrow(ax, coords, params)
        arguments
            ax
            coords (3,1) double
            params.scale double = 1
            params.lineWidth double = 1
            params.colour (1,3) double = [255 14 14]/255
        end
            outline = [1, -.5, -.5, 1, 0;
                       0, -.5, .5, 0, 0];
            rotation = [cos(coords(3)) -sin(coords(3)); 
                        sin(coords(3)) cos(coords(3))];
            arrow = rotation*(outline*params.scale)+coords(1:2);
            arr = plot(ax, arrow(1, :), arrow(2,:), ...
                'LineWidth', params.lineWidth, 'color', params.colour);
        end
    end
end
