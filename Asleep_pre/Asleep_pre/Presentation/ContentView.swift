//
//  ContentView.swift
//  Asleep_pre
//
//  Created by jinahyun on 2/10/26.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView {
            RecordingView()
                .tabItem {
                    Label("녹음", systemImage: "mic.fill")
                }

            RecordingListView()
                .tabItem {
                    Label("녹음 목록", systemImage: "list.bullet")
                }
        }
    }
}

#Preview {
    ContentView()
}
