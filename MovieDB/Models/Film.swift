//
//  Film.swift
//  MovieDB
//
//  Created by Preisler András on 2025. 03. 07..
//

import Foundation
import Observation

@Observable
class Film: Codable, Identifiable {
    let adult: Bool
    let backdrop_path: String?
    let genre_ids: [Int]
    let id: Int
    let original_language: String
    let original_title: String
    let overview: String
    let popularity: Double
    let poster_path: String?
    let release_date: String
    let title: String
    let video: Bool
    let vote_average: Double
    let vote_count: Int
    
    init(adult: Bool, backdrop_path: String?, genre_ids: [Int], id: Int, original_language: String, original_title: String, overview: String, popularity: Double, poster_path: String?, release_date: String, title: String, video: Bool, vote_average: Double, vote_count: Int) {
        self.adult = adult
        self.backdrop_path = backdrop_path
        self.genre_ids = genre_ids
        self.id = id
        self.original_language = original_language
        self.original_title = original_title
        self.overview = overview
        self.popularity = popularity
        self.poster_path = poster_path
        self.release_date = release_date
        self.title = title
        self.video = video
        self.vote_average = vote_average
        self.vote_count = vote_count
    }
}
