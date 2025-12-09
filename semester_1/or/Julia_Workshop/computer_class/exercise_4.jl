using JuMP;
using GLPK;

model = Model(GLPK.Optimizer);

n = 4;
capacity = [5, 4, 3, 2];
cost     = [2, 3, 1, 4];

@variable(model , x[1:n], Bin);

@objective(model, Min, sum(cost[i] * x[i] for i in 1:n));

@constraint(model, sum(capacity[i] * x[i] for i in 1:n) >= 10);


println("---Solving---");
optimize!(model);

println("Obj : ", objective_value(model));
println("X : ", value.(x));
