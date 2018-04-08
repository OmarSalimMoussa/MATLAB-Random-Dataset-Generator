% Author: Omar Salim Moussa
% A program that generates normally distributed data points for
% experimental multiple regression
% Output Format: Excel

% Data Generation

c = input('Number of independent variables: ');
r = input('Number of data points (More than 35 recommended): ');
iv = zeros(r,c+1);
for i = 1:c
    fprintf('Parameter %d\n', i);
    mu = input('Mean: ');
    sigma = input('Standard Deviation: ');
    for j = 1:r
        iv(j,i) = normrnd(mu,sigma);
    end
    clc
end
iv = sort(iv);

% Randomized Bucket Shuffle

b = input('Bucket Size: ');

for i = 1:c
    sz = 0;
    while sz < r
        in = 1;
        while in <= b && sz < r
            column(in) = iv(sz+1,i);
            in = in+1;
            sz = sz+1;
        end
        p = randperm(in-1);
        for j = 1:in-1
            iv(sz-in+1+j, i) = column(p(j));
        end
    end
end

% Multiple Regression Parameters

inter = input('Intercept: ');
for i = 1:c
    fprintf('Parameter %d\n', i);
    coef(i) = input('Slope: ');
end
for i = 1:r
    iv(i,c+1) = inter + rand()*2 - rand()*1.5;
    for j = 1:c
        iv(i,c+1) = iv(i,c+1) + coef(j) .* iv(i,j);
    end
end

%Adjustments

fprintf('Max/Min values: \n');
for i = 1:c+1
    fprintf('Parameter %d\n', i);
    mx(i) = input('Max: ');
    mn(i) = input('Min: ');
end
for i = 1:r
    for j = 1:c+1
        iv(i,j) = min(mx(j),iv(i,j));
        iv(i,j) = max(mn(j),iv(i,j));
    end
end
xlswrite('Dataset.xlsx',iv);