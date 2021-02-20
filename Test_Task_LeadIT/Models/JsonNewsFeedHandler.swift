//
//  JsonNewsFeedHandler.swift
//  Test_Task_LeadIT
//
//  Created by Zufar Suleimanov on 19.02.2021.
//

import Foundation

class JsonNewsFeedHandler {

    static var onCompletion: ((News?) -> Void)?
    
    static func getJsonRequest(url: URL) {
        let session = URLSession.shared
        session.dataTask(with: url) { (data, response, error) in
            if let data = data {
                self.parseJsonResult(withData: data)
            }
        }.resume()
    }
    
    static func parseJsonResult(withData data: Data) {
        let decoder = JSONDecoder()
        do {
            let json = try! decoder.decode(NewsFeed.self, from: data)
            if json.status == "OK" {
                for jsonNews in json.results {
                    let news = News.init(
                        title:          jsonNews.title ?? "no data",
                        abstract:       jsonNews.abstract ?? "no data",
                        url:            jsonNews.url ?? "no data",
                        publishedDate:  toDate(dateFormat: jsonNews.publishedDate ?? "0001-01-01T00:00:00") ?? Date(),
                        multimediaURL:  jsonNews.multimedia?.first!.url ?? "no data"
                    )
                    onCompletion?(news)
                }
            } else {
                onCompletion?(nil)
            }
        }
    }
    
    static func toDate(dateFormat: String) -> Date? {
        let lengthDate              = 19
        let lengthDateFormat        = dateFormat.count
        let lengthDrop              = lengthDateFormat - lengthDate
        let dateAsString            = dateFormat.dropLast(lengthDrop)
        let dateFormatter           = DateFormatter()
        dateFormatter.dateFormat    = "yyyy-MM-dd'T'HH:mm:ss"
        
        return dateFormatter.date(from: String(dateAsString))
    }

}
