% This is to deal with the output data from contiki cooja
% return the number of generated data at each grade
% Author: F. Tong
% Date: May 13, 2015

function [ ] = pdc_G_process_data_12_sensors_1_sink( file_in )
%UNTITLED 此处显示有关此函数的摘要
%   此处显示详细说明
file_in = ['GeneratedData/pdc_sync_G_pgi=',int2str(1),'s.txt'];
node_num=12;
fidout_array = zeros(node_num,1);
for ii=1:12
    fidout_array(ii)=fopen(['processeddata/pdc_G_',int2str(ii+1),'.txt'],'w+');
end
fidin=fopen(file_in,'r+');

while ~feof(fidin)              %判断是否为文件末尾
    tline=fgetl(fidin);        %从文件读行
    if ~isempty(tline)
        [~,~,~,~,node,~,~ ]=strread(tline,'%s %s %s %s %s %s %s');
        for ii = 1:12
            if(strcmp(node , [int2str(ii+1),'.0']))
                fprintf(fidout_array(ii),'%s\n',tline);
            end
        end
    end
end

for ii=1:12
    fclose(fidout_array(ii));
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

end

