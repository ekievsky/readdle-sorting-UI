//
//  AlgorithmPlayer.swift
//  ReaddleSortings
//
//  Created by Yevhen Kyivskyi on 14.08.2024.
//

import Foundation

struct AlgorithmPlayer {
    
    var currentStep: Int
    let output: AlgorithmOutput?
    
    init(currentStep: Int = 0, output: AlgorithmOutput? = nil) {
        self.currentStep = currentStep
        self.output = output
    }
}
