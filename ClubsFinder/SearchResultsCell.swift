//
//  SearchResultsCell.swift
//  ClubsFinder
//
//  Created by Séverin de Beaulieu on 30/10/2014.
//  Copyright (c) 2014. All rights reserved.
//

import UIKit

class SearchResultsCell: UITableViewCell {

    @IBOutlet weak var label1: UILabel!
    @IBOutlet weak var label2: UILabel!
    @IBOutlet weak var label3: UILabel!
    @IBOutlet weak var imageClub: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
