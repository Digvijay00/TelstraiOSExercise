//
//  FactsModel.swift
//  TelstraiOSExercise
//
//  Created by Digvijay.digvijay on 6/20/20.
//  Copyright © 2020 Digvijay.digvijay. All rights reserved.
//

import Foundation

//MARK:  TELSTRA FACT RESPONSE DATA  MODEL

struct TelstraFacts : Codable {
    let title : String?
    let rows : [TelstraFactData]?

    enum CodingKeys: String, CodingKey {

        case title = "title"
        case rows = "rows"
    }
}


struct TelstraFactData : Codable {
    let title : String?
    let description : String?
    let imageUrl : String?

    enum CodingKeys: String, CodingKey {
        case title = "title"
        case description = "description"
        case imageUrl = "imageHref"
    }
}
