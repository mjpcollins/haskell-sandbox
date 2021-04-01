// compare.c
#include <stdio.h>
#include <stdbool.h>
#include <string.h>
#define FAMILY_ARRAY_SIZE 300
#define FEATURE_ARRAY_SIZE 400
#define THIS_FEATURE_ARRAY_SIZE 3
#define CODE_LENGTH 6
#define CONSTRAINT_LENGTH 30
#define CONSTRAINTS_IN_RULE 10
#define MAX_RULES 300


bool familyIncluded(char this_feature[THIS_FEATURE_ARRAY_SIZE][CODE_LENGTH],
                    char families[FAMILY_ARRAY_SIZE][CODE_LENGTH]) {
    int family_array_index;
    for (family_array_index = 0; family_array_index < FAMILY_ARRAY_SIZE; ++family_array_index)
    {
        int compare = strcmp(this_feature[0], families[family_array_index]);
        if (compare == 0) {
            return true;
        }
        else if (compare == 70) {
            return false;
        }
    }
    return false;
}

bool featureInFeatures(char this_feature[THIS_FEATURE_ARRAY_SIZE][CODE_LENGTH],
                       char features[FEATURE_ARRAY_SIZE][CODE_LENGTH]) {
    int feature_array_index = 0;
    for (feature_array_index = 0; feature_array_index < FEATURE_ARRAY_SIZE; ++feature_array_index)
    {
        int compare = strcmp(this_feature[1], features[feature_array_index]);
        if (compare == 0) {
            return true;
        }
        else if (compare > CODE_LENGTH) {
            return false;
        }
    }
    return false;
 }

bool have(char this_feature[THIS_FEATURE_ARRAY_SIZE][CODE_LENGTH]) {
    int compare = strcmp(this_feature[2], "Y");
    if (compare == 0) {
        return true;
    } else {
        return false;
    }
}

bool checkThisFeature(char this_feature[THIS_FEATURE_ARRAY_SIZE][CODE_LENGTH],
                      char families[FAMILY_ARRAY_SIZE][CODE_LENGTH],
                      char features[FEATURE_ARRAY_SIZE][CODE_LENGTH]) {
    bool have_feature = have(this_feature);
    bool family_included = familyIncluded(this_feature, families);
    bool feature_in = featureInFeatures(this_feature, features);
    if (have_feature && family_included) {
        return feature_in;
    } else if (!(have_feature) && family_included) {
        return !feature_in;
    } else {
        return true;
    }
}


bool constraintCheck(char constraint[CONSTRAINT_LENGTH][THIS_FEATURE_ARRAY_SIZE][CODE_LENGTH],
                     char families[FAMILY_ARRAY_SIZE][CODE_LENGTH],
                     char features[FEATURE_ARRAY_SIZE][CODE_LENGTH],
                     int feature_index) {
    int compare = strcmp(constraint[feature_index][0], "\0");
    if (compare == 0) {
        return true;
    } else {
        int feature_check = checkThisFeature(constraint[feature_index], families, features);
        if (feature_check) {
            feature_index++;
            bool constraint_check_result = constraintCheck(constraint, families, features, feature_index);
            return constraint_check_result;
        } else {
            return false;
        }
    }
}


bool pathThroughConstraints(char constraints_in_rule[CONSTRAINTS_IN_RULE][CONSTRAINT_LENGTH][THIS_FEATURE_ARRAY_SIZE][CODE_LENGTH],
                            char families[FAMILY_ARRAY_SIZE][CODE_LENGTH],
                            char features[FEATURE_ARRAY_SIZE][CODE_LENGTH],
                            int constraint_index) {
    int compare = strcmp(constraints_in_rule[constraint_index][0][0], "\0");
    if (compare == 0) {
        return false;
    } else {
        int feature_index = 0;
        bool check_unconstrained = constraintCheck(constraints_in_rule[constraint_index], families, features, feature_index);
        if (check_unconstrained) {
            return check_unconstrained;
        } else {
            constraint_index++;
            bool result = pathThroughConstraints(constraints_in_rule, families, features, constraint_index);
            return result;
        }
    }
}


bool checkUnconstrained(char all_rules[MAX_RULES][CONSTRAINTS_IN_RULE][CONSTRAINT_LENGTH][THIS_FEATURE_ARRAY_SIZE][CODE_LENGTH],
                        char families[FAMILY_ARRAY_SIZE][CODE_LENGTH],
                        char features[FEATURE_ARRAY_SIZE][CODE_LENGTH],
                        int rule_index) {
    int compare = strcmp(all_rules[rule_index][0][0][0], "\0");
    if (compare == 0) {
        return true;
    } else {
        int constraint_index = 0;
        bool path_exists_through_rule = pathThroughConstraints(all_rules[rule_index], families, features, constraint_index);
        if (path_exists_through_rule) {
            rule_index++;
            bool result = checkUnconstrained(all_rules, families, features, rule_index);
            return result;
        } else {
            return false;
        }

    }
}


int runAll(char all_rules[MAX_RULES][CONSTRAINTS_IN_RULE][CONSTRAINT_LENGTH][THIS_FEATURE_ARRAY_SIZE][CODE_LENGTH],
           char families[FAMILY_ARRAY_SIZE][CODE_LENGTH],
           char features[FEATURE_ARRAY_SIZE][CODE_LENGTH],
           int loops) {
    int i;
    int result = 0;
    for (i = 0; i < loops; ++i) {
        int starting_index = 0;
        int constrainResult = checkUnconstrained(all_rules, families, features, starting_index);
        result = result + constrainResult;
    }
    return result;
}


int main() {
    char features[FEATURE_ARRAY_SIZE][CODE_LENGTH] = {"1AA", "3DD"};
    char families[FAMILY_ARRAY_SIZE][CODE_LENGTH] = {"ABBA", "BABB"};
    char all_rules[MAX_RULES][CONSTRAINTS_IN_RULE][CONSTRAINT_LENGTH][THIS_FEATURE_ARRAY_SIZE][CODE_LENGTH] = {
        {
            {{"BABB", "3DD", ""}, {"ABBA", "4DD", "Y"},  {"ABBA", "1AA", ""}},
            {{"BABB", "3DD", "Y"}, {"ABBA", "4DD", ""},  {"ABBA", "1AA", "Y"}}
        },
        {
            {{"FEKA", "HAA02", ""}, {"FEKA", "GII01", "Y"},  {"ZZZD", "BGB", ""},  {"ABBA", "1AA", ""}},
            {{"FEKA", "HAA02", "Y"}, {"FEKA", "GII01", ""},  {"ZZZD", "BGB", "Y"},  {"ABBA", "1AA", "Y"}}
        }
    };

    int loops = 1000000;
    int result = runAll(all_rules, families, features, loops);
    printf("%d", result);
    return result;
    //  Compile command: gcc -O3 -lm -o compare.exe compare.c
}



