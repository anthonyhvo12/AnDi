//
//  CommentTableViewCell.swift
//  AnDi
//
//  Created by Trần Sỹ Quyết on 6/16/19.
//  Copyright © 2019 Trần Sỹ Quyết. All rights reserved.
//

import UIKit
import Cosmos

class CommentTableViewCell: UITableViewCell {

    @IBOutlet weak var commentImageView: UIImageView!

    @IBOutlet weak var starRateView: CosmosView!

    @IBOutlet weak var commentTitleLabel: UILabel!

    @IBOutlet weak var detailTitleLabel: UILabel!

    @IBOutlet weak var commentBackgroundView: UIView!

    var delegate: CommentViewControllerDelegate!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        starRateView.didFinishTouchingCosmos = { rating in
            self.delegate.updateStarRate(value: rating, selectedIndex: self.tag)
            print("didFinishTouchingCosmos", self.tag, rating)
            self.starRateView.rating = rating
        }

        commentBackgroundView.layer.shadowColor = UIColor.black.cgColor
        commentBackgroundView.layer.shadowOpacity = 1
        commentBackgroundView.layer.shadowOffset = .zero
        commentBackgroundView.layer.shadowRadius = 2
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
