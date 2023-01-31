Sets
t shows beginning of year /1,2,3,4,5/
i investment options / A,B,C,D,E/
;
Scalars
Initial_amount_to_invest        /100000/
Maximum_per_investment          /75000 /
Interest_rate_on_cash           /0.03  /
;
Table
cash_outlays(t,i)
           A         B            C           D            E
1        1.00        0.00        1.00        0.00        0.00
2        0.00        1.00        0.00        0.00        0.00
3        0.00        0.00        0.00        0.00        1.00
4        0.00        0.00        0.00        1.00        0.00
;
Table
cash_returns(t,i)
            A         B           C           D            E
1        0.00        0.00        0.00        0.00        0.00
2        0.50        0.00        1.20        0.00        0.00
3        1.00        0.50        0.00        0.00        0.00
4        0.00        1.00        0.00        0.00        1.50
5        0.00        0.00        0.00        1.90        0.00
;
Positive variable
X(i)
CB(t) cash at the beginning of t BEFORE transactions
CA(t) cash at the beginning of t AFTER transactions;
variable Z;
Equations
obj_fn
money_dynamics1
money_dynamics2
money_dynamics3
diversity
;
obj_fn.. Z =E= CA("5") ;
money_dynamics1(t).. CA(t) =E= CB(t) + sum(i, cash_returns(t,i)*X(i))
                                    - sum(i, cash_outlays(t,i)*X(i));
money_dynamics2(t)$(ORD(t) GE 2).. CB(t) =E= CA(t-1)*(1+Interest_rate_on_cash);
money_dynamics3.. CB("1") =E= Initial_amount_to_invest ;
diversity(i).. X(i) =L= Maximum_per_investment ;

Model investment_planning / all / ;
Solve investment_planning using LP maximizing Z;
Display
X.L
CB.L
CA.L
Z.L;


