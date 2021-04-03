fn main() {
    let features: &[u16] = &[1, 2];
    let families: &[u16] = &[0, 1];
    let constraint_a: &[[u16; 3]] = &[[0, 1, 0], [1, 0, 1], [1, 2, 0]];
    let constraint_b: &[[u16; 3]] = &[[0, 1, 1], [1, 0, 1], [1, 2, 0]];
    let constraint_c: &[[u16; 3]] = &[[2, 3, 0], [2, 4, 1],  [3, 5, 0],  [1, 2, 0]];
    let constraint_d: &[[u16; 3]] = &[[2, 3, 1], [2, 4, 0],  [3, 5, 1],  [1, 2, 1]];
    let rule1: &[&[[u16; 3]]] = &[constraint_a, constraint_b];
    let rule2: &[&[[u16; 3]]] = &[constraint_c, constraint_d];
    let all_rules: &[&[&[[u16; 3]]]] = &[rule1, rule2];
    let loops: u32 = 1000000;
    let mut counter: u32 = 0;
    for _i in 0..loops {
        if check_unconstrained(all_rules, families, features) {
            counter = counter + 1;
        }
    }
    println!("{}", counter)

}

fn check_unconstrained(all_rules: &[&[&[[u16; 3]]]], families: &[u16], features: &[u16]) -> bool {
    return if all_rules.is_empty() {
        true
    } else if path_through_constraints(&all_rules[0], families, features) {
        check_unconstrained(&all_rules[1..], families, features)
    } else {
        false
    }
}


fn path_through_constraints(constraints: &[&[[u16; 3]]], families: &[u16], features: &[u16]) -> bool {
    return if constraints.is_empty() {
        false
    } else if constraint_check(&constraints[0], families, features) {
        true
    } else {
        path_through_constraints(&constraints[1..], families, features)
    }
}


fn constraint_check(constraint: &[[u16; 3]], families: &[u16], features: &[u16]) -> bool {
    return if constraint.is_empty() {
        true
    } else if check_this_feature(&constraint[0], families, features) {
        return constraint_check(&constraint[1..], families, features)
    } else {
        false
    };
}


fn check_this_feature(this_feature: &[u16; 3], families: &[u16], features: &[u16]) -> bool {
    let have_feature: &bool = &have(this_feature);
    let family_in: &bool = &family_included(this_feature, families);
    return if *have_feature && *family_in {
        features.contains(&this_feature[1])
    } else if !*have_feature && *family_in {
        !features.contains(&this_feature[1])
    } else {
        true
    };
}

fn have(this_feature: &[u16; 3]) -> bool {
    return this_feature[2] == 0;
}

fn family_included(this_feature: &[u16; 3], families: &[u16]) -> bool {
    return families.contains(&this_feature[0]);
}

// Compile command: rustc -o compare compare.rs;