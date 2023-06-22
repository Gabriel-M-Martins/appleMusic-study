//
//  FavoritesViewController.swift
//  UIKit-Nano
//
//  Created by Eduardo Filot Brum on 21/06/23.
//

import UIKit

class FavoritesViewController: UIViewController, UITableViewDataSource {
    
    @IBOutlet weak var favoritesTableView: UITableView!
    
    let searchController = UISearchController()
    
    var favoriteMusics = MusicService.shared.favoriteMusics

    override func viewDidLoad() {
        super.viewDidLoad()

        searchController.searchBar.placeholder = "Artists, Songs, Lyrics, and More"
        navigationItem.searchController = searchController
        
        favoritesTableView.dataSource = self
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //guard !favoriteMusics.isEmpty else { return 1 }
        
        //return favoriteMusics.count
        if section == 0 {
            return favoriteMusics.count
        } else {
            return 1
        }
    }
    
    @IBAction func favorite(_ sender: Any) {
//        print(MusicService.shared.getAllMusics().first)
        guard let music = MusicService.shared.getAllMusics().first else { return }
        MusicService.shared.toggleFavorite(music: music, isFavorite: true)
        favoriteMusics = MusicService.shared.favoriteMusics
        favoritesTableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.section == 0 {
            let music = favoriteMusics[indexPath.row]
            let favoriteButton = UIImageView(image: UIImage(systemName: "heart.fill"))
            favoriteButton.tintColor = .systemPink
            
            let cell = favoritesTableView.dequeueReusableCell(withIdentifier: "FavoriteMusicCell", for: indexPath)
            
            cell.imageView?.image = MusicService.shared.getCoverImage(forItemIded: music.id)
            cell.imageView?.layer.cornerRadius = 4
            
            cell.textLabel?.text = music.title
            
            cell.detailTextLabel?.text = music.artist
            
            cell.accessoryView = favoriteButton
            
            return cell
        } else {
            let cell = favoritesTableView.dequeueReusableCell(withIdentifier: "EmptyFavoritesCell", for: indexPath)
            
            return cell
        }
    }
}
