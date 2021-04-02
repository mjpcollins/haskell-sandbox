

checkUnconstrained :: [[[[Int]]]] -> [Int] -> [Int] -> Bool
checkUnconstrained allRules families features
    | allRules == []                                           = True
    | pathThroughConstraints (head allRules) families features = checkUnconstrained (tail allRules) families features
    | otherwise                                                = False

pathThroughConstraints :: [[[Int]]] -> [Int] -> [Int] -> Bool
pathThroughConstraints constraints families features
    | constraints == []                                    = False
    | constraintCheck (head constraints) families features = True
    | otherwise                                            = pathThroughConstraints (tail constraints) families features

constraintCheck :: [[Int]] -> [Int] -> [Int] -> Bool
constraintCheck constraint families features
    | constraint == []                                     = True
    | checkThisFeature (head constraint) families features = constraintCheck (tail constraint) families features
    | otherwise                                            = False

checkThisFeature :: [Int] -> [Int] -> [Int] -> Bool
checkThisFeature thisFeature families features
    | and [have thisFeature, familyIncluded thisFeature families]       = elem (thisFeature !! 1) features
    | and [not (have thisFeature), familyIncluded thisFeature families] = not (elem (thisFeature !! 1) features)
    | otherwise                                                         = True

have :: [Int] -> Bool
have thisFeature = (last thisFeature) == 1

familyIncluded :: [Int] -> [Int] -> Bool
familyIncluded thisFeature families = elem (head thisFeature) families

runManyTimes :: Int -> [[[[Int]]]] -> [Int] -> [Int] -> Bool
runManyTimes runTimes rules families features
    | runTimes == 0                              = True
    | checkUnconstrained rules families features = runManyTimes (runTimes - 1) rules families features


main = do
    let constraintA = [[0, 1, 0], [1, 0, 1],  [1, 2, 0]]
    let constraintB = [[0, 1, 1], [1, 0, 1],  [1, 2, 0]]
    let constraintC = [[2, 3, 0], [2, 4, 1],  [3, 5, 0],  [1, 2, 0]]
    let constraintD = [[2, 3, 1], [2, 4, 0],  [3, 5, 1],  [1, 2, 1]]
    let rule1 = [constraintA, constraintB]
    let rule2 = [constraintC, constraintD]
    let rules = [rule1, rule2]
    let families = [1, 0]
    let features = [2, 1]
    let runAmount = 1000000
    let res = runManyTimes runAmount rules families features
    print res
    -- Compile command: ghc -O2 -o compare_ints compare_ints.hs;

