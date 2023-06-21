//
//  SongsViewController.swift
//  UIKit-Nano
//
//  Created by Gabriel Medeiros Martins on 21/06/23.
//

import UIKit

class SongsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    @IBOutlet weak var tableView: UITableView!
    
    let songs: [Music] = MusicService.shared.getAllMusics()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        tableView.delegate = self
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        songs.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: UITableViewCell = tableView.dequeueReusableCell(withIdentifier: "MusicCell", for: indexPath)
        
        let song = songs[indexPath.row]
        
        cell.textLabel?.text = song.title
        cell.detailTextLabel?.text = song.artist
        cell.imageView?.image = imageWithImage(image: MusicService.shared.getCoverImage(forItemIded: song.id)!, scaledToSize: .init(width: 40, height: 40))

        cell.imageView?.layer.cornerRadius = 4
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "toPlayer", sender: songs[indexPath.row])
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toPlayer" {
            guard let vc = segue.destination as? PlayerViewController else { return }
            
            guard let info = sender as? Music else { return }
            
            vc.musicImage = MusicService.shared.getCoverImage(forItemIded: info.id)
            vc.musicTitleHolder = info.title
            vc.musicArtistHolder = info.artist
        }
    }
    
}
