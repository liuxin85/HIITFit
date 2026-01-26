//
//  ContainerView.swift
//  HIITFit
//
//  Created by liuxin on 2026/1/26.
//

import SwiftUI

struct ContainerView<Content: View>: View {
    var content: Content
    
    init(@ViewBuilder content: ()-> Content) {
        self.content = content()
    }
    
    
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 2.5)
                .foregroundColor(Color("background"))
            
            VStack {
                Spacer()
                Rectangle()
                    .frame(height: 25)
                    .foregroundColor(Color("background"))
            }
            content
        }
   
    }
}

#Preview {
    ContainerView {
        VStack {
            RaisedButton(buttonText: "Hello World") {
                
            }
            .padding(50)
            
            Button("Tap me!"){}
                .buttonStyle(EmbossedButtonStyle(buttonShape: .round))
        }
    }
    
}
