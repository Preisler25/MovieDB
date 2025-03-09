//
//  MovieDBApp.swift
//  MovieDB
//
//  Created by Preisler András on 2025. 03. 07..
//

import SwiftUI

@main
struct MovieDBApp: App {
    @State private var filmList = FilmList()
    @State private var filmSettings = FilmListSettings()
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.filmList, filmList)
                .environment(\.filmSettings, filmSettings)
        }
    }
}
