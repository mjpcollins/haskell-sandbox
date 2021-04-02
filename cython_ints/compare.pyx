

def check_unconstrained(all_rules, families, features):
    if not all_rules:
        return True
    elif path_through_constraints(all_rules[0], families, features):
        return check_unconstrained(all_rules[1:], families, features)
    else:
        return False


def path_through_constraints(constraints, families, features):
    if not constraints:
        return False
    elif constraint_check(constraints[0], families, features):
        return True
    else:
        return path_through_constraints(constraints[1:], families, features)


def constraint_check(constraint, families, features):
    if not constraint:
        return True
    elif check_this_feature(constraint[0], families, features):
        return constraint_check(constraint[1:], families, features)
    else:
        return False


def check_this_feature(this_feature, families, features):
    if have(this_feature) and family_included(this_feature, families):
        return this_feature[1] in features
    elif (not have(this_feature)) and family_included(this_feature, families):
        return not (this_feature[1] in features)
    else:
        return True


def have(this_feature):
    return bool(this_feature[-1])


def family_included(this_feature, families):
    return this_feature[0] in families
