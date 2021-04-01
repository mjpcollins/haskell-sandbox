from compare import check_unconstrained


if __name__ == '__main__':
    constraintA = [["BABB", "3DD", ""], ["ABBA", "4DD", "Y"],  ["ABBA", "1AA", ""]]
    constraintB = [["BABB", "3DD", "Y"], ["ABBA", "4DD", ""],  ["ABBA", "1AA", "Y"]]
    constraintC = [["FEKA", "HAA02", ""], ["FEKA", "GII01", "Y"],  ["ZZZD", "BGB", ""],  ["ABBA", "1AA", ""]]
    constraintD = [["FEKA", "HAA02", "Y"], ["FEKA", "GII01", ""],  ["ZZZD", "BGB", "Y"],  ["ABBA", "1AA", "Y"]]
    rule1 = [constraintA, constraintB]
    rule2 = [constraintC, constraintD]
    rules = [rule1, rule2]
    families = ["ABBA", "BABB"]
    features = ["1AA", "3DD"]
    runAmount = 1000000
    for i in range(runAmount):
        check_unconstrained(rules, families, features)
