//
//  JugarViewController.swift
//  ExamenT2
//
//  Created by Ariana Esquivel on 04/03/21.
//

import UIKit

class JugarViewController: UIViewController {

    @IBOutlet weak var ayerAmarillo: UIButton!
    @IBOutlet weak var ayerRojo: UIButton!
    @IBOutlet weak var ayerVerde: UIButton!
    @IBOutlet weak var ayerAzul: UIButton!
    @IBOutlet weak var ayerLbPlayer: UILabel!
    @IBOutlet weak var ayerLbScore: UILabel!
    @IBOutlet weak var ayerLbBestPlayer: UILabel!
    var numerosRandom = [Int]()
    var gan: Bool = true
    var cantGanadas: Int = 3
    var coloresToc = [Int]()
    var terminado:Bool = false
    var score:Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.ayerLbPlayer.text = "Player: \(Player.playerN ?? "")"
        self.ayerLbScore.text = "Score: \(Player.playerP ?? 0)"
//        numerosRandom.append(Int.random(in: 1..<5))
        Timer.scheduledTimer(timeInterval: 0.5, target: self, selector: #selector(prende), userInfo: nil, repeats: false)
        self.bestPlayer()
        
//        Timer.scheduledTimer(withTimeInterval: 3, repeats: true) { timer in
//            let randomNumber = Int.random(in: 1...20)
//            print("Number: \(randomNumber)")
//
//            if randomNumber == 10 {
//                timer.invalidate()
//            }
//        }
        
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        if Player.playerN != "" && Player.playerP != 0 {
            let player = Player(Player.playerN, Player.playerP)
            player.store(ve: self)
            Player.playerN = ""
            Player.playerP = 0
        }
        
//        print("adios")
    }
    
    
    @IBAction func ayerBtnsColores(_ sender: UIButton) {
        switch sender {
        case ayerAmarillo:
            coloresToc.append(1)
        case ayerRojo:
            coloresToc.append(2)
        case ayerVerde:
            coloresToc.append(3)
        case ayerAzul:
            coloresToc.append(4)
        default:
            print("No hay de esosss")
        }
        sender.change()
    self.confirmar()
    }
    
    @objc func prende(){
        self.ayerAmarillo.isEnabled = false
        self.ayerRojo.isEnabled = false
        self.ayerVerde.isEnabled = false
        self.ayerAzul.isEnabled = false
        var lleva : Int = 0
        Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { timer in
            let numRandom = Int.random(in: 1..<5)
            lleva += 1
            switch numRandom {
            case 1:
                self.ayerAmarillo.change()
            case 2:
                self.ayerRojo.change()
            case 3:
                self.ayerVerde.change()
            case 4:
                self.ayerAzul.change()
            default:
                print("Achis no hay de ese")
            }
            print("Numer: \(numRandom)")
            self.numerosRandom.append(numRandom)

            if self.cantGanadas == lleva {
                timer.invalidate()
                self.ayerAmarillo.isEnabled = true
                self.ayerRojo.isEnabled = true
                self.ayerVerde.isEnabled = true
                self.ayerAzul.isEnabled = true
            }
        }
    }
    
    func confirmar(){
        if self.coloresToc.count > self.numerosRandom.count{
            self.numerosRandom.removeAll()
            self.coloresToc.removeAll()
        }
        else if self.coloresToc.count <= self.numerosRandom.count {
            let countColoresToc:Int = self.coloresToc.count
            let numers = self.numerosRandom[self.numerosRandom.index(before: countColoresToc)]
            if numers == self.coloresToc.last {
//                print("Correcto, era \(self.coloresToc.last ?? 0)")
                if self.coloresToc.count == self.numerosRandom.count {
//                    print("Vas bieeen, de nuevo")
                    self.cantGanadas += 1
                    self.score += 10
                    Player.playerP = self.score
                    self.ayerLbScore.text = "Score: \(Player.playerP ?? 0)"
//                    print("puntajePlayerP: \(Player.playerP ?? 0)")
                    Timer.scheduledTimer(timeInterval: 0.5, target: self, selector: #selector(prende), userInfo: nil, repeats: false)
                }
            }
            else {
                self.numerosRandom.removeAll()
                self.coloresToc.removeAll()
//                print("Ya perdiste jeje")
                self.bestPlayer()
                self.dismiss(animated: true, completion: nil)
//                self.alertDefault(with: "¡Oh no  \(Player.playerN ?? "")!", andWithMsg: "Has perdido, obtuviste \(Player.playerP ?? 0) puntos, incicia sesión con otro usuario")
            }
//            print("numers:\(numers)")
        }
    }
    
    func bestPlayer(){
        var idPlay: Int = 0
        let players:[Player] = Player.allPlayers()
        let countP = players.count
        var va = 0
        if countP > 0 {
            for play in players {
                va += 1
//                print(va)
                if countP > va {
                    if va < countP {
//                        print(play.puntaje)
//                        print(players[va].puntaje)
                        if play.puntaje < players[va].puntaje {
                            idPlay = va
                        }
                    }
                }
            }
            self.ayerLbBestPlayer.text = "Best Player: \(players[idPlay].username ?? "") "
        }
    }
}




