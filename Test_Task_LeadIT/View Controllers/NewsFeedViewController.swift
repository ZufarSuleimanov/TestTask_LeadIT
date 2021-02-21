//
//  NewsFeedViewController.swift
//  Test_Task_LeadIT
//
//  Created by Zufar Suleimanov on 19.02.2021.
//

import UIKit

final class NewsFeedViewController: UIViewController {
    @IBOutlet weak var newsFeedCollectionView: UICollectionView!
    let newsRefreshControl: UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        let title = NSLocalizedString("Just a second", comment: "Pull to refresh")
        refreshControl.attributedTitle = NSAttributedString(string: title)
        refreshControl.addTarget(self, action: #selector(refresh(sender:)), for: .valueChanged)
            return refreshControl
    }()
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        if Reachability.isConnectedToNetwork() != true {
            Notifications.callAlert(title: "Error", message: "Please connect to the Internet", in: self)
        } else {
            executeRequest(checking: false)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        newsFeedCollectionView.delegate = self
        newsFeedCollectionView.dataSource = self
        newsFeedCollectionView.refreshControl = newsRefreshControl
        newsFeedCollectionView.register(UINib.init(nibName: XIBs.NewsCell.rawValue, bundle: nil), forCellWithReuseIdentifier: Cells.NewsFeedCell.rawValue)
    }
    
    @objc func refresh(sender: UIRefreshControl) {
        executeRequest(checking: true)
        sender.endRefreshing()
    }
}
