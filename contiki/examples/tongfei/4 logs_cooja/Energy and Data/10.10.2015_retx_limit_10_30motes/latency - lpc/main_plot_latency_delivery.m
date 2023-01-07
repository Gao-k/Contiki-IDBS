close all 
clear all
clc

file_num = [1 2 3 4 5];
pgi = [1 2 3 4 5]*10;

pdc_sf4_avg_hop_latency = zeros(5,1);
pdc_sf7_avg_hop_latency = zeros(5,1);
pdc_sf10_avg_hop_latency = zeros(5,1);

cc32hz_noRDC_avg_hop_latency = zeros(5,1);
cc32hz_avg_hop_latency = zeros(5,1);

cxmac_avg_hop_latency = zeros(5,1);
%%
pdc_sf4_avg_delivery = zeros(5,1);
pdc_sf7_avg_delivery = zeros(5,1);
pdc_sf10_avg_delivery = zeros(5,1);

cc32hz_noRDC_avg_delivery = zeros(5,1);
cc32hz_avg_delivery = zeros(5,1);

cxmac_avg_delivery = zeros(5,1);
total_data_num = 30*10; % 30 nodes, 10 pkts/node generated
for ii = file_num
    %% pdc sf =4
    file_name = ['rawdata/pdc_sf=4_tempdata_pgi=',int2str(ii),'s.txt'];
    [~,~,~,~,~,~,grade,~,latency,~,~,~,~ ]=textread(file_name,'%s %s %d %s %s %s %d %s %d %s %d %s %d');
    pdc_sf4_avg_hop_latency(ii) = sum(latency./grade)/length(latency)./128;
    
    pdc_sf4_avg_delivery(ii) = length(latency)/total_data_num;
    %% pdc sf=7
    file_name = ['rawdata/pdc_sf=7_tempdata_pgi=',int2str(ii),'s.txt'];
    [~,~,~,~,~,~,grade,~,latency,~,~,~,~ ]=textread(file_name,'%s %s %d %s %s %s %d %s %d %s %d %s %d');
    pdc_sf7_avg_hop_latency(ii) = sum(latency./grade)/length(latency)./128;
    
    pdc_sf7_avg_delivery(ii) = length(latency)/total_data_num;
    %% pdc sf = 10
    file_name = ['rawdata/pdc_sf=10_tempdata_pgi=',int2str(ii),'s.txt'];
    [~,~,~,~,~,~,grade,~,latency,~,~,~,~ ]=textread(file_name,'%s %s %d %s %s %s %d %s %d %s %d %s %d');
    pdc_sf10_avg_hop_latency(ii) = sum(latency./grade)/length(latency)./128;
    
    pdc_sf10_avg_delivery(ii) = length(latency)/total_data_num;
    %% contikimac 32hz No RDC
    file_name = ['rawdata/cc(FullActive)_tempdata_pgi=',int2str(ii),'s.txt'];
    [~,~,~,~,~,~,grade,~,~,~,latency,~,~,~,~ ]=textread(file_name,'%s %s %d %s %s %s %d %s %s %s %d %s %d %s %d');
    cc32hz_noRDC_avg_hop_latency(ii) = sum(abs(latency)./grade)/length(latency)./128;
    
    cc32hz_noRDC_avg_delivery(ii) = length(latency)/total_data_num;
    %% contikimac 32hz
    file_name = ['rawdata/cc(32hz)_tempdata_pgi=',int2str(ii),'s.txt'];
    [~,~,~,~,~,~,grade,~,~,~,latency,~,~,~,~ ]=textread(file_name,'%s %s %d %s %s %s %d %s %s %s %d %s %d %s %d');
    cc32hz_avg_hop_latency(ii) = sum(abs(latency)./grade)/length(latency)./128;
    
    cc32hz_avg_delivery(ii) = length(latency)/total_data_num;
    %% cxmac
    file_name = ['rawdata/cxmac_tempdata_pgi=',int2str(ii),'s.txt'];
    [~,~,~,~,~,~,grade,~,~,~,latency,~,~,~,~ ]=textread(file_name,'%s %s %d %s %s %s %d %s %s %s %d %s %d %s %d');
    cxmac_avg_hop_latency(ii) = sum(abs(latency)./grade)/length(latency)./128;
    
    cxmac_avg_delivery(ii) = length(latency)/total_data_num;
end
% l_pdc = 'b-s'; l_cc32hz = 'r--o'; l_cxmac = 'g:d';%l_cc8hz='r-.>';
l_pdc_sf4 = 'b-s'; l_pdc_sf7 = 'b-^';l_pdc_sf10='b-x'; l_cc32hz = 'r--o';l_cc32hzNoRDC = 'm-.*'; l_cxmac = 'g:d'; %l_cc8hz='r-.>';
linewidth_value=2.5;
%semilogy
pdc_sf4_latency = plot(pgi,pdc_sf4_avg_hop_latency,l_pdc_sf4,'LineWidth',linewidth_value);
hold on;
pdc_sf7_latency = plot(pgi,pdc_sf7_avg_hop_latency,l_pdc_sf7,'LineWidth',linewidth_value);
pdc_sf10_latency = plot(pgi,pdc_sf10_avg_hop_latency,l_pdc_sf10,'LineWidth',linewidth_value,'MarkerSize',12);
cc32hz_noRDC_latency = plot(pgi,cc32hz_noRDC_avg_hop_latency,l_cc32hzNoRDC,'LineWidth',linewidth_value,'MarkerSize',10);
cc32hz_latency = plot(pgi,cc32hz_avg_hop_latency,l_cc32hz,'LineWidth',linewidth_value);
cxmac_latency = plot(pgi,cxmac_avg_hop_latency,l_cxmac,'LineWidth',linewidth_value);

box on;
xlabel('Packet Generation Interval (s)','fontsize',16); %设置x轴的标题和字体大小
ylabel('Average Hop Delivery Latency (s)','fontsize',16); %设置y轴的标题和字体大小
% AX = legend([pdc_latency_1s cc_latency_1s pdc_latency_6s cc_latency_6s pdc_latency_11s cc_latency_11s ...
%     pdc_latency_16s cc_latency_16s pdc_latency_21s cc_latency_21s],'PDC (PGI=1s)','CC (PGI=1s)','PDC (PGI=6s)','CC (PGI=6s)', ...
%     'PDC (PGI=11s)','CC (PGI=11s)','PDC (PGI=16s)','CC (PGI=16s)','PDC (PGI=21s)','CC (PGI=21s)',2);%设置legend位置。
AX = legend([pdc_sf4_latency pdc_sf7_latency pdc_sf10_latency cc32hz_latency cxmac_latency cc32hz_noRDC_latency], ...
    'PDC (SF=4)','PDC (SF=7)','PDC (SF=10)','CCP (ContimicMAC)','CCP (X-MAC)','CCP (Fully-Active Radio)',1);%设置legend位置。
LEG = findobj(AX,'type','text');
set(LEG,'FontSize',14);%设置legend字体大小
set(gca,'FontSize',16);%设置坐标字体大小
grid on;

figure;
pdc_sf4_delivery = plot(pgi,pdc_sf4_avg_delivery,l_pdc_sf4,'LineWidth',linewidth_value);
hold on;
pdc_sf7_delivery = plot(pgi,pdc_sf7_avg_delivery,l_pdc_sf7,'LineWidth',linewidth_value);
pdc_sf10_delivery = plot(pgi,pdc_sf10_avg_delivery,l_pdc_sf10,'LineWidth',linewidth_value,'MarkerSize',12);
cc32hz_noRDC_delivery = plot(pgi,cc32hz_noRDC_avg_delivery,l_cc32hzNoRDC,'LineWidth',linewidth_value,'MarkerSize',10);
cc32hz_delivery = plot(pgi,cc32hz_avg_delivery,l_cc32hz,'LineWidth',linewidth_value);
cxmac_delivery = plot(pgi,cxmac_avg_delivery,l_cxmac,'LineWidth',linewidth_value);
box on;
xlabel('Packet Generation Interval (s)','fontsize',16); %设置x轴的标题和字体大小
ylabel('Packet Delivery Ratio','fontsize',16); %设置y轴的标题和字体大小
% AX = legend([pdc_data_num_1s cc_data_num_1s],'PDC (PGI=5s)','CC (PGI=5s)',3);%设置legend位置。
AX = legend([pdc_sf4_delivery pdc_sf7_delivery pdc_sf10_delivery cc32hz_delivery cxmac_delivery cc32hz_noRDC_delivery], ...
'PDC (SF=4)','PDC (SF=7)','PDC (SF=10)','CCP (ContikiMAC)','CCP (X-MAC)','CCP (Fully-Active Radio)',4);%设置legend位置。
LEG = findobj(AX,'type','text');
axis([10 50 0.4 1.001]);
set(LEG,'FontSize',14);%设置legend字体大小
set(gca,'FontSize',16);%设置坐标字体大小
grid on;