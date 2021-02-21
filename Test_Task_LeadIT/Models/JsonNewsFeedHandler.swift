//
//  JsonNewsFeedHandler.swift
//  Test_Task_LeadIT
//
//  Created by Zufar Suleimanov on 19.02.2021.
//

import UIKit

final class JsonNewsFeedHandler {

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
        do {
            let json = try JSONDecoder().decode(NewsFeed.self, from: data)
            if json.status == "OK" {
                for jsonNews in json.results {
                    let news = News.init(
                        title:          jsonNews.title,
                        abstract:       jsonNews.abstract,
                        url:            jsonNews.url,
                        publishedDate:  toDate(dateFormat: jsonNews.published_date)!,
                        multimediaURL:  (jsonNews.multimedia[3].url),
                        image:          nil
                    )
                    onCompletion?(news)
                }
            } else {
                Notifications.callAlert(title: "Error", message: "Please connect to the Internet.", in: NewsFeedViewController.self as! UIViewController)
            }
        } catch {
            Notifications.callAlert(title: "Error", message: "Service unavailable, out of try later.", in: NewsFeedViewController.self as! UIViewController)
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
