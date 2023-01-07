close all 
clear all
pgi_array = 1:5:21;
pdc_dc_array = zeros(5,1);
cc_dc_array = zeros(5,1);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
jj = 1;
for ii = pgi_array
    pgi = ii;
    file_name = ['pdc_dc_pgi=',int2str(pgi),'s.txt']; % get the file name
    [~,~,~,~,dc,~]=textread(file_name,'%s %s %d %s %f %s');
    pdc_dc_array(jj) = dc(1);
    %%contiki collect
    
    file_name = [ 'cc_dc_pgi=',int2str(pgi),'s.txt']; % get the file name
    [~,~,~,~,dc,~]=textread(file_name,'%s %s %d %s %f %s');
    cc_dc_array(jj) = dc(1);
    
    jj=jj+1;
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
linewidth_value = 2;
figure(3);
pdc_dc = plot(pgi_array,pdc_dc_array,'b-s','LineWidth',linewidth_value);
hold on;
cc_dc = plot(pgi_array,cc_dc_array,'r:>','LineWidth',linewidth_value);

xlabel('Packet Generation Interval (s)','fontsize',16); %设置x轴的标题和字体大小
ylabel('Duty Cycle (%)','fontsize',16);
AX = legend([pdc_dc cc_dc],'PDC','CC',1);
LEG = findobj(AX,'type','text');
axis([0 21 0 30]);
set(LEG,'FontSize',16);%设置legend字体大小
set(gca,'FontSize',16);%设置坐标字体大小
grid on;