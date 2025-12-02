using JuMP;
using GLPK;

m = Model(GLPK.Optimizer);

@variable(m, x1 >= 0, Int);
@variable(m, x2 >= 0, Int);
@variable(m, x3 >= 0, Int);
@variable(m, x4 >= 0, Int);
@variable(m, x5 >= 0, Int);

@objective(m, Max, x1 + 2x2 + 2x3 + 10x4 + 9x5)

@constraint(m, x1 + x2 + 2x3 + 5x4 + 7x5 <= 9);
@constraint(m, x1<= 1);
@constraint(m, x2<= 1);
@constraint(m, x3<= 1);
@constraint(m, x4<= 1);
@constraint(m, x5<= 1);
optimize!(m);
println("MAX:", objective_value(m));
println("X1 :", value.(x1));
println("X2 :", value.(x2));
println("X3 :", value.(x3));
println("X4 :", value.(x4));
println("X5 :", value.(x5));
