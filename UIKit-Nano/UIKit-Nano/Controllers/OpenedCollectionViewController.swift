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
        
        tableView.register(UINib(nibName: "MusicTableViewCell", bundle: nil), forCellReuseIdentifier: "MusicCell")
        tableView.dataSource = self
        
//        collection = MusicService.shared.getCollection(id: "2KJjOBX280F3hZZE1xO33O")
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
            
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "MusicCell", for: indexPath) as! MusicTableViewCell
            
            let music = musics[indexPath.row]
            
            cell.musicImage.image = MusicService.shared.getCoverImage(forItemIded: music.id)
            cell.title.text = music.title
            cell.subtitle.text = music.artist
            
            return cell
        }
        
        
    }
    

}
