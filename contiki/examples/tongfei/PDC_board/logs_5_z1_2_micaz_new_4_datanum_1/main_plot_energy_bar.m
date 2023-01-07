close all 
clear all
file_num = [1 2 3 4 5];
pgi = [1 3 5 7 9];
adc_18_fa_dc_array = zeros(5,1);
adc_18_nfa_dc_array=zeros(5,1);
pdc_18_nfa_dc_array=zeros(5,1);

adc_10_fa_dc_array = zeros(5,1);
adc_10_nfa_dc_array=zeros(5,1);
pdc_10_nfa_dc_array=zeros(5,1);
data_folder = 'P_data';
data_format='%s %d %d %d %d'; % original format: '%s %s %d %s %s %s %d %d %d %d'

sf_list = [10 18]';
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
jj = 1;
for ii = file_num
    ii
    %% adc sf =18, with free addressing
    file_name = [data_folder,'/adc_18_fa_',int2str(pgi(ii)),'s.txt'];
    [~,control,data,idle,total]=textread(file_name,data_format);
    adc_18_fa_dc_array(jj) = sum((control+data+idle)./total)/length(total) * 100;
    
    %% adc sf =18, without free addressing
    file_name = [data_folder,'/adc_18_nfa_',int2str(pgi(ii)),'s.txt'];
    [~,control,data,idle,total]=textread(file_name,data_format);
    adc_18_nfa_dc_array(jj) = sum((control+data+idle)./total)/length(total) * 100;
    
    %% pdc sf =18, without free addressing
    file_name = [data_folder,'/pdc_18_nfa_',int2str(pgi(ii)),'s.txt'];
    [~,control,data,idle,total]=textread(file_name,data_format);
    pdc_18_nfa_dc_array(jj) = sum((control+data+idle)./total)/length(total) * 100;
    
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
     %% adc sf =10, with free addressing
    file_name = [data_folder,'/adc_10_fa_',int2str(pgi(ii)),'s.txt'];
    [~,control,data,idle,total]=textread(file_name,data_format);
    adc_10_fa_dc_array(jj) = sum((control+data+idle)./total)/length(total) * 100;
    
    %% adc sf =10, without free addressing
    file_name = [data_folder,'/adc_10_nfa_',int2str(pgi(ii)),'s.txt'];
    [~,control,data,idle,total]=textread(file_name,data_format);
    adc_10_nfa_dc_array(jj) = sum((control+data+idle)./total)/length(total) * 100;
    
    %% pdc sf =10, without free addressing
    file_name = [data_folder,'/pdc_10_nfa_',int2str(pgi(ii)),'s.txt'];
    [~,control,data,idle,total]=textread(file_name,data_format);
    pdc_10_nfa_dc_array(jj) = sum((control+data+idle)./total)/length(total) * 100;
    jj=jj+1;
end
adc_18_fa_dc_array_std = std(adc_18_fa_dc_array,0,1);
adc_18_fa_dc_array = mean(adc_18_fa_dc_array,1);

adc_18_nfa_dc_array_std = std(adc_18_nfa_dc_array,0,1);
adc_18_nfa_dc_array = mean(adc_18_nfa_dc_array,1);

pdc_18_nfa_dc_array_std = std(pdc_18_nfa_dc_array,0,1);
pdc_18_nfa_dc_array = mean(pdc_18_nfa_dc_array,1);

adc_10_fa_dc_array_std = std(adc_10_fa_dc_array,0,1);
adc_10_fa_dc_array = mean(adc_10_fa_dc_array,1);

adc_10_nfa_dc_array_std = std(adc_10_nfa_dc_array,0,1);
adc_10_nfa_dc_array = mean(adc_10_nfa_dc_array,1);

pdc_10_nfa_dc_array_std = std(pdc_10_nfa_dc_array,0,1);
pdc_10_nfa_dc_array = mean(pdc_10_nfa_dc_array,1);

sf_10_dc_std = [adc_10_fa_dc_array_std adc_10_nfa_dc_array_std pdc_10_nfa_dc_array_std]';
sf_18_dc_std = [adc_18_fa_dc_array_std adc_18_nfa_dc_array_std pdc_18_nfa_dc_array_std]';
dc_std_all = [sf_10_dc_std sf_18_dc_std]';

sf_10_dc = [adc_10_fa_dc_array adc_10_nfa_dc_array pdc_10_nfa_dc_array]';
sf_18_dc = [adc_18_fa_dc_array adc_18_nfa_dc_array pdc_18_nfa_dc_array]';
dc_all = [sf_10_dc sf_18_dc]';
% H = bar(sf_list,dc_all);
barweb(dc_all,dc_std_all);
barmap=[ 0 0 1; 0.7 0.7 0.7; 1 1 1];
colormap(barmap);
% hold on;
% for i=1:3
%     errorbar(sf_list, dc_all(:,i),dc_std_all(:,i),'.','Linewidth' ,1.5);
% end
xlabel('Number of Sleeping Slots (SSL)','fontsize',16); %设置x轴的标题和字体大小
ylabel('Duty Cycle (%)','fontsize',16);
AX = legend('ADC-FA', 'ADC-No FA','PDC' );
set(gca,'XTickLabel',[10 18],'XTickLabel',{'SSL=10' ,'SSL=18' },'fontsize' ,12);
LEG = findobj(AX,'type','text');
% ylim([1 6.5]);
set(LEG,'FontSize',11);%设置legend字体大小
set(gca,'FontSize',16);%设置坐标字体大小
grid on;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% linewidth_value = 2.5;
% l_adc_18_fa = 'b-s'; l_adc_18_nfa = 'b-^'; l_pdc_18_nfa = 'r->';
% l_adc_10_fa = 'b--s'; l_adc_10_nfa = 'b--^'; l_pdc_10_nfa = 'r-->';
% 
% adc_18_fa_dc = plot(pgi,adc_18_fa_dc_array,l_adc_18_fa,'LineWidth',linewidth_value);
% hold on;
% adc_18_nfa_dc = plot(pgi,adc_18_nfa_dc_array,l_adc_18_nfa,'LineWidth',linewidth_value);
% pdc_18_nfa_dc = plot(pgi,pdc_18_nfa_dc_array,l_pdc_18_nfa,'LineWidth',linewidth_value);
% 
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% adc_10_fa_dc = plot(pgi,adc_10_fa_dc_array,l_adc_10_fa,'LineWidth',linewidth_value);
% adc_10_nfa_dc = plot(pgi,adc_10_nfa_dc_array,l_adc_10_nfa,'LineWidth',linewidth_value);
% pdc_10_nfa_dc = plot(pgi,pdc_10_nfa_dc_array,l_pdc_10_nfa,'LineWidth',linewidth_value);
% 
% % 
%  axis([0 10 1 6.5]);
% box on;
% xlabel('Packet Generation Interval (s)','fontsize',16); %设置x轴的标题和字体大小
% ylabel('Duty Cycle (%)','fontsize',16);
% AX = legend([adc_10_fa_dc adc_10_nfa_dc adc_18_fa_dc adc_18_nfa_dc pdc_10_nfa_dc pdc_18_nfa_dc],...
%     'ADC-FA (SSL=10)','ADC-No FA (SSL=10)','ADC-FA (SSL=18)','ADC-No FA (SSL=18)','PDC (SSL=10)','PDC (SSL=18)',1);
% LEG = findobj(AX,'type','text');
% 
% set(LEG,'FontSize',11);%设置legend字体大小
% set(gca,'FontSize',16);%设置坐标字体大小
% grid on;