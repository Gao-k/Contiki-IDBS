close all 
clear all

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
pgi=1;
file_name = ['pdc_sync_dc_pgi=',int2str(pgi),'s.txt']; % get the file name
[~,~,~,~,dc,~]=textread(file_name,'%s %s %d %s %f %s');
pdc_sync_dc_1s = dc(1);

file_name = ['pdc_idea_dc_pgi=',int2str(pgi),'s.txt']; % get the file name
[~,~,~,~,dc,~]=textread(file_name,'%s %s %d %s %f %s');
pdc_idea_dc_1s = dc(1);

file_name = ['cc_dc_pgi=',int2str(pgi),'s.txt']; % get the file name
[~,~,~,~,dc,~]=textread(file_name,'%s %s %d %s %f %s');
cc_dc_1s = dc(1);

% dc_1s_array = [pdc_sync_dc_1s pdc_idea_dc_1s cc_dc_1s];
%%
pgi=10;
file_name = ['pdc_sync_dc_pgi=',int2str(pgi),'s.txt']; % get the file name
[~,~,~,~,dc,~]=textread(file_name,'%s %s %d %s %f %s');
pdc_sync_dc_10s = dc(1);

file_name = ['pdc_idea_dc_pgi=',int2str(pgi),'s.txt']; % get the file name
[~,~,~,~,dc,~]=textread(file_name,'%s %s %d %s %f %s');
pdc_idea_dc_10s = dc(1);

file_name = ['cc_dc_pgi=',int2str(pgi),'s.txt']; % get the file name
[~,~,~,~,dc,~]=textread(file_name,'%s %s %d %s %f %s');
cc_dc_10s = dc(1);

% dc_10s_array = [pdc_sync_dc_10s pdc_idea_dc_10s cc_dc_10s];
dc_1 = [pdc_sync_dc_1s pdc_sync_dc_10s]';
dc_2 = [pdc_idea_dc_1s pdc_idea_dc_10s]';
dc_3 = [cc_dc_1s cc_dc_10s]';

H=bar([dc_1 dc_2 dc_3]);
AX = legend(H,{'PDC-sync','PDC-idea','CC'},1);
set(gca,'XTickLabel',{'PGI=1s' 'PGI=10s'},'fontsize' ,16);
ylabel('Duty Cycle (%)','fontsize',16);
LEG = findobj(AX,'type','text');
set(LEG,'FontSize',16);
