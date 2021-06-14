for i=136:142
    %         [X,cmap]=imread([num2str(i) '.gif']);%Index image X is uint8 array. Color image cmap is double matrix.
    [X,cmap]=imread([num2str(i) '.gif']);
    image=ind2rgb(X,cmap);%tranform index image into RGB image resulting double array
    for j=1:size(image,1)
        for k=1:size(image,2)
            if image(j,k,:)==0
                image(j,k,:)=0.5;
            end
        end
    end
    %         imwrite(image,[num2str(i) '.png']);%png, bmp
    imwrite(image,[num2str(i) '.bmp']);
end