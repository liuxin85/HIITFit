//
//  ContentView.swift
//  HIITFit
//
//  Created by liuxin on 2026/1/21.
//

import SwiftUI

struct ContentView: View {
    @SceneStorage("selectedTab") private var selectedTab = 9
 
    
    var body: some View {
        TabView(selection: $selectedTab) {
            WelcomeView(selectedTab: $selectedTab).tag(9)
            
            ForEach(Exercise.exercises.indices, id: \.self){ index in
                ExercieseView(selectedTab: $selectedTab, index: index)
                    .tag(index)
            }
              
        }
       
        .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
      
   
    }
}

#Preview {
    ContentView()
}
