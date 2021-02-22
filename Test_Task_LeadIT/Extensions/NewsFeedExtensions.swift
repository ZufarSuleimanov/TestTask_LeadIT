//
//  NewsFeedExtensions.swift
//  Test_Task_LeadIT
//
//  Created by Zufar Suleimanov on 19.02.2021.
//

import UIKit

let itemsPerRow: CGFloat = 1
let sectionInserts = UIEdgeInsets(top: 20, left: 20, bottom: 20, right: 20)
var newsFeedData = [List]()
var newsFeedDataDifference = [List]()

extension UIImageView {
    func getNewsArticleImage(link:String) {
        DispatchQueue.global(qos: .userInitiated).async {
            guard let url = URL(string: link) else { return }
            URLSession.shared.dataTask(with: url, completionHandler: { (data, _, error) -> Void in
                guard let data = data , error == nil, let image = UIImage(data: data) else { return }
                DispatchQueue.main.async { () -> Void in
                    self.image = image
                }
            }).resume()
        }
    }
}

extension NewsFeedViewController: UICollectionViewDelegate {  }

extension NewsFeedViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let news = newsFeedData[indexPath.row]
        guard let url = URL(string: news.url) else {return}
        UIApplication.shared.open(url)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        if newsFeedData.count > 0 {
            processingActivityIndicatorView.isHidden = true
            processingActivityIndicatorView.stopAnimating()
        }
        return newsFeedData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Cells.NewsFeedCell.rawValue, for: indexPath) as! NewsCell
        let news = newsFeedData[indexPath.row]
        let formatter = DateFormatter()
        formatter.dateFormat = "dd-MM-yyyy HH:mm"
        cell.publishedDateLabel.text = formatter.string(from: news.published_date)
        cell.titleTextView.text = news.title
        cell.abstractTextView.text = news.abstract
        cell.multimediaImageView.getNewsArticleImage(link: news.multimedia[3].url)
        cell.url = news.url
        cell.contentView.layer.cornerRadius = 15
        cell.contentView.layer.masksToBounds = true
        return cell
    }
    
    func executeRequest(checking records: Bool) {
        JsonNewsFeedHandler.getJsonRequest(url: URL(string: urlTopStoriesAPI)!)
        JsonNewsFeedHandler.onCompletion = { [weak self] news in
            guard let self = self else { return }
            if news != nil {
                if records == false {
                    newsFeedData = news!
                } else {
                    newsFeedDataDifference.removeAll()
                    newsFeedDataDifference = news!
                    self.controlRecords()
                }
                DispatchQueue.main.async { self.newsFeedCollectionView.reloadData() }
            }
        }
    }
    
    func controlRecords() {
        var differenceСontrol = Set(newsFeedDataDifference)
        differenceСontrol.subtract(newsFeedData)
        if differenceСontrol.count > 0 {
            newsFeedData.append(contentsOf: differenceСontrol)
            let sortResult = newsFeedData.sorted{ $0.published_date > $1.published_date }
            newsFeedData = sortResult
            DispatchQueue.main.async{ self.newsFeedCollectionView.reloadData() }
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
