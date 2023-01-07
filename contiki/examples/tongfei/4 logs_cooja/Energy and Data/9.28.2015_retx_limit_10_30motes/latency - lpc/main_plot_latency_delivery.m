close all 
clear all
clc

file_num = [1 2 3 4 5];
pgi = [1 2 3 4 5]*10;
pdc_avg_hop_latency = zeros(5,1);
cc_avg_hop_latency = zeros(5,1);
pdc_avg_delivery = zeros(5,1);
cc_avg_delivery = zeros(5,1);
total_data_num = 30*10; % 30 nodes, 10 pkts/node generated
for ii = file_num
    %% pdc
    file_name = ['rawdata/pdc_tempdata_pgi=',int2str(ii),'s.txt'];
    [~,~,~,~,~,~,grade,~,latency,~,~,~,~ ]=textread(file_name,'%s %s %d %s %s %s %d %s %d %s %d %s %d');
    pdc_avg_hop_latency(ii) = sum(latency./grade)/length(latency)./128;
    
    pdc_avg_delivery(ii) = length(latency)/total_data_num;
    
    file_name = ['rawdata/cc(32hz)_tempdata_pgi=',int2str(ii),'s.txt'];
    [~,~,~,~,~,~,grade,~,~,~,latency,~,~,~,~ ]=textread(file_name,'%s %s %d %s %s %s %d %s %s %s %d %s %d %s %d');
    cc_avg_hop_latency(ii) = sum(latency./grade)/length(latency)./128;
    
    cc_avg_delivery(ii) = length(latency)/total_data_num;
end
linewidth_value=2;
pdc_latency = plot(pgi,pdc_avg_hop_latency,'b-s','LineWidth',linewidth_value);
hold on;
cc_latency = plot(pgi,cc_avg_hop_latency,'r-.>','LineWidth',linewidth_value);

box on;
xlabel('Packet Generation Interval (s)','fontsize',16); %设置x轴的标题和字体大小
ylabel('Average Hop Delivery Latency (s)','fontsize',16); %设置y轴的标题和字体大小
% AX = legend([pdc_latency_1s cc_latency_1s pdc_latency_6s cc_latency_6s pdc_latency_11s cc_latency_11s ...
%     pdc_latency_16s cc_latency_16s pdc_latency_21s cc_latency_21s],'PDC (PGI=1s)','CC (PGI=1s)','PDC (PGI=6s)','CC (PGI=6s)', ...
%     'PDC (PGI=11s)','CC (PGI=11s)','PDC (PGI=16s)','CC (PGI=16s)','PDC (PGI=21s)','CC (PGI=21s)',2);%设置legend位置。
AX = legend([pdc_latency cc_latency],'PDC','CC',1);%设置legend位置。
LEG = findobj(AX,'type','text');
set(LEG,'FontSize',14);%设置legend字体大小
set(gca,'FontSize',16);%设置坐标字体大小
grid on;

figure;
pdc_delivery = plot(pgi,pdc_avg_delivery,'b-s','LineWidth',linewidth_value);
hold on;
cc_delivery = plot(pgi,cc_avg_delivery,'r-.>','LineWidth',linewidth_value);
box on;
xlabel('Packet Generation Interval (s)','fontsize',16); %设置x轴的标题和字体大小
ylabel('Packet Delivery Ratio','fontsize',16); %设置y轴的标题和字体大小
% AX = legend([pdc_data_num_1s cc_data_num_1s],'PDC (PGI=5s)','CC (PGI=5s)',3);%设置legend位置。
AX = legend([pdc_delivery cc_delivery],'PDC','CC',4);%设置legend位置。
LEG = findobj(AX,'type','text');
set(LEG,'FontSize',14);%设置legend字体大小
set(gca,'FontSize',16);%设置坐标字体大小
grid on;