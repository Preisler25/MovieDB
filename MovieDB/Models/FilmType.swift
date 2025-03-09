//
//  FilmType.swift
//  MovieDB
//
//  Created by Preisler András on 2025. 03. 07..
//

import Foundation

class FilmType: Codable, Identifiable {
    let id: Int
    let name: String
    
    init(id: Int, name: String) {
        self.id = id
        self.name = name
    }
}
