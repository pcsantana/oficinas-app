//
//  AlertaHelper.swift
//  HinovaOficinas
//
//  Created by Paulo Santana on 26/03/22.
//

import UIKit

class AlertaHelper {
    
    static func mostrarAlerta(titulo: String, mensagem: String, controller: UIViewController) {
        let alertController = UIAlertController(title: titulo, message: mensagem, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK, entendi", style: .default, handler: nil)
        alertController.addAction(okAction)
        controller.present(alertController, animated: true, completion: nil)
    }
    
    static func mostrarAlertaComAcao(titulo: String, mensagem: String, controller: UIViewController, listaAcoes: [UIAlertAction]){
        let alertController = UIAlertController(title: titulo, message: mensagem, preferredStyle: .alert)
        for acao in listaAcoes {
            alertController.addAction(acao)
        }
        controller.present(alertController, animated: true, completion: nil)
    }

}
