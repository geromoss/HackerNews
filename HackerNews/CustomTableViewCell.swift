//
//  CustomTableViewCell.swift
//  HackerNews
//
//  Created by Gerardo Lupa on 12-10-17.
//  Copyright © 2017 Gerardo Lupa. All rights reserved.
//

import UIKit

class CustomTableViewCell: UITableViewCell {
    
    //here I customize each cell
    //show title
    @IBOutlet weak var story_title: UILabel!
    //for show name author
    @IBOutlet weak var author: UILabel!
    //for show label Created_at
    
    @IBOutlet weak var created_at: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
