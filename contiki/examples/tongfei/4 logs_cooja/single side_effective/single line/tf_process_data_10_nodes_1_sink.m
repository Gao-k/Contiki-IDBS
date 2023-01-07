% This is to deal with the output data from contiki cooja
% Author: F. Tong
% Date: May 13, 2015

function [ ] = tf_process_data_10_nodes_1_sink(  )
%UNTITLED 此处显示有关此函数的摘要
%   此处显示详细说明
%%
file_in = 'tempdata.txt';
output1 = 'cd_2.txt';
output2 = 'cd_3.txt';
output3 = 'cd_4.txt';
output4 = 'cd_5.txt';
output5 = 'cd_6.txt';
output6 = 'cd_7.txt';
output7 = 'cd_8.txt';
output8 = 'cd_9.txt';
output9 = 'cd_10.txt';
output10 = 'cd_11.txt';
fidout1=fopen(output1,'w+');
fidout2=fopen(output2,'w+');
fidout3=fopen(output3,'w+');
fidout4=fopen(output4,'w+');
fidout5=fopen(output5,'w+');
fidout6=fopen(output6,'w+');
fidout7=fopen(output7,'w+');
fidout8=fopen(output8,'w+');
fidout9=fopen(output9,'w+');
fidout10=fopen(output10,'w+');
fidin=fopen(file_in,'r+');
while ~feof(fidin)              %判断是否为文件末尾
  
    tline=fgetl(fidin);        %从文件读行
    if ~isempty(tline)
        [~,b2,~,~,b5]=strread(tline,'%s %s %s %s %s');
        if(strcmp(b2 , 'ID:2'))
            fprintf(fidout1,'%s\n',tline);
        elseif (strcmp(b2,'ID:3'))
            fprintf(fidout2,'%s\n',tline);
        elseif (strcmp(b2 ,'ID:4'))
            fprintf(fidout3,'%s\n',tline);
        elseif (strcmp(b2 ,'ID:5'))
            fprintf(fidout4,'%s\n',tline);
        elseif (strcmp(b2,'ID:6'))
            fprintf(fidout5,'%s\n',tline);
        elseif (strcmp(b2 ,'ID:7'))
            fprintf(fidout6,'%s\n',tline);
        elseif (strcmp(b2 ,'ID:8'))
            fprintf(fidout7,'%s\n',tline);
        elseif (strcmp(b2 ,'ID:9'))
            fprintf(fidout8,'%s\n',tline);
        elseif (strcmp(b2 ,'ID:10'))
            fprintf(fidout9,'%s\n',tline);
        elseif (strcmp(b2 ,'ID:11'))
            fprintf(fidout10,'%s\n',tline);
        end
    end
end
fclose(fidin);
fclose(fidout1);
fclose(fidout2);
fclose(fidout3);
fclose(fidout4);
fclose(fidout5);
fclose(fidout6);
fclose(fidout7);
fclose(fidout8);
fclose(fidout9);
fclose(fidout10);
end

