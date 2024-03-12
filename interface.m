classdef interface < matlab.apps.AppBase

    % Properties that correspond to app components
    properties (Access = public)
        MTRN4010ControlCentreUIFigure  matlab.ui.Figure
        TabGroup                       matlab.ui.container.TabGroup
        StatusTab                      matlab.ui.container.Tab
        GridLayout                     matlab.ui.container.GridLayout
        Panel_9                        matlab.ui.container.Panel
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
        Panel                          matlab.ui.container.Panel
        XYLabel                        matlab.ui.control.Label
        iVyGauge                       matlab.ui.control.SemicircularGauge
        SpeedmsGauge                   matlab.ui.control.Gauge
        SpeedmsGaugeLabel              matlab.ui.control.Label
        InstantaneousVelocityradssGauge  matlab.ui.control.LinearGauge
        InstantaneousVelocityradssGaugeLabel  matlab.ui.control.Label
        PlaybackSpeedLabel             matlab.ui.control.Label
        Button_2                       matlab.ui.control.Button
        Button                         matlab.ui.control.Button
        PausedLabel                    matlab.ui.control.Label
        PlayButton                     matlab.ui.control.StateButton
        iVxGauge                       matlab.ui.control.SemicircularGauge
        InstantaneousVelocitymsLabel   matlab.ui.control.Label
        SetParametersButton            matlab.ui.control.Button
        ProgramStatusPanel             matlab.ui.container.Panel
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
        GridLayout2                    matlab.ui.container.GridLayout
        Panel_8                        matlab.ui.container.Panel
        initY                          matlab.ui.control.NumericEditField
        YEditFieldLabel                matlab.ui.control.Label
        initTheta                      matlab.ui.control.NumericEditField
        thetaEditFieldLabel            matlab.ui.control.Label
        initX                          matlab.ui.control.NumericEditField
        XEditFieldLabel                matlab.ui.control.Label
        Panel_6                        matlab.ui.container.Panel
        initPosAxes                    matlab.ui.control.UIAxes
        Panel_5                        matlab.ui.container.Panel
        GotoStatusButton               matlab.ui.control.Button
        EXITButton_2                   matlab.ui.control.Button
        Panel_4                        matlab.ui.container.Panel
        biasSpinner                    matlab.ui.control.Spinner
        gainSpinner                    matlab.ui.control.Spinner
        IMUParametersLabel             matlab.ui.control.Label
        BiasSlider                     matlab.ui.control.Slider
        BiasSliderLabel                matlab.ui.control.Label
        GainSlider                     matlab.ui.control.Slider
        GainSliderLabel                matlab.ui.control.Label
        Panel_2                        matlab.ui.container.Panel
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
        

    end
    
    methods (Access = private)
        
        function drawInitPose(app)
            if (isempty(app.initX.Value) || ...
                isempty(app.initY.Value) || ...
                isempty(app.initTheta.Value))
                return;
            end
            coords = [app.initX.Value; app.initY.Value; app.InitPlot.Rads];
            arrow = app.getArrow(coords);
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
        
        %TODO - remove
        function wallObj = drawWalls(app, ax)
            wallObj = plot(ax, app.wallsData(1,:), app.wallsData(2,:), ...
                'LineWidth', 2, 'color', [205, 127, 50]/255);
        end
    end
    
    methods (Access = public)
        
        function ready = initialise(app, data)
            arguments
                app
                data.directory
                data.Walls (2,:) double
                data.Position (3,1) double = [0 0 0]
            end
            % init properties
            app.PlaybackRequested = false;
            app.PlaybackResetRequested = false;

            % initialise axes objects
            app.wallsData = data.Walls;
            %GCF Axes
            app.pathData = struct('deadReckoning', zeros(8,1), ...
                'groundTruth', zeros(2,1), ...
                'ooiCoords', zeros(2, 1), ...
                'error', zeros(2,1), ...
                'initialised', false);
            ax = app.GCFAxes;
            walls = line(ax, data.Walls(1,:), data.Walls(2,:), ...
                'LineWidth', 2, 'color', [205, 127, 50]/255);
            app.GCFPlot = struct( ...
                'DRline', line(ax, [0 0], [0 0], 'Color', [0 255 0]/255, 'LineWidth', 1.5), ...
                'arrow', line(ax, [0 0], [0 0], 'Color', [255 0 0]/255, 'LineWidth', 2), ...
                'GTLine', line(ax, [0 0], [0 0], 'Color', [186 26 26]/225, 'LineStyle', '--', 'LineWidth', 0.7),...
                'OOI', line(ax, [0 0], [0 0], 'Color', [186 26 26]/225, 'LineStyle', 'none', 'Marker', 'pentagram'), ...
                'WallsLine', walls);
            ax = app.ErrorAxes;
            app.ErrorPlot = struct( ...
                'XErrLine', line(ax, [0 0], [0 0], 'Color', [104 91 207]/255, 'LineWidth', 1.5), ...
                'YErrLine', line(ax, [0 0], [0 0], 'Color', [219 166 92]/255, 'LineWidth', 1.5), ...
                'origin', xline(ax, 0, 'Color',[212 212 212]/255, 'LineStyle','--'));

            %Initial Position Display Axes
            ax = app.initPosAxes;
            walls = line(ax, data.Walls(1,:), data.Walls(2,:), ...
                'LineWidth', 2, 'color', [205, 127, 50]/255);
            arrow = app.getArrow([0 0 0], 'scale', 1);
            app.InitPlot = struct( ...
                'walls', walls, ...
                'arrow', line(ax, arrow(1,:), arrow(2,:), 'LineStyle', 'none', 'Color', [255 0 0]/255, 'LineWidth', 2),...
                'Rads', data.Position(3));

            %TODO - add lidar stuff here

            app.playbackController = struct('option', 0, 'updateVis', false, 'tickRate', 0.05);


            
            % discover path files
            files = {};
            for i=1:length(data.directory)
                files{i} = data.directory(i).name;
            end
            app.ActiveFileDropDown.Items = files;
            app.ActiveFileDropDown.ItemsData = files;

            ready = true;
        end
        
        function loadPathData(app, data)
            arguments
                app
                data.deadReckoning   (8,:) double
                data.groundTruth     (2,:) double = [0;0]
                data.ooiCoords       (2,:) double = [0;0]
            end
            app.pathData.deadReckoning = data.deadReckoning;

            app.pathData.groundTruth = data.groundTruth;
            app.pathData.error = (data.groundTruth(:,:) - data.deadReckoning(1:2, :));

            app.GCFPlot.GTLine.XData = data.groundTruth(1,:);
            app.GCFPlot.GTLine.YData = data.groundTruth(2,:);

            app.pathData.ooiCoords = data.ooiCoords;
            app.GCFPlot.OOI.XData = data.ooiCoords(1,:);
            app.GCFPlot.OOI.YData = data.ooiCoords(2,:);

            app.pathData.initialised = true;
            
        end
        function startPlaybackSession(app) %move to private later
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
            pause(0.05);
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
            app.iVyGauge.Value = coords(7);
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
    end
    

    % Callbacks that handle component events
    methods (Access = private)

        % Callback function
        function AmplitudeSliderValueChanged(app, event)
            value = app.AmplitudeSlider.Value;
            plot(app.GCFAxes, value*peaks)
            app.GCFAxes.YLim = [-1000, 1000];
            
        end

        % Value changing function: gainSpinner
        function gainSpinnerValueChanging(app, event)
            changingValue = event.Value;
            app.GainSlider.Value = changingValue;
        end

        % Value changing function: biasSpinner
        function biasSpinnerValueChanging(app, event)
            changingValue = event.Value;
            app.BiasSlider.Value = changingValue;
        end

        % Value changing function: GainSlider
        function GainSliderValueChanging(app, event)
            changingValue = event.Value;
            app.gainSpinner.Value = changingValue;
        end

        % Value changing function: BiasSlider
        function BiasSliderValueChanging(app, event)
            changingValue = event.Value;
            app.biasSpinner.Value = changingValue;
        end

        % Value changed function: initX
        function initXValueChanged(app, event)
            app.drawInitPose();
        end

        % Value changed function: initY
        function initYValueChanged(app, event)
            app.drawInitPose();            
        end

        % Value changed function: initTheta
        function initThetaValueChanged(app, event)
            app.SwitchValueChanged;
        end

        % Button pushed function: EXITButton, EXITButton_2
        function EXITButtonPushed(app, event)
            app.delete;
        end

        % Button pushed function: SetParametersButton
        function SetParametersButtonPushed(app, event)
            app.TabGroup.SelectedTab = app.ParameterControlTab;
        end

        % Button pushed function: GotoStatusButton
        function GotoStatusButtonPushed(app, event)
            app.TabGroup.SelectedTab = app.StatusTab;
        end

        % Value changed function: Switch
        function SwitchValueChanged(app, event)
            value = app.Switch.Value;
            if (value == 'd')
                app.InitPlot.Rads = deg2rad(app.initTheta.Value);
            else
                app.InitPlot.Rads = app.initTheta.Value;
            end
            app.drawInitPose;


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
            app.playbackController.option = 5;
        end

        % Value changed function: DeadReckoningEstimateSwitch, 
        % ...and 3 other components
        function UpdateVis(app, event)
            app.playbackController.updateVis = true;
        end

        % Value changed function: PlayButton
        function PlayButtonValueChanged(app, event)
            value = app.PlayButton.Value;
            pathToMLAPP = fileparts(mfilename('fullpath'));
            if (~value)
                app.PlayButton.Icon = fullfile(pathToMLAPP, 'src', 'pause.png');
                app.PlayButton.Text = 'Pause';
                app.playbackController.option = 1; % set to play
                app.PausedLabel.Text = 'Playing';
            else
                app.PlayButton.Icon = fullfile(pathToMLAPP, 'src', 'play.png');
                app.PlayButton.Text = 'Play';
                app.playbackController.option = 0; % set to pause
                app.PausedLabel.Text = 'Paused';
            end
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
            app.MTRN4010ControlCentreUIFigure.WindowStyle = 'modal';

            % Create TabGroup
            app.TabGroup = uitabgroup(app.MTRN4010ControlCentreUIFigure);
            app.TabGroup.Position = [1 1 1115 763];

            % Create StatusTab
            app.StatusTab = uitab(app.TabGroup);
            app.StatusTab.Title = 'Status';
            app.StatusTab.BackgroundColor = [1 1 1];

            % Create GridLayout
            app.GridLayout = uigridlayout(app.StatusTab);
            app.GridLayout.ColumnWidth = {200, 165, '1x', 200};
            app.GridLayout.RowHeight = {20, '3x', '1x', '1x', 20};
            app.GridLayout.RowSpacing = 2.8;
            app.GridLayout.Padding = [10 2.8 10 2.8];

            % Create CLidarAxes
            app.CLidarAxes = uiaxes(app.GridLayout);
            title(app.CLidarAxes, 'LIDAR_1 (Cartesian)')
            xlabel(app.CLidarAxes, 'X')
            ylabel(app.CLidarAxes, 'Y')
            zlabel(app.CLidarAxes, 'Z')
            app.CLidarAxes.XGrid = 'on';
            app.CLidarAxes.YGrid = 'on';
            app.CLidarAxes.Layout.Row = 4;
            app.CLidarAxes.Layout.Column = [2 3];

            % Create PLidarAxes
            app.PLidarAxes = uiaxes(app.GridLayout);
            title(app.PLidarAxes, 'LIDAR_1 (Polar)')
            xlabel(app.PLidarAxes, 'X')
            ylabel(app.PLidarAxes, 'Y')
            zlabel(app.PLidarAxes, 'Z')
            app.PLidarAxes.XGrid = 'on';
            app.PLidarAxes.YGrid = 'on';
            app.PLidarAxes.Layout.Row = 3;
            app.PLidarAxes.Layout.Column = [2 3];

            % Create GCFAxes
            app.GCFAxes = uiaxes(app.GridLayout);
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
            app.MTRN4010Assignment1ControlCentreLabel = uilabel(app.GridLayout);
            app.MTRN4010Assignment1ControlCentreLabel.HorizontalAlignment = 'center';
            app.MTRN4010Assignment1ControlCentreLabel.FontSize = 14;
            app.MTRN4010Assignment1ControlCentreLabel.FontWeight = 'bold';
            app.MTRN4010Assignment1ControlCentreLabel.Layout.Row = 1;
            app.MTRN4010Assignment1ControlCentreLabel.Layout.Column = [2 3];
            app.MTRN4010Assignment1ControlCentreLabel.Text = 'MTRN4010 Assignment 1 Control Centre';

            % Create RobotStatusPanel
            app.RobotStatusPanel = uipanel(app.GridLayout);
            app.RobotStatusPanel.ForegroundColor = [0 0 0];
            app.RobotStatusPanel.BorderType = 'none';
            app.RobotStatusPanel.TitlePosition = 'centertop';
            app.RobotStatusPanel.Title = 'Robot Status';
            app.RobotStatusPanel.BackgroundColor = [0.94 0.94 0.94];
            app.RobotStatusPanel.Layout.Row = [3 4];
            app.RobotStatusPanel.Layout.Column = 4;
            app.RobotStatusPanel.FontName = 'Candara';
            app.RobotStatusPanel.FontWeight = 'bold';

            % Create InitialisedLampLabel
            app.InitialisedLampLabel = uilabel(app.RobotStatusPanel);
            app.InitialisedLampLabel.HorizontalAlignment = 'right';
            app.InitialisedLampLabel.FontName = 'Candara';
            app.InitialisedLampLabel.Position = [103 221 53 22];
            app.InitialisedLampLabel.Text = 'Initialised';

            % Create InitialisedLamp
            app.InitialisedLamp = uilamp(app.RobotStatusPanel);
            app.InitialisedLamp.Position = [171 221 20 20];

            % Create ParametersSetLampLabel
            app.ParametersSetLampLabel = uilabel(app.RobotStatusPanel);
            app.ParametersSetLampLabel.HorizontalAlignment = 'right';
            app.ParametersSetLampLabel.FontName = 'Candara';
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
            app.CalculationsCompleteLampLabel.Position = [38 81 118 22];
            app.CalculationsCompleteLampLabel.Text = 'Calculations Complete';

            % Create CalculationsCompleteLamp
            app.CalculationsCompleteLamp = uilamp(app.RobotStatusPanel);
            app.CalculationsCompleteLamp.Position = [171 81 20 20];
            app.CalculationsCompleteLamp.Color = [1 0 0];

            % Create EXITButton
            app.EXITButton = uibutton(app.RobotStatusPanel, 'push');
            app.EXITButton.ButtonPushedFcn = createCallbackFcn(app, @EXITButtonPushed, true);
            app.EXITButton.FontWeight = 'bold';
            app.EXITButton.Position = [52 1 100 23];
            app.EXITButton.Text = 'EXIT';

            % Create PlottingLampLabel
            app.PlottingLampLabel = uilabel(app.RobotStatusPanel);
            app.PlottingLampLabel.HorizontalAlignment = 'right';
            app.PlottingLampLabel.FontName = 'Candara';
            app.PlottingLampLabel.Position = [110 42 45 22];
            app.PlottingLampLabel.Text = 'Plotting';

            % Create PlottingLamp
            app.PlottingLamp = uilamp(app.RobotStatusPanel);
            app.PlottingLamp.Position = [170 42 20 20];
            app.PlottingLamp.Color = [1 0 0];

            % Create ProgramStatusPanel
            app.ProgramStatusPanel = uipanel(app.GridLayout);
            app.ProgramStatusPanel.BorderType = 'none';
            app.ProgramStatusPanel.TitlePosition = 'centertop';
            app.ProgramStatusPanel.Title = 'Program Status';
            app.ProgramStatusPanel.Layout.Row = 4;
            app.ProgramStatusPanel.Layout.Column = 1;

            % Create CurrentStatusLabel
            app.CurrentStatusLabel = uilabel(app.ProgramStatusPanel);
            app.CurrentStatusLabel.FontSize = 18;
            app.CurrentStatusLabel.FontWeight = 'bold';
            app.CurrentStatusLabel.Position = [35 78 136 23];
            app.CurrentStatusLabel.Text = 'Current Status:';

            % Create Status
            app.Status = uitextarea(app.ProgramStatusPanel);
            app.Status.ValueChangedFcn = createCallbackFcn(app, @StatusValueChanged, true);
            app.Status.Editable = 'off';
            app.Status.HorizontalAlignment = 'center';
            app.Status.FontName = 'Lucida Console';
            app.Status.FontSize = 10;
            app.Status.Position = [14 39 175 25];

            % Create Panel
            app.Panel = uipanel(app.GridLayout);
            app.Panel.BorderType = 'none';
            app.Panel.BorderWidth = 0;
            app.Panel.Title = ' ';
            app.Panel.Layout.Row = 2;
            app.Panel.Layout.Column = 4;

            % Create SetParametersButton
            app.SetParametersButton = uibutton(app.Panel, 'push');
            app.SetParametersButton.ButtonPushedFcn = createCallbackFcn(app, @SetParametersButtonPushed, true);
            app.SetParametersButton.FontWeight = 'bold';
            app.SetParametersButton.Position = [51 9 102 23];
            app.SetParametersButton.Text = 'Set Parameters';

            % Create InstantaneousVelocitymsLabel
            app.InstantaneousVelocitymsLabel = uilabel(app.Panel);
            app.InstantaneousVelocitymsLabel.HorizontalAlignment = 'center';
            app.InstantaneousVelocitymsLabel.WordWrap = 'on';
            app.InstantaneousVelocitymsLabel.FontWeight = 'bold';
            app.InstantaneousVelocitymsLabel.Position = [56 339 90 57];
            app.InstantaneousVelocitymsLabel.Text = {'Instantaneous '; '    Velocity    (m/s)'};

            % Create iVxGauge
            app.iVxGauge = uigauge(app.Panel, 'semicircular');
            app.iVxGauge.Limits = [-2 2];
            app.iVxGauge.MajorTicks = [-2 -1 0 1 2];
            app.iVxGauge.Orientation = 'east';
            app.iVxGauge.ScaleDirection = 'counterclockwise';
            app.iVxGauge.Position = [4 255 73 136];

            % Create PlayButton
            app.PlayButton = uibutton(app.Panel, 'state');
            app.PlayButton.ValueChangedFcn = createCallbackFcn(app, @PlayButtonValueChanged, true);
            app.PlayButton.Icon = fullfile(pathToMLAPP, 'src', 'play.png');
            app.PlayButton.Text = 'Play';
            app.PlayButton.Position = [53 54 100 23];
            app.PlayButton.Value = true;

            % Create PausedLabel
            app.PausedLabel = uilabel(app.Panel);
            app.PausedLabel.HorizontalAlignment = 'center';
            app.PausedLabel.Position = [79 32 46 22];
            app.PausedLabel.Text = 'Paused';

            % Create Button
            app.Button = uibutton(app.Panel, 'push');
            app.Button.Icon = fullfile(pathToMLAPP, 'src', 'fast-forward.png');
            app.Button.Position = [155 54 27 23];
            app.Button.Text = '';

            % Create Button_2
            app.Button_2 = uibutton(app.Panel, 'push');
            app.Button_2.Icon = fullfile(pathToMLAPP, 'src', 'fast-backward.png');
            app.Button_2.Position = [24 54 27 23];
            app.Button_2.Text = '';

            % Create PlaybackSpeedLabel
            app.PlaybackSpeedLabel = uilabel(app.Panel);
            app.PlaybackSpeedLabel.HorizontalAlignment = 'center';
            app.PlaybackSpeedLabel.Position = [25 79 95 22];
            app.PlaybackSpeedLabel.Text = 'Playback Speed:';

            % Create InstantaneousVelocityradssGaugeLabel
            app.InstantaneousVelocityradssGaugeLabel = uilabel(app.Panel);
            app.InstantaneousVelocityradssGaugeLabel.HorizontalAlignment = 'center';
            app.InstantaneousVelocityradssGaugeLabel.WordWrap = 'on';
            app.InstantaneousVelocityradssGaugeLabel.FontWeight = 'bold';
            app.InstantaneousVelocityradssGaugeLabel.Position = [11 150 180 22];
            app.InstantaneousVelocityradssGaugeLabel.Text = 'Instantaneous Velocity (rads/s)';

            % Create InstantaneousVelocityradssGauge
            app.InstantaneousVelocityradssGauge = uigauge(app.Panel, 'linear');
            app.InstantaneousVelocityradssGauge.Limits = [-3.14 3.14];
            app.InstantaneousVelocityradssGauge.Position = [4 110 197 41];

            % Create SpeedmsGaugeLabel
            app.SpeedmsGaugeLabel = uilabel(app.Panel);
            app.SpeedmsGaugeLabel.HorizontalAlignment = 'center';
            app.SpeedmsGaugeLabel.FontWeight = 'bold';
            app.SpeedmsGaugeLabel.Position = [64 268 73 22];
            app.SpeedmsGaugeLabel.Text = 'Speed (m/s)';

            % Create SpeedmsGauge
            app.SpeedmsGauge = uigauge(app.Panel, 'circular');
            app.SpeedmsGauge.Limits = [0 2];
            app.SpeedmsGauge.Position = [56 180 92 92];

            % Create iVyGauge
            app.iVyGauge = uigauge(app.Panel, 'semicircular');
            app.iVyGauge.Limits = [-2 2];
            app.iVyGauge.MajorTicks = [-2 -1 0 1 2];
            app.iVyGauge.Orientation = 'west';
            app.iVyGauge.Position = [126 255 73 136];

            % Create XYLabel
            app.XYLabel = uilabel(app.Panel);
            app.XYLabel.HorizontalAlignment = 'center';
            app.XYLabel.FontWeight = 'bold';
            app.XYLabel.Position = [81 312 41 22];
            app.XYLabel.Text = 'X      Y';

            % Create visibilityControl
            app.visibilityControl = uipanel(app.GridLayout);
            app.visibilityControl.ForegroundColor = [0 0 0];
            app.visibilityControl.BorderType = 'none';
            app.visibilityControl.TitlePosition = 'centertop';
            app.visibilityControl.Title = 'Visibility Control';
            app.visibilityControl.BackgroundColor = [0.94 0.94 0.94];
            app.visibilityControl.Layout.Row = 2;
            app.visibilityControl.Layout.Column = 2;
            app.visibilityControl.FontWeight = 'bold';
            app.visibilityControl.FontSize = 18;

            % Create PositionIndicatorSwitchLabel
            app.PositionIndicatorSwitchLabel = uilabel(app.visibilityControl);
            app.PositionIndicatorSwitchLabel.HorizontalAlignment = 'center';
            app.PositionIndicatorSwitchLabel.Position = [88 237 97 22];
            app.PositionIndicatorSwitchLabel.Text = 'Position Indicator';

            % Create PositionIndicatorSwitch
            app.PositionIndicatorSwitch = uiswitch(app.visibilityControl, 'slider');
            app.PositionIndicatorSwitch.ItemsData = {'off', 'on'};
            app.PositionIndicatorSwitch.ValueChangedFcn = createCallbackFcn(app, @UpdateVis, true);
            app.PositionIndicatorSwitch.Position = [113 274 45 20];
            app.PositionIndicatorSwitch.Value = 'on';

            % Create GroundTruthSwitchLabel
            app.GroundTruthSwitchLabel = uilabel(app.visibilityControl);
            app.GroundTruthSwitchLabel.HorizontalAlignment = 'center';
            app.GroundTruthSwitchLabel.Position = [99 160 76 22];
            app.GroundTruthSwitchLabel.Text = 'Ground Truth';

            % Create GroundTruthSwitch
            app.GroundTruthSwitch = uiswitch(app.visibilityControl, 'slider');
            app.GroundTruthSwitch.ItemsData = {'off', 'on'};
            app.GroundTruthSwitch.ValueChangedFcn = createCallbackFcn(app, @UpdateVis, true);
            app.GroundTruthSwitch.Position = [113 197 45 20];
            app.GroundTruthSwitch.Value = 'on';

            % Create DeadReckoningEstimateLabel
            app.DeadReckoningEstimateLabel = uilabel(app.visibilityControl);
            app.DeadReckoningEstimateLabel.HorizontalAlignment = 'center';
            app.DeadReckoningEstimateLabel.WordWrap = 'on';
            app.DeadReckoningEstimateLabel.Position = [83 79 108 33];
            app.DeadReckoningEstimateLabel.Text = 'Dead Reckoning Estimate';

            % Create DeadReckoningEstimateSwitch
            app.DeadReckoningEstimateSwitch = uiswitch(app.visibilityControl, 'slider');
            app.DeadReckoningEstimateSwitch.ItemsData = {'off', 'on'};
            app.DeadReckoningEstimateSwitch.ValueChangedFcn = createCallbackFcn(app, @UpdateVis, true);
            app.DeadReckoningEstimateSwitch.Position = [113 120 45 20];
            app.DeadReckoningEstimateSwitch.Value = 'on';

            % Create OOIsSwitchLabel
            app.OOIsSwitchLabel = uilabel(app.visibilityControl);
            app.OOIsSwitchLabel.HorizontalAlignment = 'center';
            app.OOIsSwitchLabel.Position = [120 7 35 22];
            app.OOIsSwitchLabel.Text = 'OOI''s';

            % Create OOIsSwitch
            app.OOIsSwitch = uiswitch(app.visibilityControl, 'slider');
            app.OOIsSwitch.ItemsData = {'off', 'on'};
            app.OOIsSwitch.ValueChangedFcn = createCallbackFcn(app, @UpdateVis, true);
            app.OOIsSwitch.Position = [113 44 45 20];
            app.OOIsSwitch.Value = 'on';

            % Create ResetPlaybackButton
            app.ResetPlaybackButton = uibutton(app.visibilityControl, 'push');
            app.ResetPlaybackButton.ButtonPushedFcn = createCallbackFcn(app, @ResetPlaybackButtonPushed, true);
            app.ResetPlaybackButton.Position = [87 314 100 23];
            app.ResetPlaybackButton.Text = 'Reset Playback';

            % Create Panel_9
            app.Panel_9 = uipanel(app.GridLayout);
            app.Panel_9.ForegroundColor = [0 0 0];
            app.Panel_9.BackgroundColor = [0.94 0.94 0.94];
            app.Panel_9.Layout.Row = [2 3];
            app.Panel_9.Layout.Column = 1;

            % Create ErrorAxes
            app.ErrorAxes = uiaxes(app.Panel_9);
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

            % Create GridLayout2
            app.GridLayout2 = uigridlayout(app.ParameterControlTab);
            app.GridLayout2.ColumnWidth = {10, 70, '0.1x', 70, '0.1x', 70, '0.15x', '1x', 350};
            app.GridLayout2.RowHeight = {160, '1x', 25, 20, 225};

            % Create Panel_7
            app.Panel_7 = uipanel(app.GridLayout2);
            app.Panel_7.ForegroundColor = [0 0 0];
            app.Panel_7.BorderType = 'none';
            app.Panel_7.BackgroundColor = [0.9412 0.9412 0.9412];
            app.Panel_7.Layout.Row = [3 4];
            app.Panel_7.Layout.Column = [1 7];

            % Create Switch
            app.Switch = uiswitch(app.Panel_7, 'rocker');
            app.Switch.Items = {'r', 'd'};
            app.Switch.ValueChangedFcn = createCallbackFcn(app, @SwitchValueChanged, true);
            app.Switch.FontSize = 8;
            app.Switch.Position = [346 7 20 45];
            app.Switch.Value = 'r';

            % Create degreeradsLabel
            app.degreeradsLabel = uilabel(app.Panel_7);
            app.degreeradsLabel.WordWrap = 'on';
            app.degreeradsLabel.Interpreter = 'latex';
            app.degreeradsLabel.Position = [371 9 25 34];
            app.degreeradsLabel.Text = {'\degree'; 'rads'};

            % Create Panel_2
            app.Panel_2 = uipanel(app.GridLayout2);
            app.Panel_2.ForegroundColor = [0 0 0];
            app.Panel_2.BorderType = 'none';
            app.Panel_2.BorderWidth = 0;
            app.Panel_2.BackgroundColor = [0.94 0.94 0.94];
            app.Panel_2.Layout.Row = 1;
            app.Panel_2.Layout.Column = [1 7];

            % Create ActiveFileDropDownLabel
            app.ActiveFileDropDownLabel = uilabel(app.Panel_2);
            app.ActiveFileDropDownLabel.HorizontalAlignment = 'center';
            app.ActiveFileDropDownLabel.FontSize = 14;
            app.ActiveFileDropDownLabel.FontWeight = 'bold';
            app.ActiveFileDropDownLabel.Position = [29 92 290 22];
            app.ActiveFileDropDownLabel.Text = 'Active File';

            % Create ActiveFileDropDown
            app.ActiveFileDropDown = uidropdown(app.Panel_2);
            app.ActiveFileDropDown.Position = [29 69 297 22];

            % Create Panel_4
            app.Panel_4 = uipanel(app.GridLayout2);
            app.Panel_4.ForegroundColor = [0 0 0];
            app.Panel_4.BorderType = 'none';
            app.Panel_4.BackgroundColor = [0.94 0.94 0.94];
            app.Panel_4.Layout.Row = 5;
            app.Panel_4.Layout.Column = [1 7];

            % Create GainSliderLabel
            app.GainSliderLabel = uilabel(app.Panel_4);
            app.GainSliderLabel.HorizontalAlignment = 'right';
            app.GainSliderLabel.Position = [26 113 30 22];
            app.GainSliderLabel.Text = 'Gain';

            % Create GainSlider
            app.GainSlider = uislider(app.Panel_4);
            app.GainSlider.Limits = [0.01 10];
            app.GainSlider.ValueChangingFcn = createCallbackFcn(app, @GainSliderValueChanging, true);
            app.GainSlider.Position = [77 135 150 3];
            app.GainSlider.Value = 1;

            % Create BiasSliderLabel
            app.BiasSliderLabel = uilabel(app.Panel_4);
            app.BiasSliderLabel.HorizontalAlignment = 'right';
            app.BiasSliderLabel.Position = [26 45 28 22];
            app.BiasSliderLabel.Text = 'Bias';

            % Create BiasSlider
            app.BiasSlider = uislider(app.Panel_4);
            app.BiasSlider.Limits = [-3.14159265358979 3.14159265358979];
            app.BiasSlider.ValueChangingFcn = createCallbackFcn(app, @BiasSliderValueChanging, true);
            app.BiasSlider.Position = [77 67 150 3];

            % Create IMUParametersLabel
            app.IMUParametersLabel = uilabel(app.Panel_4);
            app.IMUParametersLabel.FontWeight = 'bold';
            app.IMUParametersLabel.Position = [112 170 96 22];
            app.IMUParametersLabel.Text = 'IMU Parameters';

            % Create gainSpinner
            app.gainSpinner = uispinner(app.Panel_4);
            app.gainSpinner.Step = 0.05;
            app.gainSpinner.ValueChangingFcn = createCallbackFcn(app, @gainSpinnerValueChanging, true);
            app.gainSpinner.Limits = [0.01 10];
            app.gainSpinner.Position = [251 114 100 22];
            app.gainSpinner.Value = 1;

            % Create biasSpinner
            app.biasSpinner = uispinner(app.Panel_4);
            app.biasSpinner.Step = 0.0174533;
            app.biasSpinner.ValueChangingFcn = createCallbackFcn(app, @biasSpinnerValueChanging, true);
            app.biasSpinner.Limits = [-3.14159265358979 3.14159265358979];
            app.biasSpinner.Position = [251 45 100 22];

            % Create Panel_5
            app.Panel_5 = uipanel(app.GridLayout2);
            app.Panel_5.ForegroundColor = [0 0 0];
            app.Panel_5.BackgroundColor = [0.94 0.94 0.94];
            app.Panel_5.Layout.Row = 5;
            app.Panel_5.Layout.Column = 9;

            % Create EXITButton_2
            app.EXITButton_2 = uibutton(app.Panel_5, 'push');
            app.EXITButton_2.ButtonPushedFcn = createCallbackFcn(app, @EXITButtonPushed, true);
            app.EXITButton_2.FontWeight = 'bold';
            app.EXITButton_2.Position = [230 16 100 23];
            app.EXITButton_2.Text = 'EXIT';

            % Create GotoStatusButton
            app.GotoStatusButton = uibutton(app.Panel_5, 'push');
            app.GotoStatusButton.ButtonPushedFcn = createCallbackFcn(app, @GotoStatusButtonPushed, true);
            app.GotoStatusButton.FontWeight = 'bold';
            app.GotoStatusButton.Position = [231 48 100 23];
            app.GotoStatusButton.Text = 'Go to Status';

            % Create Panel_6
            app.Panel_6 = uipanel(app.GridLayout2);
            app.Panel_6.ForegroundColor = [0 0 0];
            app.Panel_6.BorderType = 'none';
            app.Panel_6.BackgroundColor = [0.94 0.94 0.94];
            app.Panel_6.Layout.Row = 2;
            app.Panel_6.Layout.Column = [1 7];

            % Create initPosAxes
            app.initPosAxes = uiaxes(app.Panel_6);
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
            app.XEditFieldLabel = uilabel(app.GridLayout2);
            app.XEditFieldLabel.HorizontalAlignment = 'center';
            app.XEditFieldLabel.FontWeight = 'bold';
            app.XEditFieldLabel.FontAngle = 'italic';
            app.XEditFieldLabel.Layout.Row = 4;
            app.XEditFieldLabel.Layout.Column = 2;
            app.XEditFieldLabel.Text = 'X';

            % Create initX
            app.initX = uieditfield(app.GridLayout2, 'numeric');
            app.initX.AllowEmpty = 'on';
            app.initX.ValueChangedFcn = createCallbackFcn(app, @initXValueChanged, true);
            app.initX.HorizontalAlignment = 'center';
            app.initX.Layout.Row = 3;
            app.initX.Layout.Column = 2;
            app.initX.Value = [];

            % Create thetaEditFieldLabel
            app.thetaEditFieldLabel = uilabel(app.GridLayout2);
            app.thetaEditFieldLabel.HorizontalAlignment = 'center';
            app.thetaEditFieldLabel.FontWeight = 'bold';
            app.thetaEditFieldLabel.FontAngle = 'italic';
            app.thetaEditFieldLabel.Layout.Row = 4;
            app.thetaEditFieldLabel.Layout.Column = 6;
            app.thetaEditFieldLabel.Interpreter = 'latex';
            app.thetaEditFieldLabel.Text = '\theta';

            % Create initTheta
            app.initTheta = uieditfield(app.GridLayout2, 'numeric');
            app.initTheta.AllowEmpty = 'on';
            app.initTheta.ValueChangedFcn = createCallbackFcn(app, @initThetaValueChanged, true);
            app.initTheta.HorizontalAlignment = 'center';
            app.initTheta.Layout.Row = 3;
            app.initTheta.Layout.Column = 6;
            app.initTheta.Value = [];

            % Create YEditFieldLabel
            app.YEditFieldLabel = uilabel(app.GridLayout2);
            app.YEditFieldLabel.HorizontalAlignment = 'center';
            app.YEditFieldLabel.FontWeight = 'bold';
            app.YEditFieldLabel.FontAngle = 'italic';
            app.YEditFieldLabel.Layout.Row = 4;
            app.YEditFieldLabel.Layout.Column = 4;
            app.YEditFieldLabel.Text = 'Y';

            % Create initY
            app.initY = uieditfield(app.GridLayout2, 'numeric');
            app.initY.AllowEmpty = 'on';
            app.initY.ValueChangedFcn = createCallbackFcn(app, @initYValueChanged, true);
            app.initY.HorizontalAlignment = 'center';
            app.initY.Layout.Row = 3;
            app.initY.Layout.Column = 4;
            app.initY.Value = [];

            % Create Panel_8
            app.Panel_8 = uipanel(app.GridLayout2);
            app.Panel_8.ForegroundColor = [0 0 0];
            app.Panel_8.BackgroundColor = [0.94 0.94 0.94];
            app.Panel_8.Layout.Row = [1 2];
            app.Panel_8.Layout.Column = 8;

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