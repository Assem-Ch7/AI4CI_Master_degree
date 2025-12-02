 using JuMP;
 using GLPK; #or "using Cbc"
 m=Model(GLPK.Optimizer); #or "Cbc.Optimizer"
 # Define the variables
 @variable(m, x>=0, Int);
 @variable(m, y>=0);
 # Define the objective function
 @objective(m, Max, 6x+y);
 # Define the constraints
 @constraint(m, 4x+y<=28);
 @constraint(m, 6x+(5/2)y<=37);
 #Run the solver
 optimize!(m);
 # Output
 println(objective_value(m)) # optimal obj
 println("x= " , value.(x) , # optimal x
 "\n" ,
 "y= " , value.(y))
