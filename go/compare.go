package main

import "fmt"

func main() {
    var constraintA = [][3]int{{0, 1, 0}, {1, 0, 1},  {1, 2, 0}}
    var constraintB = [][3]int{{0, 1, 1}, {1, 0, 1},  {1, 2, 0}}
    var constraintC = [][3]int{{2, 3, 0}, {2, 4, 1},  {3, 5, 0}, {1, 2, 0}}
    var constraintD = [][3]int{{2, 3, 1}, {2, 4, 0},  {3, 5, 1}, {1, 2, 1}}
    var rule1 = [][][3]int{constraintA, constraintB}
    var rule2 = [][][3]int{constraintC, constraintD}
    var all_rules = [][][][3]int{rule1, rule2}
    var families = []int{0, 1}
    var features = []int{1, 2}
    var loops int = 1000000
    var ans = [1000000]bool{}
    for i := 0; i < loops; i++ {
        ans[i] = check_unconstrained(all_rules, families, features)
    }
    fmt.Println(ans[1000000-1])
}

func check_unconstrained(all_rules [][][][3]int, families []int, features []int) bool {
    if len(all_rules) == 0 {
        return true
    } else if path_through_constraints(all_rules[0], families, features) {
        return check_unconstrained(all_rules[1:], families, features)
    } else {
        return false
    }
}

func path_through_constraints(constraints [][][3]int, families []int, features []int) bool {
    if len(constraints) == 0 {
        return false
    } else if constraint_check(constraints[0], families, features) {
        return true
    } else {
        return path_through_constraints(constraints[1:], families, features)
    }
}

func constraint_check(constraint [][3]int, families []int, features []int) bool {
    if len(constraint) == 0 {
        return true
    } else if check_this_feature(constraint[0], families, features) {
        return constraint_check(constraint[1:], families, features)
    } else {
        return false
    }
}

func check_this_feature(this_feature [3]int, families []int, features []int) bool {
    if have(this_feature) && family_included(this_feature, families) {
        return in(this_feature[1], features)
    } else if (!have(this_feature)) && family_included(this_feature, families) {
        return !in(this_feature[1], features)
    } else {
        return true
    }

}

func have(this_feature [3]int) bool {
    return this_feature[2] == 1
}

func family_included(this_feature [3]int, families []int) bool {
    return in(this_feature[0], families)
}

func in(val int, slice []int) bool {
    for item := range slice {
        if item == val {
            return true
        }
    }
    return false
}

// Run script: go run compare.go

