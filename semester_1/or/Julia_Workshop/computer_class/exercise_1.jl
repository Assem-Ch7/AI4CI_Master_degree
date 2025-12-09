using JuMP;
using GLPK;

m = Model(GLPK.Optimizer);

@variable(m, x >= 0, Int);
@variable(m, y >= 0, Int);

@objective(m, Max, 10x + 6y);

@constraint(m, 4x + 2y <= 40);
@constraint(m, 2x + y  <= 18);

println("---Solving---");
optimize!(m);

println("Obj : ", objective_value(m));
 println("x = " , value.(x) ,
 "\n" ,
 "y = " , value.(y));
 println("------------");
