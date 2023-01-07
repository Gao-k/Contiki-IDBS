close all 
clear all
clc
total_data_num = 360;

node_num_at_each_grade = [1 1 2 4 4]';
node_num_at_each_grade = node_num_at_each_grade * 30;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
pgi = 1;
pdc_process_data_12_sensors_1_sink( ['rawdata/pdc_tempdata_pgi=',int2str(pgi),'s.txt'] ); % process the raw obtained data
file_in_array = char('processeddata/pdc_grade_1.txt','processeddata/pdc_grade_2.txt','processeddata/pdc_grade_3.txt', 'processeddata/pdc_grade_4.txt','processeddata/pdc_grade_5.txt');
temp = size(file_in_array);
pdc_latency_array_pgi_1s = zeros(5,1);
file_num = temp(1);
% pdc_total_data_num_pgi_10s = 0;
pdc_total_data_num_pgi_1s=zeros(5,1);
for i=1:1:file_num,
    file_name = file_in_array(i,:); % get the file name
    [~,~,~,~,~,~,grade,~,latency,~,~,~,~ ]=textread(file_name,'%s %s %d %s %s %s %d %s %d %s %d %s %d');
    pdc_latency_array_pgi_1s(i)=sum(latency)/length(latency);
%     pdc_total_data_num_pgi_10s = pdc_total_data_num_pgi_10s + length(latency);
    pdc_total_data_num_pgi_1s(i)=length(latency);
end
% fprintf('pdc_total_data_num = %d\n',pdc_total_data_num_pgi_10s);
pdc_latency_array_pgi_1s=pdc_latency_array_pgi_1s./128;

%%contiki collect
cc_process_data_12_sensors_1_sink([ 'rawdata/cc_tempdata_pgi=',int2str(pgi),'s.txt'] ); % process the raw obtained data
file_in_array = char('processeddata/cc_grade_1.txt','processeddata/cc_grade_2.txt','processeddata/cc_grade_3.txt', 'processeddata/cc_grade_4.txt','processeddata/cc_grade_5.txt');
temp = size(file_in_array);
cc_latency_array_pgi_1s = zeros(5,1);
file_num = temp(1);
% cc_total_data_num_1 = 0;
cc_total_data_num_pgi_1s = zeros(5,1);
for i=1:1:file_num,
    file_name = file_in_array(i,:); % get the file name
    [~,~,~,~,~,~,grade,~,~,~,latency,~,~,~,~ ]=textread(file_name,'%s %s %d %s %s %s %d %s %s %s %d %s %d %s %d');
    cc_latency_array_pgi_1s(i)=sum(abs(latency))/length(latency);
%     cc_total_data_num_1 = cc_total_data_num_1 + length(latency);
    cc_total_data_num_pgi_1s(i)=length(latency);
end
% fprintf('cc_total_data_num_1 = %d\n',cc_total_data_num_1);
cc_latency_array_pgi_1s=cc_latency_array_pgi_1s./128;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
pgi = 6;
pdc_process_data_12_sensors_1_sink( ['rawdata/pdc_tempdata_pgi=',int2str(pgi),'s.txt'] ); % process the raw obtained data
file_in_array = char('processeddata/pdc_grade_1.txt','processeddata/pdc_grade_2.txt','processeddata/pdc_grade_3.txt', 'processeddata/pdc_grade_4.txt','processeddata/pdc_grade_5.txt');
temp = size(file_in_array);
pdc_latency_array_pgi_6s = zeros(5,1);
file_num = temp(1);
% pdc_total_data_num_pgi_10s = 0;
pdc_total_data_num_pgi_6s=zeros(5,1);
for i=1:1:file_num,
    file_name = file_in_array(i,:); % get the file name
    [~,~,~,~,~,~,grade,~,latency,~,~,~,~ ]=textread(file_name,'%s %s %d %s %s %s %d %s %d %s %d %s %d');
    pdc_latency_array_pgi_6s(i)=sum(latency)/length(latency);
%     pdc_total_data_num_pgi_10s = pdc_total_data_num_pgi_10s + length(latency);
    pdc_total_data_num_pgi_6s(i)=length(latency);
end
% fprintf('pdc_total_data_num = %d\n',pdc_total_data_num_pgi_10s);
pdc_latency_array_pgi_6s=pdc_latency_array_pgi_6s./128;

%%contiki collect
cc_process_data_12_sensors_1_sink([ 'rawdata/cc_tempdata_pgi=',int2str(pgi),'s.txt'] ); % process the raw obtained data
file_in_array = char('processeddata/cc_grade_1.txt','processeddata/cc_grade_2.txt','processeddata/cc_grade_3.txt', 'processeddata/cc_grade_4.txt','processeddata/cc_grade_5.txt');
temp = size(file_in_array);
cc_latency_array_pgi_6s = zeros(5,1);
file_num = temp(1);
% cc_total_data_num_1 = 0;
cc_total_data_num_pgi_6s = zeros(5,1);
for i=1:1:file_num,
    file_name = file_in_array(i,:); % get the file name
    [~,~,~,~,~,~,grade,~,~,~,latency,~,~,~,~ ]=textread(file_name,'%s %s %d %s %s %s %d %s %s %s %d %s %d %s %d');
    cc_latency_array_pgi_6s(i)=sum(abs(latency))/length(latency);
%     cc_total_data_num_1 = cc_total_data_num_1 + length(latency);
    cc_total_data_num_pgi_6s(i)=length(latency);
end
% fprintf('cc_total_data_num_1 = %d\n',cc_total_data_num_1);
cc_latency_array_pgi_6s=cc_latency_array_pgi_6s./128;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
pgi = 11;
pdc_process_data_12_sensors_1_sink( ['rawdata/pdc_tempdata_pgi=',int2str(pgi),'s.txt'] ); % process the raw obtained data
file_in_array = char('processeddata/pdc_grade_1.txt','processeddata/pdc_grade_2.txt','processeddata/pdc_grade_3.txt', 'processeddata/pdc_grade_4.txt','processeddata/pdc_grade_5.txt');
temp = size(file_in_array);
pdc_latency_array_pgi_11s = zeros(5,1);
file_num = temp(1);
% pdc_total_data_num_pgi_10s = 0;
pdc_total_data_num_pgi_11s=zeros(5,1);
for i=1:1:file_num,
    file_name = file_in_array(i,:); % get the file name
    [~,~,~,~,~,~,grade,~,latency,~,~,~,~ ]=textread(file_name,'%s %s %d %s %s %s %d %s %d %s %d %s %d');
    pdc_latency_array_pgi_11s(i)=sum(latency)/length(latency);
%     pdc_total_data_num_pgi_10s = pdc_total_data_num_pgi_10s + length(latency);
    pdc_total_data_num_pgi_11s(i)=length(latency);
end
% fprintf('pdc_total_data_num = %d\n',pdc_total_data_num_pgi_10s);
pdc_latency_array_pgi_11s=pdc_latency_array_pgi_11s./128;

%%contiki collect
cc_process_data_12_sensors_1_sink([ 'rawdata/cc_tempdata_pgi=',int2str(pgi),'s.txt'] ); % process the raw obtained data
file_in_array = char('processeddata/cc_grade_1.txt','processeddata/cc_grade_2.txt','processeddata/cc_grade_3.txt', 'processeddata/cc_grade_4.txt','processeddata/cc_grade_5.txt');
temp = size(file_in_array);
cc_latency_array_pgi_11s = zeros(5,1);
file_num = temp(1);
% cc_total_data_num_1 = 0;
cc_total_data_num_pgi_11s = zeros(5,1);
for i=1:1:file_num,
    file_name = file_in_array(i,:); % get the file name
    [~,~,~,~,~,~,grade,~,~,~,latency,~,~,~,~ ]=textread(file_name,'%s %s %d %s %s %s %d %s %s %s %d %s %d %s %d');
    cc_latency_array_pgi_11s(i)=sum(abs(latency))/length(latency);
%     cc_total_data_num_1 = cc_total_data_num_1 + length(latency);
    cc_total_data_num_pgi_11s(i)=length(latency);
end
% fprintf('cc_total_data_num_1 = %d\n',cc_total_data_num_1);
cc_latency_array_pgi_11s=cc_latency_array_pgi_11s./128;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
pgi = 16;
pdc_process_data_12_sensors_1_sink( ['rawdata/pdc_tempdata_pgi=',int2str(pgi),'s.txt'] ); % process the raw obtained data
file_in_array = char('processeddata/pdc_grade_1.txt','processeddata/pdc_grade_2.txt','processeddata/pdc_grade_3.txt', 'processeddata/pdc_grade_4.txt','processeddata/pdc_grade_5.txt');
temp = size(file_in_array);
pdc_latency_array_pgi_16s = zeros(5,1);
file_num = temp(1);
% pdc_total_data_num_pgi_10s = 0;
pdc_total_data_num_pgi_16s=zeros(5,1);
for i=1:1:file_num,
    file_name = file_in_array(i,:); % get the file name
    [~,~,~,~,~,~,grade,~,latency,~,~,~,~ ]=textread(file_name,'%s %s %d %s %s %s %d %s %d %s %d %s %d');
    pdc_latency_array_pgi_16s(i)=sum(latency)/length(latency);
%     pdc_total_data_num_pgi_10s = pdc_total_data_num_pgi_10s + length(latency);
    pdc_total_data_num_pgi_16s(i)=length(latency);
end
% fprintf('pdc_total_data_num = %d\n',pdc_total_data_num_pgi_10s);
pdc_latency_array_pgi_16s=pdc_latency_array_pgi_16s./128;

%%contiki collect
cc_process_data_12_sensors_1_sink([ 'rawdata/cc_tempdata_pgi=',int2str(pgi),'s.txt'] ); % process the raw obtained data
file_in_array = char('processeddata/cc_grade_1.txt','processeddata/cc_grade_2.txt','processeddata/cc_grade_3.txt', 'processeddata/cc_grade_4.txt','processeddata/cc_grade_5.txt');
temp = size(file_in_array);
cc_latency_array_pgi_16s = zeros(5,1);
file_num = temp(1);
% cc_total_data_num_1 = 0;
cc_total_data_num_pgi_16s = zeros(5,1);
for i=1:1:file_num,
    file_name = file_in_array(i,:); % get the file name
    [~,~,~,~,~,~,grade,~,~,~,latency,~,~,~,~ ]=textread(file_name,'%s %s %d %s %s %s %d %s %s %s %d %s %d %s %d');
    cc_latency_array_pgi_16s(i)=sum(abs(latency))/length(latency);
%     cc_total_data_num_1 = cc_total_data_num_1 + length(latency);
    cc_total_data_num_pgi_16s(i)=length(latency);
end
% fprintf('cc_total_data_num_1 = %d\n',cc_total_data_num_1);
cc_latency_array_pgi_16s=cc_latency_array_pgi_16s./128;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
pgi = 21;
pdc_process_data_12_sensors_1_sink( ['rawdata/pdc_tempdata_pgi=',int2str(pgi),'s.txt'] ); % process the raw obtained data
file_in_array = char('processeddata/pdc_grade_1.txt','processeddata/pdc_grade_2.txt','processeddata/pdc_grade_3.txt', 'processeddata/pdc_grade_4.txt','processeddata/pdc_grade_5.txt');
temp = size(file_in_array);
pdc_latency_array_pgi_21s = zeros(5,1);
file_num = temp(1);
% pdc_total_data_num_pgi_10s = 0;
pdc_total_data_num_pgi_21s=zeros(5,1);
for i=1:1:file_num,
    file_name = file_in_array(i,:); % get the file name
    [~,~,~,~,~,~,grade,~,latency,~,~,~,~ ]=textread(file_name,'%s %s %d %s %s %s %d %s %d %s %d %s %d');
    pdc_latency_array_pgi_21s(i)=sum(latency)/length(latency);
%     pdc_total_data_num_pgi_10s = pdc_total_data_num_pgi_10s + length(latency);
    pdc_total_data_num_pgi_21s(i)=length(latency);
end
% fprintf('pdc_total_data_num = %d\n',pdc_total_data_num_pgi_10s);
pdc_latency_array_pgi_21s=pdc_latency_array_pgi_21s./128;

%%contiki collect
cc_process_data_12_sensors_1_sink([ 'rawdata/cc_tempdata_pgi=',int2str(pgi),'s.txt'] ); % process the raw obtained data
file_in_array = char('processeddata/cc_grade_1.txt','processeddata/cc_grade_2.txt','processeddata/cc_grade_3.txt', 'processeddata/cc_grade_4.txt','processeddata/cc_grade_5.txt');
temp = size(file_in_array);
cc_latency_array_pgi_21s = zeros(5,1);
file_num = temp(1);
% cc_total_data_num_1 = 0;
cc_total_data_num_pgi_21s = zeros(5,1);
for i=1:1:file_num,
    file_name = file_in_array(i,:); % get the file name
    [~,~,~,~,~,~,grade,~,~,~,latency,~,~,~,~ ]=textread(file_name,'%s %s %d %s %s %s %d %s %s %s %d %s %d %s %d');
    cc_latency_array_pgi_21s(i)=sum(abs(latency))/length(latency);
%     cc_total_data_num_1 = cc_total_data_num_1 + length(latency);
    cc_total_data_num_pgi_21s(i)=length(latency);
end
% fprintf('cc_total_data_num_1 = %d\n',cc_total_data_num_1);
cc_latency_array_pgi_21s=cc_latency_array_pgi_21s./128;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
grade=[1 2 3 4 5];
% all_latency = [pdc_latency_array_pgi_1s  cc_latency_array_pgi_1s ];
pdc_1s='k-d'; pdc_6s='m-x'; pdc_11s='r-s'; pdc_16s='g->'; pdc_21s='b-o';
line_style='-.';
cc_1s=['k',line_style,'d']; cc_6s=['m',line_style,'x']; cc_11s=['r',line_style,'s']; cc_16s=['g',line_style,'>']; cc_21s=['b',line_style,'o'];

% all_latency = [pdc_latency_array_pgi_1s cc_latency_array_pgi_1s pdc_latency_array_pgi_11s cc_latency_array_pgi_11s ...
%     pdc_latency_array_pgi_21s cc_latency_array_pgi_21s];
linewidth_value=2;
pdc_latency_1s = plot(grade,pdc_latency_array_pgi_1s,pdc_1s,'LineWidth',linewidth_value);
hold on;
cc_latency_1s = plot(grade,cc_latency_array_pgi_1s,cc_1s,'LineWidth',linewidth_value);

% pdc_latency_6s = plot(grade,pdc_latency_array_pgi_6s,pdc_6s);
% cc_latency_6s = plot(grade,cc_latency_array_pgi_6s,cc_6s);

pdc_latency_11s = plot(grade,pdc_latency_array_pgi_11s,pdc_11s,'LineWidth',linewidth_value);
cc_latency_11s = plot(grade,cc_latency_array_pgi_11s,cc_11s,'LineWidth',linewidth_value);

% pdc_latency_16s = plot(grade,pdc_latency_array_pgi_16s,pdc_16s);
% cc_latency_16s = plot(grade,cc_latency_array_pgi_16s,cc_16s);

pdc_latency_21s = plot(grade,pdc_latency_array_pgi_21s,pdc_21s,'LineWidth',linewidth_value);
cc_latency_21s = plot(grade,cc_latency_array_pgi_21s,cc_21s,'LineWidth',linewidth_value);
box on;
xlabel('Hops','fontsize',16); %设置x轴的标题和字体大小
ylabel('Packet Delivery Latency (s)','fontsize',16); %设置y轴的标题和字体大小
% AX = legend([pdc_latency_1s cc_latency_1s pdc_latency_6s cc_latency_6s pdc_latency_11s cc_latency_11s ...
%     pdc_latency_16s cc_latency_16s pdc_latency_21s cc_latency_21s],'PDC (PGI=1s)','CC (PGI=1s)','PDC (PGI=6s)','CC (PGI=6s)', ...
%     'PDC (PGI=11s)','CC (PGI=11s)','PDC (PGI=16s)','CC (PGI=16s)','PDC (PGI=21s)','CC (PGI=21s)',2);%设置legend位置。
AX = legend([pdc_latency_1s cc_latency_1s   pdc_latency_11s cc_latency_11s ...
      pdc_latency_21s cc_latency_21s],'PDC (PGI=1s)','CC (PGI=1s)', ...
    'PDC (PGI=11s)','CC (PGI=11s)','PDC (PGI=21s)','CC (PGI=21s)',2);%设置legend位置。
LEG = findobj(AX,'type','text');
set(LEG,'FontSize',14);%设置legend字体大小
set(gca,'FontSize',16);%设置坐标字体大小
% grid on;

figure;
linewidth_value=2;
pdc_data_num_1s=plot(grade,pdc_total_data_num_pgi_1s./node_num_at_each_grade,pdc_1s,'LineWidth',linewidth_value);
hold on;
cc_data_num_1s = plot(grade,cc_total_data_num_pgi_1s./node_num_at_each_grade,cc_1s,'LineWidth',linewidth_value);

pdc_data_num_11s=plot(grade,pdc_total_data_num_pgi_11s./node_num_at_each_grade,pdc_11s,'LineWidth',linewidth_value);
cc_data_num_11s = plot(grade,cc_total_data_num_pgi_11s./node_num_at_each_grade,cc_11s,'LineWidth',linewidth_value);

pdc_data_num_21s=plot(grade,pdc_total_data_num_pgi_21s./node_num_at_each_grade,pdc_21s,'LineWidth',linewidth_value);
cc_data_num_21s = plot(grade,cc_total_data_num_pgi_21s./node_num_at_each_grade,cc_21s,'LineWidth',linewidth_value);

box on;
xlabel('Hops','fontsize',16); %设置x轴的标题和字体大小
ylabel('Packet Reception Ratio','fontsize',16); %设置y轴的标题和字体大小
% AX = legend([pdc_data_num_1s cc_data_num_1s],'PDC (PGI=5s)','CC (PGI=5s)',3);%设置legend位置。
AX = legend([pdc_data_num_1s cc_data_num_1s   pdc_data_num_11s cc_data_num_11s ...
      pdc_data_num_21s cc_data_num_21s],'PDC (PGI=1s)','CC (PGI=1s)', ...
    'PDC (PGI=11s)','CC (PGI=11s)','PDC (PGI=21s)','CC (PGI=21s)',3);%设置legend位置。
LEG = findobj(AX,'type','text');
set(LEG,'FontSize',14);%设置legend字体大小
set(gca,'FontSize',16);%设置坐标字体大小
grid on;
% data_delivery_ratio = [pdc_total_data_num_pgi_10s   cc_total_data_num_1  ]'./total_data_num;
% 
% H=bar(data_delivery_ratio,0.5);
% ylabel('Packet Reception Ratio','fontsize',16);
% xtl_text = {'PDC','CC $(L_R=0)$','CC $(L_R=5)$','CC $(L_R=10)$'};
% xtk = get(gca,'xtick');
% h = my_xticklabels(gca,xtk,xtl_text);
% ylim([0,1]);
% set(gca,'FontSize',14);
