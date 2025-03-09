//
//  FilmTileView.swift
//  MovieDB
//
//  Created by Preisler András on 2025. 03. 07..
//

import SwiftUI

struct FilmTileView: View {
    var film: Film
    var body: some View {
        VStack{
            Text(film.title)
            BaseImageView(subString: film.poster_path ?? "")
            FilmInfoView(date: film.release_date, rate: film.vote_average)
        }.padding().background(.regularMaterial).cornerRadius(20).padding(5)
    }
}

#Preview {
    FilmTileView(film: Film(adult: true, backdrop_path: "q0bCG4NX32iIEsRFZqRtuvzNCyZ.jpg", genre_ids: [0], id: 1, original_language: "eng", original_title: "Alma", overview: "alma", popularity: 10.1, poster_path: "q0bCG4NX32iIEsRFZqRtuvzNCyZ.jpg", release_date: "2015-03-02", title: "alma", video: false, vote_average: 10.2, vote_count: 30))
}
