function out = B2(lambda, test)
    %A talks to B
    %C talks to D

    %RTS/CTS exchanged before transmission of a frame. If RTS collides,
    %something something experimental backoff. Otherwise, stations that hear
    %the RTS/CTS message defer.
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
    RTS = 2;
    CTS = 2;
    ACK = 2;
    DIFS = 2;
    SIFS = 1;
    
    A_RTS = false;
    C_RTS = false;
    B_CTS = false;
    
    
    frame = 100;
    k = 0; %number of collisions
    n = 0; %temp number of collisions
    timer = 0; %keeps track of real time after collisions and tx's

    while ((Acounter <= 10*lambda || Ccounter <= 10*lambda*test) && timer < 500000)
        % Get A Event
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
        % Get C Event
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
        
        % Assign new backoff value if not already carrying one forward
        if(Aback == 0) 
            Aback = back(0);
        end
        if(Cback == 0)
            Cback = back(0);
        end
        
        
        % Here A and C need to check for B_CTS, if so, collision
        if(A_RTS == true && C_RTS == true)
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
            Afair = Afair + A + Aback + RTS + frame + CTS;
            Cfair = Cfair + C + Cback + RTS + frame + CTS;
            A_RTS = false;
            C_RTS = false;
            continue;
        else 
            n = 0;
        end
        % Here A needs to check for B_CTS, if not detected, send RTS
        % A cannot sense an RTS from C, so it is limited in that regard.
        A_RTS_TEMP = A_RTS; % temp done so A and C make decisions in "parallel"
        if(A_RTS == true && B_CTS == true)
            timer = timer + A + Aback + RTS + frame + CTS + ACK;
            Aback = 0;
            Acounter = Acounter + 1;
            Atx = Atx + 1;
            A_RTS_TEMP = false;
            B_CTS = false;
        elseif(A_RTS == true)
            B_CTS = true;
            Atx = Atx + 1;
            Afair = Afair + A + Aback + RTS + frame + CTS + ACK;
        elseif(C + Cback >= A + Aback) % A goes
            Acounter = Acounter + 1;
            A_RTS_TEMP = true;
            timer = timer + RTS;
        end    
        
        % Here C needs to check for B_CTS, if none, send RTS
        C_RTS_TEMP = C_RTS; % temp done so A and C make decisions in "parallel"
        if(C_RTS == true && B_CTS == true)
            timer = timer + C + Cback + RTS + frame + CTS + ACK;
            Cback = 0;
            Ccounter = Ccounter + 1;
            Ctx = Ctx + 1;
            C_RTS_TEMP = false;
            B_CTS = false;
        elseif(C_RTS == true)
            B_CTS = true;
            Ctx = Ctx + 1;
            Cfair = Cfair + C + Cback + RTS + frame + CTS;
        elseif(A + Aback >= C + Cback) % C goes
            Ccounter = Ccounter + 1;
            C_RTS_TEMP = true;
            timer = timer + RTS;
        end
        
        A_RTS = A_RTS_TEMP;
        C_RTS = C_RTS_TEMP;
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