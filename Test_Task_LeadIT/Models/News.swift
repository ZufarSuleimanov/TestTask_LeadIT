//
//  News.swift
//  Test_Task_LeadIT
//
//  Created by Zufar Suleimanov on 19.02.2021.
//

import UIKit

struct News: Hashable {
    var title: String
    var abstract: String
    var url: String
    var publishedDate: Date
    var multimediaURL: String
    var image: UIImage?
}
