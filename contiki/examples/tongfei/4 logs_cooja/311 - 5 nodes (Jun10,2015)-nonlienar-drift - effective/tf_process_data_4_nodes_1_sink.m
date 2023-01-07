% This is to deal with the output data from contiki cooja
% Author: F. Tong
% Date: May 13, 2015

function [ ] = tf_process_data_4_nodes_1_sink( file_in )
%UNTITLED 此处显示有关此函数的摘要
%   此处显示详细说明
%%
%file_in = 'tempdata.txt';
output2 = 'cd_2.txt';
output3 = 'cd_3.txt';
output4 = 'cd_4.txt';
output5 = 'cd_5.txt';

fidout2=fopen(output2,'w+');
fidout3=fopen(output3,'w+');
fidout4=fopen(output4,'w+');
fidout5=fopen(output5,'w+');


fidin=fopen(file_in,'r+');
while ~feof(fidin)              %判断是否为文件末尾
  
    tline=fgetl(fidin);        %从文件读行
    if ~isempty(tline)
        [~,b2,~,~,b5]=strread(tline,'%s %s %s %s %s');
        if(strcmp(b2 , 'ID:2'))
            fprintf(fidout2,'%s\n',tline);
        elseif (strcmp(b2,'ID:3'))
            fprintf(fidout3,'%s\n',tline);
        elseif (strcmp(b2 ,'ID:4'))
            fprintf(fidout4,'%s\n',tline);
        elseif (strcmp(b2 ,'ID:5'))
            fprintf(fidout5,'%s\n',tline);
        end
    end
end
fclose(fidin);
fclose(fidout2);
fclose(fidout3);
fclose(fidout4);
fclose(fidout5);
end

