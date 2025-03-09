//
//  FilmList.swift
//  MovieDB
//
//  Created by Preisler András on 2025. 03. 07..
//
import SwiftUI
import Foundation
import Observation

@Observable class FilmList {
    var films: [Film] = []
    
    
    func fetchFilms(filmSettings: FilmListSettings) async {
        let url = URL(string: "https://api.themoviedb.org/3/discover/\(filmSettings.type)")!
        var components = URLComponents(url: url, resolvingAgainstBaseURL: true)!
        let queryItems: [URLQueryItem] = [
            URLQueryItem(name: "include_adult", value: "\(filmSettings.showAdult)"),
          URLQueryItem(name: "include_video", value: "false"),
          URLQueryItem(name: "language", value: "en-US"),
            URLQueryItem(name: "page", value: "\(filmSettings.page)"),
            URLQueryItem(name: "sort_by", value: "\(filmSettings.sortBy).desc"),
        ]
        components.queryItems = components.queryItems.map { $0 + queryItems } ?? queryItems

        var request = URLRequest(url: components.url!)
        request.httpMethod = "GET"
        request.timeoutInterval = 10
        request.allHTTPHeaderFields = [
          "accept": "application/json",
          "Authorization": "Bearer \(Secrets.apiKey)"
        ]
        do {
            let (data, _) = try await URLSession.shared.data(for: request)
            let decodedResponse = try JSONDecoder().decode(FilmResponse.self, from: data)
            films = decodedResponse.results
            print("Fetched \(films.count) films.")
                    
        } catch {
            print("Failed to fetch films: \(error.localizedDescription)")
        }
    }
}

extension EnvironmentValues {
    var filmList: FilmList {
        get { self[FilmListKey.self] }
        set { self[FilmListKey.self] = newValue }
    }
}

private struct FilmListKey: EnvironmentKey {
    static var defaultValue: FilmList = FilmList()
}


//Films settings

enum SortByEnum: String, CaseIterable {
    case popularity
    case release_date
    case vote_average
}

enum FilmTypeEnum: String, CaseIterable {
    case movie
    case tv
}

@Observable class FilmListSettings {
    var page: Int = 1
    var showAdult: Bool = true
    var sortBy: SortByEnum = .popularity
    var type: FilmTypeEnum = .movie
}

extension EnvironmentValues {
    var filmSettings: FilmListSettings {
        get { self[FilmSettingsKey.self] }
        set { self[FilmSettingsKey.self] = newValue }
    }
}

private struct FilmSettingsKey: EnvironmentKey {
    static var defaultValue: FilmListSettings = FilmListSettings()
}
