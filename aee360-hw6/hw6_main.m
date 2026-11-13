% AEE 360 HW6 Problem 1 driver: runs all cases using llt_fun.m
clear; close all;
N = 200;  alpha = 5;                       % converged N (see convergence check), alpha with CL > 0
% convergence check
for Nc = [20 50 100 200 400]
    [CL,CDi,e] = llt_fun(10,0,0.4,0,Nc,alpha); fprintf('N=%d CL=%.5f CDi=%.6f e=%.5f\n',Nc,CL,CDi,e);
end
% (a) taper sweep
lam = 0.1:0.1:1.0;  r = zeros(size(lam)); eA = r;
for i = 1:numel(lam), [CL,CDi,eA(i)] = llt_fun(10,0,lam(i),0,N,alpha); r(i) = CDi/CL^2; end
figure; plot(lam,r,'o-'); grid on; xlabel('Taper ratio \lambda'); ylabel('C_{D_i}/C_L^2'); title('Induced drag factor vs. taper ratio, AR = 10');
figure; plot(lam,eA,'o-'); grid on; xlabel('Taper ratio \lambda'); ylabel('Oswald efficiency e'); title('Oswald efficiency vs. taper ratio, AR = 10');
lamOpt = 0.4;
% (b) aspect ratio sweep
ARs = [4 6 8 10 15 30];  rB = zeros(size(ARs)); eB = rB;
for i = 1:numel(ARs), [CL,CDi,eB(i)] = llt_fun(ARs(i),0,lamOpt,0,N,alpha); rB(i) = CDi/CL^2; end
figure; plot(ARs,rB,'o-'); grid on; xlabel('AR'); ylabel('C_{D_i}/C_L^2'); title('Induced drag factor vs. AR, \lambda = 0.4');
figure; plot(ARs,eB,'o-'); grid on; xlabel('AR'); ylabel('Oswald efficiency e'); title('Oswald efficiency vs. AR, \lambda = 0.4');
% (c) lift curves
al = 0:12; figure; hold on; slope = zeros(size(ARs));
for i = 1:numel(ARs)
    CLs = arrayfun(@(a) llt_fun(ARs(i),0,lamOpt,0,N,a), al);
    p = polyfit(al,CLs,1); slope(i) = p(1)*180/pi;    % per rad
    plot(al,CLs,'DisplayName',sprintf('AR = %d',ARs(i)));
end
grid on; xlabel('\alpha (deg)'); ylabel('C_L'); legend('Location','best'); title('Lift curves, untwisted, \lambda = 0.4');
fprintf('AR  dCL/dalpha(LLT)  elliptical 2*pi/(1+2/AR)\n');
for i = 1:numel(ARs), fprintf('%2d  %.3f  %.3f\n',ARs(i),slope(i),2*pi/(1+2/ARs(i))); end
% (d) optimal twist
angs = 2:2:10; tw = -12:0.01:0; topt = zeros(size(angs)); CLopt = topt;
for j = 1:numel(angs)
    ee = arrayfun(@(t) nthargout(3,@llt_fun,10,t,1.0,0,N,angs(j)), tw);
    [emax,k] = max(ee); topt(j) = tw(k); CLopt(j) = llt_fun(10,tw(k),1.0,0,N,angs(j));
    fprintf('alpha=%d twist*=%.3f CL=%.3f e=%.5f\n',angs(j),topt(j),CLopt(j),emax);
end
figure; plot(CLopt,topt,'o-'); grid on; xlabel('C_L'); ylabel('Optimal twist (deg)'); title('Optimal linear twist vs. C_L, AR = 10, \lambda = 1');
