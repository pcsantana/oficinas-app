//
//  AlertaHelper.swift
//  HinovaOficinas
//
//  Created by Paulo Santana on 24/03/22.
//

import UIKit

class UtilsHelper: NSObject {
    
    static func abrirAppUrl(_ urlApp: String, nomeApp: String, controller: UIViewController) {
        if let url = URL(string: urlApp), UIApplication.shared.canOpenURL(url) {
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        } else {
            AlertaHelper.mostrarAlerta(titulo: "Ops!", mensagem: "Não foi possível abrir \(nomeApp)", controller: controller)
        }
    }
}
