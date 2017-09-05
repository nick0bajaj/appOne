//
//  mainTableViewCell.swift
//  Split
//
//  Created by Nikhil Bajaj on 8/2/17.
//  Copyright © 2017 NickBajaj. All rights reserved.
//

import UIKit

class mainTableViewCell: UITableViewCell {

    @IBOutlet weak var groupPhoto: UIImageView!

    @IBOutlet weak var namesOfTravellers: UILabel!
    
    @IBOutlet weak var travellerDestinations: UILabel!
    
//    var infoShownByThisCell: Type {
//        didSet {
//            updateUI()
//        }
//    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    

}
