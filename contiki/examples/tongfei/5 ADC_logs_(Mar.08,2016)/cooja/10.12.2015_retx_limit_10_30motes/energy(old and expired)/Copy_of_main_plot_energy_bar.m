close all 
clear all
file_num = [1 2 3 4 5];
pgi_array = [1 2 3 4 5]*10;
pdc_sf4_dc_array = zeros(5,1);
pdc_sf7_dc_array = zeros(5,1);
pdc_sf10_dc_array = zeros(5,1);
cc32hzAutoAck_dc_array = zeros(5,1);
cc16hz_dc_array = zeros(5,1);
cc32hz_dc_array = zeros(5,1);
cc64hz_dc_array = zeros(5,1);
cxmac_dc_array = zeros(5,1);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
jj = 1;
for ii = file_num
    pgi = ii;
    %% pdc = 4
    file_name = ['pdc_sf=4_dc_pgi=',int2str(pgi),'s.txt']; % get the file name
    [~,~,~,~,dc,~]=textread(file_name,'%s %s %d %s %f %s');
    pdc_sf4_dc_array(jj) = dc(1);
    %% pdc sf = 7
    file_name = ['pdc_sf=7_dc_pgi=',int2str(pgi),'s.txt']; % get the file name
    [~,~,~,~,dc,~]=textread(file_name,'%s %s %d %s %f %s');
    pdc_sf7_dc_array(jj) = dc(1);
    %% pdc sf = 10
    file_name = ['pdc_sf=10_dc_pgi=',int2str(pgi),'s.txt']; % get the file name
    [~,~,~,~,dc,~]=textread(file_name,'%s %s %d %s %f %s');
    pdc_sf10_dc_array(jj) = dc(1);
%     %% contikimac 32hz AutoAck
%     file_name = [ 'cc(32hzAutoAck)_dc_pgi=',int2str(pgi),'s.txt']; % get the file name
%     [~,~,~,~,dc,~]=textread(file_name,'%s %s %d %s %f %s');
%     cc32hzAutoAck_dc_array(jj) = dc(1);
    %% contikimac 16hz
    file_name = [ 'cc(16hz)_dc_pgi=',int2str(pgi),'s.txt']; % get the file name
    [~,~,~,~,dc,~]=textread(file_name,'%s %s %d %s %f %s');
    cc16hz_dc_array(jj) = dc(1);
    %% contikimac 32hz
    file_name = [ 'cc(32hz)_dc_pgi=',int2str(pgi),'s.txt']; % get the file name
    [~,~,~,~,dc,~]=textread(file_name,'%s %s %d %s %f %s');
    cc32hz_dc_array(jj) = dc(1);
    %% contikimac 32hz
    file_name = [ 'cc(64hz)_dc_pgi=',int2str(pgi),'s.txt']; % get the file name
    [~,~,~,~,dc,~]=textread(file_name,'%s %s %d %s %f %s');
    cc64hz_dc_array(jj) = dc(1);
    %% contikimac    
    file_name = [ 'cxmac_dc_pgi=',int2str(pgi),'s.txt']; % get the file name
    [~,~,~,~,dc,~]=textread(file_name,'%s %s %d %s %f %s');
    cxmac_dc_array(jj) = dc(1);
    jj=jj+1;
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
linewidth_value = 2.5;
l_pdc_sf4 = 'b-s'; l_pdc_sf7 = 'b-^';l_pdc_sf10='b-x'; l_cc16hz = 'r--s'; l_cc32hz = 'r--^'; l_cc64hz = 'r--x'; 
l_cc32hzNoRDC = 'm-.o'; l_cxmac = 'g:d'; %l_cc8hz='r-.>';
pdc_sf4_dc = semilogy(pgi_array,pdc_sf4_dc_array,l_pdc_sf4,'LineWidth',linewidth_value);
hold on;
pdc_sf7_dc = semilogy(pgi_array,pdc_sf7_dc_array,l_pdc_sf7,'LineWidth',linewidth_value);
pdc_sf10_dc = semilogy(pgi_array,pdc_sf10_dc_array,l_pdc_sf10,'LineWidth',linewidth_value,'MarkerSize',12);
% cc32hzAutoAck_dc = plot(pgi_array,cc32hzAutoAck_dc_array,l_cc32hzAutoAck,'LineWidth',linewidth_value,'MarkerSize',11);
cc_noRDC_dc = semilogy(pgi_array,[100 100 100 100 100],l_cc32hzNoRDC,'LineWidth',linewidth_value,'MarkerSize',7);
cc16hz_dc = semilogy(pgi_array,cc16hz_dc_array,l_cc16hz,'LineWidth',linewidth_value);
cc32hz_dc = semilogy(pgi_array,cc32hz_dc_array,l_cc32hz,'LineWidth',linewidth_value);
cc64hz_dc = semilogy(pgi_array,cc64hz_dc_array,l_cc64hz,'LineWidth',linewidth_value,'MarkerSize',12);
cxmac_dc = semilogy(pgi_array,cxmac_dc_array,l_cxmac,'LineWidth',linewidth_value);
% 
axis([10 50 4 100]);
box on;
xlabel('Packet Generation Interval (s)','fontsize',16); %设置x轴的标题和字体大小
ylabel('Duty Cycle (%)','fontsize',16);
AX = legend([pdc_sf4_dc pdc_sf7_dc pdc_sf10_dc cc16hz_dc cc32hz_dc cc64hz_dc cxmac_dc cc_noRDC_dc],...
    'PDC (SF=4)','PDC (SF=7)','PDC (SF=10)','CTP-CMAC-16Hz','CTP-CMAC-32Hz','CTP-CMAC-64Hz','CTP-XMAC','CTP-Full Active',1);
LEG = findobj(AX,'type','text');

set(LEG,'FontSize',14);%设置legend字体大小
set(gca,'FontSize',16);%设置坐标字体大小
grid on;