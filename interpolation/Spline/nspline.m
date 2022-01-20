function yy = nspline(x, y, varargin)

switch nargin
    case 1
        y = x;
        method = "cubic";
        xx = x(1);
    case 2
        method = "cubic";
        xx = x(1);
    case 3
        method = "cubic";
        xx = varargin{1};
    case 4
        if strcmp(varargin{2}, 1) || contains(lower(varargin{2}), "lin")
            method = "linear";
            xx = varargin{1};
        elseif strcmp(varargin{2}, 2) || contains(lower(varargin{2}), "quad")
            method = "quadratic";
            xx =  varargin{1};
        else
            method = "cubic";
            xx = varargin{1};
        end
    otherwise
        error("incorrect input")
end
switch method
    case "linear"
        a = y(1:end-1);
        b = a;
        for i = 1:length(x)-1
            b(i) = (y(i+1) - y(i)) / (x(i+1) - x(i));
        end
        s = a + b .* (xx - x(1:end-1));
        for i = 1:length(x)-1
            if xx >= x(i) && xx < x(i+1)
                yy = s(i);
            end
        end
        hold on
        plot(x,y,'ob')
        plot(xx,yy,"xr")
        plot(x,y,"-","DisplayName", "Linear")
        hold off
    case "quadratic"
        xxx = x(1):(x(2)-x(1))/100:x(end);
        yyy = xxx;
        for i = 1:length(xxx)
            yyy(i) = quadratic(x, y, xxx(i));
        end
        yy = quadratic(x, y, xx);
        hold on
        plot(x,y,"ob")
        plot(xx,yy,"xr")
        plot(xxx,yyy,"--","DisplayName", "Quadratic")
        hold off
    case "cubic"
        xxx = x(1):(x(2)-x(1))/100:x(end);
        yyy = xxx;
        for i = 1:length(xxx)
            yyy(i) = cubic(x, y, xxx(i));
        end
        yy = cubic(x, y, xx);
        hold on
        plot(x,y,"ob")
        plot(xx,yy,"xr")
        plot(xxx,yyy,"-.", "DisplayName", "Cubic")
        hold off
end
