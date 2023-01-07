close all 
clear all

% subfigure's position
left = 0.11;
interval = 0.025;
bottom_for_last = 0.1;
height = (1-bottom_for_last-interval*3)/4-0.01;
width=0.85;
% x/y-axis range
x_from=0;
x_end = 25;
y_from=-0.02;
y_end=0.02;
% legend position
legend_pos_1 = 1;
legend_pos_2 = 1;
legend_pos_3 = 1;
legend_pos_4 = 1;
%========================================================================================%
%数据处理部分
%注意：指定的处理文件需放在与该文件相同的目录下

filename_final = 'processed_data1.txt';                     %最终输出并分析的txt
%========================================================================================%
process_data('ClockDrift_2to1.txt', filename_final, 2, 1);              %对数据进行简单的去偷去尾的处理
%数据读取以及分析部分
 [ss0 ss1 s1 time s2 clock_drift] = textread(filename_final, '%s %s %s %d %s %d');
time2=time;%-time(1);
time3 = time2/128;
clock_drift = clock_drift/32768;
% subplot(4,1,1);
subplot('Position', [left,bottom_for_last+3*height+3*interval,width,height]);
plot(time3/3600,clock_drift,'*');
legend('Node 2 to 1',legend_pos_1);
set(gca,'XTickLabel',' ');
axis([x_from x_end y_from y_end]);
grid on;
%========================================================================================%
process_data('ClockDrift_4to2.txt', filename_final, 2, 1);              %对数据进行简单的去偷去尾的处理
%数据读取以及分析部分
 [ss0 ss1 s1 time s2 clock_drift] = textread(filename_final, '%s %s %s %d %s %d');
time2=time;%-time(1);
time3 = time2/128;
clock_drift = clock_drift/32768;
% subplot(4,1,2);
subplot('Position', [left,bottom_for_last+2*height+2*interval,width,height]);
plot(time3/3600,clock_drift,'*');
legend('Node 4 to 2',legend_pos_2);
set(gca,'XTickLabel',' ');
axis([x_from x_end y_from y_end]);
grid on;
%========================================================================================%
process_data('ClockDrift_5to2.txt', filename_final, 2, 1);              %对数据进行简单的去偷去尾的处理
%数据读取以及分析部分
 [ss0 ss1 s1 time s2 clock_drift] = textread(filename_final, '%s %s %s %d %s %d');
time2=time;%-time(1);
time3 = time2/128;
clock_drift = clock_drift/32768;
% subplot(4,1,3);
subplot('Position', [left,bottom_for_last+height+interval,width,height]);
plot(time3/3600,clock_drift,'*');
legend('Node 5 to 2',legend_pos_3);

box on;
axis([x_from x_end y_from y_end]);
xlabel('Time (Hour)','fontsize',16); 
ylabel('           Clock Drift (Second)','fontsize',16);
grid on;

%plot(ff1);


