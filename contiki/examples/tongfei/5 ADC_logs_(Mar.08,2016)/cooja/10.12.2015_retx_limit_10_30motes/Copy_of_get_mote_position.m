xmlDoc = xmlread('ADC-PDC-30.csc');
x_Array = xmlDoc.getElementsByTagName('x');
y_Array = xmlDoc.getElementsByTagName('y');
x_Array_len = x_Array.getLength;
coordinates = zeros(x_Array_len,2);
for ii = 0 : x_Array_len-1    % �������У� IDArray.getLength ���� 2  
    coordinates(ii+1,1) = str2double(x_Array.item(ii).getFirstChild.getData);    % ��ȡ��ǰ�ڵ������  
    coordinates(ii+1,2) = str2double(y_Array.item(ii).getFirstChild.getData); 
end  
figure(1);
plot(coordinates(2:end,1),coordinates(2:end,2),'K.','MarkerSize',25);
hold on;

plot(coordinates(1,1),coordinates(1,2),'r^','MarkerSize',12,'MarkerFaceColor','r');
axis([0 100 0 100]);

set(gca,'ydir','reverse','xaxislocation','top'); %����ԭ�����õ����Ͻ�
set(gca,'FontSize',14);%�������������С
axis square