% This is to deal with the output data from contiki cooja
% Author: F. Tong
% Date: May 13, 2015

function [ ] = tf_process_z1_data(  )
%UNTITLED 此处显示有关此函数的摘要
%   此处显示详细说明
%%
%file_in = 'data.txt';
file_in_array = char('2.txt','3.txt', '5.txt');
temp = size(file_in_array);
file_num = temp(1);
for i=1:1:file_num,
    file_in = file_in_array(i,:); % get the file name
    fidin=fopen(file_in,'r+'); % open the file
    file_out = ['cd_',file_in(1),'.txt']; % set the output file name, e.g., cd_2.txt
    fidout = fopen(file_out,'w+');
    while ~feof(fidin) % if not the end of the file
        tline = fgetl(fidin); % read one line
        if ~isempty(strfind(tline,' CD ')) % find the line containing ' CD '
            fprintf(fidout,'%s\n',tline);
        end
    end
    fclose(fidout); % close the ouput file
    fclose(fidin); % close the input file
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%

end

