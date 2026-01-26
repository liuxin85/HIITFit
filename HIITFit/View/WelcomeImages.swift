//
//  WelcomeImages.swift
//  HIITFit
//
//  Created by liuxin on 2026/1/26.
//

import SwiftUI

extension WelcomeView {
    static var images: some View {
        ZStack {
            Image("hands")
            .resizeToFill(width: 100, height: 100)
              .clipShape(Circle())
              .offset(x: -88, y: 30)
            Image("step-up")
                .resizeToFill(width: 180, height: 180)
                 .clipShape(Circle())
                 .offset(x: 74)
        }
        .frame(maxWidth: .infinity, maxHeight: 220)
        .shadow(color: Color("drop-shadow"), radius: 6, x: 5, y: 5)
         .padding(.top, 10)
         .padding(.leading, 20)
         .padding(.bottom, 10)
    }
    
    static var welcomeText: some View {
      return HStack(alignment: .bottom) {
        VStack(alignment: .leading) {
          Text("Get fit")
            .font(.largeTitle)
            .fontWeight(.black)
            .kerning(2)
          Text("by exercising at home")
            .font(.headline)
            .fontWeight(.medium)
            .kerning(2)
            .fixedSize(horizontal: false, vertical: true)
        }
      }
    }

}
struct WelcomeImagesPreview: View {
    var body: some View {
        WelcomeView.images
            .background(Color.gray.opacity(0.1)) // 可选，方便看布局
    }
}

#Preview {
    WelcomeImagesPreview()
}

