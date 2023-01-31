Sets
i /Aqua_Spa, Hydro_Lux/
j /Pumps, Labor, Tubing/;
Parameters
Unit_Profit(i)
/ Aqua_Spa  350
  Hydro_Lux 300 /
Resource_Limit(j)
/ Pumps  200
  Labor  1566
  Tubing 2880/
;
Table  Resource_Consumption(j,i)
         Aqua_Spa        Hydro_Lux
Pumps       1                 1
Labor       9                 6
Tubing      12                16
;
Positive Variables  X(i);
Variable Z;
Equations
Objective_fn
Constraints
;
Objective_fn.. z =e= sum(i, Unit_Profit(i)*X(i));
Constraints(j).. sum(i, Resource_Consumption(j,i)*X(i)) =l= Resource_Limit(j) ;

Model Product_Mix_Hot_Tubs /all/;
Solve Product_Mix_Hot_Tubs using lp maximizing z;
Display X.L, Z.L;