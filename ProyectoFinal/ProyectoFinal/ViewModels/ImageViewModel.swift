//
//  Image.swift
//  ProyectoFinal
//
//  Created by Cristian Zuniga on 4/4/21.
//

import Foundation
import SwiftUI

struct ImageViewModel: Hashable, Codable {
    var id: Int
    var name: String
    var uploadDate: Date
    var likes: Int
    
    private var imageName:String
    var image: Image {
        Image(imageName)
    }
    
    var comments: [Quotes]
}
