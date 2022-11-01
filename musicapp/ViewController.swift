//
//  ViewController.swift
//  musicapp
//
//  Created by Alibek Allamzharov on 01.11.2022.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var table: UITableView!
    
    var songs = [Song]()

    override func viewDidLoad() {
        super.viewDidLoad()
        configureSongs()
        table.delegate = self
        table.dataSource = self
        
    }
    
    func configureSongs(){
        songs.append(Song(name: "Perfect",
                          albumName: "EdSheeran album",
                          artistName: "EdSheeran - (Deluxe)",
                          imageName: "Divide_cover",
                          trackName: "edsheeran"))
        songs.append(Song(name: "Трата времени",
                          albumName: "Script album",
                          artistName: "Scriptonit - Уроборос: Улица 36",
                          imageName: "script",
                          trackName: "trata"))
        songs.append(Song(name: "Kok tu",
                          albumName: "IK",
                          artistName: "Ирина Кайратовна & Shiza - Kok tu",
                          imageName: "18711",
                          trackName: "koktu"))
        songs.append(Song(name: "Цепи",
                          albumName: "Script album",
                          artistName: "Scriptonit - Уроборос: Улица 36",
                          imageName: "script",
                          trackName: "cepi"))
        songs.append(Song(name: "Koke(feat.Hiro,De Lacure",
                          albumName: "IK",
                          artistName: "Ирина Кайратовна - Koke",
                          imageName: "ik",
                          trackName: "koke"))
        songs.append(Song(name: "Lovely",
                          albumName: "Eilish album",
                          artistName: "Billie Eilish & Khalid - Lovely",
                          imageName: "bilie",
                          trackName: "bilie"))
        songs.append(Song(name: "Arriva(feat.Hiro)",
                          albumName: "IK",
                          artistName: "Ирина Кайратовна - Arriva",
                          imageName: "ik",
                          trackName: "arriva"))
        songs.append(Song(name: "Falling",
                          albumName: "Trevor album",
                          artistName: "Trevor Daniel",
                          imageName: "trevel",
                          trackName: "Falling"))
        songs.append(Song(name: "5000",
                          albumName: "Ирина Кайратовна - 13 ВЫПУСК",
                          artistName: "Ирина Кайратовна",
                          imageName: "irina",
                          trackName: "5000"))
        songs.append(Song(name: "NE ANGIME?",
                          albumName: "IK",
                          artistName: "Ирина Кайратовна - NE ANGIME?",
                          imageName: "ik",
                          trackName: "neangme"))
        songs.append(Song(name: "Hobbit",
                          albumName: "EdSheeran album",
                          artistName: "Ed Sheeran",
                          imageName: "hobbit",
                          trackName: "hobbit"))
        songs.append(Song(name: "Hymn for the Weekend",
                          albumName: "Coldplay album",
                          artistName: "Coldplay - A Head Full of Dreams",
                          imageName: "humn",
                          trackName: "hymn"))
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return songs.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        let song = songs[indexPath.row]
        
        cell.textLabel?.text = song.name
        cell.detailTextLabel?.text = song.albumName
        cell.accessoryType = .disclosureIndicator
        cell.imageView?.image = UIImage(named: song.imageName)
        cell.textLabel?.font = UIFont(name: "Helvetica-Bold", size: 18)
        cell.detailTextLabel?.font = UIFont(name: "Helvetica", size: 14)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let position = indexPath.row
        
        guard let vc = storyboard?.instantiateViewController(identifier: "player") as? PlayerViewController else{
            return
        }
        
        vc.songs = songs
        vc.position = position
        
        present(vc, animated: true)
    }


}

struct Song{
    let name: String
    let albumName: String
    let artistName: String
    let imageName: String
    let trackName: String
}
