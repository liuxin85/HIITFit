//
//  SuccessView.swift
//  HIITFit
//
//  Created by liuxin on 2026/1/22.
//

import SwiftUI

struct SuccessView: View {
    @Environment(\.dismiss) var dismiss
    @Binding var selectedTab: Int
    
    var body: some View {
        ZStack {
            VStack {
                Image(systemName: "hand.raised.fill")
                    .resizeToFill(width: 75, height: 75)
                    .foregroundColor(.purple)
                Text("High Five!")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                Text("""
                       Good job completing all four exercises!
                        Remember tomorrow's another day.
                        So eat well and get some rest.
                    """)
                .foregroundColor(.gray)
                .multilineTextAlignment(.center)
                
            }
            VStack {
                Spacer()
                Button("continue"){
                    dismiss()
                    selectedTab = 9
                }
                    .padding()
            }
        }
    }
}

#Preview {
    SuccessView(selectedTab: .constant(3))
}
