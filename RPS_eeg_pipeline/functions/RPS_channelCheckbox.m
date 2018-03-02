function [ badLabel ] = RPS_channelCheckbox()
% RPS_CHANNELCHECKBOX is a function, which displays a small GUI for the 
% selection of bad channels. It returns a cell array including the labels
% of the bad channels
%
% Use as
%   [ badLabel ] = RPS_channelCheckbox()
%
% SEE also UIFIGURE, UICHECKBOX, UIBUTTON, UIRESUME, UIWAIT

% Copyright (C) 2018, Daniel Matthes, MPI CBS

% -------------------------------------------------------------------------
% Create GUI
% -------------------------------------------------------------------------
SelectBadChannels = uifigure;
SelectBadChannels.Position = [150 400 535 210];
SelectBadChannels.Name = 'Select bad channels';

% Create F7CheckBox
F7 = uicheckbox(SelectBadChannels);
F7.Text = 'F7';
F7.Position = [45 150 80 15];
% Create FzCheckBox
Fz = uicheckbox(SelectBadChannels);
Fz.Text = 'Fz';
Fz.Position = [125 150 80 15];
% Create F8CheckBox
F8 = uicheckbox(SelectBadChannels);
F8.Text = 'F8';
F8.Position = [205 150 80 15];
% Create FC5CheckBox
FC5 = uicheckbox(SelectBadChannels);
FC5.Text = 'FC5';
FC5.Position = [285 150 80 15];
% Create FC1CheckBox
FC1 = uicheckbox(SelectBadChannels);
FC1.Text = 'FC1';
FC1.Position = [365 150 80 15];
% Create FC2CheckBox
FC2 = uicheckbox(SelectBadChannels);
FC2.Text = 'FC2';
FC2.Position = [445 150 80 15];

% Create FC6CheckBox
FC6 = uicheckbox(SelectBadChannels);
FC6.Text = 'FC6';
FC6.Position = [45 125 80 15];
% Create T7CheckBox
T7 = uicheckbox(SelectBadChannels);
T7.Text = 'T7';
T7.Position = [125 125 80 15];
% Create C3CheckBox
C3 = uicheckbox(SelectBadChannels);
C3.Text = 'C3';
C3.Position = [205 125 80 15];
% Create CzCheckBox
Cz = uicheckbox(SelectBadChannels);
Cz.Text = 'Cz';
Cz.Position = [285 125 80 15];
% Create C4CheckBox
C4 = uicheckbox(SelectBadChannels);
C4.Text = 'C4';
C4.Position = [365 125 80 15];
% Create T8CheckBox
T8 = uicheckbox(SelectBadChannels);
T8.Text = 'T8';
T8.Position = [445 125 80 15];

% Create FCzCheckBox
FCz = uicheckbox(SelectBadChannels);
FCz.Text = 'FCz';
FCz.Position = [45 100 80 15];
% Create CP1CheckBox
CP1 = uicheckbox(SelectBadChannels);
CP1.Text = 'CP1';
CP1.Position = [125 100 80 15];
% Create CP2CheckBox
CP2 = uicheckbox(SelectBadChannels);
CP2.Text = 'CP2';
CP2.Position = [205 100 80 15];
% Create TP10CheckBox
TP10 = uicheckbox(SelectBadChannels);
TP10.Text = 'TP10';
TP10.Position = [285 100 80 15];
% Create P7CheckBox
P7 = uicheckbox(SelectBadChannels);
P7.Text = 'P7';
P7.Position = [365 100 80 15];
% Create P3CheckBox
P3 = uicheckbox(SelectBadChannels);
P3.Text = 'P3';
P3.Position = [445 100 80 15];

% Create PzCheckBox
Pz = uicheckbox(SelectBadChannels);
Pz.Text = 'Pz';
Pz.Position = [45 75 80 15];
% Create P4CheckBox
P4 = uicheckbox(SelectBadChannels);
P4.Text = 'P4';
P4.Position = [125 75 80 15];
% Create P8CheckBox
P8 = uicheckbox(SelectBadChannels);
P8.Text = 'P8';
P8.Position = [205 75 80 15];
% Create O1CheckBox
O1 = uicheckbox(SelectBadChannels);
O1.Text = 'O1';
O1.Position = [285 75 80 15];
% Create OzCheckBox
Oz = uicheckbox(SelectBadChannels);
Oz.Text = 'Oz';
Oz.Position = [365 75 80 15];
% Create O2CheckBox
O2 = uicheckbox(SelectBadChannels);
O2.Text = 'O2';
O2.Position = [445 75 80 15];

% Create SaveButton
btn = uibutton(SelectBadChannels, 'push');
btn.ButtonPushedFcn = @(btn, evt)SaveButtonPushed(SelectBadChannels);
btn.Position = [217 27 101 21];
btn.Text = 'Save';

% -------------------------------------------------------------------------
% Wait for user input and return selection after btn 'save' was pressed
% -------------------------------------------------------------------------
% Wait until btn is pushed
uiwait(SelectBadChannels);

if ishandle(SelectBadChannels)                                              % if gui still exists
  badLabel = [F7.Value; Fz.Value; F8.Value; FC5.Value; FC1.Value; ...       % return existing selection
              FC2.Value; FC6.Value; T7.Value; C3.Value; Cz.Value; ...
              C4.Value; T8.Value; FCz.Value; CP1.Value; CP2.Value; ...
              TP10.Value; P7.Value; P3.Value; Pz.Value; P4.Value; ...
              P8.Value; O1.Value; Oz.Value; O2.Value];
  label    = {'F7', 'Fz', 'F8', 'FC5', 'FC1', 'FC2', 'FC6' 'T7', 'C3', ...
              'Cz', 'C4', 'T8', 'FCz', 'CP1', 'CP2', 'TP10', 'P7', 'P3',...
              'Pz', 'P4', 'P8', 'O1', 'Oz', 'O2'};
  badLabel = label(badLabel);
  if isempty(badLabel)
    badLabel = [];
  end
  delete(SelectBadChannels);                                                % close gui
else                                                                        % if gui was already closed (i.e. by using the close symbol)
  badLabel = [];                                                            % return empty selection
end

end

% -------------------------------------------------------------------------
% Event Functions
% -------------------------------------------------------------------------
% Button pushed function: btn
function  SaveButtonPushed(SelectBadChannels)
  uiresume(SelectBadChannels);                                              % resume from wait status                                                                             
end
