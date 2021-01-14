//
//  Result.swift
//  JanoneTwelApi
//
//  Created by 황현지 on 2021/01/13.
//

import Foundation

//struct Result {
//    var adult : Bool = false
//    var title : String = ""
//    var overview : String = ""
//    var average : Float = 0.0
//}


struct Result: Codable {
        var adult : Bool = false
        var title : String = ""
        var overview : String = ""
        var average : Float = 0.0
    //4. 이미지 연동 (4-1)
        var poster : String = ""
    
    enum CodingKeys: String, CodingKey {
        case adult
        case title
        case overview
        case average = "vote_average"
    //4. 이미지 연동 (4-1)
        case poster = "poster_path"
    }
    

    init(from decoder:Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        adult = try values.decode(Bool.self, forKey: .adult)
        title = try values.decode(String.self, forKey: .title)
        overview = try values.decode(String.self, forKey: .overview)
        average = try values.decode(Float.self, forKey: .average)
    //4. 이미지 연동 (4-1)
        poster = try values.decode(String.self, forKey: .poster)
    }
}

struct ResultDataStore: Codable {
    var results: [Result]
}
