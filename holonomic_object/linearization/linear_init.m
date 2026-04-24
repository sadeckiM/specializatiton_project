theta1=3.1; theta2=9.5; theta3=0.24; theta4=0.77;
g=9.81; l1=0.3; l2=0.58; A=7; B=8; C=1; D=7;

Kp_val = [0, 10, 1000, 1000, 30];
Kd_val = [0, 1000, 10, 1000, 20];

figure('Name', 'Analiza wpływu nastaw regulatora', 'Color', 'white');

for i = 1:5
    Kp11 = Kp_val(i);
    Kd11 = Kd_val(i);
    Kp = [Kp11 0; 0 Kp11]; 
    Kd = [Kd11 0; 0 Kd11];
    
    simOut = sim("linear.slx");
    
    t = simOut.data.Time;
    
    e_all = squeeze(simOut.data.Data); 
    
    if size(e_all, 1) == 2
        e_all = e_all'; 
    end
    
    e1 = e_all(:,1);
    e2 = e_all(:,2);
    
    subplot(3, 2, i);
    plot(t, e1, 'g', 'LineWidth', 1.2);
    hold on;
    plot(t, e2, 'b', 'LineWidth', 1.2);
    grid on;
    
    if i > 2
        ylim([-2e-10, 2e-10]);
    end
    title(['$K_p=', num2str(Kp11), ', K_d=', num2str(Kd11), '$'], 'Interpreter', 'latex');
    ylabel('$\dot{e}_1, \dot{e}_2$', 'Interpreter', 'latex', 'FontSize', 12);
    
    if i >= 4
        xlabel('Czas [s]');
    end
end
legend({'$\dot{e}_1$', '$\dot{e}_2$'}, 'Interpreter', 'latex', 'Location', 'best');