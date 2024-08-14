//
//  InsertionSort.swift
//  ReaddleSortings
//
//  Created by Yevhen Kyivskyi on 14.08.2024.
//

import Foundation

extension Array where Element == Int {
    
    func insertionSort() -> AlgorithmOutput {
        guard count > 1 else {
            return .init(inputArray: self, cachedStates: [], sortedArray: self)
        }
        
        let inputArray = self
        var states: [[Int]] = []
        var sortingArray = self
        
        for i in 1..<sortingArray.count {
            states.append(sortingArray)
            var j = i
            while j > 0 && sortingArray[j] < sortingArray[j - 1] {
                sortingArray.swapAt(j - 1, j)
                j -= 1
            }
        }
        
        states.append(sortingArray)
        
        return .init(
            inputArray: inputArray,
            cachedStates: states,
            sortedArray: sortingArray
        )
    }
}
