close all 
clear all
filename_in = 'power.txt';
format
[cooja_time, ID1, time, file_type, grade, ID2, control_time, data_time, idle_time, all_time] = textread(filename_in, '%s %s %d %s %d %s %d %d %d %d');
Y=[idle_time*100./all_time data_time*100./all_time control_time*100./all_time]
H=bar(Y,'stacked');

P=findobj(gca,'type','patch');
%设置直方图的颜色
C=['r','g','b'];
for n=1:length(P) 
    set(P(n),'facecolor',C(n));
end

AX = legend(H,{'idle','data','control'},4);
ylabel('Duty Cycle (%)','fontsize',16);
LEG = findobj(AX,'type','text');
set(LEG,'FontSize',16);

%设置legend的颜色
LEG = findobj(AX,'type','patch');
for n=1:length(LEG) 
    set(LEG(n),'facecolor',C(n));
end