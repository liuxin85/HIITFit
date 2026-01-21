//
//  ContentView.swift
//  HIITFit
//
//  Created by liuxin on 2026/1/21.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView {
           WelcomeView()
            ForEach(0..<4){ index in
                ExercieseView(index: index)
            }
              
        }
        .tabViewStyle(PageTabViewStyle())
        .indexViewStyle(
            PageIndexViewStyle(backgroundDisplayMode: .never)
        )
   
    }
}

#Preview {
    ContentView()
}
