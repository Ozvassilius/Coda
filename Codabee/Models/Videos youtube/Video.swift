//
//  Video.swift
//  Codabee
//
//  Created by Macinstosh on 12/02/2019.
//  Copyright © 2019 ozvassilius. All rights reserved.
//

// structure de la reponse json pour les VIDEOS Youtube

import Foundation

struct APIResponse: Decodable {
    var items: [Video]
}

struct Video: Decodable {
    var id: ID
    var snippet: Snippet
}

struct ID: Decodable {
    var videoId: String
}

struct Snippet: Decodable {
    var title: String
    var description: String
    var thumbnails : Thumb
}

struct Thumb: Decodable {
    var medium: Image
    var high: Image
}

struct Image: Decodable {
    var url: String
}
