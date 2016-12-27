//
//  CustomTableViewCell.swift
//  MRTStation
//
//  Created by 江鈺云 on 2016/12/26.
//  Copyright © 2016年 tw. All rights reserved.
//

import UIKit

class CustomTableViewCell: UITableViewCell {
    @IBOutlet weak var stationNameLabel: UILabel!
    @IBOutlet weak var stationCode1Label: UILabel!
    @IBOutlet weak var stationCode2Label: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
