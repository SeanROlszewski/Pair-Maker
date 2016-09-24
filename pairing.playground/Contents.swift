//: Playground - noun: a place where people can play

import UIKit

struct Engineer {
    let name: String = ""
    let company: String = ""
}

func generatePairs(fromEngineers engineers: [Engineer]) -> [(Engineer, Engineer)]? {
   return nil
}

let oddNumberOfEngineersCantPair = generatePairs(fromEngineers: [Engineer(), Engineer(), Engineer()]) == nil
print("Returns nil when there are an odd number of engineers: \(oddNumberOfEngineersCantPair)")

let pairsEngineersOfDifferentCompanies = generatePairs(fromEngineers: [])
let pairNames = pairsEngineersOfDifferentCompanies?.reduce("") { (result, pair) -> String in
    result.appending("\(pair.0.name) is pairing with \(pair.1.name)\n")
}
print("List of pairs: \(pairNames)")




