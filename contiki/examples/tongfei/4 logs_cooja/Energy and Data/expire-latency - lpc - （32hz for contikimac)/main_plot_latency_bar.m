close all 
clear all
clc

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
lpc_process_data_12_sensors_1_sink( 'rawdata/lpc_tempdata.txt' );
file_in_array = char('processeddata/lpc_grade_1.txt','processeddata/lpc_grade_2.txt','processeddata/lpc_grade_3.txt', 'processeddata/lpc_grade_4.txt','processeddata/lpc_grade_5.txt');
temp = size(file_in_array);
lpc_latency_array = zeros(5,1);
file_num = temp(1);
lpc_total_data_num = 0;
for i=1:1:file_num,
    file_name = file_in_array(i,:); % get the file name
    [~,~,~,~,~,~,grade,~,latency,~,~,~,~ ]=textread(file_name,'%s %s %d %s %s %s %d %s %d %s %d %s %d');
    lpc_latency_array(i)=sum(latency)/length(latency);
    lpc_total_data_num = lpc_total_data_num + length(latency);
end
fprintf('lpc_total_data_num = %d\n',lpc_total_data_num);
lpc_latency_array=lpc_latency_array.*1000./(128*3600);
%bar(latency_array);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
contikiCollect_process_data_12_sensors_1_sink( 'rawdata/contikiCollect_tempdata_1.txt' );
file_in_array = char('processeddata/contikiCollect_grade_1.txt','processeddata/contikiCollect_grade_2.txt','processeddata/contikiCollect_grade_3.txt', 'processeddata/contikiCollect_grade_4.txt','processeddata/contikiCollect_grade_5.txt');
temp = size(file_in_array);
contikiCollect_latency_array_1 = zeros(5,1);
file_num = temp(1);
contikiCollect_total_data_num_1 = 0;
for i=1:1:file_num,
    file_name = file_in_array(i,:); % get the file name
    [~,~,~,~,~,~,grade,~,~,~,latency,~,~,~,~ ]=textread(file_name,'%s %s %d %s %s %s %d %s %s %s %d %s %d %s %d');
    contikiCollect_latency_array_1(i)=sum(abs(latency))/length(latency);
    contikiCollect_total_data_num_1 = contikiCollect_total_data_num_1 + length(latency);
end
fprintf('contikiCollect_total_data_num_1 = %d\n',contikiCollect_total_data_num_1);
contikiCollect_latency_array_1=contikiCollect_latency_array_1.*1000./(128*3600);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
contikiCollect_process_data_12_sensors_1_sink( 'rawdata/contikiCollect_tempdata_2.txt' );
file_in_array = char('processeddata/contikiCollect_grade_1.txt','processeddata/contikiCollect_grade_2.txt','processeddata/contikiCollect_grade_3.txt', 'processeddata/contikiCollect_grade_4.txt','processeddata/contikiCollect_grade_5.txt');
temp = size(file_in_array);
contikiCollect_latency_array_2 = zeros(5,1);
file_num = temp(1);
contikiCollect_total_data_num_2 = 0;
for i=1:1:file_num,
    file_name = file_in_array(i,:); % get the file name
    [~,~,~,~,~,~,grade,~,~,~,latency,~,~,~,~ ]=textread(file_name,'%s %s %d %s %s %s %d %s %s %s %d %s %d %s %d');
    contikiCollect_latency_array_2(i)=sum(abs(latency))/length(latency);
    contikiCollect_total_data_num_2 = contikiCollect_total_data_num_2 + length(latency);
end
fprintf('contikiCollect_total_data_num_2 = %d\n',contikiCollect_total_data_num_2);
contikiCollect_latency_array_2=contikiCollect_latency_array_2.*1000./(128*3600);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
contikiCollect_process_data_12_sensors_1_sink( 'rawdata/contikiCollect_tempdata_3.txt' );
file_in_array = char('processeddata/contikiCollect_grade_1.txt','processeddata/contikiCollect_grade_2.txt','processeddata/contikiCollect_grade_3.txt', 'processeddata/contikiCollect_grade_4.txt','processeddata/contikiCollect_grade_5.txt');
temp = size(file_in_array);
contikiCollect_latency_array_3 = zeros(5,1);
file_num = temp(1);
contikiCollect_total_data_num_3 = 0;
for i=1:1:file_num,
    file_name = file_in_array(i,:); % get the file name
    [~,~,~,~,~,~,grade,~,~,~,latency,~,~,~,~ ]=textread(file_name,'%s %s %d %s %s %s %d %s %s %s %d %s %d %s %d');
    contikiCollect_latency_array_3(i)=sum(abs(latency))/length(latency);
    contikiCollect_total_data_num_3 = contikiCollect_total_data_num_3 + length(latency);
end
fprintf('contikiCollect_total_data_num_3 = %d\n',contikiCollect_total_data_num_3);
contikiCollect_latency_array_3=contikiCollect_latency_array_3.*1000./(128*3600);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% contikiCollect_process_data_12_sensors_1_sink( 'rawdata/contikiCollect_tempdata_4.txt' );
% file_in_array = char('processeddata/contikiCollect_grade_1.txt','processeddata/contikiCollect_grade_2.txt','processeddata/contikiCollect_grade_3.txt', 'processeddata/contikiCollect_grade_4.txt','processeddata/contikiCollect_grade_5.txt');
% temp = size(file_in_array);
% contikiCollect_latency_array_4 = zeros(5,1);
% file_num = temp(1);
% contikiCollect_total_data_num_4 = 0;
% for i=1:1:file_num,
%     file_name = file_in_array(i,:); % get the file name
%     [~,~,~,~,~,~,grade,~,~,~,latency,~,~,~,~ ]=textread(file_name,'%s %s %d %s %s %s %d %s %s %s %d %s %d %s %d');
%     contikiCollect_latency_array_4(i)=sum(abs(latency))/length(latency);
%     contikiCollect_total_data_num_4 = contikiCollect_total_data_num_4 + length(latency);
% end
% fprintf('contikiCollect_total_data_num_4 = %d\n',contikiCollect_total_data_num_4);
% contikiCollect_latency_array_4=contikiCollect_latency_array_4.*1000./(128*3600);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
all_latency = [lpc_latency_array contikiCollect_latency_array_1 contikiCollect_latency_array_2 contikiCollect_latency_array_3];
bar(all_latency,1);
ylim([0,0.7]);
xlabel('Hop(s) to sink','fontsize',16);
ylabel('Packet Delivery Latency (ms)','fontsize',16);
AX=legend({'PCC','CC({\it L_R}=0)','CC ({\it L_R}=5)','CC ({\it L_R}=10)'},2);
LEG = findobj(AX,'type','text');
set(LEG,'FontSize',16);
set(gca,'FontSize',14);
set(gcf, 'color', 'w');
applyhatch(gcf,'\x./');

% P=findobj(gca,'type','patch');
% %设置直方图的颜色
% C=['r','g','b','m','k'];
% for n=1:length(P) 
%     set(P(n),'facecolor',C(n));
% end


% AX = legend({'LPC','CC({\it L_R}=0)','CC ({\it L_R}=5)','CC ({\it L_R}=10)','CC ({\it L_R}=15)'},2);

%设置legend的颜色
% LEG = findobj(AX,'type','patch');
% for n=1:length(LEG) 
%     set(LEG(n),'facecolor',C(n));
% end

% xlabel('Hop(s) to sink','fontsize',16);
% ylabel('Packet Delivery Latency (ms)','fontsize',16);
% ylim([0,6]);
% LEG = findobj(AX,'type','text');
%set(LEG,'FontSize',16);



figure;
data_delivery_ratio = [lpc_total_data_num contikiCollect_total_data_num_1 contikiCollect_total_data_num_2 contikiCollect_total_data_num_3]'./600;

H=bar(data_delivery_ratio,0.5);
ylabel('Packet Delivery Ratio','fontsize',16);
xtl_text = {'PCC','CC $(L_R=0)$','CC $(L_R=5)$','CC $(L_R=10)$'};
xtk = get(gca,'xtick');
h = my_xticklabels(gca,xtk,xtl_text);
ylim([0,1]);
set(gca,'FontSize',14);
