//
//  AlgorithmsViewModel.swift
//  ReaddleSortings
//
//  Created by Yevhen Kyivskyi on 14.08.2024.
//

import Foundation
import Combine

class AlgorithmsViewModel: ObservableObject {
    
    enum SortingType {
        case bubble
        case insertion
    }
    
    @Published var inputArrayText: String = ""
    @Published var sortingType: SortingType?
    @Published var currentAlgorithm: AlgorithmOutput?
    @Published var currentPlayer: AlgorithmPlayer = .init()
    
    @Published var outputArrayText: String = ""
    @Published var previousOutputArrayText: String = ""
    @Published var nextOutputArrayText: String = ""
    
    var shouldShowEntryHint: Bool {
        inputArrayText.isEmpty || sortingType == nil
    }
    
    var isBackButtonDisabled: Bool {
        currentPlayer.currentStep == 0
    }
    
    var isForwardButtonDisabled: Bool {
        currentPlayer.currentStep == ((currentPlayer.output?.cachedStates.count ?? 0) - 1)
    }
    
    private var cancelBag = CancelBag()
    
    init() {
        Publishers.CombineLatest($inputArrayText, $sortingType)
            .map { inputText, sortingType in
                guard let sortingType else {
                    return nil
                }
                let output = inputText.components(separatedBy: ",")
                let arrayValues = output.compactMap { Int($0) }
                switch sortingType {
                case .bubble:
                    return arrayValues.bubbleSort()
                case .insertion:
                    return arrayValues.insertionSort()
                }
            }
            .assign(to: &$currentAlgorithm)
        
        
        let sharedPlayer = $currentAlgorithm
            .compactMap { AlgorithmPlayer(currentStep: 0, output: $0) }
            .share()
        
        sharedPlayer
            .assign(to: &$currentPlayer)
        
        sharedPlayer
            .sink { [weak self] in self?.invalidateState(with: $0) }
            .store(in: &cancelBag)

    }
    
    func stepBack() {
        currentPlayer.currentStep -= 1
        previousOutputArrayText = generateOutput(on: currentPlayer.currentStep - 1, with: currentPlayer.output)
        outputArrayText = generateOutput(on: currentPlayer.currentStep, with: currentPlayer.output)
        nextOutputArrayText = generateOutput(on: currentPlayer.currentStep + 1, with: currentPlayer.output)
    }
    
    func stepForward() {
        currentPlayer.currentStep += 1
        previousOutputArrayText = generateOutput(on: currentPlayer.currentStep - 1, with: currentPlayer.output)
        outputArrayText = generateOutput(on: currentPlayer.currentStep, with: currentPlayer.output)
        nextOutputArrayText = generateOutput(on: currentPlayer.currentStep + 1, with: currentPlayer.output)
    }
    
    func finish() {
        currentPlayer.currentStep = (currentPlayer.output?.sortedArray.count ?? 0) - 1
        previousOutputArrayText = generateOutput(on: currentPlayer.currentStep - 1, with: currentPlayer.output)
        outputArrayText = generateOutput(on: currentPlayer.currentStep, with: currentPlayer.output, shouldFinish: true)
    }
    
    func updateSortingType(_ type: SortingType) {
        self.sortingType = type
    }
}

private extension AlgorithmsViewModel {
    func generateOutput(
        on step: Int,
        with output: AlgorithmOutput?,
        shouldFinish: Bool = false
    ) -> String {
        guard let output, (0..<output.cachedStates.count).contains(step) else {
            return ""
        }
        
        if shouldFinish {
            return output.sortedArray.map { String($0) }.joined(separator: ",")
        }
        
        return output.cachedStates[step].map { String($0) }.joined(separator: ",")
    }
    
    func invalidateState(with player: AlgorithmPlayer) {
        outputArrayText = generateOutput(on: player.currentStep, with: player.output)
        previousOutputArrayText = ""
        nextOutputArrayText = ""
    }
}
