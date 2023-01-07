close all
clear all
clc

file_num = [1 2 3 4 5];
pgi = [1 3 5 7 9];

sim_times = 3;

adc_18_fa_avg_hop_latency = zeros(5,sim_times);
adc_18_nfa_avg_hop_latency = zeros(5,sim_times);
pdc_18_nfa_avg_hop_latency = zeros(5,sim_times);

adc_18_fa_avg_delivery = zeros(5,sim_times);
adc_18_nfa_avg_delivery = zeros(5,sim_times);
pdc_18_nfa_avg_delivery = zeros(5,sim_times);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
adc_10_fa_avg_hop_latency = zeros(5,sim_times);
adc_10_nfa_avg_hop_latency = zeros(5,sim_times);
pdc_10_nfa_avg_hop_latency = zeros(5,sim_times);

adc_10_fa_avg_delivery = zeros(5,sim_times);
adc_10_nfa_avg_delivery = zeros(5,sim_times);
pdc_10_nfa_avg_delivery = zeros(5,sim_times);

seed_array = [123456  123462 123467];

total_data_num = 6*50; % 4 nodes, 90 pkts/node generated
% output_data_folder = 'R_data';
data_format = '%s %s %d %s %s %s %d %d %d';

sim_i=1;
for seed = seed_array
    output_data_folder = ['.\logs_fixed_data_7_',int2str(seed),'\R_data']; %'R_data'
    for ii = file_num
        %% adc sf =18, with free addressing
        file_name = [output_data_folder,'/adc_18_fa_',int2str(pgi(ii)),'s.txt'];
        [~,~,~,~,~,~,grade,latency,~]=textread(file_name,data_format);
        adc_18_fa_avg_hop_latency(ii,sim_i) = sum(latency./grade)/length(latency)./128;
        adc_18_fa_avg_delivery(ii,sim_i) = length(latency)/total_data_num;
        
        %% adc sf =18, without free addressing
        file_name = [output_data_folder,'/adc_18_nfa_',int2str(pgi(ii)),'s.txt'];
        [~,~,~,~,~,~,grade,latency,~]=textread(file_name,data_format);
        adc_18_nfa_avg_hop_latency(ii,sim_i) = sum(latency./grade)/length(latency)./128;
        adc_18_nfa_avg_delivery(ii,sim_i) = length(latency)/total_data_num;
        %% pdc sf=18
        file_name = [output_data_folder,'/pdc_18_nfa_',int2str(pgi(ii)),'s.txt'];
        [~,~,~,~,~,~,grade,latency,~]=textread(file_name,data_format);
        pdc_18_nfa_avg_hop_latency(ii,sim_i) = sum(latency./grade)/length(latency)./128;
        pdc_18_nfa_avg_delivery(ii,sim_i) = length(latency)/total_data_num;
        
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        %% adc sf =10, with free addressing
        file_name = [output_data_folder,'/adc_10_fa_',int2str(pgi(ii)),'s.txt'];
        [~,~,~,~,~,~,grade,latency,~]=textread(file_name,data_format);
        adc_10_fa_avg_hop_latency(ii,sim_i) = sum(latency./grade)/length(latency)./128;
        adc_10_fa_avg_delivery(ii,sim_i) = length(latency)/total_data_num;
        
        %% adc sf =18, without free addressing
        file_name = [output_data_folder,'/adc_10_nfa_',int2str(pgi(ii)),'s.txt'];
        [~,~,~,~,~,~,grade,latency,~]=textread(file_name,data_format);
        adc_10_nfa_avg_hop_latency(ii,sim_i) = sum(latency./grade)/length(latency)./128;
        adc_10_nfa_avg_delivery(ii,sim_i) = length(latency)/total_data_num;
        %% pdc sf=18
        file_name = [output_data_folder,'/pdc_10_nfa_',int2str(pgi(ii)),'s.txt'];
        [~,~,~,~,~,~,grade,latency,~]=textread(file_name,data_format);
        pdc_10_nfa_avg_hop_latency(ii,sim_i) = sum(latency./grade)/length(latency)./128;
        pdc_10_nfa_avg_delivery(ii,sim_i) = length(latency)/total_data_num;
    end
    sim_i=sim_i+1;
end
% l_pdc = 'b-s'; l_cc32hz = 'r--o'; l_cxmac = 'g:d';%l_cc8hz='r-.>';
%l_adc_18_fa = 'b-s'; l_adc_18_nfa = 'b--^'; l_pdc_18_nfa = 'r-^';
l_adc_18_fa = 'b-s'; l_adc_18_nfa = 'b-^'; l_pdc_18_nfa = 'r->';
l_adc_10_fa = 'b--s'; l_adc_10_nfa = 'b--^'; l_pdc_10_nfa = 'r-->';
linewidth_value=1.5;
%semilogy
adc_18_fa_avg_hop_latency_std = std(adc_18_fa_avg_hop_latency,0,2);
adc_18_fa_avg_hop_latency = mean(adc_18_fa_avg_hop_latency,2);
errorbar(pgi,adc_18_fa_avg_hop_latency,adc_18_fa_avg_hop_latency_std,l_adc_18_fa,'LineWidth',linewidth_value);
hold on;
adc_18_fa_latency = plot(pgi,adc_18_fa_avg_hop_latency,l_adc_18_fa,'LineWidth',linewidth_value);

adc_18_nfa_avg_hop_latency_std = std(adc_18_nfa_avg_hop_latency,0,2);
adc_18_nfa_avg_hop_latency = mean(adc_18_nfa_avg_hop_latency,2);
errorbar(pgi,adc_18_nfa_avg_hop_latency,adc_18_nfa_avg_hop_latency_std,l_adc_18_nfa,'LineWidth',linewidth_value);
adc_18_nfa_latency = plot(pgi,adc_18_nfa_avg_hop_latency,l_adc_18_nfa,'LineWidth',linewidth_value);

pdc_18_nfa_avg_hop_latency_std = std(pdc_18_nfa_avg_hop_latency,0,2);
pdc_18_nfa_avg_hop_latency = mean(pdc_18_nfa_avg_hop_latency,2);
errorbar(pgi,pdc_18_nfa_avg_hop_latency,pdc_18_nfa_avg_hop_latency_std,l_pdc_18_nfa,'LineWidth',linewidth_value);
pdc_18_nfa_latency = plot(pgi,pdc_18_nfa_avg_hop_latency,l_pdc_18_nfa,'LineWidth',linewidth_value);

adc_10_fa_avg_hop_latency_std = std(adc_10_fa_avg_hop_latency,0,2);
adc_10_fa_avg_hop_latency = mean(adc_10_fa_avg_hop_latency,2);
errorbar(pgi,adc_10_fa_avg_hop_latency,adc_10_fa_avg_hop_latency_std,l_adc_10_fa,'LineWidth',linewidth_value);
adc_10_fa_latency = plot(pgi,adc_10_fa_avg_hop_latency,l_adc_10_fa,'LineWidth',linewidth_value);

adc_10_nfa_avg_hop_latency_std = std(adc_10_nfa_avg_hop_latency,0,2);
adc_10_nfa_avg_hop_latency = mean(adc_10_nfa_avg_hop_latency,2);
errorbar(pgi,adc_10_nfa_avg_hop_latency,adc_10_nfa_avg_hop_latency_std,l_adc_10_nfa,'LineWidth',linewidth_value);
adc_10_nfa_latency = plot(pgi,adc_10_nfa_avg_hop_latency,l_adc_10_nfa,'LineWidth',linewidth_value);

pdc_10_nfa_avg_hop_latency_std = std(pdc_10_nfa_avg_hop_latency,0,2);
pdc_10_nfa_avg_hop_latency = mean(pdc_10_nfa_avg_hop_latency,2);
errorbar(pgi,pdc_10_nfa_avg_hop_latency,pdc_10_nfa_avg_hop_latency_std,l_pdc_10_nfa,'LineWidth',linewidth_value);
pdc_10_nfa_latency = plot(pgi,pdc_10_nfa_avg_hop_latency,l_pdc_10_nfa,'LineWidth',linewidth_value);

box on;
xlabel('Packet Generation Interval (s)','fontsize',16); %����x��ı���������С
ylabel('Average Hop Delivery Latency (s)','fontsize',16); %����y��ı���������С
% AX = legend([pdc_latency_1s cc_latency_1s pdc_latency_6s cc_latency_6s pdc_latency_11s cc_latency_11s ...
%     pdc_latency_16s cc_latency_16s pdc_latency_21s cc_latency_21s],'PDC (PGI=1s)','CC (PGI=1s)','PDC (PGI=6s)','CC (PGI=6s)', ...
%     'PDC (PGI=11s)','CC (PGI=11s)','PDC (PGI=16s)','CC (PGI=16s)','PDC (PGI=21s)','CC (PGI=21s)',2);%����legendλ�á�
% AX = legend([pdc_sf4_latency pdc_sf7_latency pdc_sf10_latency cc32hz_noRDC_latency cc16hz_latency cc32hz_latency cc64hz_latency cxmac_latency ], ...
%     'PDC (SF=4)','PDC (SF=7)','PDC (SF=10)','CTP-Full Active','CTP-CMAC-16Hz','CTP-CMAC-32Hz','CTP-CMAC-64Hz','CTP-XMAC',1);%����legendλ�á�
AX = legend([adc_10_fa_latency adc_10_nfa_latency adc_18_fa_latency adc_18_nfa_latency pdc_10_nfa_latency pdc_18_nfa_latency ], ...
    'ADC-FA (SSL=10)','ADC-No FA (SSL=10)','ADC-FA (SSL=18)','ADC-No FA (SSL=18)','PDC (SSL=10)','PDC (SSL=18)',0);%����legendλ�á�
LEG = findobj(AX,'type','text');
set(LEG,'FontSize',11);%����legend�����С
%copyobj(AX,gcf);
%AX=legend([pdc_sf4_latency pdc_sf7_latency], 'CTP-CMAC-16Hz','CTP-CMAC-32Hz','CTP-CMAC-64Hz','CTP-XMAC',1);
%LEG = findobj(AX,'type','text');
%set(LEG,'FontSize',11);%����legend�����С
set(gca,'FontSize',16);%�������������С
grid on;

figure;
adc_18_fa_avg_delivery_std = std(adc_18_fa_avg_delivery,0,2);
adc_18_fa_avg_delivery = mean(adc_18_fa_avg_delivery,2);
errorbar(pgi,adc_18_fa_avg_delivery,adc_18_fa_avg_delivery_std,l_adc_18_fa,'LineWidth',linewidth_value);
hold on;
adc_18_fa_delivery = plot(pgi,adc_18_fa_avg_delivery,l_adc_18_fa,'LineWidth',linewidth_value);
hold on;

adc_18_nfa_avg_delivery_std = std(adc_18_nfa_avg_delivery,0,2);
adc_18_nfa_avg_delivery = mean(adc_18_nfa_avg_delivery,2);
errorbar(pgi,adc_18_nfa_avg_delivery,adc_18_nfa_avg_delivery_std,l_adc_18_nfa,'LineWidth',linewidth_value);
adc_18_nfa_delivery = plot(pgi,adc_18_nfa_avg_delivery,l_adc_18_nfa,'LineWidth',linewidth_value);

pdc_18_nfa_avg_delivery_std = std(pdc_18_nfa_avg_delivery,0,2);
pdc_18_nfa_avg_delivery = mean(pdc_18_nfa_avg_delivery,2);
errorbar(pgi,pdc_18_nfa_avg_delivery,pdc_18_nfa_avg_delivery_std,l_pdc_18_nfa,'LineWidth',linewidth_value);
pdc_18_nfa_delivery = plot(pgi,pdc_18_nfa_avg_delivery,l_pdc_18_nfa,'LineWidth',linewidth_value);

adc_10_fa_avg_delivery_std = std(adc_10_fa_avg_delivery,0,2);
adc_10_fa_avg_delivery = mean(adc_10_fa_avg_delivery,2);
errorbar(pgi,adc_10_fa_avg_delivery,adc_10_fa_avg_delivery_std,l_adc_10_fa,'LineWidth',linewidth_value);
adc_10_fa_delivery = plot(pgi,adc_10_fa_avg_delivery,l_adc_10_fa,'LineWidth',linewidth_value);

adc_10_nfa_avg_delivery_std = std(adc_10_nfa_avg_delivery,0,2);
adc_10_nfa_avg_delivery = mean(adc_10_nfa_avg_delivery,2);
errorbar(pgi,adc_10_nfa_avg_delivery,adc_10_nfa_avg_delivery_std,l_adc_10_nfa,'LineWidth',linewidth_value);
adc_10_nfa_delivery = plot(pgi,adc_10_nfa_avg_delivery,l_adc_10_nfa,'LineWidth',linewidth_value);

pdc_10_nfa_avg_delivery_std = std(pdc_10_nfa_avg_delivery,0,2);
pdc_10_nfa_avg_delivery = mean(pdc_10_nfa_avg_delivery,2);
errorbar(pgi,pdc_10_nfa_avg_delivery,pdc_10_nfa_avg_delivery_std,l_pdc_10_nfa,'LineWidth',linewidth_value);
pdc_10_nfa_delivery = plot(pgi,pdc_10_nfa_avg_delivery,l_pdc_10_nfa,'LineWidth',linewidth_value);
box on;
xlabel('Packet Generation Interval (s)','fontsize',16); %����x��ı���������С
ylabel('Packet Delivery Ratio','fontsize',16); %����y��ı���������С
% AX = legend([pdc_data_num_1s cc_data_num_1s],'PDC (PGI=5s)','CC (PGI=5s)',3);%����legendλ�á�
AX = legend([adc_10_fa_delivery adc_10_nfa_delivery adc_18_fa_delivery adc_18_nfa_delivery pdc_10_nfa_delivery pdc_18_nfa_delivery], ...
    'ADC-FA (SSL=10)','ADC-No FA (SSL=10)','ADC-FA (SSL=18)','ADC-No FA (SSL=18)','PDC (SSL=10)','PDC (SSL=18)',4);%����legendλ�á�
LEG = findobj(AX,'type','text');
axis([0 10 0.1 1.1]);
set(LEG,'FontSize',11);%����legend�����С
set(gca,'FontSize',16);%�������������С
grid on;