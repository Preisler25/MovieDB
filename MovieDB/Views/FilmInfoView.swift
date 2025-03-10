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
        HStack{
            Text(convertDateToDisplay(date: date))
            CircularProgressView(progress: rate)
        }
    }
    
    func convertDateToDisplay(date: String) -> String {
        let splitDate: [Substring] = date.split(separator: "-")
        return splitDate.joined(separator: ".")
    }
}

#Preview {
    FilmInfoView(date: "akma", rate: 0.1)
}
