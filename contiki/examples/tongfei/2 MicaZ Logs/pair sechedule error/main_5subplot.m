% address of each node in the real test bed:
% node : address
% sink : 1
% 1    : 2
% 2    : 5
% 3    : 6
% 4    : 7
close all 
clear all

% % subfigure's position
% left = 0.12;
% interval = 0.025;
% bottom_for_last = 0.11;
% sub_plots=3;
% height = (1-bottom_for_last-interval*(sub_plots-1))/sub_plots-0.01;
% width=0.85;

% subfigure's position
subfloat_num = 5;
left = 0.11;
interval = 0.009;
bottom_for_last = 0.1;
height = (1-bottom_for_last-interval*(subfloat_num-1))/subfloat_num-0.01;
width=0.85;
% x/y-axis range
x_from=0;
x_end = 12;
y_from_or_end = 13;
y_from=-13;
y_end=-y_from;
% legend position
legend_pos_2 = 4;
legend_pos_3 = 4;
legend_pos_4 = 4;
legend_pos_5 = 1;
legend_pos_6 = 1;
% legend label
legend2 = 'MicaZ pair 1';
legend3 = 'MicaZ pair 2';
legend4 = 'MicaZ pair 3';
legend5 = 'MicaZ pair 4';
legend6 = 'MicaZ pair 5';
z1_division = 32768;
figure_point = '.';
%========================================================================================%
%数据处理部分
%注意：指定的处理文件需放在与该文件相同的目录下

filename_final = 'processed_data1.txt';                     %最终输出并分析的txt
%========================================================================================%
process_data('cd_2.txt', filename_final, 0, 0);              %对数据进行简单的去偷去尾的处理
%数据读取以及分析部分
 [s1 time s2 clock_drift] = textread(filename_final, '%s %d %s %d');
time2=time;%-time(1);
time3 = time2/128;
clock_drift = clock_drift*1000/z1_division;
% subplot(4,1,1);
subplot('Position', [left,bottom_for_last+(subfloat_num-1)*height+(subfloat_num-1)*interval,width,height]);
plot(time3/3600,clock_drift,figure_point);
AX=legend(legend2,legend_pos_2);
LEG = findobj(AX,'type','text');
set(LEG,'FontSize',14);
set(gca,'FontSize',14);
set(gca,'XTickLabel',' ');
axis([x_from x_end y_from y_from_or_end]);
grid on;
%========================================================================================%
process_data('cd_4.txt', filename_final, 0, 0);              %对数据进行简单的去偷去尾的处理
%数据读取以及分析部分
 [s1 time s2 clock_drift] = textread(filename_final, '%s %d %s %d');
time2=time;%-time(1);
time3 = time2/128;
clock_drift = clock_drift*1000/z1_division;
% subplot(4,1,2);
subplot('Position', [left,bottom_for_last+(subfloat_num-2)*height+(subfloat_num-2)*interval,width,height]);
plot(time3/3600,clock_drift,figure_point);
AX=legend(legend3,legend_pos_3);
LEG = findobj(AX,'type','text');
set(LEG,'FontSize',14);
set(gca,'FontSize',14);
set(gca,'XTickLabel',' ');
axis([x_from x_end -y_from_or_end y_end]);
grid on;
%========================================================================================%
process_data('cd_8.txt', filename_final, 0, 0);               %对数据进行简单的去偷去尾的处理
%数据读取以及分析部分
 [s1 time s2 clock_drift] = textread(filename_final, '%s %d %s %d');
time2=time;%-time(1);
time3 = time2/128;
clock_drift = clock_drift*1000/z1_division;
% subplot(4,1,3);
subplot('Position', [left,bottom_for_last+(subfloat_num-3)*height+(subfloat_num-3)*interval,width,height]);
plot(time3/3600,clock_drift,figure_point);
AX=legend(legend4,legend_pos_4);
LEG = findobj(AX,'type','text');
set(LEG,'FontSize',14);
set(gca,'FontSize',14);
axis([x_from x_end y_from y_from_or_end]);
set(gca,'XTickLabel',' ');
ylabel('Schedule Error (ms)','fontsize',16);
grid on;
%========================================================================================%
process_data('cd_3.txt', filename_final, 0, 0);               %对数据进行简单的去偷去尾的处理
%数据读取以及分析部分
 [s1 time s2 clock_drift] = textread(filename_final, '%s %d %s %d');
time2=time;%-time(1);
time3 = time2/128;
clock_drift = clock_drift*1000/z1_division;
% subplot(4,1,3);
subplot('Position', [left,bottom_for_last+(subfloat_num-4)*height+(subfloat_num-4)*interval,width,height]);
plot(time3/3600,clock_drift,figure_point);
AX=legend(legend5,legend_pos_5);
LEG = findobj(AX,'type','text');
set(LEG,'FontSize',14);
set(gca,'FontSize',14);
axis([x_from x_end -y_from_or_end y_end]);
set(gca,'XTickLabel',' ');
grid on;
%========================================================================================%
process_data('cd_7.txt', filename_final, 0, 0);               %对数据进行简单的去偷去尾的处理
%数据读取以及分析部分
 [s1 time s2 clock_drift] = textread(filename_final, '%s %d %s %d');
time2=time;%-time(1);
time3 = time2/128;
clock_drift = clock_drift*1000/z1_division;
% subplot(4,1,4);
subplot('Position', [left,bottom_for_last,width,height]);
plot(time3/3600,clock_drift,figure_point);
AX=legend(legend6,legend_pos_6);
LEG = findobj(AX,'type','text');
set(LEG,'FontSize',14);
set(gca,'FontSize',14);
box on;
axis([x_from x_end y_from y_from_or_end]);
xlabel('Time (Hour)','fontsize',16); 
% ylabel('Clock Drift (Second)','fontsize',16);
grid on;

%plot(ff1);


