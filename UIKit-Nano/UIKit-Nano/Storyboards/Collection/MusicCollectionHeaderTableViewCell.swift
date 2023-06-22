//
//  MusicCollectionHeaderTableViewCell.swift
//  UIKit-Nano
//
//  Created by Gabriel Medeiros Martins on 20/06/23.
//

import UIKit

class MusicCollectionHeaderTableViewCell: UITableViewCell {

    @IBOutlet weak var imageCover: UIImageView!
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var subtitle: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        imageCover.layer.cornerRadius = 10
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
