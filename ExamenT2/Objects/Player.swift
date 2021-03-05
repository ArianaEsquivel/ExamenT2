//
//  Player.swift
//  ExamenT2
//
//  Created by Ariana Esquivel on 04/03/21.
//

import UIKit

class Player: Codable {
    var username:String!
    var puntaje:Int!
    static var playerN:String!
    static var playerP:Int!
    
    init(_ username:String, _ puntaje:Int) {
        self.username = username
        self.puntaje = puntaje
    }
    
    func store(ve: UIViewController){
        App.shared.players = Player.allPlayers()
        App.shared.players.append(self)
        do {
            let encode = JSONEncoder()
            let data = try encode.encode(App.shared.players)
            App.shared.defaults.setValue(data, forKey: "players")
//            App.shared.defaults.synchronize()
//            ve.alertDefault(with: "'\(self.username ?? "")' se ha registrado", andWithMsg: "Has sido registrado con exito")
        }catch{
            ve.alertDefault(with: "¡Oh no!", andWithMsg: "Ha habido un problema")
            print("Oh no")
        }
    }
    
    static func allPlayers() -> [Player]{
        if let data = App.shared.defaults.object(forKey: "players") as? Data {
            let decoder = JSONDecoder()
            guard let players = try? decoder.decode([Player].self, from: data) else {return [Player]()}
            return players
        }
        return [Player]()
    }
    
//    static func getPlayer(index) -> Player {
//        let players:[Player] = Player.allPlayers()
//        let index = players.endIndex
//        let player:Player! = players[index]
//        print(players[index].username)
//        return player
//    }
}
