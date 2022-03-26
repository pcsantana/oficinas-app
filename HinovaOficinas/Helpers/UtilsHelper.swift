//
//  AlertaHelper.swift
//  HinovaOficinas
//
//  Created by Paulo Santana on 24/03/22.
//

import UIKit

class UtilsHelper: NSObject {
    
    class func mostrarAlerta(titulo: String, mensagem: String, controller: UIViewController) {
        
        let alertController = UIAlertController(title: titulo, message: mensagem, preferredStyle: .alert)
        
        let okAction = UIAlertAction(title: "OK, entendi", style: .default, handler: nil)
        alertController.addAction(okAction)
        
        controller.present(alertController, animated: true, completion: nil)
    }
    
    class func abrirAppUrl(_ urlApp: String, nomeApp: String, controller: UIViewController) {
        if let url = URL(string: urlApp), UIApplication.shared.canOpenURL(url) {
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        } else {
            UtilsHelper.mostrarAlerta(titulo: "Ops!", mensagem: "Não foi possível abrir \(nomeApp)", controller: controller)
        }
    }
}
