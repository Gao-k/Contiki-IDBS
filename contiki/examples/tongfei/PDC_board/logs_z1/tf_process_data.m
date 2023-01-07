% This is to deal with the output data from contiki cooja
% Author: F. Tong
% Date: May 13, 2015

 function [ ] = tf_process_data( separater )
%UNTITLED 此处显示有关此函数的摘要
%  input: separater
%          it could be 'R', 'P', or other characters used to find all
%          the lines which contain this separater.
%%
%file_in = 'data.txt';
SF_array = [10 18];
protocol_array = char('adc','pdc');
fa_array = char('fa','nfa'); %fa: with free addressing; %nfa: no free addressing
pgi_array = [1 3 5 7 9]; %packet generation interval (unit: second)
input_data_folder = '.';
input_file_name='sink.txt';
output_data_folder = [separater,'_data'];

for i = pgi_array
    for SF = SF_array
        temp=size(protocol_array);
        protocol_num=temp(1);
        for j = 1:1:protocol_num
            protocol = protocol_array(j,:);
            temp=size(fa_array);
            fa_num = temp(1);
            for k = 1:1:fa_num
                fa = fa_array(k,:);
                if strcmp(fa,'fa ') % if fa is 'fa ', the last space should be removed
                    fa='fa';
                end
                if strcmp(protocol,'pdc') && strcmp(fa,'fa') %'pdc' and 'fa' are not shown together
                    continue;
                end
               
                common_file_name = [protocol,'_',int2str(SF),'_',fa,'_',int2str(i),'s'];
                file_in=[input_data_folder,'/',common_file_name,'/',input_file_name];
                fidin=fopen(file_in,'r+'); % open the file
                file_out=[output_data_folder,'/',common_file_name,'.txt'];
                fidout = fopen(file_out,'w+');
                while ~feof(fidin) % if not the end of the file
                    tline = fgetl(fidin); % read one line
                    if ~isempty(strfind(tline,[' ',separater,' '])) % find the line containing ' R ' or ' P '
                        fprintf(fidout,'%s\n',tline);
                    end
                end
                fclose(fidout); % close the ouput file
                fclose(fidin); % close the input file
            end
        end
    end
end

% file_in_array = char('2.txt','3.txt', '4.txt','5.txt');
% temp = size(file_in_array);
% file_num = temp(1);
% for i=1:1:file_num,
%     file_in = file_in_array(i,:); % get the file name
%     fidin=fopen(file_in,'r+'); % open the file
%     file_out = ['cd_',file_in(1),'.txt']; % set the output file name, e.g., cd_2.txt
%     fidout = fopen(file_out,'w+');
%     while ~feof(fidin) % if not the end of the file
%         tline = fgetl(fidin); % read one line
%         if ~isempty(strfind(tline,' CD ')) % find the line containing ' CD '
%             fprintf(fidout,'%s\n',tline);
%         end
%     end
%     fclose(fidout); % close the ouput file
%     fclose(fidin); % close the input file
% end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%

end

