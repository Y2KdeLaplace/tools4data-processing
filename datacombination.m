function  alldata=datacombination(filename,ntrial)
% combine the variable in data structure with same size
% core of code copy from Qing Yu's code
% written by Yiheng Hu(8/6/2021)
finfo=dir(filename);
for n=1:length(finfo)
    load([filename(1:end-5) num2str(n) '.mat'],'data')
    if n==1
        alldata=data;
    else
        f=fieldnames(alldata);
        for k=1:numel(f)
            if size(data.(f{k}),2)==ntrial
                alldata.(f{k})=[alldata.(f{k}),data.(f{k})];
            elseif size(data.(f{k}),1)==ntrial
                alldata.(f{k})=[alldata.(f{k});data.(f{k})];
            end
        end
    end
end
fprintf(['Totally combining ' num2str(n) ' runs data. \n'])
end

