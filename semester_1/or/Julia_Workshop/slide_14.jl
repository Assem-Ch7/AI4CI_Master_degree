using JuMP;
using GLPK;

m = Model(GLPK.Optimizer);

@variable(m, x12, Bin);
@variable(m, x13, Bin);
@variable(m, x23, Bin);
@variable(m, x34, Bin);

@objective(m, Min, 5x12 + 4x13+ 2x23 + 3x34);

@constraint(m, x12 + x13 == 1);
@constraint(m, x34 == 1);
@constraint(m, x12 == x23);
@constraint(m, x13 + x23 == x34);
@constraint(m , x12 +x23+ x34 + x13 <= 2); # max 2 hops

optimize!(m);

println("Obj : ", objective_value(m));
println("x12 : ", value(x12));
println("x13 : ", value(x13));
println("x23 : ", value(x23));
println("x34 : ", value(x34));
