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
            RecordingView()
                .tabItem {
                    Image(systemName: "mic.fill")
                    Text("녹음")
                }
                .tag(0)

            RecordingListView()
                .tabItem {
                    Image(systemName: "chart.bar.fill")
                    Text("기록")
                }
                .tag(1)
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
}
