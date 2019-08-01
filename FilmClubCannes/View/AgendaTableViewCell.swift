//
//  AgendaTableViewCell.swift
//  FilmClubCannes
//
//  Created by ISABELLE Terwagne on 27/07/2019.
//  Copyright © 2019 ISABELLE Terwagne. All rights reserved.
//

import UIKit
import FirebaseFirestore

class AgendaTableViewCell: UITableViewCell {
    
    //MARK: Outlets
   
    @IBOutlet weak var afficheImage: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var directorLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var placeLabel: UILabel!
    
    @IBOutlet weak var heureLabel: UILabel!
    let db = Firestore.firestore()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    //MARK: Properties
    
    var mov: Movies? {
        didSet {
            titleLabel.text = mov?.title
            directorLabel.text = "de \(mov?.director ?? "")"
            dateLabel.text = mov?.date
            heureLabel.text = mov?.heure
            placeLabel.text = mov?.place
            guard let image = mov?.image else {return}
            guard let url = URL(string: image) else {return}
            print(url)
            DispatchQueue.global().async {
                let data = try? Data(contentsOf: url)
                DispatchQueue.main.async {
                    self.afficheImage.image = UIImage(data: data! as Data)
        }
    }
    
}
}
   
//       func convertStringDateToDate(stringDate: String) -> Date {
//        let formatter = DateFormatter()
//        formatter.dateFormat = "EEEE, dd MMMM yyyy"
//        formatter.locale = Locale(identifier: "fr-FR")
//        let dateFormatted: Date = formatter.date(from: stringDate)!
//        return dateFormatted
//        }
    }
