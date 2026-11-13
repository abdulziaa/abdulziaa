function [CL,CDi,e] = llt_fun(AR,twist_deg,taper,alpha0L_deg,N,alpha_deg)
% Non-interactive version of llt.m (same method, plot removed).
% Inputs: AR, linear geometric twist (deg, negative = washout), taper ratio,
% section zero-lift angle (deg), number of spanwise stations, angle of attack (deg)
twist  = twist_deg*pi/180;  alpha0L = alpha0L_deg*pi/180;  alpha = alpha_deg*pi/180;
index = 1:N;
theta = index.*pi/(N+1);
ybar  = -cos(theta)/2;
alphag = alpha + twist.*abs(2.*ybar);
cbar   = 2/(AR*(1+taper))*(1-2*(1-taper)*abs(ybar));
Matrix = zeros(N,N);  rhs = zeros(N,1);
for n = 1:N
   for m = 1:N
      Matrix(m,n) = 2/(pi*cbar(m))*sin(n*theta(m)) + n*sin(n*theta(m))/sin(theta(m));
   end
   rhs(n,1) = alphag(n) - alpha0L;
end
A  = Matrix\rhs;
CL = A(1)*pi*AR;
delta = 0;
for m = 2:N
   delta = delta + m*A(m)^2/A(1)^2;
end
e   = 1/(1+delta);
CDi = CL^2/(pi*AR*e);
end
