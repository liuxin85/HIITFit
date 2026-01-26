//
//  HIITFitApp.swift
//  HIITFit
//
//  Created by liuxin on 2026/1/21.
//

import SwiftUI

@main
struct HIITFitApp: App {
    @StateObject private var historyStore = HistoryStore()
    var body: some Scene {
        WindowGroup {
            ContentView()
                .onAppear {
                    print(URL.documentsDirectory)
                }
                .environmentObject(historyStore)
                .alert(isPresented: $historyStore.loadingError){
                    Alert(title: Text("History"),
                    message: Text(
                        """
                        Unfortunately we can't load your post history.
                        Email support:
                        support@xyz.com
                        """
                        
                    )
                    )
                }
                .buttonStyle(.raised)
        }
    }
}
