close all 
clear all

tf_process_data( 'data.txt' );

% subfigure's position
left = 0.12;
interval = 0.025;
bottom_for_last = 0.11;
sub_plots=3;
height = (1-bottom_for_last-interval*(sub_plots-1))/sub_plots-0.01;
width=0.85;
% x/y-axis range
x_from=0;
x_end = 15;
y_from=-400;
y_end=-y_from;
% legend position
legend_pos_1 = 4;
legend_pos_2 = 4;
legend_pos_3 = 4;
legend_pos_4 = 2;
% legend label
legend1 = '2 to sink';
legend2 = '3 to 2';
legend3 = '4 to 3';
legend4 = '5 to 4';
src_file1 = 'cd_2.txt';
src_file2 = 'cd_3.txt';
src_file3 = 'cd_4.txt';
src_file4 = 'cd_5.txt';
divison=1;
%========================================================================================%
%数据处理部分
%注意：指定的处理文件需放在与该文件相同的目录下

filename_final = 'processed_data1.txt';                     %最终输出并分析的txt
%========================================================================================%
process_data(src_file1, filename_final, 2, 1);              %对数据进行简单的去偷去尾的处理
%数据读取以及分析部分
 [ss0 ss1 s1 time s2 clock_drift] = textread(filename_final, '%s %s %s %d %s %d');
time2=time;%-time(1);
time3 = time2/128;
clock_drift = clock_drift/divison;
% subplot(4,1,1);
subplot('Position', [left,bottom_for_last+2*height+2*interval,width,height]);
plot(time3/3600,clock_drift,'*');
legend(legend1,legend_pos_1);
set(gca,'XTickLabel',' ');
axis([x_from x_end y_from y_end]);
grid on;
%========================================================================================%
process_data(src_file2, filename_final, 2, 1);              %对数据进行简单的去偷去尾的处理
%数据读取以及分析部分
 [ss0 ss1 s1 time s2 clock_drift] = textread(filename_final, '%s %s %s %d %s %d');
time2=time;%-time(1);
time3 = time2/128;
clock_drift = clock_drift/divison;
% subplot(4,1,2);
subplot('Position', [left,bottom_for_last+height+interval,width,height]);
plot(time3/3600,clock_drift,'*');
legend(legend2,legend_pos_2);
set(gca,'XTickLabel',' ');
axis([x_from x_end y_from y_end]);
ylabel('Clock Drift (Second)','fontsize',16);
grid on;
%========================================================================================%
process_data(src_file3, filename_final, 2, 1);              %对数据进行简单的去偷去尾的处理
%数据读取以及分析部分
 [ss0 ss1 s1 time s2 clock_drift] = textread(filename_final, '%s %s %s %d %s %d');
time2=time;%-time(1);
time3 = time2/128;
clock_drift = clock_drift/divison;
% subplot(4,1,3);
subplot('Position', [left,bottom_for_last,width,height]);
plot(time3/3600,clock_drift,'*');
legend(legend3,legend_pos_3);
axis([x_from x_end y_from y_end]);
xlabel('Time (Hour)','fontsize',16); 
grid on;
%========================================================================================%
% process_data(src_file4, filename_final, 2, 1);              %对数据进行简单的去偷去尾的处理
% %数据读取以及分析部分
%  [ss0 ss1 s1 time s2 clock_drift] = textread(filename_final, '%s %s %s %d %s %d');
% time2=time;%-time(1);
% time3 = time2/128;
% clock_drift = clock_drift/32768;
% % subplot(4,1,4);
% subplot('Position', [left,bottom_for_last,width,height]);
% plot(time3/3600,clock_drift,'*');
% legend('Node 4',legend_pos_4);
% box on;
% axis([x_from x_end y_from y_end]);
% xlabel('Time (Hour)','fontsize',16); 
% % ylabel('Clock Drift (Second)','fontsize',16);
% grid on;

%plot(ff1);


