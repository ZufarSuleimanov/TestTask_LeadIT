//
//  JsonNewsFeedData.swift
//  Test_Task_LeadIT
//
//  Created by Zufar Suleimanov on 19.02.2021.
//

import Foundation

struct NewsFeed: Codable {
    let status: String
    let results: [Result]
}

struct Result: Codable {
    let title: String
    let abstract: String
    let url: String
    let published_date: String
    let multimedia: [Multimedia]
}

struct Multimedia: Codable {
    let url: String
}
