//
//  PlayerViewController.swift
//  UIKit-Nano
//
//  Created by Gabriel Medeiros Martins on 21/06/23.
//

import UIKit

class PlayerViewController: UIViewController {

    @IBOutlet weak var imageCover: UIImageView!
    @IBOutlet weak var musicTitle: UILabel!
    @IBOutlet weak var musicArtist: UILabel!
    @IBOutlet weak var favoriteIcon: UIImageView!
    @IBOutlet weak var timerSlider: UISlider!
    @IBOutlet weak var playButton: UIImageView!
    @IBOutlet weak var forwardButton: UIImageView!
    @IBOutlet weak var backwardButton: UIImageView!
    @IBOutlet weak var volumeSlider: UISlider!
    
    var musicImage: UIImage? = nil
    var musicTitleHolder: String? = nil
    var musicArtistHolder: String? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()

        imageCover.image = musicImage
        musicTitle.text = musicTitleHolder
        musicArtist.text = musicArtistHolder
        
        imageCover.layer.cornerRadius = 10
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
