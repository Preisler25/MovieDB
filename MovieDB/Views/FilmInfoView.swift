//
//  FilmInfoView.swift
//  MovieDB
//
//  Created by Preisler András on 2025. 03. 09..
//

import SwiftUI

struct FilmInfoView: View {
    var date: String
    var rate: Double
    var body: some View {
        VStack{
            Text(date)
            Text("\(rate)")
        }
    }
}

#Preview {
    FilmInfoView(date: "akma", rate: 1.1)
}
