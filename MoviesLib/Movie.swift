//
//  Movie.swift
//  MoviesLib
//
//  Created by Usuário Convidado on 13/02/19.
//  Copyright © 2019 FIAP. All rights reserved.
//

import Foundation

struct Movie: Codable {
    let title: String
    let categories: String
    let duration: String
    let rating: Double
    let summary: String
    let image: String
}
