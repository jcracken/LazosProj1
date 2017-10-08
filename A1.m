%A talks to B
%C talks to D

%DIFS of 40 us + random backoff of [1,3] (slots)
%If channel busy during DIFS, it freezes and waits for it to become idle.
%Decrements counter until it hits zero, freezes when not idle, transmits
%once counter hits zero. If no collision, SIFS of 10 us and then ACK. Then
%DIFS again and the next transmission starts. If collision, the colliding
%stations choose backoff from [0, 2^k * 4 - 1] where k is number of
%collisions. Calculated upper bound cannot exceeed 1024 slots.