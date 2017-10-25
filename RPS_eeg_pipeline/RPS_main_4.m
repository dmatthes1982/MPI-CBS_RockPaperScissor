%% check if basic variables are defined and import segmented data
if ~exist('sessionStr', 'var')
  cfg           = [];
  cfg.subFolder = '02_preproc/';
  cfg.filename  = 'RPS_p01_02_preproc';
  sessionStr    = sprintf('%03d', RPS_getSessionNum( cfg ));                % estimate current session number
end

if ~exist('desPath', 'var')
  desPath       = '/data/pt_01843/eegData/DualEEG_RPS_processedData/';      % destination path for processed data  
end

if ~exist('numOfPart', 'var')                                               % estimate number of participants in segmented data folder
  sourceList    = dir([strcat(desPath, '02_preproc/'), ...
                       strcat('*_', sessionStr, '.mat')]);
  sourceList    = struct2cell(sourceList);
  sourceList    = sourceList(1,:);
  numOfSources  = length(sourceList);
  numOfPart     = zeros(1, numOfSources);

  for i=1:1:numOfSources
    numOfPart(i)  = sscanf(sourceList{i}, ...
                    strcat('RPS_p%d_02_preproc_', sessionStr, '.mat'));
  end
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% bandpass filtering

for i = numOfPart
  cfg             = [];
  cfg.srcFolder   = strcat(desPath, '02_preproc/');
  cfg.filename    = sprintf('RPS_p%02d_02_preproc', i);
  cfg.sessionStr  = sessionStr;
  
  fprintf('Dyad %d\n', i);
  fprintf('Load segmented data...\n\n');
  RPS_loadData( cfg );
  
  filtCoeffDiv = 500 / data_preproc.FP.part1.fsample;                       % estimate sample frequency dependent divisor of filter length

  % bandpass filter data at 10Hz
  cfg           = [];
  cfg.bpfreq    = [9 11];
  cfg.filtorder = fix(250 / filtCoeffDiv);
  
  data_bpfilt_10Hz = RPS_bpFiltering(cfg, data_preproc);
  
  % export the filtered data into a *.mat file
  cfg             = [];
  cfg.desFolder   = strcat(desPath, '07_bpfilt/');
  cfg.filename    = sprintf('RPS_p%02d_07a_bpfilt10Hz', i);
  cfg.sessionStr  = sessionStr;

  file_path = strcat(cfg.desFolder, cfg.filename, '_', cfg.sessionStr, ...
                     '.mat');
                   
  fprintf('Saving bandpass filtered data (10Hz) of dyad %d in:\n', i); 
  fprintf('%s ...\n', file_path);
  RPS_saveData(cfg, 'data_bpfilt_10Hz', data_bpfilt_10Hz);
  fprintf('Data stored!\n\n');
  clear data_bpfilt_10Hz

  % bandpass filter data at 20Hz
  cfg           = [];
  cfg.bpfreq    = [19 21];
  cfg.filtorder = fix(250 / filtCoeffDiv);
  
  data_bpfilt_20Hz = RPS_bpFiltering(cfg, data_preproc);

  % export the filtered data into a *.mat file
  cfg             = [];
  cfg.desFolder   = strcat(desPath, '07_bpfilt/');
  cfg.filename    = sprintf('RPS_p%02d_07b_bpfilt20Hz', i);
  cfg.sessionStr  = sessionStr;

  file_path = strcat(cfg.desFolder, cfg.filename, '_', cfg.sessionStr, ...
                     '.mat');
                   
  fprintf('Saving bandpass filtered data (20Hz) of dyad %d in:\n', i); 
  fprintf('%s ...\n', file_path);
  RPS_saveData(cfg, 'data_bpfilt_20Hz', data_bpfilt_20Hz);
  fprintf('Data stored!\n\n');
  clear data_bpfilt_20Hz data_preproc
  
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% hilbert phase calculation

for i = numOfPart
  cfg             = [];
  cfg.srcFolder   = strcat(desPath, '07_bpfilt/');
  cfg.sessionStr  = sessionStr;
  
  fprintf('Dyad %d\n', i);
  
  cfg.filename    = sprintf('RPS_p%02d_07a_bpfilt10Hz', i);
  fprintf('Load the at 10 Hz bandpass filtered data ...\n');
  RPS_loadData( cfg );
  
  cfg.filename    = sprintf('RPS_p%02d_07b_bpfilt20Hz', i);
  fprintf('Load the at 20 Hz bandpass filtered data ...\n');
  RPS_loadData( cfg );
  
  % calculate hilbert phase at 10Hz
  data_hilbert_10Hz = RPS_hilbertPhase(data_bpfilt_10Hz);
  
  % export the hilbert phase data into a *.mat file
  cfg             = [];
  cfg.desFolder   = strcat(desPath, '08_hilbert/');
  cfg.filename    = sprintf('RPS_p%02d_08a_hilbert10Hz', i);
  cfg.sessionStr  = sessionStr;

  file_path = strcat(cfg.desFolder, cfg.filename, '_', cfg.sessionStr, ...
                     '.mat');
                   
  fprintf('Saving Hilbert phase data (10Hz) of dyad %d in:\n', i); 
  fprintf('%s ...\n', file_path);
  RPS_saveData(cfg, 'data_hilbert_10Hz', data_hilbert_10Hz);
  fprintf('Data stored!\n\n');
  clear data_hilbert_10Hz data_bpfilt_10Hz
  
  % calculate hilbert phase at 20Hz
  data_hilbert_20Hz = RPS_hilbertPhase(data_bpfilt_20Hz);
  
  % export the hilbert phase data into a *.mat file
  cfg             = [];
  cfg.desFolder   = strcat(desPath, '08_hilbert/');
  cfg.filename    = sprintf('RPS_p%02d_08b_hilbert20Hz', i);
  cfg.sessionStr  = sessionStr;

  file_path = strcat(cfg.desFolder, cfg.filename, '_', cfg.sessionStr, ...
                     '.mat');
                   
  fprintf('Saving Hilbert phase data (20Hz) of dyad %d in:\n', i); 
  fprintf('%s ...\n', file_path);
  RPS_saveData(cfg, 'data_hilbert_20Hz', data_hilbert_20Hz);
  fprintf('Data stored!\n\n');
  clear data_hilbert_20Hz data_bpfilt_20Hz
end

%% clear workspace
clear cfg file_path numOfSources sourceList i filtCoeffDiv 