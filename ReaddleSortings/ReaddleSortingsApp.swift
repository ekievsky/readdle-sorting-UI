//
//  ReaddleSortingsApp.swift
//  ReaddleSortings
//
//  Created by Yevhen Kyivskyi on 14.08.2024.
//

import SwiftUI

@main
struct ReaddleSortingsApp: App {
    var body: some Scene {
        WindowGroup {
            AlgorithmsScreen()
        }
    }
}

extension ReaddleSortingsApp {
    static func resignFirstResponder() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
