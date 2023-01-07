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
% legend position
legend_pos_1 = 4;
legend_pos_2 = 4;
legend_pos_3 = 4;
legend_pos_4 = 4;
% legend label
legend1 = 'D to sink';
legend2 = 'C to D';
legend3 = 'B to D';
legend4 = 'A to D';
z1_division = 32768;
figure_point = '.';
%========================================================================================%
%���ݴ�����
%ע�⣺ָ���Ĵ����ļ����������ļ���ͬ��Ŀ¼��

filename_final = 'processed_data1.txt';                     %���������������txt
%========================================================================================%
process_data('cd_2.txt', filename_final, 0, 0);              %�����ݽ��м򵥵�ȥ͵ȥβ�Ĵ���
%���ݶ�ȡ�Լ���������
 [s1 time s2 clock_drift] = textread(filename_final, '%s %d %s %d');
time2=time;%-time(1);
time3 = time2/128;
clock_drift = clock_drift*1000/z1_division;
% subplot(4,1,1);
subplot('Position', [left,bottom_for_last+3*height+3*interval,width,height]);
plot(time3/3600,clock_drift,figure_point);
AX=legend(legend1,legend_pos_1);
LEG = findobj(AX,'type','text');
set(LEG,'FontSize',16);
set(gca,'FontSize',14);
set(gca,'XTickLabel',' ');
axis([x_from x_end y_from y_end]);
grid on;
%========================================================================================%
process_data('cd_5.txt', filename_final, 0, 0);              %�����ݽ��м򵥵�ȥ͵ȥβ�Ĵ���
%���ݶ�ȡ�Լ���������
 [s1 time s2 clock_drift] = textread(filename_final, '%s %d %s %d');
time2=time;%-time(1);
time3 = time2/128;
clock_drift = clock_drift*1000/z1_division;
% subplot(4,1,2);
subplot('Position', [left,bottom_for_last+2*height+2*interval,width,height]);
plot(time3/3600,clock_drift,figure_point);
AX=legend(legend2,legend_pos_2);
LEG = findobj(AX,'type','text');
set(LEG,'FontSize',16);
set(gca,'FontSize',14);
set(gca,'XTickLabel',' ');
axis([x_from x_end y_from y_end]);
grid on;
%========================================================================================%
process_data('cd_6.txt', filename_final, 0, 0);               %�����ݽ��м򵥵�ȥ͵ȥβ�Ĵ���
%���ݶ�ȡ�Լ���������
 [s1 time s2 clock_drift] = textread(filename_final, '%s %d %s %d');
time2=time;%-time(1);
time3 = time2/128;
clock_drift = clock_drift*1000/z1_division;
% subplot(4,1,3);
subplot('Position', [left,bottom_for_last+height+interval,width,height]);
plot(time3/3600,clock_drift,figure_point);
AX=legend(legend3,legend_pos_3);
LEG = findobj(AX,'type','text');
set(LEG,'FontSize',16);
set(gca,'FontSize',14);
axis([x_from x_end y_from y_end]);
set(gca,'XTickLabel',' ');
ylabel('             Schedule Error (ms)','fontsize',16);
grid on;
%========================================================================================%
process_data('cd_7.txt', filename_final, 0, 0);               %�����ݽ��м򵥵�ȥ͵ȥβ�Ĵ���
%���ݶ�ȡ�Լ���������
 [s1 time s2 clock_drift] = textread(filename_final, '%s %d %s %d');
time2=time;%-time(1);
time3 = time2/128;
clock_drift = clock_drift*1000/z1_division;
% subplot(4,1,4);
subplot('Position', [left,bottom_for_last,width,height]);
plot(time3/3600,clock_drift,figure_point);
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


