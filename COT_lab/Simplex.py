import numpy as np
import math

def to_tableau(c, A, b):
    # Add slack variables to constraints
    num_constraints = len(A)
    num_variables = len(c)
    
    # Create the tableau for the Simplex method
    tableau = np.zeros((num_constraints + 1, num_variables + num_constraints + 1))
    
    # Fill in the constraint coefficients and RHS
    for i in range(num_constraints):
        tableau[i, :num_variables] = A[i]
        tableau[i, num_variables + i] = 1  # Slack variable
        tableau[i, -1] = b[i]
    
    # Fill in the objective function
    tableau[-1, :num_variables] = -np.array(c)  # Maximize Z: coefficients are negated
    return tableau

def can_be_improved(tableau):
    # Check if there are negative values in the objective function row
    return any(x < 0 for x in tableau[-1, :-1])

def get_pivot_position(tableau):
    # Find the entering variable (most negative coefficient in the objective function row)
    z = tableau[-1]
    column = next(i for i, x in enumerate(z[:-1]) if x < 0)

    # Find the exiting variable (minimum ratio test)
    restrictions = []
    for eq in tableau[:-1]:
        el = eq[column]
        restrictions.append(math.inf if el <= 0 else eq[-1] / el)

    row = restrictions.index(min(restrictions))
    return row, column

def pivot_step(tableau, pivot_position):
    new_tableau = np.copy(tableau)

    i, j = pivot_position
    pivot_value = tableau[i, j]
    new_tableau[i] = tableau[i] / pivot_value

    for eq_i, eq in enumerate(tableau):
        if eq_i != i:
            multiplier = new_tableau[i] * tableau[eq_i, j]
            new_tableau[eq_i] = tableau[eq_i] - multiplier

    return new_tableau

def is_basic(column):
    return sum(column) == 1 and len([c for c in column if c == 0]) == len(column) - 1

def get_solution(tableau):
    columns = np.array(tableau).T
    solutions = []
    for column in columns[:-1]:
        solution = 0
        if is_basic(column):
            one_index = column.tolist().index(1)
            solution = columns[-1][one_index]
        solutions.append(solution)

    return solutions

def simplex(c, A, b):
    tableau = to_tableau(c, A, b)

    while can_be_improved(tableau):
        pivot_position = get_pivot_position(tableau)
        tableau = pivot_step(tableau, pivot_position)

    return get_solution(tableau)

# Problem definition
# Objective function coefficients
Z = [6, 5, 4]

# Constraints coefficients
constr = [
    [2, 1, 1],
    [1, 3, 2],
    [2, 1, 2]
]

# Right-hand side values
rhs = [240, 360, 300]

# Solve the problem
sol = simplex(Z, constr, rhs)
print("Optimal Solution:", sol)

# Calculating the optimal value of Z
optimal_value = Z @ np.array(sol)
print("Optimal value of Z:", optimal_value)
