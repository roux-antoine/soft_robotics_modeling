function dynamics2 = dynamics2_gen(q,dq,C1,C2,D,Tau)
%DYNAMICS2_GEN
%    DYNAMICS2 = DYNAMICS2_GEN(Q,DQ,C1,C2,D,TAU)

%    This function was generated by the Symbolic Math Toolbox version 8.3.
%    02-May-2019 20:48:14

t2 = sin(q);
t4 = q./2.0;
t6 = q.*1.0e+4;
t8 = q+1.0e-4;
t3 = 1.0./t2;
t7 = t6+1.0;
t9 = cos(t8);
t10 = sin(t8);
t14 = t4+5.0e-5;
t5 = q.*t3;
t11 = 1.0./t7;
t15 = t9./2.0;
t16 = cos(t14);
t17 = sin(t14);
t12 = t11.^2;
t13 = t11.^3;
t18 = t15-1.0./2.0;
t19 = t17.*(2.1e+1./1.0e+3);
t20 = t16.*(2.1e+1./1.0e+3);
t21 = t9.*t11.*4.2e+2;
t22 = t10.*t11.*4.2e+2;
t23 = -t21;
t24 = t10.*t12.*4.2e+6;
t25 = t12.*t18.*8.4e+6;
t26 = t19+t23+t24;
t29 = t20+t22+t25;
t27 = t26.^2;
t30 = t29.^2;
t28 = t27./2.0e+1;
t31 = t30./2.0e+1;
t32 = t28+t31;
t33 = 1.0./t32;
dynamics2 = [dq;Tau.*t33+t33.*(t17.*1.03005e-2+t10.*t12.*2.0601e+6-(t9.*4.1202e+4)./(q.*2.0e+6+2.0e+2)-(1.0./t5.^2.*(t5.^4-1.0).*(C1.*2.0+C2.*(t5-t2./q).^2.*4.0))./(t3.*(t5-1.0)))-dq.*t33.*(D-dq.*((t29.*(t17.*1.05e-2+t23+t10.*t12.*8.4e+6+t13.*t18.*1.68e+11))./2.0e+1-(t26.*(t16.*1.05e-2+t22+t9.*t12.*8.4e+6-t10.*t13.*8.4e+10))./2.0e+1))];
