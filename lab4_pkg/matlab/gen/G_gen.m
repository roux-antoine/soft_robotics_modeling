function G = G_gen(q)
%G_GEN
%    G = G_GEN(Q)

%    This function was generated by the Symbolic Math Toolbox version 8.1.
%    02-May-2019 17:08:03

t2 = q+1.0e-4;
G = sin(q.*(1.0./2.0)+5.0e-5).*(-1.03005e-2)+(cos(t2).*4.1202e4)./(q.*2.0e6+2.0e2)-sin(t2).*1.0./(q.*1.0e4+1.0).^2.*2.0601e6;
