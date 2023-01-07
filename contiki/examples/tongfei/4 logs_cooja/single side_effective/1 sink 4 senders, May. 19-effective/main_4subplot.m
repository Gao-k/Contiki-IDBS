close all 
clear all

tf_process_data( 'tempdata.txt' );

% subfigure's position
left = 0.11;
interval = 0.025;
bottom_for_last = 0.1;
height = (1-bottom_for_last-interval*3)/4-0.01;
width=0.85;
% x/y-axis range
x_from=0;
x_end = 10;
y_from=-0.025; % guard time:20ms
y_end=-y_from;

% legend position
legend_pos_1 = 4;
legend_pos_2 = 4;
legend_pos_3 = 4;
legend_pos_4 = 2;
% legend label
legend1 = '2 to sink';
legend2 = '5 to sink';
legend3 = '6 to sink';
legend4 = '7 to sink';
src_file1 = 'cd_2.txt';
src_file2 = 'cd_5.txt';
src_file3 = 'cd_6.txt';
src_file4 = 'cd_7.txt';
divison=32768;
%========================================================================================%
filename_final = 'processed_data1.txt';                     %最终输出并分析的txt
%========================================================================================%
process_data(src_file1, filename_final, 2, 1);              %对数据进行简单的去偷去尾的处理
%数据读取以及分析部分
 [~, ~ , ~, time , ~, clock_drift] = textread(filename_final, '%s %s %s %d %s %d');
time2=time;%-time(1);
time3 = time2/128;
clock_drift = clock_drift/divison;
% subplot(4,1,1);
subplot('Position', [left,bottom_for_last+3*height+3*interval,width,height]);
plot(time3/3600,clock_drift,'*');
legend(legend1,4);
set(gca,'XTickLabel',' ');
axis([x_from x_end y_from y_end]);
grid on;
%========================================================================================%
process_data(src_file2, filename_final, 2, 1);              %对数据进行简单的去偷去尾的处理
%数据读取以及分析部分
 [~, ~ , ~, time , ~, clock_drift] = textread(filename_final, '%s %s %s %d %s %d');
time2=time;%-time(1);
time3 = time2/128;
clock_drift = clock_drift/divison;
% subplot(4,1,2);
subplot('Position', [left,bottom_for_last+2*height+2*interval,width,height]);
plot(time3/3600,clock_drift,'*');
legend(legend2,4);
set(gca,'XTickLabel',' ');
axis([x_from x_end y_from y_end]);
grid on;
%========================================================================================%
process_data(src_file3, filename_final, 2, 1);              %对数据进行简单的去偷去尾的处理
%数据读取以及分析部分
 [~, ~, ~, time , ~, clock_drift] = textread(filename_final, '%s %s %s %d %s %d');
time2=time;%-time(1);
time3 = time2/128;
clock_drift = clock_drift/divison;
% subplot(4,1,3);
subplot('Position', [left,bottom_for_last+height+interval,width,height]);
plot(time3/3600,clock_drift,'*');
legend(legend3,1);
set(gca,'XTickLabel',' ');
axis([x_from x_end y_from y_end]);
ylabel('           Clock Drift (Second)','fontsize',16);
grid on;
%========================================================================================%
process_data(src_file4, filename_final, 2, 1);              %对数据进行简单的去偷去尾的处理
%数据读取以及分析部分
 [ss0, ss1, s1, time, s2, clock_drift] = textread(filename_final, '%s %s %s %d %s %d');
time2=time;%-time(1);
time3 = time2/128;
clock_drift = clock_drift/divison;
% subplot(4,1,4);
subplot('Position', [left,bottom_for_last,width,height]);
plot(time3/3600,clock_drift,'*');
legend(legend4,1);
box on;
axis([x_from x_end y_from y_end]);
xlabel('Time (Hour)','fontsize',16); 
% ylabel('Clock Drift (Second)','fontsize',16);
grid on;

%plot(ff1);


