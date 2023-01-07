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
y_from_or_end = 12;
y_from=-12;
y_end=-y_from;
% legend position
legend_pos_2 = 4;
legend_pos_3 = 4;
legend_pos_5 = 1;
legend_pos_6 = 1;
legend_pos_7 = 1;
% legend label
legend2 = '6 to 5';
legend3 = '7 to 6';
legend5 = '8 to 7';
legend6 = '9 to 8';
legend7 = '10 to 9';
z1_division = 32768/1000;
figure_point = '.';
%========================================================================================%
%数据处理部分
%注意：指定的处理文件需放在与该文件相同的目录下

filename_final = 'processed_data1.txt';                     %最终输出并分析的txt
%========================================================================================%
process_data('cd_7.txt', filename_final, 0, 0);              %对数据进行简单的去偷去尾的处理
%数据读取以及分析部分
[ss0 ss1 s1 time s2 clock_drift] = textread(filename_final, '%s %s %s %d %s %d');
time2=time;%-time(1);
time3 = time2/128;
clock_drift = clock_drift/z1_division;
% subplot(4,1,1);
subplot('Position', [left,bottom_for_last+(subfloat_num-1)*height+(subfloat_num-1)*interval,width,height]);
plot(time3/3600,clock_drift,figure_point);
legend(legend2,legend_pos_2);
set(gca,'XTickLabel',' ');
axis([x_from x_end y_from y_from_or_end]);
grid on;
%========================================================================================%
process_data('cd_8.txt', filename_final, 0, 0);              %对数据进行简单的去偷去尾的处理
%数据读取以及分析部分
[ss0 ss1 s1 time s2 clock_drift] = textread(filename_final, '%s %s %s %d %s %d');
time2=time;%-time(1);
time3 = time2/128;
clock_drift = clock_drift/z1_division;
% subplot(4,1,2);
subplot('Position', [left,bottom_for_last+(subfloat_num-2)*height+(subfloat_num-2)*interval,width,height]);
plot(time3/3600,clock_drift,figure_point);
legend(legend3,legend_pos_3);
set(gca,'XTickLabel',' ');
axis([x_from x_end -y_from_or_end y_end]);
grid on;
%========================================================================================%
process_data('cd_9.txt', filename_final, 0, 0);               %对数据进行简单的去偷去尾的处理
%数据读取以及分析部分
[ss0 ss1 s1 time s2 clock_drift] = textread(filename_final, '%s %s %s %d %s %d');
time2=time;%-time(1);
time3 = time2/128;
clock_drift = clock_drift/z1_division;
% subplot(4,1,3);
subplot('Position', [left,bottom_for_last+(subfloat_num-3)*height+(subfloat_num-3)*interval,width,height]);
plot(time3/3600,clock_drift,figure_point);
legend(legend5,legend_pos_5);
axis([x_from x_end y_from y_from_or_end]);
set(gca,'XTickLabel',' ');
ylabel('Schedule Error (ms)','fontsize',16);
grid on;
%========================================================================================%
process_data('cd_10.txt', filename_final, 0, 0);               %对数据进行简单的去偷去尾的处理
%数据读取以及分析部分
[ss0 ss1 s1 time s2 clock_drift] = textread(filename_final, '%s %s %s %d %s %d');
time2=time;%-time(1);
time3 = time2/128;
clock_drift = clock_drift/z1_division;
% subplot(4,1,3);
subplot('Position', [left,bottom_for_last+(subfloat_num-4)*height+(subfloat_num-4)*interval,width,height]);
plot(time3/3600,clock_drift,figure_point);
legend(legend6,legend_pos_6);
axis([x_from x_end -y_from_or_end y_end]);
set(gca,'XTickLabel',' ');
grid on;
%========================================================================================%
process_data('cd_11.txt', filename_final, 0, 0);               %对数据进行简单的去偷去尾的处理
%数据读取以及分析部分
[ss0 ss1 s1 time s2 clock_drift] = textread(filename_final, '%s %s %s %d %s %d');
time2=time;%-time(1);
time3 = time2/128;
clock_drift = clock_drift/z1_division;
% subplot(4,1,4);
subplot('Position', [left,bottom_for_last,width,height]);
plot(time3/3600,clock_drift,figure_point);
legend(legend7,legend_pos_7);
box on;
axis([x_from x_end y_from y_from_or_end]);
xlabel('Time (Hour)','fontsize',16); 
% ylabel('Clock Drift (Second)','fontsize',16);
grid on;

%plot(ff1);


