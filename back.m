function num = back( k )
%BACK Generates CW val and then backoff based off of that
    CW0 = 4;
    b = (2^k) * CW0 - 1;
    if (b > 1024)
        b = 1024;
    end
    num = 1 + (b - 1).*randi(1,1);
end

