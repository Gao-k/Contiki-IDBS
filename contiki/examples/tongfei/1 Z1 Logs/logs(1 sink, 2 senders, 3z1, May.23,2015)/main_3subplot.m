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
x_from=0;
x_end = 12;
y_from=-0.013;
y_end=0.013;
% legend position
legend_pos_1 = 2;
legend_pos_2 = 3;
legend_pos_3 = 2;
legend_pos_4 = 2;
% legend label
legend1 = '3 vs. sink';
legend2 = '4 vs. sink';
legend3 = '5 vs. sink';

%========================================================================================%
%���ݴ�������
%ע�⣺ָ���Ĵ����ļ����������ļ���ͬ��Ŀ¼��

filename_final = 'processed_data1.txt';                     %���������������txt
figure_point = '.';
%========================================================================================%
process_data('cd_2.txt', filename_final, 2, 1);              %�����ݽ��м򵥵�ȥ͵ȥβ�Ĵ���
%���ݶ�ȡ�Լ���������
 [s1 time s2 clock_drift] = textread(filename_final, '%s %d %s %d');
time2=time;%-time(1);
time3 = time2/128;
clock_drift = clock_drift/32768;
% subplot(4,1,1);
subplot('Position', [left,bottom_for_last+2*height+2*interval,width,height]);
plot(time3/3600,clock_drift,figure_point);
legend(legend1,legend_pos_1);
set(gca,'XTickLabel',' ');
axis([x_from x_end y_from y_end]);
grid on;
%========================================================================================%
process_data('cd_3.txt', filename_final, 2, 1);              %�����ݽ��м򵥵�ȥ͵ȥβ�Ĵ���
%���ݶ�ȡ�Լ���������
 [s1 time s2 clock_drift] = textread(filename_final, '%s %d %s %d');
time2=time;%-time(1);
time3 = time2/128;
clock_drift = clock_drift/32768;
% subplot(4,1,2);
subplot('Position', [left,bottom_for_last+height+interval,width,height]);
plot(time3/3600,clock_drift,figure_point);
legend(legend2,legend_pos_2);
set(gca,'XTickLabel',' ');
axis([x_from x_end y_from y_end]);
ylabel('Clock Drift (Second)','fontsize',16);
grid on;
%========================================================================================%
process_data('cd_5.txt', filename_final, 2, 1);              %�����ݽ��м򵥵�ȥ͵ȥβ�Ĵ���
%���ݶ�ȡ�Լ���������
 [s1 time s2 clock_drift] = textread(filename_final, '%s %d %s %d');
time2=time;%-time(1);
time3 = time2/128;
clock_drift = clock_drift/32768;
% subplot(4,1,3);
subplot('Position', [left,bottom_for_last,width,height]);
plot(time3/3600,clock_drift,figure_point);
legend(legend3,legend_pos_3);
axis([x_from x_end y_from y_end]);
xlabel('Time (Hour)','fontsize',16); 
grid on;
%========================================================================================%
% process_data('ClockDrift_5.txt', filename_final, 2, 1);              %�����ݽ��м򵥵�ȥ͵ȥβ�Ĵ���
% %���ݶ�ȡ�Լ���������
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

