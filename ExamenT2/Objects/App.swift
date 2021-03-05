//
//  App.swift
//  ExamenT2
//
//  Created by Ariana Esquivel on 04/03/21.
//

import UIKit

class App: NSObject {
    static let shared = App()
    let defaults = UserDefaults.standard
    var players = [Player]()
}
