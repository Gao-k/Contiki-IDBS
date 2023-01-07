xmlDoc = xmlread('ADC-PDC-30.csc');
x_Array = xmlDoc.getElementsByTagName('x');
y_Array = xmlDoc.getElementsByTagName('y');
x_Array_len = x_Array.getLength;
coordinates = zeros(x_Array_len,2);
for ii = 0 : x_Array_len-1    % 此例子中， IDArray.getLength 等于 2  
    coordinates(ii+1,1) = str2double(x_Array.item(ii).getFirstChild.getData);    % 提取当前节点的内容  
    coordinates(ii+1,2) = str2double(y_Array.item(ii).getFirstChild.getData); 
end  
figure(1);
plot(coordinates(2:end,1),coordinates(2:end,2),'K.','MarkerSize',25);
hold on;

plot(coordinates(1,1),coordinates(1,2),'r^','MarkerSize',12,'MarkerFaceColor','r');
axis([0 100 0 100]);

set(gca,'ydir','reverse','xaxislocation','top'); %坐标原点设置到左上角
set(gca,'FontSize',14);%设置坐标字体大小
axis square