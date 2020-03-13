//
//  SearchResult.swift
//  ItunesSearch
//
//  Created by krikaz on 3/13/20.
//  Copyright © 2020 thewire. All rights reserved.
//

import Foundation

struct SearchResult: Codable {
    var title: String?
    var creator: String
    
    enum CodingKeys: String, CodingKey {
        case title = "trackName"
        case creator = "artistName"
    }
}

struct SearchResults: Codable {
    let results: [SearchResult]
}
