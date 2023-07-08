//
//  adsvfb.swift
//  AppWeather
//
//  Created by  MacOS on 09.08.2022.
//

import Foundation
struct Response : Codable {
    let request : Request?
    let location : Location?
    let current : Current?

    enum CodingKeys: String, CodingKey {

        case request = "request"
        case location = "location"
        case current = "current"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        request = try values.decodeIfPresent(Request.self, forKey: .request)
        location = try values.decodeIfPresent(Location.self, forKey: .location)
        current = try values.decodeIfPresent(Current.self, forKey: .current)
    }

}

