//
//  ContentView.swift
//  Asleep_pre
//
//  Created by jinahyun on 2/10/26.
//

import SwiftUI

struct ContentView: View {
    @State private var selectedTab = 0

    var body: some View {
        TabView(selection: $selectedTab) {
            Tab("녹음", systemImage: "mic.fill", value: 0) {
                RecordingView()
            }

            Tab("기록", systemImage: "chart.bar.fill", value: 1) {
                RecordingListView()
            }
        }
        .tint(AppTheme.accent)
        .onAppear {
            let appearance = UITabBarAppearance()
            appearance.configureWithOpaqueBackground()
            appearance.backgroundColor = UIColor(AppTheme.background)

            appearance.stackedLayoutAppearance.normal.iconColor = UIColor(AppTheme.textTertiary)
            appearance.stackedLayoutAppearance.normal.titleTextAttributes = [
                .foregroundColor: UIColor(AppTheme.textTertiary)
            ]
            appearance.stackedLayoutAppearance.selected.iconColor = UIColor(AppTheme.accent)
            appearance.stackedLayoutAppearance.selected.titleTextAttributes = [
                .foregroundColor: UIColor(AppTheme.accent)
            ]

            UITabBar.appearance().standardAppearance = appearance
            UITabBar.appearance().scrollEdgeAppearance = appearance
        }
    }
}

#Preview {
    ContentView()
        .environment(AppDependencyContainer())
}
