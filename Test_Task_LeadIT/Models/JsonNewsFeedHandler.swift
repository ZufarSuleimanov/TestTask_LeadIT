//
//  JsonNewsFeedHandler.swift
//  Test_Task_LeadIT
//
//  Created by Zufar Suleimanov on 19.02.2021.
//

import UIKit

final class JsonNewsFeedHandler {

    static var onCompletion: (([List]?) -> Void)?
    
    static func getJsonRequest(url: URL) {
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            DispatchQueue.global(qos: .utility).async {
                if let error = error {
                    parseJsonResult(withData: .failure(error))
                    return
                }
                guard let data = data else { return }
                parseJsonResult(withData: .success(data))
            }
        }.resume()
    }
    
    static func parseJsonResult(withData result: Result<Data, Error>) {
        switch result {
        case .success(let data):
            do {
                let news = try JSONDecoder().decode(NewsFeed.self, from: data)
                print(news)
                onCompletion?(news.results.sorted{ $0.published_date > $1.published_date })
            } catch let jsonError {
                print("Failed to decode JSON", jsonError)
                onCompletion?(nil)
            }
        case .failure(let error):
            print("Error received requesting data: \(error.localizedDescription)")
            onCompletion?(nil)
        }
    }
}
