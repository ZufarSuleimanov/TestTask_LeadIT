//
//  NewsFeedExtensions.swift
//  Test_Task_LeadIT
//
//  Created by Zufar Suleimanov on 19.02.2021.
//

import UIKit

let itemsPerRow: CGFloat = 1
let sectionInserts = UIEdgeInsets(top: 20, left: 20, bottom: 20, right: 20)
var newsFeedData = [News]()

extension NewsFeedViewController: UICollectionViewDelegate { }

extension NewsFeedViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return newsFeedData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Cells.NewsFeedCell.rawValue, for: indexPath) as! NewsCell
        let news = newsFeedData[indexPath.row]
        
        let formatter = DateFormatter()
        formatter.dateFormat = "dd/MM/YYYY"
        
        cell.publishedDateLabel.text = formatter.string(from: news.publishedDate)
        
        let url = URL(string: news.multimediaURL)!
        
        DispatchQueue.main.async {
            let data = try? Data(contentsOf: url)
            cell.multimediaURLImageView.image = UIImage(data: data!)
        }
        
        cell.titleTextView.text = news.title
        cell.abstractTextView.text = news.abstract
        
        return cell
    }
    
    func executeRequest() {
        JsonNewsFeedHandler.getJsonRequest(url: URL(string: urlTopStoriesAPI)!)
        JsonNewsFeedHandler.onCompletion = { [weak self] news in
            guard let self = self else { return }
            if news != nil {
                newsFeedData.append(news!)
                DispatchQueue.main.async { self.newsFeedCollectionView.reloadData() }
            }
        }
    }
}

extension NewsFeedViewController: UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let paddingWidth = sectionInserts.left * (itemsPerRow + 1)
        let availableWidth = collectionView.frame.width - paddingWidth
        let widthPerItem = availableWidth / itemsPerRow
        return CGSize(width: widthPerItem, height: widthPerItem)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return sectionInserts
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return sectionInserts.left
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return sectionInserts.left
    }
}
