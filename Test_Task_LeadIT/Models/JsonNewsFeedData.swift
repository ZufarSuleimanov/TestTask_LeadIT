//
//  JsonNewsFeedData.swift
//  Test_Task_LeadIT
//
//  Created by Zufar Suleimanov on 19.02.2021.
//

import UIKit

struct NewsFeed: Codable {
    let status: String
    let results: [List]
}

struct List: Codable, Equatable, Hashable {
    static func == (lhs: List, rhs: List) -> Bool {
        return true
    }
    
    let title: String
    let abstract: String
    let url: String
    let published_date: Date
    let multimedia: [Multimedia]
    let image: UIImage?
    
    enum CodingKeys: String, CodingKey, Hashable {
        case title
        case abstract
        case url
        case published_date
        case multimedia
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        title               = try values.decode(String.self, forKey: .title)
        abstract            = try values.decode(String.self, forKey: .abstract)
        url                 = try values.decode(String.self, forKey: .url)
        multimedia          = try values.decode([Multimedia].self, forKey: .multimedia)
        published_date      = try List.toDate(dateFormat: try values.decode(String.self, forKey: .published_date))
        image               = nil
    }
    
    static func toDate(dateFormat: String) throws -> Date {
        let lengthDate              = 19
        let lengthDateFormat        = dateFormat.count
        let lengthDrop              = lengthDateFormat - lengthDate
        let dateAsString            = dateFormat.dropLast(lengthDrop)
        let dateFormatter           = DateFormatter()
        dateFormatter.dateFormat    = "yyyy-MM-dd'T'HH:mm:ss"
        guard let date = dateFormatter.date(from: String(dateAsString)) else {
            throw(NewsError.cannotConvertDate)
        }
        return date
    }
    
    enum NewsError: Error {
        case cannotConvertDate
    }
}

struct Multimedia: Codable, Hashable {
    let url: String
}
