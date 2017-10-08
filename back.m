function num = back( k )
%BACK Generates CW val and then backoff based off of that
    CW0 = 4;
    b = (2^k) * CW0 - 1;
    num = ceil(1 + (b - 1).*rand(1,1));
end

