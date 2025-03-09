//
//  ContentView.swift
//  MovieDB
//
//  Created by Preisler András on 2025. 03. 07..
//

import SwiftUI

struct ContentView: View {
    @Environment(\.filmList) private var filmList
    @Environment(\.filmSettings) private var filmSettings
    var body: some View {
        VStack{
            Text("MovieDB App")
            Text("\(filmSettings.showAdult)")
            ScrollView(.horizontal){
                LazyHStack{
                    ForEach(filmList.films, id: \.id) { film in
                        FilmTileView(film: film)
                        let _ = film.adult
                    }
                }.onAppear() {
                    Task{
                        await filmList.fetchFilms(filmSettings: filmSettings)
                    }
                }.background(Color.gray).frame(height: 500)
            }
        }
    }
}

#Preview {
    ContentView()
}
