% This is to deal with the output data from contiki cooja
% Author: F. Tong
% Date: May 13, 2015

function [ ] = contikiCollect_process_data_12_sensors_1_sink( file_in )
%UNTITLED 此处显示有关此函数的摘要
%   此处显示详细说明
%%
%file_in = 'contikiCollect_tempdata.txt';
output1 = 'contikiCollect_grade_1.txt';
output2 = 'contikiCollect_grade_2.txt';
output3 = 'contikiCollect_grade_3.txt';
output4 = 'contikiCollect_grade_4.txt';
output5 = 'contikiCollect_grade_5.txt';
fidout1=fopen(output1,'w+');
fidout2=fopen(output2,'w+');
fidout3=fopen(output3,'w+');
fidout4=fopen(output4,'w+');
fidout5=fopen(output5,'w+');

fidin=fopen(file_in,'r+');
while ~feof(fidin)              %判断是否为文件末尾
  
    tline=fgetl(fidin);        %从文件读行
    if ~isempty(tline)
        [~,~,~,~,~,~,grade,~,~,~,~,~,~ ]=strread(tline,'%s %s %d %s %s %s %s %s %d %s %d %s %d');
        if(strcmp(grade , '1'))
            fprintf(fidout1,'%s\n',tline);
        elseif (strcmp(grade,'2'))
            fprintf(fidout2,'%s\n',tline);
        elseif (strcmp(grade ,'3'))
            fprintf(fidout3,'%s\n',tline);
        elseif (strcmp(grade ,'4'))
            fprintf(fidout4,'%s\n',tline);
        elseif (strcmp(grade,'5'))
            fprintf(fidout5,'%s\n',tline);
        end
    end
end
fclose(fidin);
fclose(fidout1);
fclose(fidout2);
fclose(fidout3);
fclose(fidout4);
fclose(fidout5);
end

