classdef interface < matlab.apps.AppBase

    % Properties that correspond to app components
    properties (Access = public)
        MTRN4010ControlCentreUIFigure  matlab.ui.Figure
        TabGroup                       matlab.ui.container.TabGroup
        StatusTab                      matlab.ui.container.Tab
        StatusGridLayout               matlab.ui.container.GridLayout
        ErrorPanel                     matlab.ui.container.Panel
        ErrorAxes                      matlab.ui.control.UIAxes
        visibilityControl              matlab.ui.container.Panel
        ResetPlaybackButton            matlab.ui.control.Button
        OOIsSwitch                     matlab.ui.control.Switch
        OOIsSwitchLabel                matlab.ui.control.Label
        DeadReckoningEstimateSwitch    matlab.ui.control.Switch
        DeadReckoningEstimateLabel     matlab.ui.control.Label
        GroundTruthSwitch              matlab.ui.control.Switch
        GroundTruthSwitchLabel         matlab.ui.control.Label
        PositionIndicatorSwitch        matlab.ui.control.Switch
        PositionIndicatorSwitchLabel   matlab.ui.control.Label
        VelocityGaugePanel             matlab.ui.container.Panel
        tTextArea_2Label               matlab.ui.control.Label
        t                              matlab.ui.control.TextArea
        step                           matlab.ui.control.TextArea
        stepTextAreaLabel              matlab.ui.control.Label
        XYLabel_2                      matlab.ui.control.Label
        iVyGauge                       matlab.ui.control.SemicircularGauge
        SpeedmsGauge                   matlab.ui.control.Gauge
        SpeedmsGaugeLabel              matlab.ui.control.Label
        InstantaneousVelocityradssGauge  matlab.ui.control.LinearGauge
        InstantaneousVelocityradssGaugeLabel  matlab.ui.control.Label
        PlaybackSpeedLabel             matlab.ui.control.Label
        Button_2                       matlab.ui.control.Button
        Button                         matlab.ui.control.Button
        PlayingLabel                   matlab.ui.control.Label
        PauseButton                    matlab.ui.control.StateButton
        iVxGauge                       matlab.ui.control.SemicircularGauge
        InstantaneousVelocitymsLabel   matlab.ui.control.Label
        SetParametersButton            matlab.ui.control.Button
        ProgramStatusPanel             matlab.ui.container.Panel
        ProcessStep                    matlab.ui.control.NumericEditField
        ProcessStepTimemsEditFieldLabel  matlab.ui.control.Label
        Status                         matlab.ui.control.TextArea
        CurrentStatusLabel             matlab.ui.control.Label
        RobotStatusPanel               matlab.ui.container.Panel
        PlottingLamp                   matlab.ui.control.Lamp
        PlottingLampLabel              matlab.ui.control.Label
        EXITButton                     matlab.ui.control.Button
        CalculationsCompleteLamp       matlab.ui.control.Lamp
        CalculationsCompleteLampLabel  matlab.ui.control.Label
        FileLoadedLamp                 matlab.ui.control.Lamp
        FileLoadedLampLabel            matlab.ui.control.Label
        ParametersSetLamp              matlab.ui.control.Lamp
        ParametersSetLampLabel         matlab.ui.control.Label
        InitialisedLamp                matlab.ui.control.Lamp
        InitialisedLampLabel           matlab.ui.control.Label
        MTRN4010Assignment1ControlCentreLabel  matlab.ui.control.Label
        GCFAxes                        matlab.ui.control.UIAxes
        PLidarAxes                     matlab.ui.control.UIAxes
        CLidarAxes                     matlab.ui.control.UIAxes
        ParameterControlTab            matlab.ui.container.Tab
        ParamGridLayout                matlab.ui.container.GridLayout
        lidarConfigPanel               matlab.ui.container.Panel
        degreeradsLabel_2              matlab.ui.control.Label
        lidarY                         matlab.ui.control.NumericEditField
        YEditFieldLabel_2              matlab.ui.control.Label
        lidarTheta                     matlab.ui.control.NumericEditField
        thetaEditFieldLabel_2          matlab.ui.control.Label
        lidarX                         matlab.ui.control.NumericEditField
        XEditFieldLabel_2              matlab.ui.control.Label
        degRadSelector                 matlab.ui.control.RockerSwitch
        Panel_8                        matlab.ui.container.Panel
        Image                          matlab.ui.control.Image
        relativetoplatformcoordinatesystemLabel  matlab.ui.control.Label
        LidarInitialPositionLabel      matlab.ui.control.Label
        ParameterDisplay               matlab.ui.container.Panel
        ResetParamsButton              matlab.ui.control.Button
        applyAndRun                    matlab.ui.control.Button
        ParamTree                      matlab.ui.container.Tree
        ParametersNode                 matlab.ui.container.TreeNode
        ActiveFileNode                 matlab.ui.container.TreeNode
        CurrentActiveFile              matlab.ui.container.TreeNode
        InitialCoordinatesNode         matlab.ui.container.TreeNode
        CurrentInitialCoords           matlab.ui.container.TreeNode
        IMUGainNode                    matlab.ui.container.TreeNode
        CurrentGain                    matlab.ui.container.TreeNode
        IMUBiasNode                    matlab.ui.container.TreeNode
        CurrentBias                    matlab.ui.container.TreeNode
        initY                          matlab.ui.control.NumericEditField
        YEditFieldLabel                matlab.ui.control.Label
        initTheta                      matlab.ui.control.NumericEditField
        thetaEditFieldLabel            matlab.ui.control.Label
        initX                          matlab.ui.control.NumericEditField
        XEditFieldLabel                matlab.ui.control.Label
        InitialPosPanel                matlab.ui.container.Panel
        initPosAxes                    matlab.ui.control.UIAxes
        Panel_5                        matlab.ui.container.Panel
        GotoStatusButton               matlab.ui.control.Button
        EXITButton_2                   matlab.ui.control.Button
        IMUConfig                      matlab.ui.container.Panel
        biasSpinner                    matlab.ui.control.Spinner
        gainSpinner                    matlab.ui.control.Spinner
        IMUParametersLabel             matlab.ui.control.Label
        BiasSlider                     matlab.ui.control.Slider
        BiasSliderLabel                matlab.ui.control.Label
        GainSlider                     matlab.ui.control.Slider
        GainSliderLabel                matlab.ui.control.Label
        Panel_2                        matlab.ui.container.Panel
        FileLoadedLamp_2               matlab.ui.control.Lamp
        FileLoadedLamp_2Label          matlab.ui.control.Label
        ActiveFileDropDown             matlab.ui.control.DropDown
        ActiveFileDropDownLabel        matlab.ui.control.Label
        Panel_7                        matlab.ui.container.Panel
        degreeradsLabel                matlab.ui.control.Label
        Switch                         matlab.ui.control.RockerSwitch
    end

    
    properties (Access = private)
        initRads double
        playbackController struct
        wallsData (2,:) double
    end
    
    properties (Access = public)
        PlaybackRequested double
        PlaybackResetRequested double% Description
        pathData struct % Description
        GCFPlot struct
        LidarPlot struct
        InitPlot struct
        ErrorPlot struct
        

        flags struct  % Description
        params struct
        control uint16
    end
    
    methods (Access = private)
        
        function drawInitPose(app)
            arrow = app.getArrow(app.InitPlot.Coords);
            app.InitPlot.arrow.XData = arrow(1,:);
            app.InitPlot.arrow.YData = arrow(2,:);
            end
        
        function arrow = getArrow(app, coords, params)
        arguments
            app
            coords (3,1) double
            params.scale double = 1
        end
            outline = [1, -.5, -.5, 1, 0;
                       0, -.5, .5, 0, 0];
            rotation = [cos(coords(3)) -sin(coords(3)); 
                        sin(coords(3)) cos(coords(3))];
            arrow = rotation*(outline*params.scale)+coords(1:2);
        end
        
        function flagParamChange(app)
            app.flags.paramsChanged = true;
            app.ResetParamsButton.Enable="on";
        end
        
        function writeParams(app)
            app.params.initPos = app.InitPlot.Coords;
            app.params.bias = app.BiasSlider.Value;
            app.params.gain = app.GainSlider.Value;
            app.params.file = app.ActiveFileDropDown.Value;

            app.ResetParamsButton.Enable="off";
            app.params.modified = true; 
            
        end

        function setGauges(app, t, i, dx, dy, dz, speed)
            arguments
                app
                t double = 0
                i uint16 = 0
                dx double = 0
                dy double = 0
                dz double = 0
                speed double = 0
            end
            app.t.Value = string(t);
            app.step.Value = string(i);
            app.iVxGauge.Value = dx;
            app.iVyGauge.Value = dy;
            app.InstantaneousVelocityradssGauge.Value = dz;
            app.SpeedmsGauge.Value = speed;
        end

        function clearPlots(app)
            delete(app.GCFPlot.DRline);
            app.GCFPlot.DRline = animatedline(app.GCFAxes, 'Color', [34 91 224]/255, 'LineWidth', 2, 'LineStyle', '-');
            
            arrow = app.getArrow(app.InitPlot.Coords);
            app.GCFPlot.arrow.XData = arrow(1,:);
            app.GCFPlot.arrow.YData = arrow(2,:);
        end
        
        function togglePausePlay(app, isPause)
            pathToMLAPP = fileparts(mfilename('fullpath'));
            if (~isPause)
                app.PauseButton.Value = false;
                app.PauseButton.Icon = fullfile(pathToMLAPP, 'src', 'pause.png');
                app.PauseButton.Text = 'Pause';
                app.control = 2; % set to play
                app.PlayingLabel.Text = 'Playing';
            else

                app.PauseButton.Value = true;
                app.PauseButton.Icon = fullfile(pathToMLAPP, 'src', 'play.png');
                app.PauseButton.Text = 'Play';
                app.control = 1; % set to pause
                app.PlayingLabel.Text = 'Paused';
            end
            
        end
    end
    
    methods (Access = public)
        
        function ready = initialise(app, data)
            arguments
                app
                data.directory
                data.loadedFile string
                data.Walls (2,:) double
                data.OOI (2,:) double
                data.GT (3,:) double
                data.Position (3,1) double = [0;0;0]
                data.LidarPos (3,1) double = [0;0;0]
            end
            % init properties
            app.flags = struct('userInput', false,...
                'paramsChanged', false);

            % initialise axes objects
            app.wallsData = data.Walls;
            %GCF Axes
            app.pathData = struct('deadReckoning', zeros(8,1), ...
                'groundTruth', data.GT, ...
                'ooiCoords', data.OOI, ...
                'error', zeros(2,1), ...
                'initialised', true);

            ax = app.GCFAxes;
            walls = line(ax, data.Walls(1,:), data.Walls(2,:), ...
                'LineWidth', 2, 'color', [205, 127, 50]/255);
            OOI = line(ax, data.OOI(1,:), data.OOI(2,:), 'Color', [186 26 26]/225, 'LineStyle', 'none', 'Marker', 'pentagram');
            GT = line(ax, data.GT(1,:), data.GT(2,:), 'Color', [224 94 34]/225, 'LineWidth', 1, 'LineStyle', ':');

            app.GCFPlot = struct( ...
                'DRline', animatedline(ax, 'Color', [34 91 224]/255, 'LineWidth', 2, 'LineStyle', '-'), ...
                'arrow', line(ax, 0, 0, 'Color', [255 0 0]/255, 'LineWidth', 2), ...
                'GTLine', GT,...
                'OOI', OOI, ...
                'WallsLine', walls);
            ax = app.ErrorAxes;
            app.ErrorPlot = struct( ...
                'XErrLine', animatedline(ax, 'Color', [104 91 207]/255, 'LineWidth', 1.5, 'DisplayName', 'X Err'), ...
                'YErrLine', animatedline(ax, 'Color', [219 166 92]/255, 'LineWidth', 1.5,  'DisplayName', 'Y Err'));
            legend(app.ErrorAxes, 'Location','north', 'Orientation','horizontal');

            %Initial Position Display Axes
            ax = app.initPosAxes;
            p0 = data.Position;
            walls = line(ax, data.Walls(1,:), data.Walls(2,:), ...
                'LineWidth', 2, 'color', [205, 127, 50]/255);
            arrow = app.getArrow(p0, 'scale', 1);
            app.InitPlot = struct( ...
                'walls', walls, ...
                'arrow', line(ax, arrow(1,:), arrow(2,:), 'LineStyle', '-', 'Color', [255 0 0]/255, 'LineWidth', 2),...
                'Coords', p0);

            app.initX.Value = p0(1); app.initY.Value = p0(2); app.initTheta.Value = p0(3);

            %TODO - add lidar stuff here
            init = zeros(301, 1);
            app.LidarPlot = struct(...
                'cart', line(app.CLidarAxes, init, init, 'LineStyle', 'none', 'Marker', '.','Color', [34 91 224]/225, 'MarkerSize', 6),...
                'pol', line(app.PLidarAxes, init, init, 'LineStyle', 'none', 'Marker', '.', 'Color', [34 91 224]/225, 'MarkerSize', 6),...
                'OOI', line(app.PLidarAxes, 'Color', [186 26 26]/225, 'LineStyle', 'none', 'Marker', 'pentagram'), ...
                'initCoords', [0;0;0]);

            app.playbackController = struct('option', 0, 'updateVis', false, 'tickRate', 0.05);


            
            % discover path files
            files = {};
            for i=1:length(data.directory)
                files{i} = data.directory(i).name;
            end
            app.ActiveFileDropDown.Items = files;
            app.ActiveFileDropDown.ItemsData = files;
            app.ActiveFileDropDown.Value = cellstr(data.loadedFile);

            %reflect robot state in param tree
            app.CurrentActiveFile.Text = data.loadedFile;
            app.CurrentInitialCoords.Text = sprintf('X: %.2f, Y:%.2f, R:%.2f', p0(1),p0(2),p0(3));
            app.CurrentGain.Text = '1';
            app.CurrentBias.Text = '0';

            app.params = struct(...
                'modified', false, ...
                'initPos', p0, ...
                'initLidar', 0,...
                'gain', app.gainSpinner.Value, ...
                'bias', app.biasSpinner.Value, ...
                'fileChanged', false,...
                'file', app.ActiveFileDropDown.Value);

            app.control = 2;
            

            ready = true;
        end
        
        function loadPathData(app, data)
            arguments
                app
                data.groundTruth     (2,:) double = [0;0]
                data.ooiCoords       (2,:) double = [0;0]
            end

            app.pathData.groundTruth = data.groundTruth;

            app.GCFPlot.GTLine.XData = data.groundTruth(1,:);
            app.GCFPlot.GTLine.YData = data.groundTruth(2,:);

            app.pathData.ooiCoords = data.ooiCoords;
            app.GCFPlot.OOI.XData = data.ooiCoords(1,:);
            app.GCFPlot.OOI.YData = data.ooiCoords(2,:);

            app.pathData.initialised = true;
            
        end
        function startPlaybackSession(app) %delete later
            % check path data loaded
            if ~(app.pathData.initialised) return; end;
           index = 1; app.playbackController.option = 0; exitFlag = false;
           dr = app.pathData.deadReckoning;
           er = app.pathData.error;
           while ~(exitFlag)
           
           switch app.playbackController.option
                case(0)     % pause
                    % await input
                pause(0.05);

                case(1)     % play
                if(index < length(dr))
                    index = index+1;
                else
                    app.playbackController.option = 2
                end

                case(2)     % end reached
                    pause(0.05);
                case(3)     % scrub backwards
                    if(index>1) index = index-1;
                    else app.playbackController.option = 0;
                    end
                case(4)     % scrub forwards
                index = index+5;
                case(5)     % reset    
                index = 1;
                case(6)     % exit
                exitFlag = true;
           end
           % plot objects
           if (~exitFlag || playback == 0)
            pause(0.1);
            coords = dr(:, index);
            Vt_ms = hypot(coords(6), coords(7));
            Vt_rs = coords(8);

            arrow = app.getArrow(coords(1:3));
            app.GCFPlot.arrow.XData = arrow(1,:);
            app.GCFPlot.arrow.YData = arrow(2,:);
            
            app.GCFPlot.DRline.XData = dr(1, 1:index);
            app.GCFPlot.DRline.YData = dr(2, 1:index);

            app.ErrorPlot.XErrLine.XData = er(1, 1:index);
            app.ErrorPlot.YErrLine.XData = er(2, 1:index);
            app.ErrorPlot.XErrLine.YData = dr(4, 1:index);
            app.ErrorPlot.YErrLine.YData = dr(4, 1:index);

            app.iVxGauge.Value = coords(6);
            iVyGaugepp.a.Value = coords(7);
            app.SpeedmsGauge.Value = Vt_ms;
            app.InstantaneousVelocityradssGauge.Value = Vt_rs;

           end

            % update visibility
            if (app.playbackController.updateVis)
                app.playbackController.updateVis = false; % acknowledge flag
                set(app.GCFPlot.arrow, 'Visible', app.PositionIndicatorSwitch.Value);
                set(app.GCFPlot.DRline, 'Visible', app.DeadReckoningEstimateSwitch.Value);
                set(app.GCFPlot.OOI, 'Visible', app.OOIsSwitch.Value);
                set(app.GCFPlot.GTLine, 'Visible', app.GroundTruthSwitch.Value);
            end
           end

        end
        
        function setActiveTab(app, tab)
            app.TabGroup.SelectedTab = tab;
        end
        
        function initialisePlotVectors(app, initCoords)
            arguments
                app
                initCoords (2,1) double
            end
            initial = initCoords.*ones(2,2048);
            app.GCFPlot.DRline.XData = initial(1,:);
            app.GCFPlot.DRline.YData = initial(2,:);
        end

        function results = updatePlotVectors(app, drCoords, lCoords, index)
            arguments
                app
                drCoords (8,1) double
                lCoords (4, 301) double
                index uint16
            end
            Vt_ms = hypot(drCoords(6), drCoords(7));

            arrow = app.getArrow(drCoords(1:3));
            app.GCFPlot.arrow.XData = arrow(1,:);
            app.GCFPlot.arrow.YData = arrow(2,:);

            app.LidarPlot.cart.XData = lCoords(1,:);
            app.LidarPlot.cart.YData = lCoords(2,:);
            app.LidarPlot.pol.XData = rad2deg(lCoords(3,:));
            app.LidarPlot.pol.YData = lCoords(4,:);

            err = app.pathData.groundTruth(1:2, index) - drCoords(1:2);
            
            % plot dead reckoning path
            addpoints(app.GCFPlot.DRline, drCoords(1),drCoords(2));
            
            % plot error path 
            %% Currently DISABLED as is using wayyyy too
            % much process time, look into optimisations??
            %addpoints(app.ErrorPlot.XErrLine, err(1), drCoords(4));
            %addpoints(app.ErrorPlot.YErrLine, err(2), drCoords(4));
            
            drawnow;
            %app.GCFPlot.DRline.YData(index:end) = drCoords(2);

            % app.ErrorPlot.XErrLine.XData = er(1, 1:index);
            % app.ErrorPlot.YErrLine.XData = er(2, 1:index);
            % app.ErrorPlot.XErrLine.YData = drCoords(4, 1:index);
            % app.ErrorPlot.YErrLine.YData = drCoords(4, 1:index);
            
            app.setGauges(drCoords(4), index, drCoords(6), drCoords(7), drCoords(8), Vt_ms);
            
        end

        function params = getParams(app)
            if (~app.flags.paramsChanged)
                params = struct('modified', false); 
                return;
            end

        end
        
        
        function updateLidarOOIs(app, OOIs)
            arguments
                app
                OOIs (2,:) double;
            end
            app.LidarPlot.OOI.XData = OOIs(1,:);
            app.LidarPlot.OOI.YData = OOIs(2,:);
        end
    end
    

    % Callbacks that handle component events
    methods (Access = private)

        % Value changing function: gainSpinner
        function gainSpinnerValueChanging(app, event)
            changingValue = event.Value;
            app.GainSlider.Value = changingValue;
            app.flagParamChange();
        end

        % Value changing function: biasSpinner
        function biasSpinnerValueChanging(app, event)
            changingValue = event.Value;
            app.BiasSlider.Value = changingValue;
            app.flagParamChange();
        end

        % Value changing function: GainSlider
        function GainSliderValueChanging(app, event)
            changingValue = event.Value;
            app.gainSpinner.Value = changingValue;
            app.flagParamChange();
        end

        % Value changing function: BiasSlider
        function BiasSliderValueChanging(app, event)
            changingValue = event.Value;
            app.biasSpinner.Value = changingValue;
            app.flagParamChange();
        end

        % Value changed function: initX
        function initXValueChanged(app, event)
            app.InitPlot.Coords(1) = app.initX.Value;
            app.drawInitPose();
            app.flagParamChange();
        end

        % Value changed function: initY
        function initYValueChanged(app, event)
            app.InitPlot.Coords(2) = app.initY.Value;
            app.drawInitPose();
            app.flagParamChange();
        end

        % Value changed function: initTheta
        function initThetaValueChanged(app, event)
            rads = app.initTheta.Value;
            if(app.Switch.Value == 'd') rads = deg2rad(rads); end
            app.InitPlot.Coords(3) = rads;
            app.drawInitPose();
            app.flagParamChange();
        end

        % Button pushed function: EXITButton, EXITButton_2
        function EXITButtonPushed(app, event)
            app.delete;
        end

        % Button pushed function: SetParametersButton
        function SetParametersButtonPushed(app, event)
            app.setActiveTab(app.ParameterControlTab);
        end

        % Button pushed function: GotoStatusButton
        function GotoStatusButtonPushed(app, event)
            app.setActiveTab(app.StatusTab);
        end

        % Value changed function: Switch
        function SwitchValueChanged(app, event)
            value = app.Switch.Value;
            if (value == 'd')
                app.initTheta.Value = rad2deg(app.InitPlot.Coords(3));
            else
                app.initTheta.Value = app.InitPlot.Coords(3);
            end

        end

        % Value changed function: Status
        function StatusValueChanged(app, event)
            value = app.Status.Value;
            if (value == "Plotting path") 
                app.PlottingLamp.Color = [0 255 0]/255;
            elseif(value == "Awaiting parameters")
                 app.ParametersSetLamp.Color = [255 191 0]/255;
            elseif(value == "Loading path")
                app.FileLoadedLamp.Color = [255 191 0]/255;
            elseif(value == "Loaded path")
                app.FileLoadedLamp.Color = [0 255 0]/255;
            end

        end

        % Button pushed function: ResetPlaybackButton
        function ResetPlaybackButtonPushed(app, event)
            app.clearPlots();

            %set to pause
            app.togglePausePlay(true);
            
            %clear gauges
            app.setGauges();

            
            app.control = 3;

        end

        % Value changed function: PauseButton
        function PauseButtonValueChanged(app, event)
            value = app.PauseButton.Value;
            app.togglePausePlay(value);
        end

        % Button pushed function: applyAndRun
        function applyAndRunPushed(app, event)
            % change button appearance
                app.applyAndRun.Enable = "off";
                app.applyAndRun.Text = 'Running...';
            % write temp params to param object
            app.writeParams();
            % flag params ready for bot
            app.flags.userInput = true;
            app.flags.paramsChanged = true;

            % switch to view page
            app.setActiveTab(app.StatusTab);
        end

        % Button pushed function: ResetParamsButton
        function ResetParamsButtonPushed(app, event)

            p0 = app.params.initPos;
            app.initX.Value = p0(1); app.initY.Value = p0(2); app.initTheta.Value = p0(3);
            app.InitPlot.Coords = p0;
            app.biasSpinner.Value = app.params.bias; app.BiasSlider.Value = app.params.bias;
            app.gainSpinner.Value = app.params.gain; app.GainSlider.Value = app.params.gain;
            app.ActiveFileDropDown.Value = app.params.file;
            app.params.fileChanged = false;

            app.ResetParamsButton.Enable="off";
            app.drawInitPose();


            app.params.modified = false;
        end

        % Value changed function: ActiveFileDropDown
        function ActiveFileDropDownValueChanged(app, event)
            value = app.ActiveFileDropDown.Value;
            app.params.fileChanged = true;
            app.flagParamChange();
        end

        % Value changed function: PositionIndicatorSwitch
        function PositionIndicatorSwitchValueChanged(app, event)
            set(app.GCFPlot.arrow, 'Visible', app.PositionIndicatorSwitch.Value);
        end

        % Value changed function: GroundTruthSwitch
        function GroundTruthSwitchValueChanged(app, event)
            set(app.GCFPlot.GTLine, 'Visible', app.GroundTruthSwitch.Value);
        end

        % Value changed function: DeadReckoningEstimateSwitch
        function DeadReckoningEstimateSwitchValueChanged(app, event)
            set(app.GCFPlot.DRline, 'Visible', app.DeadReckoningEstimateSwitch.Value);
        end

        % Value changed function: OOIsSwitch
        function OOIsSwitchValueChanged(app, event)
            set(app.GCFPlot.OOI, 'Visible', app.OOIsSwitch.Value);
        end

        % Value changed function: lidarX
        function lidarXValueChanged(app, event)
            value = app.lidarX.Value;
            app.LidarPlot.initCoords(1) = value;
        end

        % Value changed function: lidarY
        function lidarYValueChanged(app, event)
            value = app.lidarY.Value;
            
        end

        % Value changed function: lidarTheta
        function lidarThetaValueChanged(app, event)
            value = app.lidarTheta.Value;
            
        end
    end

    % Component initialization
    methods (Access = private)

        % Create UIFigure and components
        function createComponents(app)

            % Get the file path for locating images
            pathToMLAPP = fileparts(mfilename('fullpath'));

            % Create MTRN4010ControlCentreUIFigure and hide until all components are created
            app.MTRN4010ControlCentreUIFigure = uifigure('Visible', 'off');
            app.MTRN4010ControlCentreUIFigure.Color = [1 1 1];
            app.MTRN4010ControlCentreUIFigure.Position = [100 100 1115 763];
            app.MTRN4010ControlCentreUIFigure.Name = 'MTRN4010 Control Centre';
            app.MTRN4010ControlCentreUIFigure.Icon = fullfile(pathToMLAPP, 'src', 'bot.png');

            % Create TabGroup
            app.TabGroup = uitabgroup(app.MTRN4010ControlCentreUIFigure);
            app.TabGroup.Position = [1 1 1115 763];

            % Create StatusTab
            app.StatusTab = uitab(app.TabGroup);
            app.StatusTab.Title = 'Status';
            app.StatusTab.BackgroundColor = [1 1 1];
            app.StatusTab.ForegroundColor = [0.129411764705882 0.129411764705882 0.129411764705882];

            % Create StatusGridLayout
            app.StatusGridLayout = uigridlayout(app.StatusTab);
            app.StatusGridLayout.ColumnWidth = {200, 165, '1x', 200};
            app.StatusGridLayout.RowHeight = {20, '3x', '1x', '1x', 20};
            app.StatusGridLayout.RowSpacing = 2.8;
            app.StatusGridLayout.Padding = [10 2.8 10 2.8];
            app.StatusGridLayout.BackgroundColor = [0.96078431372549 0.96078431372549 0.96078431372549];

            % Create CLidarAxes
            app.CLidarAxes = uiaxes(app.StatusGridLayout);
            title(app.CLidarAxes, 'LIDAR_1 (Cartesian)')
            xlabel(app.CLidarAxes, 'X')
            ylabel(app.CLidarAxes, 'Y')
            zlabel(app.CLidarAxes, 'Z')
            app.CLidarAxes.XGrid = 'on';
            app.CLidarAxes.YGrid = 'on';
            app.CLidarAxes.Layout.Row = 4;
            app.CLidarAxes.Layout.Column = [2 3];

            % Create PLidarAxes
            app.PLidarAxes = uiaxes(app.StatusGridLayout);
            title(app.PLidarAxes, 'LIDAR_1 (Polar)')
            xlabel(app.PLidarAxes, 'Azimuth (Degrees)')
            ylabel(app.PLidarAxes, 'Range (m)')
            zlabel(app.PLidarAxes, 'Z')
            app.PLidarAxes.XLim = [-80 80];
            app.PLidarAxes.YLim = [-10 30];
            app.PLidarAxes.XGrid = 'on';
            app.PLidarAxes.YGrid = 'on';
            app.PLidarAxes.Layout.Row = 3;
            app.PLidarAxes.Layout.Column = [2 3];

            % Create GCFAxes
            app.GCFAxes = uiaxes(app.StatusGridLayout);
            title(app.GCFAxes, 'Global Co-ordinate Frame')
            app.GCFAxes.PlotBoxAspectRatio = [1 1 1];
            app.GCFAxes.XLim = [-5 20];
            app.GCFAxes.YLim = [-5 20];
            app.GCFAxes.XTick = [-5 0 5 10 15 20];
            app.GCFAxes.XTickLabel = {'-5'; '0'; '5'; '10'; '15'; '20'};
            app.GCFAxes.YAxisLocation = 'right';
            app.GCFAxes.YTick = [-5 0 5 10 15 20];
            app.GCFAxes.YTickLabel = {'-5'; '0'; '5'; '10'; '15'; '20'};
            app.GCFAxes.Box = 'on';
            app.GCFAxes.XGrid = 'on';
            app.GCFAxes.YGrid = 'on';
            app.GCFAxes.Layout.Row = 2;
            app.GCFAxes.Layout.Column = 3;

            % Create MTRN4010Assignment1ControlCentreLabel
            app.MTRN4010Assignment1ControlCentreLabel = uilabel(app.StatusGridLayout);
            app.MTRN4010Assignment1ControlCentreLabel.HorizontalAlignment = 'center';
            app.MTRN4010Assignment1ControlCentreLabel.FontSize = 14;
            app.MTRN4010Assignment1ControlCentreLabel.FontWeight = 'bold';
            app.MTRN4010Assignment1ControlCentreLabel.FontColor = [0.129411764705882 0.129411764705882 0.129411764705882];
            app.MTRN4010Assignment1ControlCentreLabel.Layout.Row = 1;
            app.MTRN4010Assignment1ControlCentreLabel.Layout.Column = [2 3];
            app.MTRN4010Assignment1ControlCentreLabel.Text = 'MTRN4010 Assignment 1 Control Centre';

            % Create RobotStatusPanel
            app.RobotStatusPanel = uipanel(app.StatusGridLayout);
            app.RobotStatusPanel.BorderType = 'none';
            app.RobotStatusPanel.TitlePosition = 'centertop';
            app.RobotStatusPanel.Title = 'Robot Status';
            app.RobotStatusPanel.Layout.Row = [3 4];
            app.RobotStatusPanel.Layout.Column = 4;
            app.RobotStatusPanel.FontName = 'Candara';
            app.RobotStatusPanel.FontWeight = 'bold';

            % Create InitialisedLampLabel
            app.InitialisedLampLabel = uilabel(app.RobotStatusPanel);
            app.InitialisedLampLabel.HorizontalAlignment = 'right';
            app.InitialisedLampLabel.FontName = 'Candara';
            app.InitialisedLampLabel.FontColor = [0.129411764705882 0.129411764705882 0.129411764705882];
            app.InitialisedLampLabel.Position = [103 221 53 22];
            app.InitialisedLampLabel.Text = 'Initialised';

            % Create InitialisedLamp
            app.InitialisedLamp = uilamp(app.RobotStatusPanel);
            app.InitialisedLamp.Position = [171 221 20 20];

            % Create ParametersSetLampLabel
            app.ParametersSetLampLabel = uilabel(app.RobotStatusPanel);
            app.ParametersSetLampLabel.HorizontalAlignment = 'right';
            app.ParametersSetLampLabel.FontName = 'Candara';
            app.ParametersSetLampLabel.FontColor = [0.129411764705882 0.129411764705882 0.129411764705882];
            app.ParametersSetLampLabel.Position = [73 176 83 22];
            app.ParametersSetLampLabel.Text = 'Parameters Set';

            % Create ParametersSetLamp
            app.ParametersSetLamp = uilamp(app.RobotStatusPanel);
            app.ParametersSetLamp.Position = [171 176 20 20];
            app.ParametersSetLamp.Color = [1 0 0];

            % Create FileLoadedLampLabel
            app.FileLoadedLampLabel = uilabel(app.RobotStatusPanel);
            app.FileLoadedLampLabel.HorizontalAlignment = 'right';
            app.FileLoadedLampLabel.FontName = 'Candara';
            app.FileLoadedLampLabel.FontColor = [0.129411764705882 0.129411764705882 0.129411764705882];
            app.FileLoadedLampLabel.Position = [93 128 63 22];
            app.FileLoadedLampLabel.Text = 'File Loaded';

            % Create FileLoadedLamp
            app.FileLoadedLamp = uilamp(app.RobotStatusPanel);
            app.FileLoadedLamp.Position = [171 128 20 20];
            app.FileLoadedLamp.Color = [1 0 0];

            % Create CalculationsCompleteLampLabel
            app.CalculationsCompleteLampLabel = uilabel(app.RobotStatusPanel);
            app.CalculationsCompleteLampLabel.HorizontalAlignment = 'right';
            app.CalculationsCompleteLampLabel.FontName = 'Candara';
            app.CalculationsCompleteLampLabel.FontColor = [0.129411764705882 0.129411764705882 0.129411764705882];
            app.CalculationsCompleteLampLabel.Position = [38 81 118 22];
            app.CalculationsCompleteLampLabel.Text = 'Calculations Complete';

            % Create CalculationsCompleteLamp
            app.CalculationsCompleteLamp = uilamp(app.RobotStatusPanel);
            app.CalculationsCompleteLamp.Position = [171 81 20 20];
            app.CalculationsCompleteLamp.Color = [1 0 0];

            % Create EXITButton
            app.EXITButton = uibutton(app.RobotStatusPanel, 'push');
            app.EXITButton.ButtonPushedFcn = createCallbackFcn(app, @EXITButtonPushed, true);
            app.EXITButton.BackgroundColor = [0.96078431372549 0.96078431372549 0.96078431372549];
            app.EXITButton.FontWeight = 'bold';
            app.EXITButton.FontColor = [0.129411764705882 0.129411764705882 0.129411764705882];
            app.EXITButton.Position = [52 1 100 23];
            app.EXITButton.Text = 'EXIT';

            % Create PlottingLampLabel
            app.PlottingLampLabel = uilabel(app.RobotStatusPanel);
            app.PlottingLampLabel.HorizontalAlignment = 'right';
            app.PlottingLampLabel.FontName = 'Candara';
            app.PlottingLampLabel.FontColor = [0.129411764705882 0.129411764705882 0.129411764705882];
            app.PlottingLampLabel.Position = [110 42 45 22];
            app.PlottingLampLabel.Text = 'Plotting';

            % Create PlottingLamp
            app.PlottingLamp = uilamp(app.RobotStatusPanel);
            app.PlottingLamp.Position = [170 42 20 20];
            app.PlottingLamp.Color = [1 0 0];

            % Create ProgramStatusPanel
            app.ProgramStatusPanel = uipanel(app.StatusGridLayout);
            app.ProgramStatusPanel.ForegroundColor = [0.129411764705882 0.129411764705882 0.129411764705882];
            app.ProgramStatusPanel.BorderType = 'none';
            app.ProgramStatusPanel.TitlePosition = 'centertop';
            app.ProgramStatusPanel.Title = 'Program Status';
            app.ProgramStatusPanel.BackgroundColor = [0.96078431372549 0.96078431372549 0.96078431372549];
            app.ProgramStatusPanel.Layout.Row = 4;
            app.ProgramStatusPanel.Layout.Column = 1;

            % Create CurrentStatusLabel
            app.CurrentStatusLabel = uilabel(app.ProgramStatusPanel);
            app.CurrentStatusLabel.FontSize = 18;
            app.CurrentStatusLabel.FontWeight = 'bold';
            app.CurrentStatusLabel.FontColor = [0.129411764705882 0.129411764705882 0.129411764705882];
            app.CurrentStatusLabel.Position = [34 33 136 23];
            app.CurrentStatusLabel.Text = 'Current Status:';

            % Create Status
            app.Status = uitextarea(app.ProgramStatusPanel);
            app.Status.ValueChangedFcn = createCallbackFcn(app, @StatusValueChanged, true);
            app.Status.Editable = 'off';
            app.Status.HorizontalAlignment = 'center';
            app.Status.FontName = 'Lucida Console';
            app.Status.FontSize = 10;
            app.Status.FontColor = [0.129411764705882 0.129411764705882 0.129411764705882];
            app.Status.Position = [14 3 175 25];

            % Create ProcessStepTimemsEditFieldLabel
            app.ProcessStepTimemsEditFieldLabel = uilabel(app.ProgramStatusPanel);
            app.ProcessStepTimemsEditFieldLabel.HorizontalAlignment = 'center';
            app.ProcessStepTimemsEditFieldLabel.Position = [33 94 136 22];
            app.ProcessStepTimemsEditFieldLabel.Text = 'Process Step Time (ms):';

            % Create ProcessStep
            app.ProcessStep = uieditfield(app.ProgramStatusPanel, 'numeric');
            app.ProcessStep.Editable = 'off';
            app.ProcessStep.HorizontalAlignment = 'center';
            app.ProcessStep.Position = [74 64 54 28];

            % Create VelocityGaugePanel
            app.VelocityGaugePanel = uipanel(app.StatusGridLayout);
            app.VelocityGaugePanel.ForegroundColor = [0.129411764705882 0.129411764705882 0.129411764705882];
            app.VelocityGaugePanel.BorderType = 'none';
            app.VelocityGaugePanel.BorderWidth = 0;
            app.VelocityGaugePanel.Title = ' ';
            app.VelocityGaugePanel.BackgroundColor = [0.96078431372549 0.96078431372549 0.96078431372549];
            app.VelocityGaugePanel.Layout.Row = 2;
            app.VelocityGaugePanel.Layout.Column = 4;

            % Create SetParametersButton
            app.SetParametersButton = uibutton(app.VelocityGaugePanel, 'push');
            app.SetParametersButton.ButtonPushedFcn = createCallbackFcn(app, @SetParametersButtonPushed, true);
            app.SetParametersButton.BackgroundColor = [0.96078431372549 0.96078431372549 0.96078431372549];
            app.SetParametersButton.FontWeight = 'bold';
            app.SetParametersButton.FontColor = [0.129411764705882 0.129411764705882 0.129411764705882];
            app.SetParametersButton.Position = [51 9 102 23];
            app.SetParametersButton.Text = 'Set Parameters';

            % Create InstantaneousVelocitymsLabel
            app.InstantaneousVelocitymsLabel = uilabel(app.VelocityGaugePanel);
            app.InstantaneousVelocitymsLabel.HorizontalAlignment = 'center';
            app.InstantaneousVelocitymsLabel.WordWrap = 'on';
            app.InstantaneousVelocitymsLabel.FontWeight = 'bold';
            app.InstantaneousVelocitymsLabel.FontColor = [0.129411764705882 0.129411764705882 0.129411764705882];
            app.InstantaneousVelocitymsLabel.Position = [56 344 90 57];
            app.InstantaneousVelocitymsLabel.Text = {'Instantaneous '; '    Velocity    (m/s)'};

            % Create iVxGauge
            app.iVxGauge = uigauge(app.VelocityGaugePanel, 'semicircular');
            app.iVxGauge.Limits = [-2 2];
            app.iVxGauge.MajorTicks = [-2 -1 0 1 2];
            app.iVxGauge.Orientation = 'east';
            app.iVxGauge.ScaleDirection = 'counterclockwise';
            app.iVxGauge.FontColor = [0.129411764705882 0.129411764705882 0.129411764705882];
            app.iVxGauge.Position = [4 260 73 136];

            % Create PauseButton
            app.PauseButton = uibutton(app.VelocityGaugePanel, 'state');
            app.PauseButton.ValueChangedFcn = createCallbackFcn(app, @PauseButtonValueChanged, true);
            app.PauseButton.Icon = fullfile(pathToMLAPP, 'src', 'pause.png');
            app.PauseButton.Text = 'Pause';
            app.PauseButton.BackgroundColor = [0.96078431372549 0.96078431372549 0.96078431372549];
            app.PauseButton.FontColor = [0.129411764705882 0.129411764705882 0.129411764705882];
            app.PauseButton.Position = [53 54 100 23];

            % Create PlayingLabel
            app.PlayingLabel = uilabel(app.VelocityGaugePanel);
            app.PlayingLabel.HorizontalAlignment = 'center';
            app.PlayingLabel.FontColor = [0.129411764705882 0.129411764705882 0.129411764705882];
            app.PlayingLabel.Position = [80 32 44 22];
            app.PlayingLabel.Text = 'Playing';

            % Create Button
            app.Button = uibutton(app.VelocityGaugePanel, 'push');
            app.Button.Icon = fullfile(pathToMLAPP, 'src', 'fast-forward.png');
            app.Button.BackgroundColor = [0.96078431372549 0.96078431372549 0.96078431372549];
            app.Button.FontColor = [0.129411764705882 0.129411764705882 0.129411764705882];
            app.Button.Position = [155 54 27 23];
            app.Button.Text = '';

            % Create Button_2
            app.Button_2 = uibutton(app.VelocityGaugePanel, 'push');
            app.Button_2.Icon = fullfile(pathToMLAPP, 'src', 'fast-backward.png');
            app.Button_2.BackgroundColor = [0.96078431372549 0.96078431372549 0.96078431372549];
            app.Button_2.FontColor = [0.129411764705882 0.129411764705882 0.129411764705882];
            app.Button_2.Position = [24 54 27 23];
            app.Button_2.Text = '';

            % Create PlaybackSpeedLabel
            app.PlaybackSpeedLabel = uilabel(app.VelocityGaugePanel);
            app.PlaybackSpeedLabel.HorizontalAlignment = 'center';
            app.PlaybackSpeedLabel.FontColor = [0.129411764705882 0.129411764705882 0.129411764705882];
            app.PlaybackSpeedLabel.Position = [25 79 95 22];
            app.PlaybackSpeedLabel.Text = 'Playback Speed:';

            % Create InstantaneousVelocityradssGaugeLabel
            app.InstantaneousVelocityradssGaugeLabel = uilabel(app.VelocityGaugePanel);
            app.InstantaneousVelocityradssGaugeLabel.HorizontalAlignment = 'center';
            app.InstantaneousVelocityradssGaugeLabel.WordWrap = 'on';
            app.InstantaneousVelocityradssGaugeLabel.FontWeight = 'bold';
            app.InstantaneousVelocityradssGaugeLabel.FontColor = [0.129411764705882 0.129411764705882 0.129411764705882];
            app.InstantaneousVelocityradssGaugeLabel.Position = [11 150 180 22];
            app.InstantaneousVelocityradssGaugeLabel.Text = 'Instantaneous Velocity (rads/s)';

            % Create InstantaneousVelocityradssGauge
            app.InstantaneousVelocityradssGauge = uigauge(app.VelocityGaugePanel, 'linear');
            app.InstantaneousVelocityradssGauge.Limits = [-3.14 3.14];
            app.InstantaneousVelocityradssGauge.FontColor = [0.129411764705882 0.129411764705882 0.129411764705882];
            app.InstantaneousVelocityradssGauge.Position = [4 110 197 41];

            % Create SpeedmsGaugeLabel
            app.SpeedmsGaugeLabel = uilabel(app.VelocityGaugePanel);
            app.SpeedmsGaugeLabel.HorizontalAlignment = 'center';
            app.SpeedmsGaugeLabel.FontWeight = 'bold';
            app.SpeedmsGaugeLabel.FontColor = [0.129411764705882 0.129411764705882 0.129411764705882];
            app.SpeedmsGaugeLabel.Position = [64 268 73 22];
            app.SpeedmsGaugeLabel.Text = 'Speed (m/s)';

            % Create SpeedmsGauge
            app.SpeedmsGauge = uigauge(app.VelocityGaugePanel, 'circular');
            app.SpeedmsGauge.Limits = [0 2];
            app.SpeedmsGauge.FontColor = [0.129411764705882 0.129411764705882 0.129411764705882];
            app.SpeedmsGauge.Position = [56 180 92 92];

            % Create iVyGauge
            app.iVyGauge = uigauge(app.VelocityGaugePanel, 'semicircular');
            app.iVyGauge.Limits = [-2 2];
            app.iVyGauge.MajorTicks = [-2 -1 0 1 2];
            app.iVyGauge.Orientation = 'west';
            app.iVyGauge.FontColor = [0.129411764705882 0.129411764705882 0.129411764705882];
            app.iVyGauge.Position = [126 260 73 136];

            % Create XYLabel_2
            app.XYLabel_2 = uilabel(app.VelocityGaugePanel);
            app.XYLabel_2.HorizontalAlignment = 'center';
            app.XYLabel_2.FontWeight = 'bold';
            app.XYLabel_2.Position = [85 317 31 22];
            app.XYLabel_2.Text = 'X   Y';

            % Create stepTextAreaLabel
            app.stepTextAreaLabel = uilabel(app.VelocityGaugePanel);
            app.stepTextAreaLabel.HorizontalAlignment = 'center';
            app.stepTextAreaLabel.FontWeight = 'bold';
            app.stepTextAreaLabel.Interpreter = 'latex';
            app.stepTextAreaLabel.Position = [165 211 30 22];
            app.stepTextAreaLabel.Text = 'step';

            % Create step
            app.step = uitextarea(app.VelocityGaugePanel);
            app.step.Editable = 'off';
            app.step.HorizontalAlignment = 'center';
            app.step.FontSize = 10;
            app.step.FontWeight = 'bold';
            app.step.Position = [155 182 46 25];

            % Create t
            app.t = uitextarea(app.VelocityGaugePanel);
            app.t.Editable = 'off';
            app.t.HorizontalAlignment = 'center';
            app.t.FontSize = 10;
            app.t.FontWeight = 'bold';
            app.t.Position = [4 182 53 25];

            % Create tTextArea_2Label
            app.tTextArea_2Label = uilabel(app.VelocityGaugePanel);
            app.tTextArea_2Label.HorizontalAlignment = 'center';
            app.tTextArea_2Label.FontWeight = 'bold';
            app.tTextArea_2Label.Interpreter = 'latex';
            app.tTextArea_2Label.Position = [16 211 25 22];
            app.tTextArea_2Label.Text = 't';

            % Create visibilityControl
            app.visibilityControl = uipanel(app.StatusGridLayout);
            app.visibilityControl.BorderType = 'none';
            app.visibilityControl.TitlePosition = 'centertop';
            app.visibilityControl.Title = 'Visibility Control';
            app.visibilityControl.Layout.Row = 2;
            app.visibilityControl.Layout.Column = 2;
            app.visibilityControl.FontWeight = 'bold';
            app.visibilityControl.FontSize = 18;

            % Create PositionIndicatorSwitchLabel
            app.PositionIndicatorSwitchLabel = uilabel(app.visibilityControl);
            app.PositionIndicatorSwitchLabel.HorizontalAlignment = 'center';
            app.PositionIndicatorSwitchLabel.FontColor = [0.129411764705882 0.129411764705882 0.129411764705882];
            app.PositionIndicatorSwitchLabel.Position = [88 237 97 22];
            app.PositionIndicatorSwitchLabel.Text = 'Position Indicator';

            % Create PositionIndicatorSwitch
            app.PositionIndicatorSwitch = uiswitch(app.visibilityControl, 'slider');
            app.PositionIndicatorSwitch.ItemsData = {'off', 'on'};
            app.PositionIndicatorSwitch.ValueChangedFcn = createCallbackFcn(app, @PositionIndicatorSwitchValueChanged, true);
            app.PositionIndicatorSwitch.FontColor = [0.129411764705882 0.129411764705882 0.129411764705882];
            app.PositionIndicatorSwitch.Position = [113 274 45 20];
            app.PositionIndicatorSwitch.Value = 'on';

            % Create GroundTruthSwitchLabel
            app.GroundTruthSwitchLabel = uilabel(app.visibilityControl);
            app.GroundTruthSwitchLabel.HorizontalAlignment = 'center';
            app.GroundTruthSwitchLabel.FontColor = [0.129411764705882 0.129411764705882 0.129411764705882];
            app.GroundTruthSwitchLabel.Position = [99 160 76 22];
            app.GroundTruthSwitchLabel.Text = 'Ground Truth';

            % Create GroundTruthSwitch
            app.GroundTruthSwitch = uiswitch(app.visibilityControl, 'slider');
            app.GroundTruthSwitch.ItemsData = {'off', 'on'};
            app.GroundTruthSwitch.ValueChangedFcn = createCallbackFcn(app, @GroundTruthSwitchValueChanged, true);
            app.GroundTruthSwitch.FontColor = [0.129411764705882 0.129411764705882 0.129411764705882];
            app.GroundTruthSwitch.Position = [113 197 45 20];
            app.GroundTruthSwitch.Value = 'on';

            % Create DeadReckoningEstimateLabel
            app.DeadReckoningEstimateLabel = uilabel(app.visibilityControl);
            app.DeadReckoningEstimateLabel.HorizontalAlignment = 'center';
            app.DeadReckoningEstimateLabel.WordWrap = 'on';
            app.DeadReckoningEstimateLabel.FontColor = [0.129411764705882 0.129411764705882 0.129411764705882];
            app.DeadReckoningEstimateLabel.Position = [83 79 108 33];
            app.DeadReckoningEstimateLabel.Text = 'Dead Reckoning Estimate';

            % Create DeadReckoningEstimateSwitch
            app.DeadReckoningEstimateSwitch = uiswitch(app.visibilityControl, 'slider');
            app.DeadReckoningEstimateSwitch.ItemsData = {'off', 'on'};
            app.DeadReckoningEstimateSwitch.ValueChangedFcn = createCallbackFcn(app, @DeadReckoningEstimateSwitchValueChanged, true);
            app.DeadReckoningEstimateSwitch.FontColor = [0.129411764705882 0.129411764705882 0.129411764705882];
            app.DeadReckoningEstimateSwitch.Position = [113 120 45 20];
            app.DeadReckoningEstimateSwitch.Value = 'on';

            % Create OOIsSwitchLabel
            app.OOIsSwitchLabel = uilabel(app.visibilityControl);
            app.OOIsSwitchLabel.HorizontalAlignment = 'center';
            app.OOIsSwitchLabel.FontColor = [0.129411764705882 0.129411764705882 0.129411764705882];
            app.OOIsSwitchLabel.Position = [120 7 35 22];
            app.OOIsSwitchLabel.Text = 'OOI''s';

            % Create OOIsSwitch
            app.OOIsSwitch = uiswitch(app.visibilityControl, 'slider');
            app.OOIsSwitch.ItemsData = {'off', 'on'};
            app.OOIsSwitch.ValueChangedFcn = createCallbackFcn(app, @OOIsSwitchValueChanged, true);
            app.OOIsSwitch.FontColor = [0.129411764705882 0.129411764705882 0.129411764705882];
            app.OOIsSwitch.Position = [113 44 45 20];
            app.OOIsSwitch.Value = 'on';

            % Create ResetPlaybackButton
            app.ResetPlaybackButton = uibutton(app.visibilityControl, 'push');
            app.ResetPlaybackButton.ButtonPushedFcn = createCallbackFcn(app, @ResetPlaybackButtonPushed, true);
            app.ResetPlaybackButton.BackgroundColor = [0.96078431372549 0.96078431372549 0.96078431372549];
            app.ResetPlaybackButton.FontColor = [0.129411764705882 0.129411764705882 0.129411764705882];
            app.ResetPlaybackButton.Position = [87 314 100 23];
            app.ResetPlaybackButton.Text = 'Reset Playback';

            % Create ErrorPanel
            app.ErrorPanel = uipanel(app.StatusGridLayout);
            app.ErrorPanel.Layout.Row = [2 3];
            app.ErrorPanel.Layout.Column = 1;

            % Create ErrorAxes
            app.ErrorAxes = uiaxes(app.ErrorPanel);
            title(app.ErrorAxes, 'Measured Error')
            zlabel(app.ErrorAxes, 'Z')
            subtitle(app.ErrorAxes, ' in D.R Approximation')
            app.ErrorAxes.XLimitMethod = 'padded';
            app.ErrorAxes.YLimitMethod = 'padded';
            app.ErrorAxes.ZLimitMethod = 'padded';
            app.ErrorAxes.YDir = 'reverse';
            app.ErrorAxes.XAxisLocation = 'top';
            app.ErrorAxes.YAxisLocation = 'origin';
            app.ErrorAxes.YTickLabel = '';
            app.ErrorAxes.Box = 'on';
            app.ErrorAxes.XGrid = 'on';
            app.ErrorAxes.YGrid = 'on';
            app.ErrorAxes.Position = [0 8 188 540];

            % Create ParameterControlTab
            app.ParameterControlTab = uitab(app.TabGroup);
            app.ParameterControlTab.Title = 'Parameter Control';
            app.ParameterControlTab.BackgroundColor = [1 1 1];
            app.ParameterControlTab.ForegroundColor = [0.129411764705882 0.129411764705882 0.129411764705882];

            % Create ParamGridLayout
            app.ParamGridLayout = uigridlayout(app.ParameterControlTab);
            app.ParamGridLayout.ColumnWidth = {10, 70, '0.1x', 70, '0.1x', 70, '0.15x', '1x', 350};
            app.ParamGridLayout.RowHeight = {160, '1x', 25, 20, 225};
            app.ParamGridLayout.BackgroundColor = [0.96078431372549 0.96078431372549 0.96078431372549];

            % Create Panel_7
            app.Panel_7 = uipanel(app.ParamGridLayout);
            app.Panel_7.BorderType = 'none';
            app.Panel_7.BackgroundColor = [0.9412 0.9412 0.9412];
            app.Panel_7.Layout.Row = [3 4];
            app.Panel_7.Layout.Column = [1 7];

            % Create Switch
            app.Switch = uiswitch(app.Panel_7, 'rocker');
            app.Switch.Items = {'r', 'd'};
            app.Switch.ValueChangedFcn = createCallbackFcn(app, @SwitchValueChanged, true);
            app.Switch.FontSize = 8;
            app.Switch.FontColor = [0.129411764705882 0.129411764705882 0.129411764705882];
            app.Switch.Position = [346 7 20 45];
            app.Switch.Value = 'r';

            % Create degreeradsLabel
            app.degreeradsLabel = uilabel(app.Panel_7);
            app.degreeradsLabel.WordWrap = 'on';
            app.degreeradsLabel.FontColor = [0.129411764705882 0.129411764705882 0.129411764705882];
            app.degreeradsLabel.Interpreter = 'latex';
            app.degreeradsLabel.Position = [371 9 25 34];
            app.degreeradsLabel.Text = {'\degree'; 'rads'};

            % Create Panel_2
            app.Panel_2 = uipanel(app.ParamGridLayout);
            app.Panel_2.BorderType = 'none';
            app.Panel_2.BorderWidth = 0;
            app.Panel_2.Layout.Row = 1;
            app.Panel_2.Layout.Column = [1 7];

            % Create ActiveFileDropDownLabel
            app.ActiveFileDropDownLabel = uilabel(app.Panel_2);
            app.ActiveFileDropDownLabel.HorizontalAlignment = 'center';
            app.ActiveFileDropDownLabel.FontSize = 14;
            app.ActiveFileDropDownLabel.FontWeight = 'bold';
            app.ActiveFileDropDownLabel.FontColor = [0.129411764705882 0.129411764705882 0.129411764705882];
            app.ActiveFileDropDownLabel.Position = [29 115 290 22];
            app.ActiveFileDropDownLabel.Text = 'Active File';

            % Create ActiveFileDropDown
            app.ActiveFileDropDown = uidropdown(app.Panel_2);
            app.ActiveFileDropDown.ValueChangedFcn = createCallbackFcn(app, @ActiveFileDropDownValueChanged, true);
            app.ActiveFileDropDown.FontColor = [0.129411764705882 0.129411764705882 0.129411764705882];
            app.ActiveFileDropDown.BackgroundColor = [0.96078431372549 0.96078431372549 0.96078431372549];
            app.ActiveFileDropDown.Position = [29 92 297 22];

            % Create FileLoadedLamp_2Label
            app.FileLoadedLamp_2Label = uilabel(app.Panel_2);
            app.FileLoadedLamp_2Label.HorizontalAlignment = 'right';
            app.FileLoadedLamp_2Label.Position = [114 44 68 22];
            app.FileLoadedLamp_2Label.Text = 'File Loaded';

            % Create FileLoadedLamp_2
            app.FileLoadedLamp_2 = uilamp(app.Panel_2);
            app.FileLoadedLamp_2.Position = [197 44 20 20];

            % Create IMUConfig
            app.IMUConfig = uipanel(app.ParamGridLayout);
            app.IMUConfig.BorderType = 'none';
            app.IMUConfig.Layout.Row = 5;
            app.IMUConfig.Layout.Column = [1 7];

            % Create GainSliderLabel
            app.GainSliderLabel = uilabel(app.IMUConfig);
            app.GainSliderLabel.HorizontalAlignment = 'right';
            app.GainSliderLabel.FontColor = [0.129411764705882 0.129411764705882 0.129411764705882];
            app.GainSliderLabel.Position = [26 113 30 22];
            app.GainSliderLabel.Text = 'Gain';

            % Create GainSlider
            app.GainSlider = uislider(app.IMUConfig);
            app.GainSlider.Limits = [0.01 10];
            app.GainSlider.ValueChangingFcn = createCallbackFcn(app, @GainSliderValueChanging, true);
            app.GainSlider.FontColor = [0.129411764705882 0.129411764705882 0.129411764705882];
            app.GainSlider.Position = [77 135 150 3];
            app.GainSlider.Value = 1;

            % Create BiasSliderLabel
            app.BiasSliderLabel = uilabel(app.IMUConfig);
            app.BiasSliderLabel.HorizontalAlignment = 'right';
            app.BiasSliderLabel.FontColor = [0.129411764705882 0.129411764705882 0.129411764705882];
            app.BiasSliderLabel.Position = [26 45 28 22];
            app.BiasSliderLabel.Text = 'Bias';

            % Create BiasSlider
            app.BiasSlider = uislider(app.IMUConfig);
            app.BiasSlider.Limits = [-3.14159265358979 3.14159265358979];
            app.BiasSlider.ValueChangingFcn = createCallbackFcn(app, @BiasSliderValueChanging, true);
            app.BiasSlider.FontColor = [0.129411764705882 0.129411764705882 0.129411764705882];
            app.BiasSlider.Position = [77 67 150 3];

            % Create IMUParametersLabel
            app.IMUParametersLabel = uilabel(app.IMUConfig);
            app.IMUParametersLabel.FontWeight = 'bold';
            app.IMUParametersLabel.FontColor = [0.129411764705882 0.129411764705882 0.129411764705882];
            app.IMUParametersLabel.Position = [112 170 96 22];
            app.IMUParametersLabel.Text = 'IMU Parameters';

            % Create gainSpinner
            app.gainSpinner = uispinner(app.IMUConfig);
            app.gainSpinner.Step = 0.05;
            app.gainSpinner.ValueChangingFcn = createCallbackFcn(app, @gainSpinnerValueChanging, true);
            app.gainSpinner.Limits = [0.01 10];
            app.gainSpinner.FontColor = [0.129411764705882 0.129411764705882 0.129411764705882];
            app.gainSpinner.Position = [251 114 100 22];
            app.gainSpinner.Value = 1;

            % Create biasSpinner
            app.biasSpinner = uispinner(app.IMUConfig);
            app.biasSpinner.Step = 0.0174533;
            app.biasSpinner.ValueChangingFcn = createCallbackFcn(app, @biasSpinnerValueChanging, true);
            app.biasSpinner.Limits = [-3.14159265358979 3.14159265358979];
            app.biasSpinner.FontColor = [0.129411764705882 0.129411764705882 0.129411764705882];
            app.biasSpinner.Position = [251 45 100 22];

            % Create Panel_5
            app.Panel_5 = uipanel(app.ParamGridLayout);
            app.Panel_5.Layout.Row = 5;
            app.Panel_5.Layout.Column = 9;

            % Create EXITButton_2
            app.EXITButton_2 = uibutton(app.Panel_5, 'push');
            app.EXITButton_2.ButtonPushedFcn = createCallbackFcn(app, @EXITButtonPushed, true);
            app.EXITButton_2.BackgroundColor = [0.96078431372549 0.96078431372549 0.96078431372549];
            app.EXITButton_2.FontWeight = 'bold';
            app.EXITButton_2.FontColor = [0.129411764705882 0.129411764705882 0.129411764705882];
            app.EXITButton_2.Position = [230 16 100 23];
            app.EXITButton_2.Text = 'EXIT';

            % Create GotoStatusButton
            app.GotoStatusButton = uibutton(app.Panel_5, 'push');
            app.GotoStatusButton.ButtonPushedFcn = createCallbackFcn(app, @GotoStatusButtonPushed, true);
            app.GotoStatusButton.BackgroundColor = [0.96078431372549 0.96078431372549 0.96078431372549];
            app.GotoStatusButton.FontWeight = 'bold';
            app.GotoStatusButton.FontColor = [0.129411764705882 0.129411764705882 0.129411764705882];
            app.GotoStatusButton.Position = [231 48 100 23];
            app.GotoStatusButton.Text = 'Go to Status';

            % Create InitialPosPanel
            app.InitialPosPanel = uipanel(app.ParamGridLayout);
            app.InitialPosPanel.BorderType = 'none';
            app.InitialPosPanel.Layout.Row = 2;
            app.InitialPosPanel.Layout.Column = [1 7];

            % Create initPosAxes
            app.initPosAxes = uiaxes(app.InitialPosPanel);
            title(app.initPosAxes, 'Initial Position')
            xlabel(app.initPosAxes, 'X')
            ylabel(app.initPosAxes, 'Y')
            zlabel(app.initPosAxes, 'Z')
            app.initPosAxes.DataAspectRatio = [1 1 1];
            app.initPosAxes.XLim = [-5 22];
            app.initPosAxes.YLim = [-6 21];
            app.initPosAxes.XTick = [-5 0 5 10 15 20];
            app.initPosAxes.XTickLabel = {'-5'; '0'; '5'; '10'; '15'; '20'};
            app.initPosAxes.BoxStyle = 'full';
            app.initPosAxes.Box = 'on';
            app.initPosAxes.XGrid = 'on';
            app.initPosAxes.YGrid = 'on';
            app.initPosAxes.Position = [1 16 375 233];

            % Create XEditFieldLabel
            app.XEditFieldLabel = uilabel(app.ParamGridLayout);
            app.XEditFieldLabel.HorizontalAlignment = 'center';
            app.XEditFieldLabel.FontWeight = 'bold';
            app.XEditFieldLabel.FontAngle = 'italic';
            app.XEditFieldLabel.FontColor = [0.129411764705882 0.129411764705882 0.129411764705882];
            app.XEditFieldLabel.Layout.Row = 4;
            app.XEditFieldLabel.Layout.Column = 2;
            app.XEditFieldLabel.Text = 'X';

            % Create initX
            app.initX = uieditfield(app.ParamGridLayout, 'numeric');
            app.initX.ValueChangedFcn = createCallbackFcn(app, @initXValueChanged, true);
            app.initX.HorizontalAlignment = 'center';
            app.initX.FontColor = [0.129411764705882 0.129411764705882 0.129411764705882];
            app.initX.Layout.Row = 3;
            app.initX.Layout.Column = 2;

            % Create thetaEditFieldLabel
            app.thetaEditFieldLabel = uilabel(app.ParamGridLayout);
            app.thetaEditFieldLabel.HorizontalAlignment = 'center';
            app.thetaEditFieldLabel.FontWeight = 'bold';
            app.thetaEditFieldLabel.FontAngle = 'italic';
            app.thetaEditFieldLabel.FontColor = [0.129411764705882 0.129411764705882 0.129411764705882];
            app.thetaEditFieldLabel.Layout.Row = 4;
            app.thetaEditFieldLabel.Layout.Column = 6;
            app.thetaEditFieldLabel.Interpreter = 'latex';
            app.thetaEditFieldLabel.Text = '\theta';

            % Create initTheta
            app.initTheta = uieditfield(app.ParamGridLayout, 'numeric');
            app.initTheta.ValueChangedFcn = createCallbackFcn(app, @initThetaValueChanged, true);
            app.initTheta.HorizontalAlignment = 'center';
            app.initTheta.FontColor = [0.129411764705882 0.129411764705882 0.129411764705882];
            app.initTheta.Layout.Row = 3;
            app.initTheta.Layout.Column = 6;

            % Create YEditFieldLabel
            app.YEditFieldLabel = uilabel(app.ParamGridLayout);
            app.YEditFieldLabel.HorizontalAlignment = 'center';
            app.YEditFieldLabel.FontWeight = 'bold';
            app.YEditFieldLabel.FontAngle = 'italic';
            app.YEditFieldLabel.FontColor = [0.129411764705882 0.129411764705882 0.129411764705882];
            app.YEditFieldLabel.Layout.Row = 4;
            app.YEditFieldLabel.Layout.Column = 4;
            app.YEditFieldLabel.Text = 'Y';

            % Create initY
            app.initY = uieditfield(app.ParamGridLayout, 'numeric');
            app.initY.ValueChangedFcn = createCallbackFcn(app, @initYValueChanged, true);
            app.initY.HorizontalAlignment = 'center';
            app.initY.FontColor = [0.129411764705882 0.129411764705882 0.129411764705882];
            app.initY.Layout.Row = 3;
            app.initY.Layout.Column = 4;

            % Create ParameterDisplay
            app.ParameterDisplay = uipanel(app.ParamGridLayout);
            app.ParameterDisplay.Layout.Row = [1 5];
            app.ParameterDisplay.Layout.Column = 8;

            % Create ParamTree
            app.ParamTree = uitree(app.ParameterDisplay);
            app.ParamTree.Position = [28 368 271 303];

            % Create ParametersNode
            app.ParametersNode = uitreenode(app.ParamTree);
            app.ParametersNode.Text = 'Parameters';

            % Create ActiveFileNode
            app.ActiveFileNode = uitreenode(app.ParametersNode);
            app.ActiveFileNode.Text = 'Active File';

            % Create CurrentActiveFile
            app.CurrentActiveFile = uitreenode(app.ActiveFileNode);
            app.CurrentActiveFile.Text = 'Node';

            % Create InitialCoordinatesNode
            app.InitialCoordinatesNode = uitreenode(app.ParametersNode);
            app.InitialCoordinatesNode.Text = 'Initial Co-ordinates';

            % Create CurrentInitialCoords
            app.CurrentInitialCoords = uitreenode(app.InitialCoordinatesNode);
            app.CurrentInitialCoords.Text = 'Node';

            % Create IMUGainNode
            app.IMUGainNode = uitreenode(app.ParametersNode);
            app.IMUGainNode.Text = 'IMU Gain';

            % Create CurrentGain
            app.CurrentGain = uitreenode(app.IMUGainNode);
            app.CurrentGain.Text = 'Node';

            % Create IMUBiasNode
            app.IMUBiasNode = uitreenode(app.ParametersNode);
            app.IMUBiasNode.Text = 'IMU Bias';

            % Create CurrentBias
            app.CurrentBias = uitreenode(app.IMUBiasNode);
            app.CurrentBias.Text = 'Node';

            % Create applyAndRun
            app.applyAndRun = uibutton(app.ParameterDisplay, 'push');
            app.applyAndRun.ButtonPushedFcn = createCallbackFcn(app, @applyAndRunPushed, true);
            app.applyAndRun.Position = [55 57 219 47];
            app.applyAndRun.Text = 'Apply Parameters and Run Simulation';

            % Create ResetParamsButton
            app.ResetParamsButton = uibutton(app.ParameterDisplay, 'push');
            app.ResetParamsButton.ButtonPushedFcn = createCallbackFcn(app, @ResetParamsButtonPushed, true);
            app.ResetParamsButton.Enable = 'off';
            app.ResetParamsButton.Position = [55 115 219 47];
            app.ResetParamsButton.Text = 'Reset Parameters';

            % Create Panel_8
            app.Panel_8 = uipanel(app.ParamGridLayout);
            app.Panel_8.Layout.Row = 2;
            app.Panel_8.Layout.Column = 9;

            % Create LidarInitialPositionLabel
            app.LidarInitialPositionLabel = uilabel(app.Panel_8);
            app.LidarInitialPositionLabel.HorizontalAlignment = 'center';
            app.LidarInitialPositionLabel.FontSize = 18;
            app.LidarInitialPositionLabel.FontWeight = 'bold';
            app.LidarInitialPositionLabel.Position = [90 203 177 23];
            app.LidarInitialPositionLabel.Text = 'Lidar Initial Position';

            % Create relativetoplatformcoordinatesystemLabel
            app.relativetoplatformcoordinatesystemLabel = uilabel(app.Panel_8);
            app.relativetoplatformcoordinatesystemLabel.HorizontalAlignment = 'center';
            app.relativetoplatformcoordinatesystemLabel.FontSize = 10;
            app.relativetoplatformcoordinatesystemLabel.FontWeight = 'bold';
            app.relativetoplatformcoordinatesystemLabel.Position = [78 178 197 22];
            app.relativetoplatformcoordinatesystemLabel.Text = '(relative to platform co-ordinate system)';

            % Create Image
            app.Image = uiimage(app.Panel_8);
            app.Image.Position = [3 -9 345 195];
            app.Image.ImageSource = fullfile(pathToMLAPP, 'src', 'annotatedModel2.png');

            % Create lidarConfigPanel
            app.lidarConfigPanel = uipanel(app.ParamGridLayout);
            app.lidarConfigPanel.BorderType = 'none';
            app.lidarConfigPanel.Layout.Row = [3 4];
            app.lidarConfigPanel.Layout.Column = 9;

            % Create degRadSelector
            app.degRadSelector = uiswitch(app.lidarConfigPanel, 'rocker');
            app.degRadSelector.Items = {'r', 'd'};
            app.degRadSelector.FontSize = 8;
            app.degRadSelector.FontColor = [0.902 0.902 0.902];
            app.degRadSelector.Position = [298 9 20 45];
            app.degRadSelector.Value = 'r';

            % Create XEditFieldLabel_2
            app.XEditFieldLabel_2 = uilabel(app.lidarConfigPanel);
            app.XEditFieldLabel_2.HorizontalAlignment = 'center';
            app.XEditFieldLabel_2.FontWeight = 'bold';
            app.XEditFieldLabel_2.FontAngle = 'italic';
            app.XEditFieldLabel_2.FontColor = [0.129411764705882 0.129411764705882 0.129411764705882];
            app.XEditFieldLabel_2.Position = [9 0 70 20];
            app.XEditFieldLabel_2.Text = 'X';

            % Create lidarX
            app.lidarX = uieditfield(app.lidarConfigPanel, 'numeric');
            app.lidarX.ValueChangedFcn = createCallbackFcn(app, @lidarXValueChanged, true);
            app.lidarX.HorizontalAlignment = 'center';
            app.lidarX.FontColor = [0.129411764705882 0.129411764705882 0.129411764705882];
            app.lidarX.Position = [9 30 70 25];

            % Create thetaEditFieldLabel_2
            app.thetaEditFieldLabel_2 = uilabel(app.lidarConfigPanel);
            app.thetaEditFieldLabel_2.HorizontalAlignment = 'center';
            app.thetaEditFieldLabel_2.FontWeight = 'bold';
            app.thetaEditFieldLabel_2.FontAngle = 'italic';
            app.thetaEditFieldLabel_2.FontColor = [0.129411764705882 0.129411764705882 0.129411764705882];
            app.thetaEditFieldLabel_2.Interpreter = 'latex';
            app.thetaEditFieldLabel_2.Position = [213 1 70 20];
            app.thetaEditFieldLabel_2.Text = '\theta';

            % Create lidarTheta
            app.lidarTheta = uieditfield(app.lidarConfigPanel, 'numeric');
            app.lidarTheta.ValueChangedFcn = createCallbackFcn(app, @lidarThetaValueChanged, true);
            app.lidarTheta.HorizontalAlignment = 'center';
            app.lidarTheta.FontColor = [0.129411764705882 0.129411764705882 0.129411764705882];
            app.lidarTheta.Position = [213 31 70 25];

            % Create YEditFieldLabel_2
            app.YEditFieldLabel_2 = uilabel(app.lidarConfigPanel);
            app.YEditFieldLabel_2.HorizontalAlignment = 'center';
            app.YEditFieldLabel_2.FontWeight = 'bold';
            app.YEditFieldLabel_2.FontAngle = 'italic';
            app.YEditFieldLabel_2.FontColor = [0.129411764705882 0.129411764705882 0.129411764705882];
            app.YEditFieldLabel_2.Position = [113 1 70 20];
            app.YEditFieldLabel_2.Text = 'Y';

            % Create lidarY
            app.lidarY = uieditfield(app.lidarConfigPanel, 'numeric');
            app.lidarY.ValueChangedFcn = createCallbackFcn(app, @lidarYValueChanged, true);
            app.lidarY.HorizontalAlignment = 'center';
            app.lidarY.FontColor = [0.129411764705882 0.129411764705882 0.129411764705882];
            app.lidarY.Position = [113 31 70 25];

            % Create degreeradsLabel_2
            app.degreeradsLabel_2 = uilabel(app.lidarConfigPanel);
            app.degreeradsLabel_2.WordWrap = 'on';
            app.degreeradsLabel_2.FontColor = [0.129411764705882 0.129411764705882 0.129411764705882];
            app.degreeradsLabel_2.Interpreter = 'latex';
            app.degreeradsLabel_2.Position = [323 11 25 34];
            app.degreeradsLabel_2.Text = {'\degree'; 'rads'};

            % Show the figure after all components are created
            app.MTRN4010ControlCentreUIFigure.Visible = 'on';
        end
    end

    % App creation and deletion
    methods (Access = public)

        % Construct app
        function app = interface

            runningApp = getRunningApp(app);

            % Check for running singleton app
            if isempty(runningApp)

                % Create UIFigure and components
                createComponents(app)

                % Register the app with App Designer
                registerApp(app, app.MTRN4010ControlCentreUIFigure)
            else

                % Focus the running singleton app
                figure(runningApp.MTRN4010ControlCentreUIFigure)

                app = runningApp;
            end

            if nargout == 0
                clear app
            end
        end

        % Code that executes before app deletion
        function delete(app)

            % Delete UIFigure when app is deleted
            delete(app.MTRN4010ControlCentreUIFigure)
        end
    end
end