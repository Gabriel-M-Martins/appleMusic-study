//
//  FavoritesViewController.swift
//  UIKit-Nano
//
//  Created by Eduardo Filot Brum on 21/06/23.
//

import UIKit

class FavoritesViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var favoritesTableView: UITableView!
    
    let searchController = UISearchController()
    
    var favoriteMusics = MusicService.shared.favoriteMusics
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        searchController.searchBar.placeholder = "Artists, Songs, Lyrics, and More"
        navigationItem.searchController = searchController
        
        favoritesTableView.dataSource = self
        favoritesTableView.delegate = self
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        MusicService.shared.toggleFavorite(music: favoriteMusics[indexPath.row], isFavorite: true)
        favoriteMusics = MusicService.shared.favoriteMusics
        favoritesTableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard !favoriteMusics.isEmpty else { return 1 }
        
        return favoriteMusics.count
    }
    
    @IBAction func favorite(_ sender: Any) {
        //        print(MusicService.shared.getAllMusics().first)
        guard let music = MusicService.shared.getAllMusics().first else { return }
        MusicService.shared.toggleFavorite(music: music, isFavorite: true)
        favoriteMusics = MusicService.shared.favoriteMusics
        favoritesTableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell: UITableViewCell
        
        if favoriteMusics.isEmpty {
            cell = favoritesTableView.dequeueReusableCell(withIdentifier: "EmptyFavoritesCell", for: indexPath)
        } else {
            let music = favoriteMusics[indexPath.row]
            let favoriteButton = UIImageView(image: UIImage(systemName: "heart.fill"))
            favoriteButton.tintColor = .systemPink
            
            cell = favoritesTableView.dequeueReusableCell(withIdentifier: "FavoriteMusicCell", for: indexPath)
            
            cell.imageView?.image = MusicService.shared.getCoverImage(forItemIded: music.id)
            cell.imageView?.layer.cornerRadius = 4
            
            cell.textLabel?.text = music.title
            
            cell.detailTextLabel?.text = music.artist
            
            cell.accessoryView = favoriteButton
            
        }
        
        return cell
    }
}
