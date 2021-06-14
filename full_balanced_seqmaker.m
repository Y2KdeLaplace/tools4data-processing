function [basic_seq,extra_seq,sequence,wheel_orientation]=full_balanced_seqmaker(linenumber,condition,retrocue,times)
% linenumber - number of angle
% condition - number of condition
% retrocue - number of retrocue
% times - total round number of basic sequence 
% create a unit of full balanced sequence and shuffling it
% total number: (linenumber*linenumber-linenumber)*condition*retrocue*times
% written by Yiheng Hu(1/5/2021)
%% unit sequence formation of '(linenumber*linenumber-linenumber)'
% unit_sequence: stimuli-1  stimuli-2
for i=1:linenumber
    unit_sequence(linenumber*(i-1)+1:linenumber*i,1)=i.*ones(linenumber,1);
end
unit_sequence(:,2)=repmat([1:linenumber],1,linenumber)';
unit_sequence(unit_sequence(:,1)==unit_sequence(:,2),:)=[];
rows_unit=size(unit_sequence,1);

%% sequence formation of '(linenumber*linenumber-linenumber)*condition*retrocue'
% sequence: stimuli-1  stimuli-2  condition_tag  retrocue_tag
sequence=[];
for i=1:condition
    sequence=[sequence;unit_sequence,i.*ones(rows_unit,1)];
end
rows_retrocue=size(sequence,1);
sequence=[sequence; sequence];
for j=1:retrocue
    sequence(rows_retrocue*(j-1)+1:rows_retrocue*j,4)=j.*ones(rows_retrocue,1);
end
rows_sequence=size(sequence,1);

%% basic sequence formation of '(linenumber*linenumber-linenumber)*condition*retrocue*times'
shuffle_seq=[];
for j=1:times
    order=Shuffle(randperm(rows_sequence));%1:rows_sequence;
    for i=rows_sequence*(j-1)+1:rows_sequence*j
        shuffle_seq(i,:)=sequence(order(i-rows_sequence*(j-1)),:);
    end
end
order_run=Shuffle(randperm(times*length(order)));
for i=1:length(order_run)
    basic_seq(i,:)=shuffle_seq(order_run(i),:);
end

%extra sequence
clear order
order=Shuffle(randperm(rows_sequence));
for i=1:rows_sequence
    extra_seq(i,:)=sequence(order(i),:);
end

%% wheel orientation at the beginning
% to create parameters of original position of response wheel
wheel_orientation=Shuffle(repmat(randperm(180),1,round(size(basic_seq,1)/180)));
if length(wheel_orientation)<length(basic_seq(:,1))
    wheel_orientation=Shuffle(repmat(randperm(180),1,round(size(basic_seq,1)/180)+1));
end
if rows_sequence<=180
    wheel_orientation=[wheel_orientation,Shuffle(randperm(180))];
else
    wheel_orientation=[wheel_orientation,Shuffle(repmat(randperm(180),1,2))];
end

% save(['full_balanced_sequence_parameters_' run '_plus_1.mat'],'basic_seq','extra_seq','sequence');
end