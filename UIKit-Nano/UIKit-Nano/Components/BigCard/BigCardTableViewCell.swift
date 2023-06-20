//
//  BigCardTableViewCell.swift
//  UIKit-Nano
//
//  Created by Gabriel Medeiros Martins on 20/06/23.
//

import UIKit

class BigCardTableViewCell: UITableViewCell {

    @IBOutlet weak var imageCover: UIImageView!
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var imageOverlay: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        imageCover.layer.cornerRadius = 10
        imageOverlay.layer.cornerRadius = 10
    }
    
}
