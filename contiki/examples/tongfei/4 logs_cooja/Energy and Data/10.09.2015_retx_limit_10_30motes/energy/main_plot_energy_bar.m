close all 
clear all
file_num = [1 2 3 4 5];
pgi_array = [1 2 3 4 5]*10;
pdc_dc_array = zeros(5,1);
cc8hz_dc_array = zeros(5,1);
cc32hz_dc_array = zeros(5,1);
cxmac_dc_array = zeros(5,1);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
jj = 1;
for ii = file_num
    pgi = ii;
    %% pdc
    file_name = ['pdc_dc_pgi=',int2str(pgi),'s.txt']; % get the file name
    [~,~,~,~,dc,~]=textread(file_name,'%s %s %d %s %f %s');
    pdc_dc_array(jj) = dc(1);
    %% contikimac 8hz
    file_name = [ 'cc_dc_pgi=',int2str(pgi),'s.txt']; % get the file name
    [~,~,~,~,dc,~]=textread(file_name,'%s %s %d %s %f %s');
    cc8hz_dc_array(jj) = dc(1);
    %% contikimac 32hz
    file_name = [ 'cc(32hz)_dc_pgi=',int2str(pgi),'s.txt']; % get the file name
    [~,~,~,~,dc,~]=textread(file_name,'%s %s %d %s %f %s');
    cc32hz_dc_array(jj) = dc(1);
    %% contikimac    
    file_name = [ 'cxmac_dc_pgi=',int2str(pgi),'s.txt']; % get the file name
    [~,~,~,~,dc,~]=textread(file_name,'%s %s %d %s %f %s');
    cxmac_dc_array(jj) = dc(1);
    jj=jj+1;
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
figure(3);
linewidth_value = 2;
l_pdc = 'b-s'; l_cc8hz='r-.>';l_cc32hz = 'm--o'; l_cxmac = 'g:d';
pdc_dc = plot(pgi_array,pdc_dc_array,l_pdc,'LineWidth',linewidth_value);
hold on;
cc8hz_dc = plot(pgi_array,cc8hz_dc_array,l_cc8hz,'LineWidth',linewidth_value);
cc32hz_dc = plot(pgi_array,cc32hz_dc_array,l_cc32hz,'LineWidth',linewidth_value);
cxmac_dc = plot(pgi_array,cxmac_dc_array,l_cxmac,'LineWidth',linewidth_value);
% 
% axis([5 50 0 11]);
xlabel('Packet Generation Interval (s)','fontsize',16); %设置x轴的标题和字体大小
ylabel('Duty Cycle (%)','fontsize',16);
AX = legend([pdc_dc cc8hz_dc cc32hz_dc cxmac_dc],'PDC','CTP-ContikiMAC-8Hz','CTP-ContikiMAC-32Hz','CXMAC',1);
LEG = findobj(AX,'type','text');

set(LEG,'FontSize',16);%设置legend字体大小
set(gca,'FontSize',16);%设置坐标字体大小
grid on;