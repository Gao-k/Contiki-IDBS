close all 
clear all
file_num = [1 2 3 4 5]*10;
pgi = [1 2 3 4 5]*10;
adc_18_fa_dc_array = zeros(5,1);
adc_18_nfa_dc_array=zeros(5,1);
pdc_18_nfa_dc_array=zeros(5,1);

adc_10_fa_dc_array = zeros(5,1);
adc_10_nfa_dc_array=zeros(5,1);
pdc_10_nfa_dc_array=zeros(5,1);
data_folder = 'P_data';
data_format='%s %d %s %d %d %d %d'; % original format: '%s %s %d %s %s %s %d %d %d %d'
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
jj = 1;
for ii = file_num
    %% adc sf =18, with free addressing
    file_name = [data_folder,'/adc_18_fa_',int2str(ii),'s.txt'];
    [~,ID,~,control,data,idle,total]=textread(file_name,data_format);
    id_index=((ID==1)|(ID==2)|(ID==5)|(ID==22)|(ID==18)|(ID==44)|(ID==15)|(ID==23)|(ID==25)|(ID==17)|(ID==14));
    adc_18_fa_dc_array(jj) = sum((control(id_index)+data(id_index)+idle(id_index))./total(id_index))/length(total(id_index));
    
    %% adc sf =18, without free addressing
    file_name = [data_folder,'/adc_18_nfa_',int2str(ii),'s.txt'];
    [~,ID,~,control,data,idle,total]=textread(file_name,data_format);
    id_index=((ID==1)|(ID==2)|(ID==5)|(ID==22)|(ID==18)|(ID==44)|(ID==15)|(ID==23)|(ID==25)|(ID==17)|(ID==14));
    adc_18_nfa_dc_array(jj) = sum((control(id_index)+data(id_index)+idle(id_index))./total(id_index))/length(total(id_index));
    
    %% pdc sf =18, without free addressing
    file_name = [data_folder,'/pdc_18_nfa_',int2str(ii),'s.txt'];
    [~,ID,~,control,data,idle,total]=textread(file_name,data_format);
    id_index=((ID==1)|(ID==2)|(ID==5)|(ID==22)|(ID==18)|(ID==44)|(ID==15)|(ID==23)|(ID==25)|(ID==17)|(ID==14));
    pdc_18_nfa_dc_array(jj) = sum((control(id_index)+data(id_index)+idle(id_index))./total(id_index))/length(total(id_index));
    
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
     %% adc sf =10, with free addressing
    file_name = [data_folder,'/adc_10_fa_',int2str(ii),'s.txt'];
    [~,ID,~,control,data,idle,total]=textread(file_name,data_format);
    id_index=((ID==1)|(ID==2)|(ID==5)|(ID==22)|(ID==18)|(ID==44)|(ID==15)|(ID==23)|(ID==25)|(ID==17)|(ID==14));
    adc_10_fa_dc_array(jj) = sum((control(id_index)+data(id_index)+idle(id_index))./total(id_index))/length(total(id_index));
    
    %% adc sf =10, without free addressing
    file_name = [data_folder,'/adc_10_nfa_',int2str(ii),'s.txt'];
    [~,ID,~,control,data,idle,total]=textread(file_name,data_format);
    id_index=((ID==1)|(ID==2)|(ID==5)|(ID==22)|(ID==18)|(ID==44)|(ID==15)|(ID==23)|(ID==25)|(ID==17)|(ID==14));
    adc_10_nfa_dc_array(jj) = sum((control(id_index)+data(id_index)+idle(id_index))./total(id_index))/length(total(id_index));
    
    %% pdc sf =10, without free addressing
    file_name = [data_folder,'/pdc_10_nfa_',int2str(ii),'s.txt'];
    [~,ID,~,control,data,idle,total]=textread(file_name,data_format);
    id_index=((ID==1)|(ID==2)|(ID==5)|(ID==22)|(ID==18)|(ID==44)|(ID==15)|(ID==23)|(ID==25)|(ID==17)|(ID==14));
    pdc_10_nfa_dc_array(jj) = sum((control(id_index)+data(id_index)+idle(id_index))./total(id_index))/length(total(id_index));
    jj=jj+1;
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
linewidth_value = 2.5;
l_adc_18_fa = 'b-s'; l_adc_18_nfa = 'b-^'; l_pdc_18_nfa = 'r->';
l_adc_10_fa = 'b--s'; l_adc_10_nfa = 'b--^'; l_pdc_10_nfa = 'r-->';

adc_18_fa_dc = plot(pgi,adc_18_fa_dc_array*100,l_adc_18_fa,'LineWidth',linewidth_value);
hold on;
adc_18_nfa_dc = plot(pgi,adc_18_nfa_dc_array*100,l_adc_18_nfa,'LineWidth',linewidth_value);
pdc_18_nfa_dc = plot(pgi,pdc_18_nfa_dc_array*100,l_pdc_18_nfa,'LineWidth',linewidth_value);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
adc_10_fa_dc = plot(pgi,adc_10_fa_dc_array*100,l_adc_10_fa,'LineWidth',linewidth_value);
adc_10_nfa_dc = plot(pgi,adc_10_nfa_dc_array*100,l_adc_10_nfa,'LineWidth',linewidth_value);
pdc_10_nfa_dc = plot(pgi,pdc_10_nfa_dc_array*100,l_pdc_10_nfa,'LineWidth',linewidth_value);
% 
axis([10 50 1 7]);
box on;
xlabel('Packet Generation Interval (s)','fontsize',16); %设置x轴的标题和字体大小
ylabel('Duty Cycle (%)','fontsize',16);
AX = legend([adc_10_fa_dc adc_10_nfa_dc adc_18_fa_dc adc_18_nfa_dc pdc_10_nfa_dc pdc_18_nfa_dc],...
    'ADC-FA (SSL=10)','ADC-No FA (SSL=10)','ADC-FA (SSL=18)','ADC-No FA (SSL=18)','PDC (SSL=10)','PDC (SSL=18)',1);
LEG = findobj(AX,'type','text');

set(LEG,'FontSize',11);%设置legend字体大小
set(gca,'FontSize',16);%设置坐标字体大小
grid on;