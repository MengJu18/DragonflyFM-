//
//  PlayListCell.swift
//  DragonflyFM
//
//  Created by 2017yd on 2019/11/23.
//  Copyright © 2019年 2017yd. All rights reserved.
//

import UIKit

class PlayListCell: UITableViewCell {
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblUserName: UILabel!
    @IBOutlet weak var lblTime: UILabel!
    @IBOutlet weak var lblCount: UILabel!
    @IBOutlet weak var imgCover: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
