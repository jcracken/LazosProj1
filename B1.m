function out = B1(lambda, test)
    %A and C both talk to B (no collisions?)

    %DIFS of 40 us + random backoff of [1,3] (slots)
    %If channel busy during DIFS, it freezes and waits for it to become idle.
    %Decrements counter until it hits zero, freezes when not idle, transmits
    %once counter hits zero. If no collision, SIFS of 10 us and then ACK. Then
    %DIFS again and the next transmission starts. If collision, the colliding
    %stations choose backoff from [0, 2^k * 4 - 1] where k is number of
    %collisions. Calculated upper bound cannot exceeed 1024 slots.

    Ain = packetgen(lambda); %events
    Cin = packetgen(test * lambda);
    Aback = 0; %backoff values
    Cback = 0;
    Acounter = 1; %which event we're on
    Ccounter = 1;
    Atx = 0; %number of transmissions each has made
    Ctx = 0;
    Adone = 0; %for throughput
    Cdone = 0;
    Afair = 0;
    Cfair = 0;

    %length in slots of each event
    DIFS = 2;
    SIFS = 1;
    ACK = 2;

    frame = 100;
    k = 0; %number of collisions
    n = 0; %temp number of collisions
    timer = 0; %keeps track of real time after collisions and tx's

    while ((Acounter <= 10*lambda || Ccounter <= 10*test * lambda) && timer < 500000)
        if(Acounter > 10*lambda) %get current event. if one runs out of events make them a non-factor
            A = 600000;
            if(Adone == 0)
                Adone = timer;
            end
        else
            if(n == 0)
                A = Ain(Acounter);
            end
        end
        if(Ccounter > test * 10*lambda)
            C = 600000;
            if(Cdone == 0)
                Cdone = timer;
            end
        else
            if(n == 0)
                C = Cin(Ccounter);
            end
        end
        if(Aback == 0) %assign new backoff value if not already carrying one forward
            Aback = back(0);
        end
        if(Cback == 0)
            Cback = back(0);
        end
        if (A + Aback == C + Cback) %collision!
            k = k + 1; %count up collision counter
            n = n + 1;
            Aback = back(n); %set new backoff. if hit max backoff, keep it there.
            if(Aback > 1024)
                Aback = 1024;
            end
            Cback = back(n);
            if(Cback > 1024)
                Cback = 1024;
            end
            timer = timer + A + Aback + DIFS + frame + SIFS; %move time forward
            A = timer;
            C = timer;
            Afair = Afair + A + Aback + DIFS + frame + SIFS;
            Cfair = Cfair + A + Aback + DIFS + frame + SIFS;
        end
        if (A + Aback > C + Cback && A >= C + Cback) %C goes, A hasn't started yet
            if(A + Aback + DIFS < C + Cback + DIFS + frame) %collision
                k = k + 1; %count up collision counter
                n = n + 1;
                Aback = back(n); %set new backoff. if hit max backoff, keep it there.
                if(Aback > 1024)
                    Aback = 1024;
                end
                Cback = back(n);
                if(Cback > 1024)
                    Cback = 1024;
                end
                timer = timer + C + Cback + DIFS + frame + SIFS;
                C = timer;
                timer = timer + A + Aback + DIFS + frame + SIFS;
                A = timer;
                Afair = Afair + A + Aback + DIFS + frame + SIFS;
                Cfair = Cfair + C + Cback + DIFS + frame + SIFS;
            else
                n = 0;
                timer = timer + C + Cback + DIFS + frame + SIFS + ACK;
                Cback = 0;
                Ccounter = Ccounter + 1;
                Ctx = Ctx + 1;
                Cfair = Cfair + C + Cback + DIFS + frame + SIFS;
            end
        end
        if (C + Cback > A + Aback && C >= A + Aback) %A goes, C hasn't started yet
             if(C + Cback + DIFS < A + Aback + DIFS + frame) %collision
                k = k + 1; %count up collision counter
                n = n + 1;
                Aback = back(n); %set new backoff. if hit max backoff, keep it there.
                if(Aback > 1024)
                    Aback = 1024;
                end
                Cback = back(n);
                if(Cback > 1024)
                    Cback = 1024;
                end
                timer = timer + A + Aback + DIFS + frame + SIFS;
                A = timer;
                timer = timer + C + Cback + DIFS + frame + SIFS; 
                C = timer;
                Afair = Afair + A + Aback + DIFS + frame + SIFS;
                Cfair = Cfair + C + Cback + DIFS + frame + SIFS;
             else
                n = 0;
                timer = timer + A + Aback + DIFS + frame + SIFS + ACK;
                Aback = 0;
                Acounter = Acounter + 1;
                Atx = Atx + 1;
                Afair = Afair + A + Aback + DIFS + frame + SIFS;
             end
        end
        if (C + Cback > A + Aback && A + Aback >= C) %A goes first, C collides
            k = k + 1; %count up collision counter
            n = n + 1;
            Aback = back(n); %set new backoff. if hit max backoff, keep it there.
            if(Aback > 1024)
                Aback = 1024;
            end
            Cback = back(n);
            if(Cback > 1024)
                Cback = 1024;
            end
            timerold = timer;
            timer = timer + A + Aback + DIFS + frame + SIFS;
            A = timer;
            timer = timerold + C + Cback + DIFS + frame + SIFS; 
            C = timer;
            Afair = Afair + A + Aback + DIFS + frame + SIFS;
            Cfair = Cfair + C + Cback + DIFS + frame + SIFS;
        end
        if (A + Aback > C + Cback && C + Cback >= A) %C goes first, A collides
            k = k + 1; %count up collision counter
            n = n + 1;
            Aback = back(n); %set new backoff. if hit max backoff, keep it there.
            if(Aback > 1024)
                Aback = 1024;
            end
            Cback = back(n);
            if(Cback > 1024)
                Cback = 1024;
            end
            timerold = timer;
            timer = timer + A + Aback + DIFS + frame + SIFS;
            A = timer;
            timer = timerold + C + Cback + DIFS + frame + SIFS; 
            C = timer;
            Afair = Afair + A + Aback + DIFS + frame + SIFS;
            Cfair = Cfair + C + Cback + DIFS + frame + SIFS;
        end
        if (n >= 9) %not gonna work, toss the events and move on
            n = 0;
            Acounter = Acounter + 1;
            Ccounter = Ccounter + 1;
        end
    end
    % out format = [A_throughput, C_Throughput, num_collisions,
    % Fairness_Index
    if(Adone == 0)
        Athroughput = (Atx * 1500) / timer;
    else
        Athroughput = (Atx * 1500) / Adone;
    end
    if(Cdone == 0)
        Cthroughput = (Ctx * 1500) / timer;
    else
        Cthroughput = (Ctx * 1500) / Cdone;
    end
    fairness = (Afair/(Afair + Cfair))/(Cfair/(Afair + Cfair));
    out = [Athroughput Cthroughput k fairness];
end