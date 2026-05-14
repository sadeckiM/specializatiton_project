% Autor: Filip Dyba
% Data:  8.11.2022r.
% Skrypt pozwala wykreślić paraboloidę obrotową dla funkcji Lapunova
% V(e1,e2), przebieg trajektorii dla badanego przypadku, a także wartości
% pochodnej funkcji Lapunova.
%
% Funkcję
%                   V(e1,e2) = V(e) = 1/2*e^T*e
% wykorzystujemy, aby pokazać, że system
%                           M*eta = B*u
% w pętli sprzężenia zwrotnego ze sterowaniem
%                   u = inv(B)*M*(deta_ref-Kd*e),
% gdzie e = eta - eta_ref, gwarantuje asymptotyczną zbieżność błędów 
% śledzenia profili prędkościowych do zerowego punktu równowagi.
% Pochodna funkcji Lapunova sprowadza się do postaci
%                   dV(e1,e2) = dV(e) = -kd*e1^2 - kd*e2^2.
%
% Aktualizacja: 29.11.2023r. - dodane wykresy funkcji Lapunova i pochodnej
% dV od czasu


%% Wartości wynikające z przeprowadzonego eksperymentu - sekcja do uzupełnienia
% Wektory błędów śledzenia profili prędkościowych
m_e1 = out.e_eta1;
m_e2 = out.e_eta2;
% Nastawa sterownika dynamicznego
m_kd = kd;
% Czas
m_t = out.tout;

%% Parametry dla powierzchni funkcji Lapunova
maxVal1 = floor(max(abs(m_e1)))+1;
maxVal2 = floor(max(abs(m_e2)))+1;

[e1, e2] = meshgrid(-maxVal1:0.5:maxVal1,-maxVal2:0.5:maxVal2);

%% Funkcja Lapunova
V = @(e1,e2) 1/2*(e1.^2 + e2.^2);

%% Wykreślanie funkcji Lapunova: powierzchnia + wartości funkcji
figure;
hold on; grid on;
surf(e1,e2,V(e1,e2),'FaceColor','none');
plot3(m_e1,m_e2,V(m_e1,m_e2),'r','LineWidth',2.5);
xlabel('e_1');
ylabel('e_2');
zlabel('$V(e_1,e_2)$','Interpreter','latex','FontSize',17);
title('Funkcja Lapunova')
view(3);
hold off;

%% Funkcja Lapunova w zależności od czasu V(t)
figure;
hold on; grid on;
plot(m_t,V(m_e1,m_e2)','LineWidth',2);
ylabel('$V(t)$','Interpreter','latex','FontSize',17);
xlabel('t [s]');
title('Funkcja Lapunova w czasie');
hold off;

%% Pochodna funkcji Lapunova
dV = @(e1,e2) -kd*e1.^2-kd*e2.^2;

figure;
hold on; grid on;
plot3(m_e1,m_e2,dV(m_e1,m_e2),'LineWidth',1.5);
xlabel('e_1');
ylabel('e_2');
zlabel('$\dot{V}(e_1,e_2)$','Interpreter','latex','FontSize',17);
view(3);
title('Przebieg pochodnej funkcji Lapunova');
hold off;

%% Pochodna funkcji Lapunova w zależności od czasu dV(t)
figure;
hold on; grid on;
plot(m_t,dV(m_e1,m_e2)','LineWidth',2);
ylabel('$\dot{V}(t)$','Interpreter','latex','FontSize',17);
xlabel('t [s]');
title('Pochodna funkcji Lapunova w czasie');
hold off;