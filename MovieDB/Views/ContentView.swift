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
            Text("MovieDB App").font(.largeTitle)
            VStack{
                Spacer()
                VStack{
                    HStack{
                        Button(action: {
                            changeType()
                        }){
                            Text(filmSettings.type == FilmTypeEnum.movie ? "Movies" : "TV Shows").font(.title2).padding(5).background().cornerRadius(6)
                        }
                        Button(action: {
                            changeType()
                        }){
                            Text(filmSettings.type == FilmTypeEnum.movie ? "Movies" : "TV Shows").font(.title2).padding(5).background().cornerRadius(6)
                        }
                        Toggle("Adult", isOn: Binding(
                            get: { filmSettings.showAdult },
                            set: {
                                filmSettings.showAdult = $0
                                Task {
                                    await filmList.fetchFilms(filmSettings: filmSettings)
                                }
                            }
                        )).frame(width: 100)
                    }
                }
                Spacer()
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
                        }
                    }
                }.frame(height: 500)
                Spacer()
                Spacer()
            }.background(Color.gray)
        }
    }
    
    enum changePageType {
        case next
        case previous
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
    
    func changeType(){
        filmSettings.type = filmSettings.type == FilmTypeEnum.movie ? FilmTypeEnum.tv : FilmTypeEnum.movie
        Task {
            await filmList.fetchFilms(filmSettings: filmSettings)
        }
        
    }
    
    
    func changeIsAdult(){
        filmSettings.showAdult.toggle()
        Task {
            await filmList.fetchFilms(filmSettings: filmSettings)
        }
    }
}

#Preview {
    ContentView()
}
