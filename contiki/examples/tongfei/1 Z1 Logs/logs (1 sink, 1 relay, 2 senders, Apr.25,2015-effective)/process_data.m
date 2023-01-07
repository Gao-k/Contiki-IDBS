
function [] = process_data( file_in, file_out, head_, tail_ )
%   process the received file for cutting error header and tial
%   input values:
%   file_in:    filename needed to be processed
%   file_out:   filename to stored after processing
%   head_:      the line counter to be cut in header
%   tail_:      the line counter to be cut in tail


head_forward = head_;           %头部需要删去的行数
tail_back = tail_;              %尾部需要删去的行数
filename_final = file_out;      %最终整理好的txt
filename_pr = file_in;          %输入的txt名称

tail_line=0;                    %获取该文件总共的行数
fidin=fopen(filename_pr,'r+');
while ~feof(fidin)              %判断是否为文件末尾
    tail_line=tail_line+1;      %对行数进行计数 
    tline=fgetl(fidin);         %从文件读行
end
fclose(fidin);

head_line=head_forward;            
tail_line=tail_line-tail_back;

fidin=fopen(filename_pr,'r+');
fidout=fopen(filename_final,'w+');
while tail_line ~= 0
    tline=fgetl(fidin);
    if head_line==0
        fprintf(fidout,'%s\n',tline);
    else
        head_line = head_line-1;
    end
    tail_line=tail_line-1;
end
fclose(fidin);
fclose(fidout);

end


