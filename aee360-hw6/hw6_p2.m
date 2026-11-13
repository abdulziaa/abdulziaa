% AEE 360 HW6 Problem 2: Daedalus 88
m = 104; S = 30; rho = 1.225; U = 8.33; g = 9.81; W = m*g;
q  = 0.5*rho*U^2;  CL = W/(q*S);              % cruise lift coefficient (~0.80)
CDi_polar = 0.0070;                            % read from the given polar at CL = 0.80 (approximate)
AR_ell = CL^2/(pi*CDi_polar);  b_ell = sqrt(AR_ell*S);       % (a) elliptical loading
b = 34; AR = b^2/S;  e = CL^2/(pi*AR*CDi_polar);             % (b)
a0 = 2*pi;  a = a0/(1+a0/(pi*e*AR));  alpha = CL/a*180/pi + (-5);   % (c) geometric AoA, deg
Di = q*S*CDi_polar;                                            % (d)
CLmax = 1.1;  Vmin = sqrt(2*W/(rho*S*CLmax));                  % (e)
CDi_e = 0.0120;                                                % polar at CL = 1.1 (approximate)
Di_e = 0.5*rho*Vmin^2*S*CDi_e;
fprintf('CL=%.3f  AR_ell=%.1f b_ell=%.1f m  AR=%.1f e=%.3f\n',CL,AR_ell,b_ell,AR,e);
fprintf('alpha=%.2f deg  Di=%.2f N  Pind=%.1f W\n',alpha,Di,Di*U);
fprintf('Vmin=%.2f m/s  Di=%.2f N  Pind=%.1f W\n',Vmin,Di_e,Di_e*Vmin);
