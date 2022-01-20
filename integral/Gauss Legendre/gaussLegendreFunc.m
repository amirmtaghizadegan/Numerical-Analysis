function result = gaussLegendreFunc(f,varargin)

%% initiating variables to be like this:
% a = lower bound
% b = upper bound
% f -> f(x) the function
% method = "2 point" or "3 point"
switch nargin-1
    case 0
        method = "3 point";
        a = -1;
        b = 1;
    case 1
        method = varargin{1};
        a = -1;
        b = 1;
    case 2
        method = "3 point";
        a = varargin{1};
        b = varargin{2};
    case num2cell(3:100)
        method = varargin{3};
        a = varargin{1};
        b = varargin{2};
    otherwise
        error('Not enough input arguments.') 
end
%%
syms g(t) t
%% changing variable x to t
 % x = (b-a)*t/2+(b+a)/2
 g(t) = f((b-a)*t/2+(b+a)/2)*(b-a)/2; %g is f(t)dt
%% using gauss legendre formula
    switch method
        case "2 point"
            aa = -1/sqrt(3);
            result = double(g(-aa)+ g(aa));
        case "3 point"
            result = double(5/9 * g(-sqrt(3/5)) +...
            8/9 * g(0) + 5/9 * g(sqrt(3/5)));
        otherwise
            error("Invalid Method")
    end
end