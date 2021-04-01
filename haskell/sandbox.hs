import qualified Data.Text as T

checkUnconstrained :: [[[[T.Text]]]] -> [T.Text] -> [T.Text] -> Bool
checkUnconstrained allRules families features
    | allRules == []                                           = True
    | pathThroughConstraints (head allRules) families features = checkUnconstrained (tail allRules) families features
    | otherwise                                                = False

pathThroughConstraints :: [[[T.Text]]] -> [T.Text] -> [T.Text] -> Bool
pathThroughConstraints constraints families features
    | constraints == []                                    = False
    | constraintCheck (head constraints) families features = True
    | otherwise                                            = pathThroughConstraints (tail constraints) families features

constraintCheck :: [[T.Text]] -> [T.Text] -> [T.Text] -> Bool
constraintCheck constraint families features
    | constraint == []                                     = True
    | checkThisFeature (head constraint) families features = constraintCheck (tail constraint) families features
    | otherwise                                            = False

checkThisFeature :: [T.Text] -> [T.Text] -> [T.Text] -> Bool
checkThisFeature thisFeature families features
    | and [have thisFeature, familyIncluded thisFeature families]       = elem (thisFeature !! 1) features
    | and [not (have thisFeature), familyIncluded thisFeature families] = not (elem (thisFeature !! 1) features)
    | otherwise                                                         = True

have :: [T.Text] -> Bool
have thisFeature = T.length (last thisFeature) == 1

familyIncluded :: [T.Text] -> [T.Text] -> Bool
familyIncluded thisFeature families = elem (head thisFeature) families

runManyTimes :: Int -> [[[[T.Text]]]] -> [T.Text] -> [T.Text] -> Bool
runManyTimes runTimes rules families features
    | runTimes == 0                              = True
    | checkUnconstrained rules families features = runManyTimes (runTimes - 1) rules families features

packAll :: [[String]] -> [[T.Text]] -> [[T.Text]]
packAll manyStrings texts
    | manyStrings == [] = texts
    | otherwise         = packAll (tail manyStrings) (texts ++ [packListOfStrings (head manyStrings) []])

packListOfStrings :: [String] -> [T.Text] -> [T.Text]
packListOfStrings listOfStrings listOfTexts
    | listOfStrings == [] = listOfTexts
    | otherwise           = packListOfStrings (tail listOfStrings) (listOfTexts ++ [T.pack (head listOfStrings)])

main = do
    let constraintA = packAll [["BABB", "3DD", ""], ["ABBA", "4DD", "Y"],  ["ABBA", "1AA", ""]] []
    let constraintB = packAll [["BABB", "3DD", "Y"], ["ABBA", "4DD", ""],  ["ABBA", "1AA", "Y"]] []
    let constraintC = packAll [["FEKA", "HAA02", ""], ["FEKA", "GII01", "Y"],  ["ZZZD", "BGB", ""],  ["ABBA", "1AA", ""]] []
    let constraintD = packAll [["FEKA", "HAA02", "Y"], ["FEKA", "GII01", ""],  ["ZZZD", "BGB", "Y"],  ["ABBA", "1AA", "Y"]] []
    let rule1 = [constraintA, constraintB]
    let rule2 = [constraintC, constraintD]
    let rules = [rule1, rule2]
    let families = packListOfStrings ["ABBA", "BABB"] []
    let features = packListOfStrings ["1AA", "3DD"] []
    let runAmount = 1000000
    let res = runManyTimes runAmount rules families features
    print res
    -- Compile command:  ghc -O2 -o sandbox sandbox.hs;

