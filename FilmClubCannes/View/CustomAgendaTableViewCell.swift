//
//  CustomAgendaTableViewCell.swift
//  FilmClubCannes
//
//  Created by ISABELLE Terwagne on 23/07/2019.
//  Copyright © 2019 ISABELLE Terwagne. All rights reserved.
//

import UIKit
import FirebaseFirestore

class CustomAgendaTableViewCell: UITableViewCell {
// MARK: Outlets
@IBOutlet weak var titleLabel: UILabel!
@IBOutlet weak var directorLabel: UILabel!
@IBOutlet weak var dateLabel: UILabel!
@IBOutlet weak var placeLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
        // Configure the view for the selected state
    var mov: Movies? {
            didSet {
    titleLabel.text = mov?.title
    directorLabel.text = mov?.director
    dateLabel.text = mov?.date
    placeLabel.text = mov?.place

        }
    }
}
