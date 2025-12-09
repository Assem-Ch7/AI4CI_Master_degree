using JuMP;
using GLPK;

m = Model(GLPK.Optimizer);

@variable(m, x >= 0, Int);
@variable(m, y >= 0, Int);
@variable(m, z >= 0, Int);

@objective(m, Max, 10x + 6y - 2z);

@constraint(m, 6x + 3y <= 50 + z)

println("---Solving---");
optimize!(m);

println("Obj : ", objective_value(m));
 println("x = " , value.(x) ,
 "\n" ,
 "y = " , value.(y) ,
 "\n" ,
 "z = " , value.(z));
 println("------------");
