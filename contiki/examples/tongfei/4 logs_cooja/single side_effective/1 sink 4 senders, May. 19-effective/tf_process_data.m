% This is to deal with the output data from contiki cooja
% Author: F. Tong
% Date: May 13, 2015

function [ ] = tf_process_data( file_in )
%UNTITLED �˴���ʾ�йش˺�����ժҪ
%   �˴���ʾ��ϸ˵��
%%
%file_in = 'data.txt';
output2 = 'cd_2.txt';
output5 = 'cd_5.txt';
output6 = 'cd_6.txt';
output7 = 'cd_7.txt';
fidout2=fopen(output2,'w+');
fidout5=fopen(output5,'w+');
fidout6=fopen(output6,'w+');
fidout7=fopen(output7,'w+');
fidin=fopen(file_in,'r+');
while ~feof(fidin)              %�ж��Ƿ�Ϊ�ļ�ĩβ
  
    tline=fgetl(fidin);        %���ļ�����
    if ~isempty(tline)
        [b1,b2,b3,b4,b5]=strread(tline,'%s %s %s %s %s');
        if(strcmp(b2 , 'ID:2'))
            fprintf(fidout2,'%s\n',tline);
        elseif (strcmp(b2,'ID:5'))
            fprintf(fidout5,'%s\n',tline);
        elseif (strcmp(b2 ,'ID:6'))
            fprintf(fidout6,'%s\n',tline);
        elseif (strcmp(b2 ,'ID:7'))
            fprintf(fidout7,'%s\n',tline);
        end
    end
end
fclose(fidin);
fclose(fidout2);
fclose(fidout5);
fclose(fidout6);
fclose(fidout7);
end

