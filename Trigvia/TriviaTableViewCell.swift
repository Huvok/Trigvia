//
//  TriviaTableViewCell.swift
//  Trigvia
//
//  Created by Juan Pablo Galaz Chávez on 5/1/19.
//  Copyright © 2019 Alumno. All rights reserved.
//

import UIKit

class TriviaTableViewCell: UITableViewCell {

    @IBOutlet weak var tfStart: UILabel!
    @IBOutlet weak var lbDifficulty: UILabel!
    @IBOutlet weak var viewTextContainer: UIView!
    @IBOutlet weak var viewContainer: UIView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        viewContainer.layer.cornerRadius = 8
        viewTextContainer.layer.cornerRadius = 8
        tfStart.text = "Empezar ➜"
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
