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

//데이터파싱 2 Codable 형식
struct Result: Codable {
        var adult : Bool = false
        var title : String = ""
        var overview : String = ""
        var average : Float = 0.0
    
    enum CodingKeys: String, CodingKey {
        case adult
        case title
        case overview
        case average = "vote_average"
    }
    
    //decode : Json 데이터를 decodable 자료형에 저장
    init(from decoder:Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        adult = try values.decode(Bool.self, forKey: .adult)
        title = try values.decode(String.self, forKey: .title)
        overview = try values.decode(String.self, forKey: .overview)
        average = try values.decode(Float.self, forKey: .average)
    }
}

struct ResultDataStore: Codable {
    var results: [Result]
}
