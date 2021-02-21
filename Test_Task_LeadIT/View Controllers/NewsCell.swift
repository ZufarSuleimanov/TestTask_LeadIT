//
//  NewsCell.swift
//  Test_Task_LeadIT
//
//  Created by Zufar Suleimanov on 19.02.2021.
//

import UIKit

final class NewsCell: UICollectionViewCell {

    @IBOutlet weak var publishedDateLabel: UILabel!
    @IBOutlet weak var titleTextView: UITextView!
    @IBOutlet weak var abstractTextView: UITextView!
    @IBOutlet weak var multimediaImageView: UIImageView!
    var url = String()
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
}
