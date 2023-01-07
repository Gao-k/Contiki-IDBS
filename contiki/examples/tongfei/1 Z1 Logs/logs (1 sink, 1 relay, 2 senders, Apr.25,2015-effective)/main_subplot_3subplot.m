%\description: 3 subplots
%\date: Apr.24,2015
%\update: Apr.24,2015

close all 
clear all

% subfigure's position
left = 0.12;
interval = 0.025;
bottom_for_last = 0.11;
sub_plots=3;
height = (1-bottom_for_last-interval*(sub_plots-1))/sub_plots-0.01;
width=0.85;
% x/y-axis range
%x: hour; y: clock drift
x_from=0;
x_end = 24;
y_from=-0.013;
y_end=0.013;
% legend position
legend_pos_1 = 2;
legend_pos_2 = 2;
legend_pos_3 = 3;
legend_pos_4 = 3;
%data source file name
src_file_1 = 'ClockDrift2to1.txt'; legend1 = '1 vs. sink';
src_file_2 = 'ClockDrift5to2.txt'; legend2 = '5 vs. 2';
src_file_3 = 'ClockDrift6to2.txt'; legend3 = '2 vs. 1';
src_file_4 = 'ClockDrift7to2.txt'; legend4 = '3 vs. 1';

%========================================================================================%
%数据处理部分
%注意：指定的处理文件需放在与该文件相同的目录下

filename_final = 'processed_data.txt';                     %最终输出并分析的txt
%========================================================================================%
% process_data(src_file_1, filename_final, 2, 1);              %对数据进行简单的去偷去尾的处理
% %数据读取以及分析部分
%  [ss0 ss1 s1 time s2 clock_drift] = textread(filename_final, '%s %s %s %d %s %d');
% time2=time;%-time(1);
% time3 = time2/128;
% clock_drift = clock_drift/32768;
% % subplot(4,1,1);
% subplot('Position', [left,bottom_for_last+3*height+3*interval,width,height]);
% plot(time3/3600,clock_drift,'*');
% legend(src_file_1,legend_pos_1);
% set(gca,'XTickLabel',' ');
% axis([x_from x_end y_from y_end]);
% grid on;
%========================================================================================%
process_data(src_file_1, 'processed_data1.txt', 2, 1);              %对数据进行简单的去偷去尾的处理
%数据读取以及分析部分
 [ss0 ss1 s1 time s2 clock_drift] = textread('processed_data1.txt', '%s %s %s %d %s %d');
time2=time;%-time(1);
temp=0;
for i=1:length(time2),
    time2(i)=time2(i)+temp;
    if time2(i)==4356036,
        temp = time2(i);
    elseif time2(i) == 4356036+2358963,
        temp = time2(i);
    elseif time2(i) == 4356036+2358963 + 3195681,
        temp = time2(i);
    end
end
time3 = time2/128;
clock_drift = clock_drift/32768;
% subplot(4,1,2);
subplot('Position', [left,bottom_for_last+2*height+2*interval,width,height]);
plot(time3/3600,clock_drift,'*');
legend(legend1,legend_pos_2);
set(gca,'XTickLabel',' ');
axis([x_from x_end y_from y_end]);
grid on;
%========================================================================================%
process_data(src_file_3, filename_final, 2, 1);              %对数据进行简单的去偷去尾的处理
%数据读取以及分析部分
 [ss0 ss1 s1 time s2 clock_drift] = textread(filename_final, '%s %s %s %d %s %d');
time2=time;%-time(1);
time3 = time2/128;
clock_drift = clock_drift/32768;
% subplot(4,1,3);
subplot('Position', [left,bottom_for_last+height+interval,width,height]);
plot(time3/3600,clock_drift,'*');
legend(legend3,legend_pos_3);
set(gca,'XTickLabel',' ');
axis([x_from x_end y_from y_end]);
ylabel('Clock Drift (Second)','fontsize',16);
grid on;
%========================================================================================%
process_data(src_file_4, filename_final, 2, 1);              %对数据进行简单的去偷去尾的处理
%数据读取以及分析部分
 [ss0 ss1 s1 time s2 clock_drift] = textread(filename_final, '%s %s %s %d %s %d');
time2=time;%-time(1);
time3 = time2/128;
clock_drift = clock_drift/32768;
% subplot(4,1,4);
subplot('Position', [left,bottom_for_last,width,height]);
plot(time3/3600,clock_drift,'*');
legend(legend4,legend_pos_4);
axis([x_from x_end y_from y_end]);
%LEG = findobj(AX,'type','text');
%set(LEG,'FontSize',16);

box on;
axis([x_from x_end y_from y_end]);
xlabel('Time (Hour)','fontsize',16); 
% ylabel('Clock Drift (Second)','fontsize',16);
grid on;

%plot(ff1);


