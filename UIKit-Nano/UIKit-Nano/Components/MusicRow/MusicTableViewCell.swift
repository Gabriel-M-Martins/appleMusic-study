//
//  MusicTableViewCell.swift
//  UIKit-Nano
//
//  Created by Gabriel Medeiros Martins on 19/06/23.
//

import UIKit

class MusicTableViewCell: UITableViewCell {

    @IBOutlet weak var musicImage: UIImageView!
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var subtitle: UILabel!
    @IBOutlet weak var button: UIImageView!
    
    // if it should display a heart icon instead of a chevron
    var favoritable: Bool = false
    // if the heart icon is filled or not
    var isFavorite: Bool = true
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        musicImage.layer.cornerRadius = 10
        
        // change icon to heart and implement gesture
        if favoritable {
            button.image = isFavorite ? .init(systemName: "heart.fill") : .init(systemName: "heart")
            button.tintColor = isFavorite ? .systemPink : button.tintColor
            
            // calls self.favorite() when tapped
            button.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(favorite)))
        }
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @objc private func favorite() {
        print("Coe apertou aqui.")
    }
}
