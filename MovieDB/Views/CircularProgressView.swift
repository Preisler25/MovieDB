//
//  CircularProgressView.swift
//  MovieDB
//
//  Created by Preisler András on 2025. 03. 10..
//

import SwiftUI

struct CircularProgressView: View {
    let progress: Double
    var body: some View {
        ZStack {
            Circle()
                .stroke(
                    Color.pink.opacity(0.5),
                    lineWidth: 5
                ).frame(width: 70)
            Circle()
                .trim(from: 0, to: progress*0.1)
                .stroke(
                    Color.pink,
                    style: StrokeStyle(
                        lineWidth: 5,
                        lineCap: .round
                    )
                ).frame(width: 70)
                .rotationEffect(.degrees(-90))
            Text(convertToDisplay(progress: progress))

        }
    }
    
    func convertToDisplay(progress: Double) -> String {
        return String(format: "%.f%%", progress * 10)
    }
}

#Preview {
    CircularProgressView(progress: 1)
}
