//
//  MemoTableViewCell.swift
//  03_AVAudioRecord
//
//  Created by Rocky on 2018/4/12.
//  Copyright © 2018年 Rocky. All rights reserved.
//

import UIKit

final class MemoTableViewCell: UITableViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var yearLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
