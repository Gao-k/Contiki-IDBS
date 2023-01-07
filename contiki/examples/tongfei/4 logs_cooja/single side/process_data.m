
function [] = process_data( file_in, file_out, head_, tail_ )
%   process the received file for cutting error header and tial
%   input values:
%   file_in:    filename needed to be processed
%   file_out:   filename to stored after processing
%   head_:      the line counter to be cut in header
%   tail_:      the line counter to be cut in tail


head_forward = head_;           %ͷ����Ҫɾȥ������
tail_back = tail_;              %β����Ҫɾȥ������
filename_final = file_out;      %��������õ�txt
filename_pr = file_in;          %�����txt����

tail_line=0;                    %��ȡ���ļ��ܹ�������
fidin=fopen(filename_pr,'r+');
while ~feof(fidin)              %�ж��Ƿ�Ϊ�ļ�ĩβ
    tail_line=tail_line+1;      %���������м��� 
    tline=fgetl(fidin);         %���ļ�����
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


