//
//  OpenedPlaylistViewController.swift
//  UIKit-Nano
//
//  Created by Gabriel Medeiros Martins on 20/06/23.
//

import UIKit

class OpenedCollectionViewController: UIViewController, UITableViewDataSource {
    @IBOutlet weak var tableView: UITableView!
    
    var collection: MusicCollection? = nil
    var musics: [Music] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        tableView.register(UINib(nibName: "MusicTableViewCell", bundle: nil), forCellReuseIdentifier: "MusicCell")
        tableView.dataSource = self
        
        musics = collection != nil ? collection!.musics : []
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 1
        }
        
        if section == 1 {
            return musics.count
        }
        
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "MusicCollectionHeaderCell", for: indexPath) as! MusicCollectionHeaderTableViewCell
            
            cell.imageCover.image = MusicService.shared.getCoverImage(forItemIded: collection!.id)
            cell.title.text = collection?.title
            cell.subtitle.text = collection?.mainPerson
            
            cell.selectionStyle = .none
            
            return cell
        } else {
            let cell: UITableViewCell = tableView.dequeueReusableCell(withIdentifier: "MusicCell", for: indexPath)
            
            let music = musics[indexPath.row]
            
            cell.textLabel?.text = music.title
            cell.detailTextLabel?.text = music.artist
            cell.imageView?.image = imageWithImage(image: MusicService.shared.getCoverImage(forItemIded: music.id)!, scaledToSize: .init(width: 40, height: 40))
            
            return cell
        }
        
        
    }
}
