close all 
clear all
file_num = [1 2 3 4 5];
pgi_list = [1 3 5 7 9];

sim_times = 3;

adc_18_fa_dc_array = zeros(5,sim_times);
adc_18_nfa_dc_array=zeros(5,sim_times);
pdc_18_nfa_dc_array=zeros(5,sim_times);

adc_10_fa_dc_array = zeros(5,sim_times);
adc_10_nfa_dc_array=zeros(5,sim_times);
pdc_10_nfa_dc_array=zeros(5,sim_times);
seed_array = [123456  123462 123467];

data_format='%s %d %s %d %d %d %d'; % original format: '%s %s %d %s %s %s %d %d %d %d'
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
exc_id_1=6; % excluded id
exc_id_2=7;

sim_i=1;
for seed = seed_array
    data_folder = ['.\logs_fixed_data_7_',int2str(seed),'\P_data']; %'R_data';
    for ii = file_num
        %% adc sf =18, with free addressing
        file_name = [data_folder,'/adc_18_fa_',int2str(pgi_list(ii)),'s.txt'];
        [~,ID,~,control,data,idle,total]=textread(file_name,data_format);
        id_index=((ID~=exc_id_1) & (ID~=exc_id_2));% They are sky motes, they will not be conunted
        adc_18_fa_dc_array(ii,sim_i) = sum((control(id_index)+data(id_index)+idle(id_index))./total(id_index))/length(total(id_index));
        
        %% adc sf =18, without free addressing
        file_name = [data_folder,'/adc_18_nfa_',int2str(pgi_list(ii)),'s.txt'];
        [~,ID,~,control,data,idle,total]=textread(file_name,data_format);
        id_index=((ID~=exc_id_1) & (ID~=exc_id_2));
        adc_18_nfa_dc_array(ii,sim_i) = sum((control(id_index)+data(id_index)+idle(id_index))./total(id_index))/length(total(id_index));
        
        %% pdc sf =18, without free addressing
        file_name = [data_folder,'/pdc_18_nfa_',int2str(pgi_list(ii)),'s.txt'];
        [~,ID,~,control,data,idle,total]=textread(file_name,data_format);
        id_index=((ID~=exc_id_1) & (ID~=exc_id_2));
        pdc_18_nfa_dc_array(ii,sim_i) = sum((control(id_index)+data(id_index)+idle(id_index))./total(id_index))/length(total(id_index));
        
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        %% adc sf =10, with free addressing
        file_name = [data_folder,'/adc_10_fa_',int2str(pgi_list(ii)),'s.txt'];
        [~,ID,~,control,data,idle,total]=textread(file_name,data_format);
        id_index=((ID~=exc_id_1) & (ID~=exc_id_2));
        adc_10_fa_dc_array(ii,sim_i) = sum((control(id_index)+data(id_index)+idle(id_index))./total(id_index))/length(total(id_index));
        
        %% adc sf =10, without free addressing
        file_name = [data_folder,'/adc_10_nfa_',int2str(pgi_list(ii)),'s.txt'];
        [~,ID,~,control,data,idle,total]=textread(file_name,data_format);
        id_index=((ID~=exc_id_1) & (ID~=exc_id_2));
        adc_10_nfa_dc_array(ii,sim_i) = sum((control(id_index)+data(id_index)+idle(id_index))./total(id_index))/length(total(id_index));
        
        %% pdc sf =10, without free addressing
        file_name = [data_folder,'/pdc_10_nfa_',int2str(pgi_list(ii)),'s.txt'];
        [~,ID,~,control,data,idle,total]=textread(file_name,data_format);
        id_index=((ID~=exc_id_1) & (ID~=exc_id_2));
        pdc_10_nfa_dc_array(ii,sim_i) = sum((control(id_index)+data(id_index)+idle(id_index))./total(id_index))/length(total(id_index));
    end
    sim_i=sim_i+1;
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
linewidth_value = 1.5;
l_adc_18_fa = 'b-s'; l_adc_18_nfa = 'b-^'; l_pdc_18_nfa = 'r->';
l_adc_10_fa = 'b--s'; l_adc_10_nfa = 'b--^'; l_pdc_10_nfa = 'r-->';

adc_18_fa_dc_array_std = std(adc_18_fa_dc_array*100,0,2);
adc_18_fa_dc_array = mean(adc_18_fa_dc_array*100,2);
errorbar(pgi_list,adc_18_fa_dc_array,adc_18_fa_dc_array_std,l_adc_18_fa,'LineWidth',linewidth_value);
hold on;
adc_18_fa_dc = plot(pgi_list,adc_18_fa_dc_array,l_adc_18_fa,'LineWidth',linewidth_value);

adc_18_nfa_dc_array_std = std(adc_18_nfa_dc_array*100,0,2);
adc_18_nfa_dc_array = mean(adc_18_nfa_dc_array*100,2);
errorbar(pgi_list,adc_18_nfa_dc_array,adc_18_nfa_dc_array_std,l_adc_18_nfa,'LineWidth',linewidth_value);
adc_18_nfa_dc = plot(pgi_list,adc_18_nfa_dc_array,l_adc_18_nfa,'LineWidth',linewidth_value);

pdc_18_nfa_dc_array_std = std(pdc_18_nfa_dc_array*100,0,2);
pdc_18_nfa_dc_array = mean(pdc_18_nfa_dc_array*100,2);
errorbar(pgi_list,pdc_18_nfa_dc_array,pdc_18_nfa_dc_array_std,l_pdc_18_nfa,'LineWidth',linewidth_value);
pdc_18_nfa_dc = plot(pgi_list,pdc_18_nfa_dc_array,l_pdc_18_nfa,'LineWidth',linewidth_value);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
adc_10_fa_dc_array_std = std(adc_10_fa_dc_array*100,0,2);
adc_10_fa_dc_array = mean(adc_10_fa_dc_array*100,2);
errorbar(pgi_list,adc_10_fa_dc_array,adc_10_fa_dc_array_std,l_adc_10_fa,'LineWidth',linewidth_value);
adc_10_fa_dc = plot(pgi_list,adc_10_fa_dc_array,l_adc_10_fa,'LineWidth',linewidth_value);

adc_10_nfa_dc_array_std = std(adc_10_nfa_dc_array*100,0,2);
adc_10_nfa_dc_array = mean(adc_10_nfa_dc_array*100,2);
errorbar(pgi_list,adc_10_nfa_dc_array,adc_10_nfa_dc_array_std,l_adc_10_nfa,'LineWidth',linewidth_value);
adc_10_nfa_dc = plot(pgi_list,adc_10_nfa_dc_array,l_adc_10_nfa,'LineWidth',linewidth_value);

pdc_10_nfa_dc_array_std = std(pdc_10_nfa_dc_array*100,0,2);
pdc_10_nfa_dc_array = mean(pdc_10_nfa_dc_array*100,2);
errorbar(pgi_list,pdc_10_nfa_dc_array,pdc_10_nfa_dc_array_std,l_pdc_10_nfa,'LineWidth',linewidth_value);
pdc_10_nfa_dc = plot(pgi_list,pdc_10_nfa_dc_array,l_pdc_10_nfa,'LineWidth',linewidth_value);
% 
axis([0 10 1 6]);
box on;
xlabel('Packet Generation Interval (s)','fontsize',16); %设置x轴的标题和字体大小
ylabel('Duty Cycle (%)','fontsize',16);
AX = legend([adc_10_fa_dc adc_10_nfa_dc adc_18_fa_dc adc_18_nfa_dc pdc_10_nfa_dc pdc_18_nfa_dc],...
    'ADC-FA (SSL=10)','ADC-No FA (SSL=10)','ADC-FA (SSL=18)','ADC-No FA (SSL=18)','PDC (SSL=10)','PDC (SSL=18)',1);
LEG = findobj(AX,'type','text');

set(LEG,'FontSize',11);%设置legend字体大小
set(gca,'FontSize',16);%设置坐标字体大小
grid on;