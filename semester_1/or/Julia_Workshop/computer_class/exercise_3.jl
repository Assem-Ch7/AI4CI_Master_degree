using JuMP;
using GLPK;

model = Model(GLPK.Optimizer);

@variable(model, x12, Bin);
@variable(model, x13, Bin);
@variable(model, x23, Bin);

@objective(model, Min, 5x12 + 4x13 + 3x23);

@constraint(model, x12 + x13 >= 1);
@constraint(model, x12 + x23 >= 1);
@constraint(model, x13 + x23 >= 1);

println("---Solving---");
optimize!(model);

println("Obj : ", objective_value(model));
println("x12 : ", value(x12));
println("x13 : ", value(x13));
println("x23 : ", value(x23));
println("--------------");
