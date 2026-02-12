//
//  Asleep_preApp.swift
//  Asleep_pre
//
//  Created by jinahyun on 2/10/26.
//

import SwiftUI

@main
struct Asleep_preApp: App {
    @State private var container = AppDependencyContainer()

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(container)
        }
    }
}
