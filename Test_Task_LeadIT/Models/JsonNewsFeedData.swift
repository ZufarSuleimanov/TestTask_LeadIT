//
//  JsonNewsFeedData.swift
//  Test_Task_LeadIT
//
//  Created by Zufar Suleimanov on 19.02.2021.
//

import Foundation

struct NewsFeed: Codable {
    let status: String?
    let copyright: String?
    let section: String?
    let lastUpdated: String?
    let numResults: Int?
    let results: [Result]
}

struct Result: Codable {
    let section: String?
    let subsection: String?
    let title: String?
    let abstract: String?
    let url: String?
    let uri: String?
    let byline: String?
    let itemType: String?
    let updatedDate: String?
    let createdDate: String?
    let publishedDate: String?
    let materialTypeFacet: String?
    let kicker: String?
    let desFacet: [String]?
    let orgFacet: [String]?
    let perFacet: [String]?
    let geoFacet: [String]?
    let multimedia: [Multimedia]?
    let shortURL: String?
}

struct Multimedia: Codable {
    let url: String?
    let format: String?
    let height: Int?
    let width: Int?
    let type: String?
    let subtype: String?
    let caption: String?
    let copyright: String?
}
