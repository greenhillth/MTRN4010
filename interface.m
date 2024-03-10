classdef interface < matlab.apps.AppBase

    % Properties that correspond to app components
    properties (Access = public)
        MTRN4010ControlCentreUIFigure  matlab.ui.Figure
        TabGroup                       matlab.ui.container.TabGroup
        StatusTab                      matlab.ui.container.Tab
        GridLayout                     matlab.ui.container.GridLayout
        visibilityControl              matlab.ui.container.Panel
        StartPlaybackButton            matlab.ui.control.Button
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
        SetParametersButton            matlab.ui.control.Button
        Gauge2                         matlab.ui.control.NinetyDegreeGauge
        Gauge2Label                    matlab.ui.control.Label
        Gauge1                         matlab.ui.control.NinetyDegreeGauge
        Gauge1Label                    matlab.ui.control.Label
        ProgramStatusPanel             matlab.ui.container.Panel
        Status                         matlab.ui.control.TextArea
        CurrentStatusLabel             matlab.ui.control.Label
        Tree                           matlab.ui.container.Tree
        Node                           matlab.ui.container.TreeNode
        Node2                          matlab.ui.container.TreeNode
        Node3                          matlab.ui.container.TreeNode
        Node4                          matlab.ui.container.TreeNode
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
        CLidarAxes                     matlab.ui.control.UIAxes
        PLidarAxes                     matlab.ui.control.UIAxes
        GCFAxes                        matlab.ui.control.UIAxes
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
    end
    
    properties (Access = public)
        PlaybackRequested boolean
        PlaybackResetRequested boolean% Description
    end
    
    methods (Access = private)
        
        function drawInitPose(app)
            if (isempty(app.initX.Value) || ...
                isempty(app.initY.Value) || ...
                isempty(app.initTheta.Value))
                return;
            end
            box = [-3, -3, 19, 19, -3;
                   -4, 18, 18, -4, -4];
            outline = [1, -.5, -.5, 1, 0;
                       0, -.5, .5, 0, 0];
            t = app.initRads;
            rotation = [cos(t) -sin(t); 
                        sin(t) cos(t)];
            translation = [app.initY.Value; app.initY.Value];
            arrow = rotation*(outline)+translation;
            ax = app.initPosAxes;
            cla(ax);
            hold(ax, "on");
            plot(ax, box(1,:), box(2,:), 'LineWidth', 2, 'Color', [205, 127, 50]/255);
            plot(ax, arrow(1,:), arrow(2,:), 'LineWidth', 2, 'Color', [255 14 14]/255);
            hold(ax, "off");
        end
    end
    
    methods (Access = public)
        
        function ready = initialise(app)
            % init properties
            app.PlaybackRequested = false;
            app.PlaybackResetRequested = false;
            
            % discover path files
            contents = dir(path);
            files = {};
            for i=1:length(contents)
                files{i} = contents(i).name;
            end
            app.ActiveFileDropDown.Items = files;
            app.ActiveFileDropDown.ItemsData = files;

            ready = true;
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
                app.initRads = deg2rad(app.initTheta.Value);
            else
                app.initRads = app.initTheta.Value;
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

        % Button pushed function: StartPlaybackButton
        function StartPlaybackButtonPushed(app, event)
            app.playbackRequested = true;
        end

        % Button pushed function: ResetPlaybackButton
        function ResetPlaybackButtonPushed(app, event)
            app.PlaybackResetRequested = true;
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

            % Create GridLayout
            app.GridLayout = uigridlayout(app.StatusTab);
            app.GridLayout.ColumnWidth = {200, 165, '1x', 200};
            app.GridLayout.RowHeight = {20, '3x', '1x', '1x', 20};
            app.GridLayout.RowSpacing = 2.8;
            app.GridLayout.Padding = [10 2.8 10 2.8];
            app.GridLayout.BackgroundColor = [0.96078431372549 0.96078431372549 0.96078431372549];

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
            app.GCFAxes.Color = [1 1 1];
            app.GCFAxes.Box = 'on';
            app.GCFAxes.XGrid = 'on';
            app.GCFAxes.YGrid = 'on';
            app.GCFAxes.ColorOrder = [0 0.447 0.741;0.85 0.325 0.098;0.929 0.694 0.125;0.494 0.184 0.556;0.466 0.674 0.188;0.301 0.745 0.933;0.635 0.078 0.184];
            app.GCFAxes.Layout.Row = 2;
            app.GCFAxes.Layout.Column = 3;

            % Create PLidarAxes
            app.PLidarAxes = uiaxes(app.GridLayout);
            title(app.PLidarAxes, 'LIDAR_1 (Polar)')
            xlabel(app.PLidarAxes, 'X')
            ylabel(app.PLidarAxes, 'Y')
            zlabel(app.PLidarAxes, 'Z')
            app.PLidarAxes.Color = [1 1 1];
            app.PLidarAxes.XGrid = 'on';
            app.PLidarAxes.YGrid = 'on';
            app.PLidarAxes.ColorOrder = [0 0.447 0.741;0.85 0.325 0.098;0.929 0.694 0.125;0.494 0.184 0.556;0.466 0.674 0.188;0.301 0.745 0.933;0.635 0.078 0.184];
            app.PLidarAxes.Layout.Row = 3;
            app.PLidarAxes.Layout.Column = [2 3];

            % Create CLidarAxes
            app.CLidarAxes = uiaxes(app.GridLayout);
            title(app.CLidarAxes, 'LIDAR_1 (Cartesian)')
            xlabel(app.CLidarAxes, 'X')
            ylabel(app.CLidarAxes, 'Y')
            zlabel(app.CLidarAxes, 'Z')
            app.CLidarAxes.Color = [1 1 1];
            app.CLidarAxes.XGrid = 'on';
            app.CLidarAxes.YGrid = 'on';
            app.CLidarAxes.ColorOrder = [0 0.447 0.741;0.85 0.325 0.098;0.929 0.694 0.125;0.494 0.184 0.556;0.466 0.674 0.188;0.301 0.745 0.933;0.635 0.078 0.184];
            app.CLidarAxes.Layout.Row = 4;
            app.CLidarAxes.Layout.Column = [2 3];

            % Create MTRN4010Assignment1ControlCentreLabel
            app.MTRN4010Assignment1ControlCentreLabel = uilabel(app.GridLayout);
            app.MTRN4010Assignment1ControlCentreLabel.HorizontalAlignment = 'center';
            app.MTRN4010Assignment1ControlCentreLabel.FontSize = 14;
            app.MTRN4010Assignment1ControlCentreLabel.FontWeight = 'bold';
            app.MTRN4010Assignment1ControlCentreLabel.FontColor = [0.129411764705882 0.129411764705882 0.129411764705882];
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
            app.EXITButton.BackgroundColor = [0.7412 0 0];
            app.EXITButton.FontWeight = 'bold';
            app.EXITButton.FontColor = [1 1 1];
            app.EXITButton.Position = [52 1 100 23];
            app.EXITButton.Text = 'EXIT';

            % Create PlottingLampLabel
            app.PlottingLampLabel = uilabel(app.RobotStatusPanel);
            app.PlottingLampLabel.HorizontalAlignment = 'right';
            app.PlottingLampLabel.FontName = 'Candara';
            app.PlottingLampLabel.FontColor = [0 0 0];
            app.PlottingLampLabel.Position = [110 42 45 22];
            app.PlottingLampLabel.Text = 'Plotting';

            % Create PlottingLamp
            app.PlottingLamp = uilamp(app.RobotStatusPanel);
            app.PlottingLamp.Position = [170 42 20 20];
            app.PlottingLamp.Color = [1 0 0];

            % Create ProgramStatusPanel
            app.ProgramStatusPanel = uipanel(app.GridLayout);
            app.ProgramStatusPanel.ForegroundColor = [0.129411764705882 0.129411764705882 0.129411764705882];
            app.ProgramStatusPanel.BorderType = 'none';
            app.ProgramStatusPanel.TitlePosition = 'centertop';
            app.ProgramStatusPanel.Title = 'Program Status';
            app.ProgramStatusPanel.BackgroundColor = [0.96078431372549 0.96078431372549 0.96078431372549];
            app.ProgramStatusPanel.Layout.Row = [2 4];
            app.ProgramStatusPanel.Layout.Column = 1;

            % Create Tree
            app.Tree = uitree(app.ProgramStatusPanel);
            app.Tree.FontColor = [0.129411764705882 0.129411764705882 0.129411764705882];
            app.Tree.BackgroundColor = [1 1 1];
            app.Tree.Position = [13 350 150 300];

            % Create Node
            app.Node = uitreenode(app.Tree);
            app.Node.Text = 'Node';

            % Create Node2
            app.Node2 = uitreenode(app.Node);
            app.Node2.Text = 'Node2';

            % Create Node3
            app.Node3 = uitreenode(app.Node);
            app.Node3.Text = 'Node3';

            % Create Node4
            app.Node4 = uitreenode(app.Node);
            app.Node4.Text = 'Node4';

            % Create CurrentStatusLabel
            app.CurrentStatusLabel = uilabel(app.ProgramStatusPanel);
            app.CurrentStatusLabel.FontSize = 18;
            app.CurrentStatusLabel.FontWeight = 'bold';
            app.CurrentStatusLabel.FontColor = [0.129411764705882 0.129411764705882 0.129411764705882];
            app.CurrentStatusLabel.Position = [34 68 136 23];
            app.CurrentStatusLabel.Text = 'Current Status:';

            % Create Status
            app.Status = uitextarea(app.ProgramStatusPanel);
            app.Status.ValueChangedFcn = createCallbackFcn(app, @StatusValueChanged, true);
            app.Status.Editable = 'off';
            app.Status.HorizontalAlignment = 'center';
            app.Status.FontName = 'Lucida Console';
            app.Status.FontSize = 10;
            app.Status.FontColor = [0.129411764705882 0.129411764705882 0.129411764705882];
            app.Status.BackgroundColor = [1 1 1];
            app.Status.Position = [13 29 175 25];

            % Create Panel
            app.Panel = uipanel(app.GridLayout);
            app.Panel.ForegroundColor = [0.129411764705882 0.129411764705882 0.129411764705882];
            app.Panel.BorderType = 'none';
            app.Panel.BorderWidth = 0;
            app.Panel.Title = ' ';
            app.Panel.BackgroundColor = [0.96078431372549 0.96078431372549 0.96078431372549];
            app.Panel.Layout.Row = 2;
            app.Panel.Layout.Column = 4;

            % Create Gauge1Label
            app.Gauge1Label = uilabel(app.Panel);
            app.Gauge1Label.HorizontalAlignment = 'center';
            app.Gauge1Label.FontColor = [0.129411764705882 0.129411764705882 0.129411764705882];
            app.Gauge1Label.Position = [92 363 48 22];
            app.Gauge1Label.Text = 'Gauge1';

            % Create Gauge1
            app.Gauge1 = uigauge(app.Panel, 'ninetydegree');
            app.Gauge1.Orientation = 'northeast';
            app.Gauge1.ScaleDirection = 'counterclockwise';
            app.Gauge1.BackgroundColor = [1 1 1];
            app.Gauge1.FontColor = [0.129411764705882 0.129411764705882 0.129411764705882];
            app.Gauge1.Position = [4 279 106 106];

            % Create Gauge2Label
            app.Gauge2Label = uilabel(app.Panel);
            app.Gauge2Label.HorizontalAlignment = 'center';
            app.Gauge2Label.FontColor = [0.129411764705882 0.129411764705882 0.129411764705882];
            app.Gauge2Label.Position = [92 238 48 22];
            app.Gauge2Label.Text = 'Gauge2';

            % Create Gauge2
            app.Gauge2 = uigauge(app.Panel, 'ninetydegree');
            app.Gauge2.Orientation = 'northeast';
            app.Gauge2.ScaleDirection = 'counterclockwise';
            app.Gauge2.BackgroundColor = [1 1 1];
            app.Gauge2.FontColor = [0.129411764705882 0.129411764705882 0.129411764705882];
            app.Gauge2.Position = [4 154 106 106];

            % Create SetParametersButton
            app.SetParametersButton = uibutton(app.Panel, 'push');
            app.SetParametersButton.ButtonPushedFcn = createCallbackFcn(app, @SetParametersButtonPushed, true);
            app.SetParametersButton.BackgroundColor = [0.1647 0.8706 0.1647];
            app.SetParametersButton.FontWeight = 'bold';
            app.SetParametersButton.FontColor = [0.149 0.149 0.149];
            app.SetParametersButton.Position = [51 9 102 23];
            app.SetParametersButton.Text = 'Set Parameters';

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
            app.PositionIndicatorSwitchLabel.FontColor = [0.129411764705882 0.129411764705882 0.129411764705882];
            app.PositionIndicatorSwitchLabel.Position = [88 237 97 22];
            app.PositionIndicatorSwitchLabel.Text = 'Position Indicator';

            % Create PositionIndicatorSwitch
            app.PositionIndicatorSwitch = uiswitch(app.visibilityControl, 'slider');
            app.PositionIndicatorSwitch.FontColor = [0.129411764705882 0.129411764705882 0.129411764705882];
            app.PositionIndicatorSwitch.Position = [113 274 45 20];
            app.PositionIndicatorSwitch.Value = 'On';

            % Create GroundTruthSwitchLabel
            app.GroundTruthSwitchLabel = uilabel(app.visibilityControl);
            app.GroundTruthSwitchLabel.HorizontalAlignment = 'center';
            app.GroundTruthSwitchLabel.FontColor = [0.129411764705882 0.129411764705882 0.129411764705882];
            app.GroundTruthSwitchLabel.Position = [99 160 76 22];
            app.GroundTruthSwitchLabel.Text = 'Ground Truth';

            % Create GroundTruthSwitch
            app.GroundTruthSwitch = uiswitch(app.visibilityControl, 'slider');
            app.GroundTruthSwitch.FontColor = [0.129411764705882 0.129411764705882 0.129411764705882];
            app.GroundTruthSwitch.Position = [113 197 45 20];
            app.GroundTruthSwitch.Value = 'On';

            % Create DeadReckoningEstimateLabel
            app.DeadReckoningEstimateLabel = uilabel(app.visibilityControl);
            app.DeadReckoningEstimateLabel.HorizontalAlignment = 'center';
            app.DeadReckoningEstimateLabel.WordWrap = 'on';
            app.DeadReckoningEstimateLabel.FontColor = [0.129411764705882 0.129411764705882 0.129411764705882];
            app.DeadReckoningEstimateLabel.Position = [83 79 108 33];
            app.DeadReckoningEstimateLabel.Text = 'Dead Reckoning Estimate';

            % Create DeadReckoningEstimateSwitch
            app.DeadReckoningEstimateSwitch = uiswitch(app.visibilityControl, 'slider');
            app.DeadReckoningEstimateSwitch.FontColor = [0.129411764705882 0.129411764705882 0.129411764705882];
            app.DeadReckoningEstimateSwitch.Position = [113 120 45 20];
            app.DeadReckoningEstimateSwitch.Value = 'On';

            % Create OOIsSwitchLabel
            app.OOIsSwitchLabel = uilabel(app.visibilityControl);
            app.OOIsSwitchLabel.HorizontalAlignment = 'center';
            app.OOIsSwitchLabel.FontColor = [0.129411764705882 0.129411764705882 0.129411764705882];
            app.OOIsSwitchLabel.Position = [120 7 35 22];
            app.OOIsSwitchLabel.Text = 'OOI''s';

            % Create OOIsSwitch
            app.OOIsSwitch = uiswitch(app.visibilityControl, 'slider');
            app.OOIsSwitch.FontColor = [0.129411764705882 0.129411764705882 0.129411764705882];
            app.OOIsSwitch.Position = [113 44 45 20];
            app.OOIsSwitch.Value = 'On';

            % Create ResetPlaybackButton
            app.ResetPlaybackButton = uibutton(app.visibilityControl, 'push');
            app.ResetPlaybackButton.ButtonPushedFcn = createCallbackFcn(app, @ResetPlaybackButtonPushed, true);
            app.ResetPlaybackButton.BackgroundColor = [0.96078431372549 0.96078431372549 0.96078431372549];
            app.ResetPlaybackButton.FontColor = [0.129411764705882 0.129411764705882 0.129411764705882];
            app.ResetPlaybackButton.Position = [87 314 100 23];
            app.ResetPlaybackButton.Text = 'Reset Playback';

            % Create StartPlaybackButton
            app.StartPlaybackButton = uibutton(app.visibilityControl, 'push');
            app.StartPlaybackButton.ButtonPushedFcn = createCallbackFcn(app, @StartPlaybackButtonPushed, true);
            app.StartPlaybackButton.BackgroundColor = [0.96078431372549 0.96078431372549 0.96078431372549];
            app.StartPlaybackButton.FontColor = [0.129411764705882 0.129411764705882 0.129411764705882];
            app.StartPlaybackButton.Position = [87 347 100 23];
            app.StartPlaybackButton.Text = 'Start Playback';

            % Create ParameterControlTab
            app.ParameterControlTab = uitab(app.TabGroup);
            app.ParameterControlTab.Title = 'Parameter Control';
            app.ParameterControlTab.BackgroundColor = [1 1 1];
            app.ParameterControlTab.ForegroundColor = [0.129411764705882 0.129411764705882 0.129411764705882];

            % Create GridLayout2
            app.GridLayout2 = uigridlayout(app.ParameterControlTab);
            app.GridLayout2.ColumnWidth = {10, 70, '0.1x', 70, '0.1x', 70, '0.15x', '1x', 350};
            app.GridLayout2.RowHeight = {160, '1x', 25, 20, 225};
            app.GridLayout2.BackgroundColor = [0.96078431372549 0.96078431372549 0.96078431372549];

            % Create Panel_7
            app.Panel_7 = uipanel(app.GridLayout2);
            app.Panel_7.BorderColor = [1 1 1];
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
            app.Switch.FontColor = [0.9412 0.9412 0.9412];
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
            app.ActiveFileDropDownLabel.FontColor = [0.129411764705882 0.129411764705882 0.129411764705882];
            app.ActiveFileDropDownLabel.Position = [29 92 290 22];
            app.ActiveFileDropDownLabel.Text = 'Active File';

            % Create ActiveFileDropDown
            app.ActiveFileDropDown = uidropdown(app.Panel_2);
            app.ActiveFileDropDown.FontColor = [0.129411764705882 0.129411764705882 0.129411764705882];
            app.ActiveFileDropDown.BackgroundColor = [0.96078431372549 0.96078431372549 0.96078431372549];
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
            app.GainSliderLabel.FontColor = [0.129411764705882 0.129411764705882 0.129411764705882];
            app.GainSliderLabel.Position = [26 113 30 22];
            app.GainSliderLabel.Text = 'Gain';

            % Create GainSlider
            app.GainSlider = uislider(app.Panel_4);
            app.GainSlider.Limits = [0.01 10];
            app.GainSlider.ValueChangingFcn = createCallbackFcn(app, @GainSliderValueChanging, true);
            app.GainSlider.FontColor = [0.129411764705882 0.129411764705882 0.129411764705882];
            app.GainSlider.Position = [77 135 150 3];
            app.GainSlider.Value = 1;

            % Create BiasSliderLabel
            app.BiasSliderLabel = uilabel(app.Panel_4);
            app.BiasSliderLabel.HorizontalAlignment = 'right';
            app.BiasSliderLabel.FontColor = [0.129411764705882 0.129411764705882 0.129411764705882];
            app.BiasSliderLabel.Position = [26 45 28 22];
            app.BiasSliderLabel.Text = 'Bias';

            % Create BiasSlider
            app.BiasSlider = uislider(app.Panel_4);
            app.BiasSlider.Limits = [-3.14159265358979 3.14159265358979];
            app.BiasSlider.ValueChangingFcn = createCallbackFcn(app, @BiasSliderValueChanging, true);
            app.BiasSlider.FontColor = [0.129411764705882 0.129411764705882 0.129411764705882];
            app.BiasSlider.Position = [77 67 150 3];

            % Create IMUParametersLabel
            app.IMUParametersLabel = uilabel(app.Panel_4);
            app.IMUParametersLabel.FontWeight = 'bold';
            app.IMUParametersLabel.FontColor = [0.129411764705882 0.129411764705882 0.129411764705882];
            app.IMUParametersLabel.Position = [112 170 96 22];
            app.IMUParametersLabel.Text = 'IMU Parameters';

            % Create gainSpinner
            app.gainSpinner = uispinner(app.Panel_4);
            app.gainSpinner.Step = 0.05;
            app.gainSpinner.ValueChangingFcn = createCallbackFcn(app, @gainSpinnerValueChanging, true);
            app.gainSpinner.Limits = [0.01 10];
            app.gainSpinner.FontColor = [0.129411764705882 0.129411764705882 0.129411764705882];
            app.gainSpinner.BackgroundColor = [1 1 1];
            app.gainSpinner.Position = [251 114 100 22];
            app.gainSpinner.Value = 1;

            % Create biasSpinner
            app.biasSpinner = uispinner(app.Panel_4);
            app.biasSpinner.Step = 0.0174533;
            app.biasSpinner.ValueChangingFcn = createCallbackFcn(app, @biasSpinnerValueChanging, true);
            app.biasSpinner.Limits = [-3.14159265358979 3.14159265358979];
            app.biasSpinner.FontColor = [0.129411764705882 0.129411764705882 0.129411764705882];
            app.biasSpinner.BackgroundColor = [1 1 1];
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
            app.initPosAxes.Color = [1 1 1];
            app.initPosAxes.Box = 'on';
            app.initPosAxes.XGrid = 'on';
            app.initPosAxes.YGrid = 'on';
            app.initPosAxes.ColorOrder = [0 0.447 0.741;0.85 0.325 0.098;0.929 0.694 0.125;0.494 0.184 0.556;0.466 0.674 0.188;0.301 0.745 0.933;0.635 0.078 0.184];
            app.initPosAxes.Position = [1 16 375 233];

            % Create XEditFieldLabel
            app.XEditFieldLabel = uilabel(app.GridLayout2);
            app.XEditFieldLabel.HorizontalAlignment = 'center';
            app.XEditFieldLabel.FontWeight = 'bold';
            app.XEditFieldLabel.FontAngle = 'italic';
            app.XEditFieldLabel.FontColor = [0.129411764705882 0.129411764705882 0.129411764705882];
            app.XEditFieldLabel.Layout.Row = 4;
            app.XEditFieldLabel.Layout.Column = 2;
            app.XEditFieldLabel.Text = 'X';

            % Create initX
            app.initX = uieditfield(app.GridLayout2, 'numeric');
            app.initX.AllowEmpty = 'on';
            app.initX.ValueChangedFcn = createCallbackFcn(app, @initXValueChanged, true);
            app.initX.HorizontalAlignment = 'center';
            app.initX.FontColor = [0.129411764705882 0.129411764705882 0.129411764705882];
            app.initX.BackgroundColor = [1 1 1];
            app.initX.Layout.Row = 3;
            app.initX.Layout.Column = 2;
            app.initX.Value = [];

            % Create thetaEditFieldLabel
            app.thetaEditFieldLabel = uilabel(app.GridLayout2);
            app.thetaEditFieldLabel.HorizontalAlignment = 'center';
            app.thetaEditFieldLabel.FontWeight = 'bold';
            app.thetaEditFieldLabel.FontAngle = 'italic';
            app.thetaEditFieldLabel.FontColor = [0.129411764705882 0.129411764705882 0.129411764705882];
            app.thetaEditFieldLabel.Layout.Row = 4;
            app.thetaEditFieldLabel.Layout.Column = 6;
            app.thetaEditFieldLabel.Interpreter = 'latex';
            app.thetaEditFieldLabel.Text = '\theta';

            % Create initTheta
            app.initTheta = uieditfield(app.GridLayout2, 'numeric');
            app.initTheta.AllowEmpty = 'on';
            app.initTheta.ValueChangedFcn = createCallbackFcn(app, @initThetaValueChanged, true);
            app.initTheta.HorizontalAlignment = 'center';
            app.initTheta.FontColor = [0.129411764705882 0.129411764705882 0.129411764705882];
            app.initTheta.BackgroundColor = [1 1 1];
            app.initTheta.Layout.Row = 3;
            app.initTheta.Layout.Column = 6;
            app.initTheta.Value = [];

            % Create YEditFieldLabel
            app.YEditFieldLabel = uilabel(app.GridLayout2);
            app.YEditFieldLabel.HorizontalAlignment = 'center';
            app.YEditFieldLabel.FontWeight = 'bold';
            app.YEditFieldLabel.FontAngle = 'italic';
            app.YEditFieldLabel.FontColor = [0.129411764705882 0.129411764705882 0.129411764705882];
            app.YEditFieldLabel.Layout.Row = 4;
            app.YEditFieldLabel.Layout.Column = 4;
            app.YEditFieldLabel.Text = 'Y';

            % Create initY
            app.initY = uieditfield(app.GridLayout2, 'numeric');
            app.initY.AllowEmpty = 'on';
            app.initY.ValueChangedFcn = createCallbackFcn(app, @initYValueChanged, true);
            app.initY.HorizontalAlignment = 'center';
            app.initY.FontColor = [0.129411764705882 0.129411764705882 0.129411764705882];
            app.initY.BackgroundColor = [1 1 1];
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