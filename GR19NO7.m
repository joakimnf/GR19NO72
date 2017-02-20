% Gruppe nummer 19, TMT4210, Runar Kyllingstad og Joakim Fredrikstad

% Innledende konstanter:
K_0 = 1e10;         % [mikrometer^2/s] Kinetisk konstant
Q = 221000;         % [J/mol] Aktiveringsenergien for kornvekst
R = 8.314;          % [J/Kmol] Gasskonstanten
n = 0.5;            % Tidseksponenten
svar = 1;
D_0 = 20;           % [mikrometer]


% sporsmal = 'Hva skal den isoterme temperaturen [°K] og tiden være og hva skal avkjølingsraten og';
% [T_iso t_iso CR HR_min HR_max] = str2double(inputdlg(' Hva skal den isoterme temperaturen[°K] og tiden'));

while svar == 1
    %Får bruker til å gi verdier for t, T, C.R og H.R. 
    T_iso = input('Hva er den isoterme temperaturen i Kelvin? ');
    t_iso = input('Hva er den isoterme tiden i sekunder? ');
    CR = input('Hva er avkjølingshastigheten i K/s? ');
    HR_min = input('Hva er nedre grense for H.R i K/s? ');
    HR_max = input('Hva er øvre grense for H.R i K/s? ');
    HR = linspace(HR_min,HR_max);           % Varrierer H.R i hundre trinn
    
    D_n = zeros(1, 100);
    
    for i = 1:100
        D_n(i) = D_0^(1/n);                         % [mikrometer], Setter D = D0 ???
        delta_t = (T_iso - T(1))/(100*HR(i));
        T(1) = 298;                                 % [°K], Setter T = romtemperatur
        % Oppvarming
        for j = 1:99 % integral nr 1, ledd 2
            D_n(i) = D_n(i) + K_0*exp(-Q/(R*T(j)))*delta_t;
            T(j+1) = T(j) + HR(i)*delta_t;
        end

        % Isoterm temp, ledd 3
        D_n(i) = D_n(i) + K_0*exp(-Q/(R*T_iso))*t_iso;

        % Nedkjøling  
        delta_t = (T_iso - T(1))/(100*CR);
        T(1) = T_iso;
        for j = 1:99 % integral 2, ledd 4

            D_n(i) = D_n(i) + K_0*exp(-Q/(R*T(j)))*delta_t;
            T(j+1) = T(j) - CR*delta_t;
        end    
    end
D = (D_n).^n;
plot(HR,D);
svar = menu('Vil du kjøre funksjonen på ny? ', 'Ja', 'Nei');
end
