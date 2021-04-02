from compare import check_unconstrained


if __name__ == '__main__':
    constraintA = [[0, 1, 0], [1, 0, 1],  [1, 2, 0]]
    constraintB = [[0, 1, 1], [1, 0, 0],  [1, 2, 1]]
    constraintC = [[2, 3, 0], [2, 4, 1],  [3, 5, 0],  [1, 2, 0]]
    constraintD = [[2, 3, 1], [2, 4, 0],  [3, 5, 1],  [1, 2, 1]]
    rule1 = [constraintA, constraintB]
    rule2 = [constraintC, constraintD]
    rules = [rule1, rule2]
    families = [1, 0]
    features = [2, 1]
    runAmount = 1000000
    for i in range(runAmount):
        check_unconstrained(rules, families, features)