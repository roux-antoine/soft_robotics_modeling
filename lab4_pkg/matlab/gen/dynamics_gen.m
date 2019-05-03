function dynamics = dynamics_gen(q,dq,K,D,Tau)
%DYNAMICS_GEN
%    DYNAMICS = DYNAMICS_GEN(Q,DQ,K,D,TAU)

%    This function was generated by the Symbolic Math Toolbox version 8.1.
%    02-May-2019 17:08:04

t2 = q+1.0e-4;
t3 = q.*1.0e4;
t4 = t3+1.0;
t6 = q.*(1.0./2.0);
t7 = t6+5.0e-5;
t8 = sin(t2);
t9 = 1.0./t4;
t10 = 1.0./t4.^2;
t11 = cos(t2);
t13 = sin(t7);
t14 = t13.*(2.1e1./1.0e3);
t15 = t9.*t11.*4.2e2;
t16 = t8.*t10.*4.2e6;
t5 = t14-t15+t16;
t19 = cos(t7);
t20 = t19.*(2.1e1./1.0e3);
t21 = t8.*t9.*4.2e2;
t22 = t11.*(1.0./2.0);
t23 = t22-1.0./2.0;
t24 = t10.*t23.*8.4e6;
t12 = t20+t21+t24;
t17 = t5.^2;
t18 = t17.*(1.0./2.0e1);
t25 = t12.^2;
t26 = t25.*(1.0./2.0e1);
t27 = t18+t26;
t28 = 1.0./t27;
t29 = 1.0./t4.^3;
dynamics = [dq;Tau.*t28+t28.*(t13.*1.03005e-2-K.*q+t8.*t10.*2.0601e6-(t11.*4.1202e4)./(q.*2.0e6+2.0e2))-dq.*t28.*(D-dq.*(t12.*(t13.*1.05e-2-t15+t8.*t10.*8.4e6+t23.*t29.*1.68e11).*(1.0./2.0e1)-t5.*(t19.*1.05e-2+t21+t10.*t11.*8.4e6-t8.*t29.*8.4e10).*(1.0./2.0e1)))];
