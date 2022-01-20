clear
close all
clc

syms f(x) x
%% Samples (comment this section for manual input)
functions = ["x^2", "1/(x^3 + 5)", "1/(x^3 + 5)"]; %functions
aa = [0, 0, -1]; %lower bounds respectivly
bb = [5, 2, 0];  %upper bounds respectivly
func = str2sym(functions); %creating a vector of f(x)
%% Creating functions out of samples(for manual input comment this for and it's end)
for i = 1:length(func)
    %% (comment for manual input)
    f(x) = func(i); %function
    a = aa(i);           %lower bound
    b = bb(i);           %upper bound
    %% (uncomment comments for manual input)
    % func = input("please input f(x): ", 's');
    % f(x) = str2sym(func);
    % a = input("please enter lower bound of integral: ");
    % b = input("please enter upper bound of integral: ");
    %% (uncomment following comments and comment the "for" for manual input)
%     quit = false;
    for choice = 1:3
%     while ~quit
%         choice = menu("choose the gauss-legendre formula", "2 point formula", "3 point formula","quit");
     %%
        switch choice
            case 1
                method = "2 point";
                result = gaussLegendreFunc(f, a, b, method);
            case 2
                method = "3 point";
                result = gaussLegendreFunc(f, a, b, method);
            otherwise
%                 quit = true;
                result = int(f,a,b);
        end
        
        if isnumeric(result)
            result = double(result);
            fprintf("using Gauss-Legendre %s method:\n", method)
            fprintf("integral of %s from %.2f to %.2f = %.4f\n",...
                string(f), a, b, result);
        else
            fprintf("The actual result is: %f\n\n", result)
        end
    end
end