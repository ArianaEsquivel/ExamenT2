//
//  ViewController.swift
//  ExamenT2
//
//  Created by Ariana Esquivel on 04/03/21.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var ayerTfNombre: UITextField!
    @IBOutlet weak var ayerBtnJugar: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.ayerBtnJugar.layer.cornerRadius = self.ayerBtnJugar.bounds.height / 2
    }

    @IBAction func ayerJugar(_ sender: UIButton) {
        let ayerNombre: String = ayerTfNombre.text ?? ""
        var exist = false
        if !ayerNombre.isEmpty{
            for player in Player.allPlayers() {
//                print("Username: \(player.username ?? "")")
                if player.username == ayerNombre{
                    sender.shake()
                    self.alertDefault(with: "Ya existe \(player.username ?? "")", andWithMsg: "Este usuario ya existe, intenta con otro")
                    exist = true
                }
            }
            if !exist {
                Player.playerN = self.ayerTfNombre.text ?? ""
                Player.playerP = 0
                self.ayerTfNombre.text = ""
                
            }
            
        }
        else{
            self.alertDefault(with: "Campo vacío", andWithMsg: "Ingresa un usuario por favor")
        }
    }
    
}

extension UIViewController{
    func alertDefault(with title:String, andWithMsg description:String){
        let alert = UIAlertController(title: title, message: description, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: {(a) in alert.dismiss(animated: true, completion: nil)}))
        self.present(alert, animated: true, completion: nil)
    }
}

extension UIButton{
    func shake(){
        UIButton.animate(withDuration: 0.2) {
            self.transform = CGAffineTransform(translationX: 10, y: -10)
            UIButton.animate(withDuration: 0.1, animations:{
                                self.transform = CGAffineTransform(translationX: 10, y: -10)}, completion: {(Bool) in UIButton.animate(withDuration: 0.1) {
                                    self.transform = CGAffineTransform(translationX: -10, y: 10)
                                    } completion: { finished in
                                    UIButton.animate(withDuration: 0.1) {
                                        self.transform = CGAffineTransform(translationX: 0, y: 0)}}})
        }
    }
    func change(){
        let color:UIColor! = self.backgroundColor
        UIButton.animate(withDuration: 1) {
            self.backgroundColor = UIColor.black
            UIButton.animate(withDuration: 1){
                self.backgroundColor = color
            }
        }
    }
}
