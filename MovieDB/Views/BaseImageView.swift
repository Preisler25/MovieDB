//
//  BaseImageView.swift
//  MovieDB
//
//  Created by Preisler András on 2025. 03. 09..
//

import SwiftUI

struct BaseImageView: View {
    var subString: String
    var body: some View {
        let url = URL(string: "https://image.tmdb.org/t/p/w600_and_h900_bestv2/\(subString)")
        AsyncImage(url: url){ phase in
            if let image = phase.image {
                image.resizable().cornerRadius(30)
            } else if phase.error != nil {
                ProgressView()
            } else {
                ProgressView()
            }
        }.frame(width: 200, height: 300)
    }
}

#Preview {
    BaseImageView(subString: "q0bCG4NX32iIEsRFZqRtuvzNCyZ.jpg")
}
