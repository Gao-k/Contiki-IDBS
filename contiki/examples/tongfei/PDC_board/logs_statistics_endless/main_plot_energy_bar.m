close all 
clear all
file_num = [1 2 3 4 5];
pgi_list = [1 3 5 7 9];
% sim_times will be modified
sim_times = 3;
folder_list = 1:1:sim_times;
adc_18_fa_dc_array = zeros(5,sim_times);
adc_18_nfa_dc_array=zeros(5,sim_times);
pdc_18_nfa_dc_array=zeros(5,sim_times);

adc_10_fa_dc_array = zeros(5,sim_times);
adc_10_nfa_dc_array=zeros(5,sim_times);
pdc_10_nfa_dc_array=zeros(5,sim_times);

data_format='%s %d %d %d %d'; % original format: '%s %s %d %s %s %s %d %d %d %d'
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
for folder = folder_list
    data_folder = ['.\logs_5_z1_2_micaz_endless_30m_',int2str(folder),'\P_data']; %'P_data';
    for ii = file_num
        ii
        %% adc sf =18, with free addressing
        file_name = [data_folder,'/adc_18_fa_',int2str(pgi_list(ii)),'s.txt'];
        [~,control,data,idle,total]=textread(file_name,data_format);
        adc_18_fa_dc_array(ii,folder) = sum((control+data+idle)./total)/length(total);

        %% adc sf =18, without free addressing
        file_name = [data_folder,'/adc_18_nfa_',int2str(pgi_list(ii)),'s.txt'];
        [~,control,data,idle,total]=textread(file_name,data_format);
        adc_18_nfa_dc_array(ii,folder) = sum((control+data+idle)./total)/length(total);

        %% pdc sf =18, without free addressing
        file_name = [data_folder,'/pdc_18_nfa_',int2str(pgi_list(ii)),'s.txt'];
        [~,control,data,idle,total]=textread(file_name,data_format);
        pdc_18_nfa_dc_array(ii,folder) = sum((control+data+idle)./total)/length(total);

        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        %% adc sf =10, with free addressing
        file_name = [data_folder,'/adc_10_fa_',int2str(pgi_list(ii)),'s.txt'];
        [~,control,data,idle,total]=textread(file_name,data_format);
        adc_10_fa_dc_array(ii,folder) = sum((control+data+idle)./total)/length(total);

        %% adc sf =10, without free addressing
        file_name = [data_folder,'/adc_10_nfa_',int2str(pgi_list(ii)),'s.txt'];
        [~,control,data,idle,total]=textread(file_name,data_format);
        adc_10_nfa_dc_array(ii,folder) = sum((control+data+idle)./total)/length(total);

        %% pdc sf =10, without free addressing
        file_name = [data_folder,'/pdc_10_nfa_',int2str(pgi_list(ii)),'s.txt'];
        [~,control,data,idle,total]=textread(file_name,data_format);
        pdc_10_nfa_dc_array(ii,folder) = sum((control+data+idle)./total)/length(total);
    end
end
adc_18_fa_dc_array = adc_18_fa_dc_array*100;
adc_18_nfa_dc_array =  adc_18_nfa_dc_array*100;
pdc_18_nfa_dc_array = pdc_18_nfa_dc_array*100;

adc_10_fa_dc_array = adc_10_fa_dc_array*100;
adc_10_nfa_dc_array = adc_10_nfa_dc_array*100;
pdc_10_nfa_dc_array = pdc_10_nfa_dc_array*100;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
linewidth_value = 1.5;
l_adc_18_fa = 'b-s'; l_adc_18_nfa = 'b-^'; l_pdc_18_nfa = 'r->';
l_adc_10_fa = 'b--s'; l_adc_10_nfa = 'b--^'; l_pdc_10_nfa = 'r-->';


adc_18_fa_dc_array_std = std(adc_18_fa_dc_array,0,2);
adc_18_fa_dc_array = mean(adc_18_fa_dc_array,2);
errorbar(pgi_list,adc_18_fa_dc_array,adc_18_fa_dc_array_std,l_adc_18_fa,'LineWidth',linewidth_value);
hold on;
adc_18_fa_dc = plot(pgi_list,adc_18_fa_dc_array,l_adc_18_fa,'LineWidth',linewidth_value);

adc_18_nfa_dc_array_std = std(adc_18_nfa_dc_array,0,2);
adc_18_nfa_dc_array = mean(adc_18_nfa_dc_array,2);
errorbar(pgi_list,adc_18_nfa_dc_array,adc_18_nfa_dc_array_std,l_adc_18_nfa,'LineWidth',linewidth_value);
adc_18_nfa_dc = plot(pgi_list,adc_18_nfa_dc_array,l_adc_18_nfa,'LineWidth',linewidth_value);

pdc_18_nfa_dc_array_std = std(pdc_18_nfa_dc_array,0,2);
pdc_18_nfa_dc_array = mean(pdc_18_nfa_dc_array,2);
errorbar(pgi_list,pdc_18_nfa_dc_array,pdc_18_nfa_dc_array_std,l_pdc_18_nfa,'LineWidth',linewidth_value);
pdc_18_nfa_dc = plot(pgi_list,pdc_18_nfa_dc_array,l_pdc_18_nfa,'LineWidth',linewidth_value);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
adc_10_fa_dc_array_std = std(adc_10_fa_dc_array,0,2);
adc_10_fa_dc_array = mean(adc_10_fa_dc_array,2);
errorbar(pgi_list,adc_10_fa_dc_array,adc_10_fa_dc_array_std,l_adc_10_fa,'LineWidth',linewidth_value);
adc_10_fa_dc = plot(pgi_list,adc_10_fa_dc_array,l_adc_10_fa,'LineWidth',linewidth_value);

adc_10_nfa_dc_array_std = std(adc_10_nfa_dc_array,0,2);
adc_10_nfa_dc_array = mean(adc_10_nfa_dc_array,2);
errorbar(pgi_list,adc_10_nfa_dc_array,adc_10_nfa_dc_array_std,l_adc_10_nfa,'LineWidth',linewidth_value);
adc_10_nfa_dc = plot(pgi_list,adc_10_nfa_dc_array,l_adc_10_nfa,'LineWidth',linewidth_value);

pdc_10_nfa_dc_array_std = std(pdc_10_nfa_dc_array,0,2);
pdc_10_nfa_dc_array = mean(pdc_10_nfa_dc_array,2);
errorbar(pgi_list,pdc_10_nfa_dc_array,pdc_10_nfa_dc_array_std,l_pdc_10_nfa,'LineWidth',linewidth_value);
pdc_10_nfa_dc = plot(pgi_list,pdc_10_nfa_dc_array,l_pdc_10_nfa,'LineWidth',linewidth_value);
% 
 axis([0 10 1 6.5]);
box on;
xlabel('Packet Generation Interval (s)','fontsize',16); %设置x轴的标题和字体大小
ylabel('Duty Cycle (%)','fontsize',16);
AX = legend([adc_10_fa_dc adc_10_nfa_dc adc_18_fa_dc adc_18_nfa_dc pdc_10_nfa_dc pdc_18_nfa_dc],...
    'ADC-FA (SSL=10)','ADC-No FA (SSL=10)','ADC-FA (SSL=18)','ADC-No FA (SSL=18)','PDC (SSL=10)','PDC (SSL=18)',1);
LEG = findobj(AX,'type','text');

set(LEG,'FontSize',11);%设置legend字体大小
set(gca,'FontSize',16);%设置坐标字体大小
grid on;