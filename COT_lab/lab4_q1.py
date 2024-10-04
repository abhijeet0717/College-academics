##### Q1
import numpy as np
from scipy.optimize import linprog

# Coefficients of the objective function
c = [-3, -12]  # Note: linprog minimizes, so we use the negative of the coefficients

# Coefficients of the inequalities
A = [[2, 4],
     [5, 3]]

# Right-hand side of the inequalities
b = [7, 15]

# Bounds for x1 and x2
x_bounds = (0, None)  # x1 >= 0, x2 >= 0

# Solve using Simplex method
res = linprog(c, A_ub=A, b_ub=b, bounds=[x_bounds, x_bounds], method='highs')

# Get the solution
if res.success:
    x1, x2 = res.x
    z = -res.fun  # Recall we minimized the negative of the objective function
    print(f"Optimal solution (Simplex): x1 = {x1}, x2 = {x2}, z = {z}")
else:
    print("No solution found using Simplex.")

# Function to perform Gomory's cutting plane method
def gomory_cutting(A, b, c, solution):
    cuts = []
    for i in range(len(solution)):
        if not solution[i].is_integer():
            # Create the Gomory cut
            fractional_part = solution[i] - int(solution[i])
            cut = np.zeros(len(solution))
            for j in range(len(solution)):
                if A[j][i] != 0:
                    cut[j] = A[j][i] - (int(solution[j]) * fractional_part)
            cuts.append(cut
    
    return cuts

# Get integer solutions (if needed, modify the above res.x to round)
integer_solution = np.round(res.x).astype(int)

# Check if the solution is already integer
if np.all(np.floor(integer_solution) == integer_solution):
    print(f"Integer solution found: x1 = {integer_solution[0]}, x2 = {integer_solution[1]}")
else:
    print("Gomory cuts needed:")
    cuts = gomory_cutting(A, b, c, res.x)
    for cut in cuts:
        print(f"Cut: {cut}")

    # Here you would implement the cutting plane method further
