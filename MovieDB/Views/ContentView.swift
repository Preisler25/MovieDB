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
                VStack{
                    VStack{
                        HStack{
                            Text("SortBy:").padding()
                            Spacer()
                        }.frame(height: 30)
                        Picker("SortBy: ", selection: Binding(
                            get: {filmSettings.sortBy},
                            set: {
                                filmSettings.sortBy = $0
                                Task {
                                    await filmList.fetchFilms(filmSettings: filmSettings)
                                }
                            }
                        )){
                            Text("Popularity").tag(SortByEnum.popularity)
                            Text("Release").tag(SortByEnum.release_date)
                            Text("Vote").tag(SortByEnum.vote_average)
                        }.pickerStyle(.segmented).padding().background(.clear).cornerRadius(10).padding().shadow(radius: 5).frame(height: 70)

                    }
                    HStack{
                        Spacer()
                        Toggle("Adult", isOn: Binding(
                            get: { filmSettings.showAdult },
                            set: {
                                filmSettings.showAdult = $0
                                Task {
                                    await filmList.fetchFilms(filmSettings: filmSettings)
                                }
                            }
                        )).frame(width: 100).padding()
                    }.frame(height: 20)
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
                }.frame(height: 480)
                Spacer()
                Spacer()
            }
        }.background(LinearGradient(gradient: Gradient(
            colors: [
                Color.accentColor.opacity(0.2),
                Color.yellow.opacity(0.2)
            ]), startPoint: .topLeading, endPoint: .bottomTrailing))
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
