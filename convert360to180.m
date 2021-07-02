function degre_line = convert360to180(angle_point)
% convert angle in degree from [0 360] to [0 180] which means 
% to convert the angle of a point position to a line orientation
% written by Yiheng Hu(18/5/2021)
dimensionsize=size(angle_point);
if length(dimensionsize)>2
    error('the input should be a N*1 or 1*N array')
    return
end
angle_point=wrapTo360(angle_point);
for i=1:length(angle_point)
    if angle_point(i)>=180
        degre_line(i)=angle_point(i)-180;
    else
        degre_line(i)=angle_point(i);
    end
end
end