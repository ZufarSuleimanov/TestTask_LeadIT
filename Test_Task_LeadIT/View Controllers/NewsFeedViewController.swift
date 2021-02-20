//
//  NewsFeedViewController.swift
//  Test_Task_LeadIT
//
//  Created by Zufar Suleimanov on 19.02.2021.
//

import UIKit

class NewsFeedViewController: UIViewController {

    @IBOutlet weak var newsFeedCollectionView: UICollectionView!
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        executeRequest()
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        newsFeedCollectionView.delegate = self
        newsFeedCollectionView.dataSource = self
        newsFeedCollectionView.register(UINib.init(nibName: XIBs.NewsCell.rawValue, bundle: nil), forCellWithReuseIdentifier: Cells.NewsFeedCell.rawValue)
    }

}
