% Autor: Filip Dyba
% Data: 05.10.2023r.
%
% Skrypt pozwala na wizualizację ruchu manipulatora EDDA poprzez zadanie
% trajektorii w kolejnych przegubach (zmierzonych w symulacji).

%% Wyniki symulacji - do samodzielnego uzupełnienia
% Pozycje przegubowe w kolejnych złączach
q1 = out.q(:,1);
q2 = out.q(:,2);
% Wektor czasu
t = out.tout;

%% Parametry animacji
animationStep = 1e-2; %Krok czasowy

% Zdefiniuj nowy wykres
fh = figure('Name', 'Animation EDDA');

%% Inicjalizajca animacji
EDDA = kinematykaProstaEDDA(q1(1),q2(1));
rysujManipulator(EDDA);
iter = 0;
%% Animacja
while iter <= t(end)
    idx = find(t <= iter);
    i = idx(end);
    iter = iter+animationStep; %Przesuń krok
    clf; %Wyczyść wykres
    
    EDDA = kinematykaProstaEDDA(q1(i),q2(i));
    rysujManipulator(EDDA);

    hold off;
    drawnow;
end

%% Konfiguracja końcowa
EDDA = kinematykaProstaEDDA(q1(end),q2(end));
rysujManipulator(EDDA);

%% Definicje funkcji pomocniczych
% Funkcja zwracająca macierze transformacji do kolejnych układów lokalnych 
% związanych z ogniwami manipulatora
function [EDDA] = kinematykaProstaEDDA(q1,q2)
l1 = 0.3;
l2 = 0.58;

c1 = cos(q1);
s1 = sin(q1);
c2 = cos(q2);
s2 = sin(q2);

% Macierz tranformująca układ bazy do 1. ogniwa
EDDA.A01 = [c1, -s1, 0, l1*c1;
            s1,  c1, 0, l1*s1;
            0, 0, 1, 0;
            0, 0, 0, 1];

% Macierz tranformująca układ 1. ogniwa do 2. ogniwa
EDDA.A12 = [c2, -s2, 0, l2*c2;
            s2, c2, 0, l2*s2;
            0, 0, 1, 0;
            0, 0, 0, 1];
        
% Macierz transformacji z układu bazy do 2. ogniwa
EDDA.A02 = EDDA.A01*EDDA.A12;
end

% Funkcja pozwalająca na prostą wizualizację manipulatora EDDA dla
% konkretnej konfiguracji 
function [] = rysujManipulator(EDDA)
    % Stwórz pusty rysunek
    p = plot(0,0);
    
    hold on; grid on;
    
   % Rysuj ogniwa
   % Pierwsze ogniwo
   linkStart = [0 0];
   linkEnd = EDDA.A01(1:3,4);
   plot([linkStart(1) linkEnd(1)], ...
        [linkStart(2) linkEnd(2)], ...
         'Color', 'blue', 'LineWidth', 2);
   
   % Zaznacz przeguby 
   plot(0,0,'ko');
   plot(linkEnd(1),linkEnd(2),'ko');
     
   % Drugie ogniwo
   linkStart = EDDA.A01(1:3,4);
   linkEnd = EDDA.A02(1:3,4);
   plot([linkStart(1) linkEnd(1)], ...
        [linkStart(2) linkEnd(2)], ...
         'Color', 'red', 'LineWidth', 2);
     
    xlim([-1 1]);
    ylim([-1 1]);
    xlabel('X');
    ylabel('Y');
end