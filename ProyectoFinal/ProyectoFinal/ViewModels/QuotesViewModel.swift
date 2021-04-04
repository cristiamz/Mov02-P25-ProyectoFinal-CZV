//
//  QuotesViewModel.swift
//  ProyectoFinal
//
//  Created by Cristian Zuniga on 4/4/21.
//

import Foundation

struct Quotes: Hashable, Codable {
    var contents: Comment
    
    struct Comment: Hashable, Codable{
        var quotes: [Quote]
        
        struct Quote: Hashable, Codable {
            var id: String
            var quote: String
            var length: Int
            var author: String
            var date: String
            var background: String
            var title: String
        }
    }
}
