function [integ] = integrate_vec(vec,dt,gvec)
    integ = zeros(size(vec));
%     integ(1,:) = vec(1,:);
    if nargin == 2
        vec_ans = vec;
    elseif nargin == 3
        gvec_mean = mean(gvec,1);
        vec_ans = vec - gvec_mean;
    end
    for i = 2:size(vec,1)
        for j = 1:size(vec,2)
            integ(i,j) = integ(i-1,j) + vec_ans(i,j)*dt;
        end
    end
%     integ = cumsum(vec)*dt;
end