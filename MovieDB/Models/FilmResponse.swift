//
//  FilmResponse.swift
//  MovieDB
//
//  Created by Preisler András on 2025. 03. 07..
//

import Foundation

struct FilmResponse: Decodable {
    let page: Int
    let results: [Film]
    let total_pages: Int
    let total_results: Int
}
