%A talks to B
%C talks to D

%DIFS of 40 us + random backoff of [1,3] (slots)
%If channel busy during DIFS, it freezes and waits for it to become idle.
%Decrements counter until it hits zero, freezes when not idle, transmits
%once counter hits zero. If no collision, SIFS of 10 us and then ACK. Then
%DIFS again and the next transmission starts. If collision, the colliding
%stations choose backoff from [0, 2^k * 4 - 1] where k is number of
%collisions. Calculated upper bound cannot exceeed 1024 slots.

lambda = 300;

Ain = packetgen(lambda); %events
Cin = packetgen(lambda);
Aback = 0; %backoff values
Cback = 0;
Acounter = 1; %which event we're on
Ccounter = 1;
Atx = 0; %number of transmissions each has made
Ctx = 0;

DIFS = 2;
SIFS = 1;
ACK = 2;

frame = 100;
k = 0; %number of collisions
timer = 0; %keeps track of real time after collisions and tx's

while (Acounter <= lambda || Ccounter <= lambda)
    if(Acounter > lambda) %get current event. if one runs out of events make them a non-factor
        A = 600000;
    else
        A = Ain(Acounter);
    end
    if(Ccounter > lambda)
        C = 600000;
    else
        C = Cin(Ccounter);
    end
    if(Aback == 0) %assign new backoff value if not already carrying one forward
        Aback = back(0);
    end
    if(Cback == 0)
        Cback = back(0);
    end
    if (A + Aback == C + Cback) %collision!
        k = k + 1; %count up collision counter
        Aback = Aback * 2; %set new backoff. if hit max backoff, keep it there.
        if(Aback > 1024)
            Aback = 1024;
        end
        Cback = Cback * 2;
        if(Cback > 1024)
            Cback = 1024;
        end
        Acounter = Acounter + 1; %move onto next event
        Ccounter = Ccounter + 1;
        timer = timer + A + Aback + DIFS + frame + SIFS; %move time forward
    end
    if (A + Aback > C + Cback && C + Cback >= A) %C goes first, A freezes
        timer = timer + C + Cback + DIFS + frame + SIFS + ACK; %move time forward
        Aback = Aback - (C + Cback - A); %adjust backoff to reflect freeze
        Cback = 0; %reset backoff
        Ccounter = Ccounter + 1; %move to next event
        Ctx = Ctx + 1; %number of transmissions goes up
    end
    if (A + Aback > C + Cback && A >= C + Cback) %C goes, A hasn't started yet
        timer = timer + C + Cback + DIFS + frame + SIFS + ACK;
        Cback = 0;
        Ccounter = Ccounter + 1;
        Ctx = Ctx + 1;
    end
    if (C + Cback > A + Aback && C >= A + Aback) %A goes, C hasn't started yet
        timer = timer + A + Aback + DIFS + frame + SIFS + ACK;
        Aback = 0;
        Acounter = Acounter + 1;
        Atx = Atx + 1;
    end
    if (C + Cback > A + Aback && A + Aback >= C) %A goes first, C freezes
        timer = timer + A + Aback + DIFS + frame + SIFS + ACK;
        Cback = Cback - (A + Aback - C);
        Aback = 0;
        Acounter = Acounter + 1;
        Atx = Atx + 1;
    end
end