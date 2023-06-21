//
//  SongsViewController.swift
//  UIKit-Nano
//
//  Created by Gabriel Medeiros Martins on 21/06/23.
//

import UIKit

class SongsViewController: UIViewController, UITableViewDataSource {
    @IBOutlet weak var tableView: UITableView!
    
    let songs: [Music] = MusicService.shared.getAllMusics()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
    }
    
    func imageWithImage(image: UIImage, scaledToSize newSize: CGSize) -> UIImage {
        UIGraphicsBeginImageContext(newSize)
        image.draw(in: CGRect(x: 0 ,y: 0 ,width: newSize.width ,height: newSize.height))
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return newImage!.withRenderingMode(.alwaysOriginal)
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
    
}
