//
//  PlaybillsCell.swift
//  DragonflyFM
//
//  Created by ChenChaoXiu on 2019/11/20.
//  Copyright © 2019年 2017yd. All rights reserved.
//

import UIKit

class PlaybillsCell: UITableViewCell {
    @IBOutlet weak var lblTable: UILabel!
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var lblCount: UILabel!
    @IBOutlet weak var lblTime: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
