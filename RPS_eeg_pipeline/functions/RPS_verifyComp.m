function [ data_eogcomp ] = RPS_verifyComp( data_eogcomp, data_icacomp )
% RPS_VERIFYCOMP is a function to verify visually the ICA components having 
% a high correlation with one of the measured EOG signals.
%
% Use as
%   [ data_eogcomp ] = RPS_verifyComp( data_eogcomp, data_icacomp )
%
% where the input data_eogcomp has to be the result of RPS_CORRCOMP ans 
% data_icacomp the result of RPS_ICA
%
% This function requires the fieldtrip toolbox
%
% See also RPS_CORRCOMP, RPS_ICA and FT_DATABROWSER

% Copyright (C) 2017, Daniel Matthes, MPI CBS

fprintf('Verify EOG-correlating components at participant 1\n\n');
data_eogcomp.part1 = corrComp(data_eogcomp.part1, data_icacomp.part1);
fprintf('\n');
fprintf('Verify EOG-correlating components at participant 2\n\n');
data_eogcomp.part2 = corrComp(data_eogcomp.part2, data_icacomp.part2);

end

%--------------------------------------------------------------------------
% SUBFUNCTION which does the verification of the EOG-correlating components
%--------------------------------------------------------------------------
function [ dataEOGComp ] = corrComp( dataEOGComp, dataICAcomp )

numOfElements = 1:length(dataEOGComp.elements);

cfg               = [];
cfg.layout        = 'mpi_002_customized_acticap32.mat';
cfg.viewmode      = 'component';
cfg.channel       = find(ismember(dataICAcomp.label, dataEOGComp.elements))';
cfg.blocksize     = 30;
cfg.showcallinfo  = 'no';

ft_databrowser(cfg, dataICAcomp);
colormap jet;

commandwindow;
selection = false;
    
while selection == false
  fprintf('\nDo you want to deselect some of theses components?\n')
  for i = numOfElements
    fprintf('[%d] - %s\n', i, dataEOGComp.elements{i});
  end
  fprintf('Comma-seperate your selection and put it in squared brackets!\n');
  fprintf('Press simply enter if you do not want to deselect any component!\n');
  x = input('\nPlease make your choice! (i.e. [1,2,3]): ');

  if ~isempty(x)
    if ~all(ismember(x, numOfElements))
      selection = false;
      fprintf('At least one of the selected components does not exist.\n');
    else
      selection = true;
      fprintf('Component(s) %d will not used for eye artifact correction\n', x);
      
      dataEOGComp.elements = dataEOGComp.elements(~ismember(numOfElements,x));
    end
  else
    selection = true;
    fprintf('No Component will be rejected.\n');
  end
end

close(gcf);

end