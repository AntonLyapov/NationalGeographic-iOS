//
//  ContentTableViewCell.swift
//  NationalGeographic
//
//  Created by Anton Lyapov on 7.02.18.
//  Copyright © 2018 Anton Lyapov. All rights reserved.
//

import UIKit
import SDWebImage

class ContentTableViewCell: UITableViewCell {
    
    static let CELL_NAME = "ContentTableViewCell"

    @IBOutlet var mediaImageView: UIImageView!
    @IBOutlet var pageTitleLabel: UILabel!
    
    @IBOutlet var activityIndicatorView: UIActivityIndicatorView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setContent(content: Content) {
        pageTitleLabel.text = content.page?.title
        
        self.activityIndicatorView.startAnimating()
        
        let url = URL(string: (content.leadMedia?.url)!)
        self.mediaImageView.sd_setImage(with: url) { (image, error, imageCacheType, url) in
            self.activityIndicatorView.stopAnimating()
        }
    }

}
