% This is to deal with the output data from contiki cooja
% Author: F. Tong
% Date: May 13, 2015

function [ ] = tf_process_data( file_in )
%UNTITLED 此处显示有关此函数的摘要
%   此处显示详细说明
%%
%file_in = 'data.txt';
output1 = 'cd_2to1.txt';
output2 = 'cd_3to2.txt';
output3 = 'cd_4to2.txt';
fidout1=fopen(output1,'w+');
fidout2=fopen(output2,'w+');
fidout3=fopen(output3,'w+');
fidin=fopen(file_in,'r+');
while ~feof(fidin)              %判断是否为文件末尾
  
    tline=fgetl(fidin);        %从文件读行
    if ~isempty(tline)
        [b1,b2,b3,b4,b5]=strread(tline,'%s %s %s %s %s');
        if(strcmp(b2 , 'ID:2'))
            fprintf(fidout1,'%s\n',tline);
        elseif (strcmp(b2,'ID:3'))
            fprintf(fidout2,'%s\n',tline);
        elseif (strcmp(b2 ,'ID:4'))
            fprintf(fidout3,'%s\n',tline);
        end
    end
end
fclose(fidin);
fclose(fidout1);
fclose(fidout2);
fclose(fidout3);
end

