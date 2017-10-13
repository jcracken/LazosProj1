%A1 lambda a = lambda c
A1_50 = A1(50, 1);
A1_100 = A1(100, 1);
A1_200 = A1(200, 1);
A1_300 = A1(300, 1);

%A1 lambda a = 2*lambda c
A1_50_2 = A1(50, 2);
A1_100_2 = A1(100, 2);
A1_200_2 = A1(200, 2);
A1_300_2 = A1(300, 2);

%B1 lambda a = lambda c
B1_50 = B1(50, 1);
B1_100 = B1(100, 1);
B1_200 = B1(200, 1);
B1_300 = B1(300, 1);

%B1 lambda a = 2*lambda c
B1_50_2 = B1(50, 2);
B1_100_2 = B1(100, 2);
B1_200_2 = B1(200, 2);
B1_300_2 = B1(300, 2);

%A2 lambda a = lambda c
A2_50 = A2(50, 1);
A2_100 = A2(100, 1);
A2_200 = A2(200, 1);
A2_300 = A2(300, 1);

%A2 lambda a = 2*lambda c
A2_50_2 = A2(50, 2);
A2_100_2 = A2(100, 2);
A2_200_2 = A2(200, 2);
A2_300_2 = A2(300, 2);

%B2 lambda a = lambda c
B2_50 = B2(50, 1);
B2_100 = B2(100, 1);
B2_200 = B2(200, 1);
B2_300 = B2(300, 1);

%B2 lambda a = 2*lambda c
B2_50_2 = B2(50, 2);
B2_100_2 = B2(100, 2);
B2_200_2 = B2(200, 2);
B2_300_2 = B2(300, 2);

%Universal Graph Vars:
lambda = [50, 100, 200, 300];

%Graph 1a vars:
g1A_line1 = [A1_50(1), A1_100(1), A1_200(1), A1_300(1)];
g1A_line2 = [A2_50(1), A2_100(1), A2_200(1), A2_300(1)];
g1A_line3 = [B1_50(1), B1_100(1), B1_200(1), B1_300(1)];
g1A_line4 = [B2_50(1), B2_100(1), B2_200(1), B2_300(1)];

%Graph 1b vars:
g1B_line1 = [A1_50(2), A1_100(2), A1_200(2), A1_300(2)];
g1B_line2 = [A2_50(2), A2_100(2), A2_200(2), A2_300(2)];
g1B_line3 = [B1_50(2), B1_100(2), B1_200(2), B1_300(2)];
g1B_line4 = [B2_50(2), B2_100(2), B2_200(2), B2_300(2)];

%Graph 1c vars:
g1C_line1 = [A1_50_2(1), A1_100_2(1), A1_200_2(1), A1_300_2(1)];
g1C_line2 = [A2_50_2(1), A2_100_2(1), A2_200_2(1), A2_300_2(1)];
g1C_line3 = [B1_50_2(1), B1_100_2(1), B1_200_2(1), B1_300_2(1)];
g1C_line4 = [B2_50_2(1), B2_100_2(1), B2_200_2(1), B2_300_2(1)];

%Graph 1d vars:
g1D_line1 = [A1_50_2(2), A1_100_2(2), A1_200_2(2), A1_300_2(2)];
g1D_line2 = [A2_50_2(2), A2_100_2(2), A2_200_2(2), A2_300_2(2)];
g1D_line3 = [B1_50_2(2), B1_100_2(2), B1_200_2(2), B1_300_2(2)];
g1D_line4 = [B2_50_2(2), B2_100_2(2), B2_200_2(2), B2_300_2(2)];

%Graph 2a vars:
g2A_line1 = [A1_50(3), A1_100(3), A1_200(3), A1_300(3)];
g2A_line2 = [A2_50(3), A2_100(3), A2_200(3), A2_300(3)];
g2A_line3 = [B1_50(3), B1_100(3), B1_200(3), B1_300(3)];
g2A_line4 = [B2_50(3), B2_100(3), B2_200(3), B2_300(3)];

%Graph 2b vars:
g2B_line1 = [A1_50(3), A1_100(3), A1_200(3), A1_300(3)];
g2B_line2 = [A2_50(3), A2_100(3), A2_200(3), A2_300(3)];
g2B_line3 = [B1_50(3), B1_100(3), B1_200(3), B1_300(3)];
g2B_line4 = [B2_50(3), B2_100(3), B2_200(3), B2_300(3)];

%Graph 2c vars:
g2C_line1 = [A1_50_2(3), A1_100_2(3), A1_200_2(3), A1_300_2(3)];
g2C_line2 = [A2_50_2(3), A2_100_2(3), A2_200_2(3), A2_300_2(3)];
g2C_line3 = [B1_50_2(3), B1_100_2(3), B1_200_2(3), B1_300_2(3)];
g2C_line4 = [B2_50_2(3), B2_100_2(3), B2_200_2(3), B2_300_2(3)];

%Graph 2d vars:
g2D_line1 = [A1_50_2(3), A1_100_2(3), A1_200_2(3), A1_300_2(3)];
g2D_line2 = [A2_50_2(3), A2_100_2(3), A2_200_2(3), A2_300_2(3)];
g2D_line3 = [B1_50_2(3), B1_100_2(3), B1_200_2(3), B1_300_2(3)];
g2D_line4 = [B2_50_2(3), B2_100_2(3), B2_200_2(3), B2_300_2(3)];

%Graph 3a vars:
g3A_line1 = [A1_50(4), A1_100(4), A1_200(4), A1_300(4)];
g3A_line2 = [A2_50(4), A2_100(4), A2_200(4), A2_300(4)];
g3A_line3 = [B1_50(4), B1_100(4), B1_200(4), B1_300(4)];
g3A_line4 = [B2_50(4), B2_100(4), B2_200(4), B2_300(4)];

%Graph 3b vars:
g3B_line1 = [A1_50_2(4), A1_100_2(4), A1_200_2(4), A1_300_2(4)];
g3B_line2 = [A2_50_2(4), A2_100_2(4), A2_200_2(4), A2_300_2(4)];
g3B_line3 = [B1_50_2(4), B1_100_2(4), B1_200_2(4), B1_300_2(4)];
g3B_line4 = [B2_50_2(4), B2_100_2(4), B2_200_2(4), B2_300_2(4)];

%graphing, only doing one of the above at a time
% To change which graph you're using, change plot variables(keep the lambda), and then
% change the title.
close all;
set(0,'defaulttextinterpreter','latex'); % allows you to use latex math
set(0,'defaultlinelinewidth',2); % line width is set to 2

set(0,'DefaultTextFontSize', 8); % Font size is set to 16
set(0,'DefaultAxesFontSize',10); % font size for the axes is set to 16

figure(1)
plot(lambda, g3B_line1, 'b', lambda, g3B_line2, 'r', lambda, g3B_line3, 'g', lambda, g3B_line4, 'm');
grid on; % grid lines on the plot
title('Fairness Index vs. Frame Rate lambda(a) = 2*lambda(c)');
legend('CSMA/CA Parallel Comms.', 'CSMA/CA w/ VCS Parallel Comms.', 'CSMA/CA Hidden Terminals', 'CSMA/CA w/ VCS Hidden Terminals', 'Location', 'northwest');
legend('boxoff');
ylabel('$Fairness Index$');
xlabel('$lambda$ (frames/sec)');