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
    
    var favorite = false
    
    var musicImage: UIImage? = nil
    var musicTitleHolder: String? = nil
    var musicArtistHolder: String? = nil
    var music: Music? = nil
    
    let hollowFavoriteIcon = UIImage(systemName: "heart")
    let filledFavoriteIcon = UIImage(systemName: "heart.fill")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Playing"

        guard let music = self.music else { return }
        
        imageCover.image = MusicService.shared.getCoverImage(forItemIded: music.id)
        imageCover.layer.cornerRadius = 10
        
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = view.bounds
        
        // Defina os pontos de parada com diferentes valores de opacidade
        gradientLayer.colors = [
            UIColor.black.withAlphaComponent(0.4).cgColor, // Opacidade 0.0 no início
            UIColor.black.withAlphaComponent(0.0).cgColor, // Opacidade 0.5 no meio
            UIColor.black.withAlphaComponent(0.4).cgColor  // Opacidade 1.0 no final
        ]

        // Defina os pontos de parada correspondentes aos valores de opacidade
        gradientLayer.locations = [0.0, 0.5, 1.0]

        // Adicione o gradiente à camada da view
        view.layer.insertSublayer(gradientLayer, at: 0)
        
        musicTitle.text = music.title
        musicArtist.text = music.artist
        
        self.favorite = MusicService.shared.favoriteMusics.contains(music)
        
        self.favoriteIcon.isUserInteractionEnabled = true
        self.favoriteIcon.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(toggleFavorite)))
        self.changeFavoriteIconTint()
    }
    
    private func changeFavoriteIconTint() {
        favoriteIcon.tintColor = self.favorite ? .systemPink : .systemGray
        favoriteIcon.image = self.favorite ? filledFavoriteIcon : hollowFavoriteIcon
    }
    
    @objc func toggleFavorite() {
        favorite.toggle()
        MusicService.shared.toggleFavorite(music: music!, isFavorite: favorite)
        self.changeFavoriteIconTint()
    }

}
