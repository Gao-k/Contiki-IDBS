clear all
clc 
xmlDoc = xmlread('ADC-PDC-30-z1-sky-exp.csc');
x_Array = xmlDoc.getElementsByTagName('x');
y_Array = xmlDoc.getElementsByTagName('y');
x_Array_len = x_Array.getLength;
coordinates = zeros(x_Array_len,2);
for ii = 0 : x_Array_len-1    % �������У� IDArray.getLength ���� 2  
    coordinates(ii+1,1) = str2double(x_Array.item(ii).getFirstChild.getData);    % ��ȡ��ǰ�ڵ������  
    coordinates(ii+1,2) = str2double(y_Array.item(ii).getFirstChild.getData); 
end  
figure(1);
z1=plot(coordinates(2:11,1),coordinates(2:11,2),'b^','MarkerSize',10); % z1
hold on;
sky=plot(coordinates(12:21,1),coordinates(12:21,2),'ks','MarkerSize',10); %sky
exp=plot(coordinates(22:31,1),coordinates(22:31,2),'g.','MarkerSize',30); % exp

sink = plot(coordinates(1,1),coordinates(1,2),'r^','MarkerSize',12,'MarkerFaceColor','r');
axis([0 100 0 100]);
AX = legend([z1 sky exp sink], 'Z1','Tmote Sky',' EXP5438','sink (Z1)',-1);%����legendλ�á�
LEG = findobj(AX,'type','text');

set(gca,'ydir','reverse','xaxislocation','top'); %����ԭ�����õ����Ͻ�
set(gca,'FontSize',16);%�������������С
axis square