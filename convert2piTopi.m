function radian_line = convert2piTopi(radian_point)
% convert angle in radian from [0 2*pi] to [0 pi] which means 
% to convert the angle of a point position to a line orientation
% written by Yiheng Hu(11/5/2021)
dimensionsize=size(radian_point);
if length(dimensionsize)>2
    error('the input should be a N*1 or 1*N array')
    return
end
radian_point=wrapTo2Pi(radian_point);
for i=1:length(radian_point)
    if radian_point(i)>=pi
        radian_line(i)=radian_point(i)-pi;
    else
        radian_line(i)=radian_point(i);
    end
end
end

