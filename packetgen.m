function out = packetgen(lambda)
    r = 0 + (0.2).*rand(lambda,1);
    X = (-1/lambda).*log(1-r);
    Y = ceil(X./0.00002);
    out = zeroes (1, lambda);
    for i = 1:lambda
        sum = 0;
        for j = 1:i
            sum = sum + Y(j);
        end
        out(i) = sum;
    end
end