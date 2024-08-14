//
//  BubbleSort.swift
//  ReaddleSortings
//
//  Created by Yevhen Kyivskyi on 14.08.2024.
//

import Foundation

extension Array where Element == Int {
    
    func bubbleSort() -> AlgorithmOutput {
        guard count > 1 else {
            return .init(inputArray: self, cachedStates: [], sortedArray: self)
        }
        let inputArray = self
        var states: [[Int]] = []
        var sortingArray = self
        for i in 0..<sortingArray.count {
            states.append(sortingArray)
            for j in 1..<sortingArray.count - i {
                if sortingArray[j] < sortingArray[j - 1] {
                    sortingArray.swapAt(j, j - 1)
                }
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
