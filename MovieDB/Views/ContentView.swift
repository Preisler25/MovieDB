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
            VStack{
                Button(action: {
                    changeType()
                }){
                    Text(filmSettings.type == FilmTypeEnum.movie ? "Movies" : "TV Shows")
                }
            }
            ScrollViewReader { scrollView in
                ScrollView(.horizontal){
                    LazyHStack{
                        if(filmSettings.page) > 1{
                            Button(action: {
                                changePage(cpt: .previous, scrollView: scrollView)
                            }) {
                                Label("Previous", systemImage: "arrow.left")
                            }
                        }
                        ForEach(filmList.films, id: \.id) { film in
                            FilmTileView(film: film).id(film.id)
                        }
                        Button(action: {
                            changePage(cpt: .next, scrollView: scrollView)
                        }){
                            Label("Next", systemImage: "arrow.right")
                        }
                    }.onAppear() {
                        Task{
                            await filmList.fetchFilms(filmSettings: filmSettings)
                        }
                    }.background(Color.gray)
                }
            }
            
        }
    }
    
    enum changePageType {
        case next
        case previous
    }
    
    func changeType(){
        filmSettings.type = filmSettings.type == FilmTypeEnum.movie ? FilmTypeEnum.tv : FilmTypeEnum.movie
        
        
    }
    
    func changePage(cpt : changePageType, scrollView: ScrollViewProxy){
        switch cpt {
        case .next:
            filmSettings.page += 1
        case .previous:
            filmSettings.page -= 1
        }
        
        Task {
            await filmList.fetchFilms(filmSettings: filmSettings)
            withAnimation {
                scrollView.scrollTo(filmList.films.first?.id, anchor: .leading)
            }
        }
    }
}

#Preview {
    ContentView()
}
