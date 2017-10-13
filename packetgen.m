function out = packetgen(lambda)
    r = 0 + (1).*rand(10*lambda,1);
    X = (-1/lambda).*log(1-r);
    Y = ceil(X./0.00002);
    out = zeros(1, 10*lambda);
    for i = 1:10*lambda
        sum = 0;
        for j = 1:i
            sum = sum + Y(j);
        end
        out(i) = sum;
    end
end