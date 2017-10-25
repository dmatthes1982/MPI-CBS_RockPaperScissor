function RPS_easyMPLVplot( cfg, data )
% RPS_EASYMPLVPLOT is a function, which makes it easier to plot the mean 
% PLV values from all electrodes of a specific condition from the 
% RPS_DATASTRUCTURE.
%
% Use as
%   RPS_easyPLVplot( cfg, data )
%
% where the input data has to be the result of RPS_PHASELOCKVAL
%
% The configuration options are
%   cfg.condition = condition (default: 2 or 'PredDiff', see RPS_DATASTRUCTURE)
%   cfg.phase     = phase (default: 11 or 'Prediction', see RPS_DATASTRUCTURE)
%
% This function requires the fieldtrip toolbox.
%
% See also RPS_DATASTRUCTURE, PLOT, RPS_PHASELOCKVAL, RPS_CALCMEANPLV

% Copyright (C) 2017, Daniel Matthes, MPI CBS

% -------------------------------------------------------------------------
% Get and check config options
% -------------------------------------------------------------------------
cond      = ft_getopt(cfg, 'condition', 2);
phase     = ft_getopt(cfg, 'phase', 11);

cond = RPS_checkCondition( cond );                                          % check cfg.condition definition    
switch cond
  case 1
    dataPlot = data.FP;
  case 2
    dataPlot = data.PD;
  case 3
    dataPlot = data.PS;
  case 4
    dataPlot = data.C;
  otherwise
    error('Condition %d is not valid', cond);
end

trialinfo = dataPlot.dyad.trialinfo;                                        % get trialinfo

phase = RPS_checkPhase( phase );                                            % check cfg.phase definition and translate it into trl number    
trl  = find(trialinfo == phase);
if isempty(trl)
  error('The selected dataset contains no condition %d.', phase);
end

% -------------------------------------------------------------------------
% Plot mPLV representation
% -------------------------------------------------------------------------
label = dataPlot.dyad.label;
components = 1:1:length(label);

colormap jet;
imagesc(components, components, dataPlot.dyad.mPLV{trl});
set(gca, 'XTick', components,'XTickLabel', label);                          % use labels instead of numbers for the axis description
set(gca, 'YTick', components,'YTickLabel', label);
set(gca,'xaxisLocation','top');                                             % move xlabel to the top
title(sprintf(' mean Phase Locking Values (PLV) in Phase %d of Condition: %d', ...
                phase, cond));   
colorbar;

end