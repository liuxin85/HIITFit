//
//  ImageExtension.swift
//  HIITFit
//
//  Created by liuxin on 2026/1/22.
//

import SwiftUI

extension Image {
    /// Resize an image with fill aspect ratio and specified frame dimensions
    /// - parameters:
    ///     - width: Frame width.
    ///     - height: Frame height.
    func resizeToFill(width: CGFloat, height: CGFloat) -> some View {
        self
            .resizable()
            .aspectRatio(contentMode: .fill)
            .frame(width: width, height: height)
    }
    
}
