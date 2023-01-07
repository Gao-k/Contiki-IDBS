close all 
clear all

contikiCollect_process_data_12_sensors_1_sink( 'contikiCollect_tempdata.txt' );

format

file_in_array = char('contikiCollect_grade_1.txt','contikiCollect_grade_2.txt','contikiCollect_grade_3.txt', 'contikiCollect_grade_4.txt','contikiCollect_grade_5.txt');
temp = size(file_in_array);
latency_array = zeros(1,5);
file_num = temp(1);
total_data_num = 0;
for i=1:1:file_num,
    file_name = file_in_array(i,:); % get the file name
    [~,~,~,~,~,~,grade,~,~,~,latency,~,~,~,~ ]=textread(file_name,'%s %s %d %s %s %s %d %s %s %s %d %s %d %s %d');
    latency_array(i)=sum(abs(latency))/length(latency)
    total_data_num = total_data_num + length(latency)
end
latency_array=latency_array.*1000./(128*3600);
bar(latency_array);

