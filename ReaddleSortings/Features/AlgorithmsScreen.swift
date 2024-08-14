//
//  AlgorithmsScreen.swift
//  ReaddleSortings
//
//  Created by Yevhen Kyivskyi on 14.08.2024.
//

import SwiftUI

struct AlgorithmsScreen: View {
    
    @StateObject private var viewModel = AlgorithmsViewModel()
    @FocusState private var isInputFieldFocused
    @State private var isPresentedSheet = false
    
    var body: some View {
        NavigationStack {
            containerView
        }
    }
}

private extension AlgorithmsScreen {
    var containerView: some View {
        List {
            contentView
        }
        .navigationTitle("Sortings")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                Button(
                    action: {
                        isPresentedSheet = true
                    },
                    label: {
                        HStack(spacing: 10) {
                            Image(systemName: "arrow.up.arrow.down")
                                .resizable()
                                .frame(width: 16, height: 16)
                            Text("Sort")
                        }
                    }
                )
            }
        }
        .confirmationDialog("Sorting type",isPresented: $isPresentedSheet) {
            Button("Insertion") {
                viewModel.updateSortingType(.insertion)
            }
            Button("Bubble") {
                viewModel.updateSortingType(.bubble)
            }
            Button("Cancel", role: .cancel) {}
        }
        .onTapGesture {
            ReaddleSortingsApp.resignFirstResponder()
        }
    }
    
    @ViewBuilder var contentView: some View {
        inputSection
        outputSection
        actionsSection
    }
    
    var inputSection: some View {
        Section("Input") {
            Text("Please enter input array separated with commas")
            TextField("Array", text: $viewModel.inputArrayText)
                .focused($isInputFieldFocused)
        }
    }
    
    var outputSection: some View {
        Section("Output") {
            if viewModel.shouldShowEntryHint {
                Text("Input array and sorting type should be given in order to generate outpu")
            } else {
                if !viewModel.previousOutputArrayText.isEmpty {
                    Text(viewModel.previousOutputArrayText)
                        .foregroundStyle(Color.red)
                }
                Text(viewModel.outputArrayText)
                if !viewModel.nextOutputArrayText.isEmpty {
                    Text(viewModel.nextOutputArrayText)
                        .foregroundStyle(Color.green)
                }
            }
        }
    }
    
    var actionsSection: some View {
        Section("Actions") {
            HStack {
                Button(
                    action: viewModel.stepBack,
                    label: {
                        Image(systemName: "backward.fill")
                    }
                )
                .buttonStyle(.borderless)
                .disabled(viewModel.isBackButtonDisabled)
                Spacer()
                Button(
                    action: viewModel.finish,
                    label: {
                        Image(systemName: "play.fill")
                    }
                )
                .buttonStyle(.borderless)
                Spacer()
                Button(
                    action: viewModel.stepForward,
                    label: {
                        Image(systemName: "forward.fill")
                    }
                )
                .buttonStyle(.borderless)
                .disabled(viewModel.isForwardButtonDisabled)
            }
        }
    }
}

#Preview {
    AlgorithmsScreen()
}
