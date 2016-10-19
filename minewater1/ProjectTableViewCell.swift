//
//  ProjectTableViewCell.swift
//  minewater1
//
//  Created by HQ-ICT-VINAYJ on 17/10/16.
//  Copyright © 2016 HQ-ICT-VINAYJ. All rights reserved.
//

import UIKit

class ProjectTableViewCell: UITableViewCell {

    @IBOutlet weak var company: UILabel!
    @IBOutlet weak var discharge: UILabel!
    @IBOutlet weak var domestic: UILabel!
    @IBOutlet weak var agriculture: UILabel!
    @IBOutlet weak var industry: UILabel!
    
    @IBOutlet weak var recharge: UILabel!
    
    @IBOutlet weak var projectuse: UILabel!
    
    @IBOutlet weak var otheruse: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
