using JuMP;
using GLPK;

m = Model(GLPK.Optimizer);

n = 5;
price = [9, 2, 10, 2, 5];
weights = [7, 1, 5, 2, 1];
@variable(m, x[1:n], Bin);

@objective(m, Max, sum(price[i] * x[i] for i in 1:n));

@constraint(m , sum(weights[i] * x[i] for i in 1:n) <= 9);

optimize!(m);
println("MAX:", objective_value(m));
println("x = ", value.(x));
