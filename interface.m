classdef interface < matlab.apps.AppBase

    % Properties that correspond to app components
    properties (Access = public)
        UIFigure                 matlab.ui.Figure
        TabGroup                 matlab.ui.container.TabGroup
        ParameterControlTab      matlab.ui.container.Tab
        ResetBias                matlab.ui.control.Button
        ResetGain                matlab.ui.control.Button
        BiasSpinner              matlab.ui.control.Spinner
        GainSpinner              matlab.ui.control.Spinner
        BiasSlider               matlab.ui.control.Slider
        BiasSliderLabel          matlab.ui.control.Label
        GainSlider               matlab.ui.control.Slider
        GainSliderLabel          matlab.ui.control.Label
        ActiveFileDropDown       matlab.ui.control.DropDown
        ActiveFileDropDownLabel  matlab.ui.control.Label
        StatusTab                matlab.ui.container.Tab
        RobotStatusPanel         matlab.ui.container.Panel
        Lamp4                    matlab.ui.control.Lamp
        Lamp4Label               matlab.ui.control.Label
        Lamp3                    matlab.ui.control.Lamp
        Lamp3Label               matlab.ui.control.Label
        Lamp2                    matlab.ui.control.Lamp
        Lamp2Label               matlab.ui.control.Label
        APIAssignedLamp          matlab.ui.control.Lamp
        APIAssignedLampLabel     matlab.ui.control.Label
        MTRN4010Assignment1ControlCentreLabel  matlab.ui.control.Label
        UIAxes                   matlab.ui.control.UIAxes
    end

    % Callbacks that handle component events
    methods (Access = private)

        % Callback function
        % function AmplitudeSliderValueChanged(app, event)
        %     value = app.AmplitudeSlider.Value;
        %     plot(app.UIAxes, value*peaks)
        %     app.UIAxes.YLim = [-1000, 1000];
        % 
        % end

        % Value changed function: ActiveFileDropDown
        function ActiveFileDropDownValueChanged(app, event)
            value = app.ActiveFileDropDown.Value;
            
        end

        % Value changed function: GainSlider
        function GainSliderValueChanged(app, event)
            value = app.GainSlider.Value;
        end
    end

    % Component initialization
    methods (Access = private)

        % Create UIFigure and components
        function createComponents(app)

            % Get the file path for locating images
            pathToMLAPP = fileparts(mfilename('fullpath'));

            % Create UIFigure and hide until all components are created
            app.UIFigure = uifigure('Visible', 'off');
            app.UIFigure.Color = [1 1 1];
            app.UIFigure.Position = [100 100 705 480];
            app.UIFigure.Name = 'MATLAB App';
            app.UIFigure.Icon = fullfile(pathToMLAPP, 'bot.png');

            % Create TabGroup
            app.TabGroup = uitabgroup(app.UIFigure);
            app.TabGroup.Position = [2 1 704 480];

            % Create StatusTab
            app.StatusTab = uitab(app.TabGroup);
            app.StatusTab.Title = 'Status';
            app.StatusTab.BackgroundColor = [1 1 1];

            % Create UIAxes
            app.UIAxes = uiaxes(app.StatusTab);
            title(app.UIAxes, 'Global Co-ordinate Frame')
            app.UIAxes.PlotBoxAspectRatio = [1 1 1];
            app.UIAxes.XLim = [-5 20];
            app.UIAxes.YLim = [-5 20];
            app.UIAxes.XTick = [-5 0 5 10 15 20];
            app.UIAxes.XTickLabel = {'-5'; '0'; '5'; '10'; '15'; '20'};
            app.UIAxes.YTick = [-5 0 5 10 15 20];
            app.UIAxes.YTickLabel = {'-5'; '0'; '5'; '10'; '15'; '20'};
            app.UIAxes.Box = 'on';
            app.UIAxes.YGrid = 'on';
            app.UIAxes.XGrid = 'on';
            app.UIAxes.Position = [197 80 311 265];

            % Create MTRN4010Assignment1ControlCentreLabel
            app.MTRN4010Assignment1ControlCentreLabel = uilabel(app.StatusTab);
            app.MTRN4010Assignment1ControlCentreLabel.FontSize = 14;
            app.MTRN4010Assignment1ControlCentreLabel.FontWeight = 'bold';
            app.MTRN4010Assignment1ControlCentreLabel.Position = [214 424 277 22];
            app.MTRN4010Assignment1ControlCentreLabel.Text = 'MTRN4010 Assignment 1 Control Centre';

            % Create RobotStatusPanel
            app.RobotStatusPanel = uipanel(app.StatusTab);
            app.RobotStatusPanel.ForegroundColor = [0 0 0];
            app.RobotStatusPanel.Title = 'Robot Status';
            app.RobotStatusPanel.BackgroundColor = [0.94 0.94 0.94];
            app.RobotStatusPanel.Position = [527 18 164 276];

            % Create APIAssignedLampLabel
            app.APIAssignedLampLabel = uilabel(app.RobotStatusPanel);
            app.APIAssignedLampLabel.HorizontalAlignment = 'right';
            app.APIAssignedLampLabel.Position = [44 223 76 22];
            app.APIAssignedLampLabel.Text = 'API Assigned';

            % Create APIAssignedLamp
            app.APIAssignedLamp = uilamp(app.RobotStatusPanel);
            app.APIAssignedLamp.Position = [135 223 20 20];

            % Create Lamp2Label
            app.Lamp2Label = uilabel(app.RobotStatusPanel);
            app.Lamp2Label.HorizontalAlignment = 'right';
            app.Lamp2Label.Position = [78 178 42 22];
            app.Lamp2Label.Text = 'Lamp2';

            % Create Lamp2
            app.Lamp2 = uilamp(app.RobotStatusPanel);
            app.Lamp2.Position = [135 178 20 20];

            % Create Lamp3Label
            app.Lamp3Label = uilabel(app.RobotStatusPanel);
            app.Lamp3Label.HorizontalAlignment = 'right';
            app.Lamp3Label.Position = [78 130 42 22];
            app.Lamp3Label.Text = 'Lamp3';

            % Create Lamp3
            app.Lamp3 = uilamp(app.RobotStatusPanel);
            app.Lamp3.Position = [135 130 20 20];

            % Create Lamp4Label
            app.Lamp4Label = uilabel(app.RobotStatusPanel);
            app.Lamp4Label.HorizontalAlignment = 'right';
            app.Lamp4Label.Position = [78 83 42 22];
            app.Lamp4Label.Text = 'Lamp4';

            % Create Lamp4
            app.Lamp4 = uilamp(app.RobotStatusPanel);
            app.Lamp4.Position = [135 83 20 20];

            % Create ParameterControlTab
            app.ParameterControlTab = uitab(app.TabGroup);
            app.ParameterControlTab.Title = 'Parameter Control';
            app.ParameterControlTab.BackgroundColor = [1 1 1];

            % Create ActiveFileDropDownLabel
            app.ActiveFileDropDownLabel = uilabel(app.ParameterControlTab);
            app.ActiveFileDropDownLabel.HorizontalAlignment = 'right';
            app.ActiveFileDropDownLabel.Position = [23 392 60 22];
            app.ActiveFileDropDownLabel.Text = 'Active File';

            % Create ActiveFileDropDown
            app.ActiveFileDropDown = uidropdown(app.ParameterControlTab);
            app.ActiveFileDropDown.ValueChangedFcn = createCallbackFcn(app, @ActiveFileDropDownValueChanged, true);
            app.ActiveFileDropDown.Position = [98 392 100 22];

            % Create GainSliderLabel
            app.GainSliderLabel = uilabel(app.ParameterControlTab);
            app.GainSliderLabel.HorizontalAlignment = 'right';
            app.GainSliderLabel.FontColor = [0 0 0];
            app.GainSliderLabel.Position = [388 403 30 22];
            app.GainSliderLabel.Text = 'Gain';

            % Create GainSlider
            app.GainSlider = uislider(app.ParameterControlTab);
            app.GainSlider.Limits = [0.01 10];
            app.GainSlider.ValueChangedFcn = createCallbackFcn(app, @GainSliderValueChanged, true);
            app.GainSlider.FontColor = [0 0 0];
            app.GainSlider.Position = [439 412 150 3];
            app.GainSlider.Value = 1;

            % Create BiasSliderLabel
            app.BiasSliderLabel = uilabel(app.ParameterControlTab);
            app.BiasSliderLabel.HorizontalAlignment = 'right';
            app.BiasSliderLabel.FontColor = [0 0 0];
            app.BiasSliderLabel.Position = [394 344 28 22];
            app.BiasSliderLabel.Text = 'Bias';

            % Create BiasSlider
            app.BiasSlider = uislider(app.ParameterControlTab);
            app.BiasSlider.Limits = [-10 10];
            app.BiasSlider.FontColor = [0 0 0];
            app.BiasSlider.Position = [443 353 150 3];

            % Create GainSpinner
            app.GainSpinner = uispinner(app.ParameterControlTab);
            app.GainSpinner.Limits = [0.01 10];
            app.GainSpinner.FontColor = [0 0 0];
            app.GainSpinner.Position = [606 403 76 22];
            app.GainSpinner.Value = 1;

            % Create BiasSpinner
            app.BiasSpinner = uispinner(app.ParameterControlTab);
            app.BiasSpinner.Limits = [-10 10];
            app.BiasSpinner.FontColor = [0 0 0];
            app.BiasSpinner.Position = [607 344 76 22];

            % Create ResetGain
            app.ResetGain = uibutton(app.ParameterControlTab, 'push');
            app.ResetGain.BackgroundColor = [0.96 0.96 0.96];
            app.ResetGain.FontColor = [0 0 0];
            app.ResetGain.Position = [605 378 77 23];
            app.ResetGain.Text = 'Reset';

            % Create ResetBias
            app.ResetBias = uibutton(app.ParameterControlTab, 'push');
            app.ResetBias.BackgroundColor = [0.96 0.96 0.96];
            app.ResetBias.FontColor = [0 0 0];
            app.ResetBias.Position = [608 319 74 23];
            app.ResetBias.Text = 'Reset';

            % Show the figure after all components are created
            app.UIFigure.Visible = 'on';
        end
    end

    % App creation and deletion
    methods (Access = public)

        % Construct app
        function app = interface

            % Create UIFigure and components
            createComponents(app)

            % Register the app with App Designer
            registerApp(app, app.UIFigure)

            if nargout == 0
                clear app
            end
        end

        % Code that executes before app deletion
        function delete(app)

            % Delete UIFigure when app is deleted
            delete(app.UIFigure)
        end
    end
end