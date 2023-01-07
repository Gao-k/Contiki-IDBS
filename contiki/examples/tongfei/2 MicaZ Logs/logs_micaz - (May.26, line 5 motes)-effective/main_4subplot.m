close all 
clear all

% subfigure's position
left = 0.11;
interval = 0.025;
bottom_for_last = 0.11;
height = (1-bottom_for_last-interval*3)/4-0.01;
width=0.85;
% x/y-axis range
x_from=0;
x_end = 24;
y_from=-13;
y_end=-y_from;
% legend label
legend1 = 'D to sink';
legend2 = 'C to D';
legend3 = 'B to C';
legend4 = 'A to B';
% legend position
legend_pos_1 = 4;
legend_pos_2 = 1;
legend_pos_3 = 4;
legend_pos_4 = 4;
division = 28800; % micaz clock ticks
figure_point = '.';
%========================================================================================%
%数据处理部分
%注意：指定的处理文件需放在与该文件相同的目录下

filename_final = 'processed_data1.txt';                     %最终输出并分析的txt
%========================================================================================%
process_data('cd_2.txt', filename_final, 2, 1);              %对数据进行简单的去偷去尾的处理
%数据读取以及分析部分
 [s1 time s2 clock_drift] = textread(filename_final, '%s %d %s %d');
time2=time;%-time(1);
time3 = time2/128;
clock_drift = clock_drift/division;
% subplot(4,1,1);
subplot('Position', [left,bottom_for_last+3*height+3*interval,width,height]);
plot(time3/3600,clock_drift*1000,figure_point);
AX=legend(legend1,legend_pos_1);
LEG = findobj(AX,'type','text');
set(LEG,'FontSize',16);
set(gca,'FontSize',14);
set(gca,'XTickLabel',' ');
axis([x_from x_end y_from y_end]);
grid on;
%========================================================================================%
process_data('cd_3.txt', filename_final, 2, 1);              %对数据进行简单的去偷去尾的处理
%数据读取以及分析部分
 [s1 time s2 clock_drift] = textread(filename_final, '%s %d %s %d');
time2=time;%-time(1);
time3 = time2/128;
clock_drift = clock_drift/division;
% subplot(4,1,2);
subplot('Position', [left,bottom_for_last+2*height+2*interval,width,height]);
plot(time3/3600,clock_drift*1000,figure_point);
AX=legend(legend2,legend_pos_2);
LEG = findobj(AX,'type','text');
set(LEG,'FontSize',16);
set(gca,'FontSize',14);
set(gca,'XTickLabel',' ');
axis([x_from x_end y_from y_end]);
grid on;
%========================================================================================%
process_data('cd_4.txt', filename_final, 2, 1);              %对数据进行简单的去偷去尾的处理
%数据读取以及分析部分
 [s1 time s2 clock_drift] = textread(filename_final, '%s %d %s %d');
time2=time;%-time(1);
time3 = time2/128;
clock_drift = clock_drift/division;
% subplot(4,1,3);
subplot('Position', [left,bottom_for_last+height+interval,width,height]);
plot(time3/3600,clock_drift*1000,figure_point);
AX=legend(legend3,legend_pos_3);
LEG = findobj(AX,'type','text');
set(LEG,'FontSize',16);
set(gca,'FontSize',14);
set(gca,'XTickLabel',' ');
axis([x_from x_end y_from y_end]);
ylabel('           Schedule Error (ms)','fontsize',16);
grid on;
%========================================================================================%
process_data('cd_5.txt', filename_final, 2, 1);              %对数据进行简单的去偷去尾的处理
%数据读取以及分析部分
 [s1 time s2 clock_drift] = textread(filename_final, '%s %d %s %d');
time2=time;%-time(1);
time3 = time2/128;
clock_drift = clock_drift/division;
% subplot(4,1,4);
subplot('Position', [left,bottom_for_last,width,height]);
plot(time3/3600,clock_drift*1000,figure_point);
AX=legend(legend4,legend_pos_4);
LEG = findobj(AX,'type','text');
set(LEG,'FontSize',16);
set(gca,'FontSize',14);
box on;
axis([x_from x_end y_from y_end]);
xlabel('Time (Hour)','fontsize',16); 
% ylabel('Clock Drift (Second)','fontsize',16);
grid on;

%plot(ff1);


