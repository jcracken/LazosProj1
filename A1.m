%A talks to B
%C talks to D

%DIFS of 40 us + random backoff of [1,3] (slots)
%If channel busy during DIFS, it freezes and waits for it to become idle.
%Decrements counter until it hits zero, freezes when not idle, transmits
%once counter hits zero. If no collision, SIFS of 10 us and then ACK. Then
%DIFS again and the next transmission starts. If collision, the colliding
%stations choose backoff from [0, 2^k * 4 - 1] where k is number of
%collisions. Calculated upper bound cannot exceeed 1024 slots.

lambda = 50;
Ain = packetgen(lambda);
Cin = packetgen(lambda);

Acounter = 1;
Ccounter = 1;
timer = 1;

DIFS = 2;
SIFS = 1;
ACK = 2;
frame = 100;
k = 0;

for i = 1:lambda
    A = Ain(Acounter);
    C = Cin(Ccounter);
    Aback = back(k);
    Cback = back(k);
    if (A + Aback == C + Cback) %collision!
        k = k + 1;
        Aback = Aback * 2;
        Cback = Cback * 2;
        timer = A + Aback + DIFS + frame + SIFS;
    end
    if (A + Aback > C + Cback && C + Cback > A) %C goes first, A freezes
        
    end
    if (A + Aback > C + Cback && A > C + Cback) %C goes, A hasn't started yet
        
    end
    if (C + Cback > A + Aback && C > A + Aback) %A goes, C hasn't started yet
        
    end
    if (C + Cback > A + Aback && A + Aback > C) %A goes first, C freezes
        
    end
end