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
    
    static func removerMascara(_ valor: String?) -> String? {
        guard let valorMascarado = valor else { return nil }
        let separatorArray = CharacterSet(charactersIn: ".-/() ")
        return valorMascarado.components(separatedBy: separatorArray).joined(separator: "")
    }
    
    // Referência: https://multithreaded.stitchfix.com/blog/2016/11/02/email-validation-swift/
    static func validarEmail(field: UITextField) -> String? {
        guard let trimmedText = field.text?.trimmingCharacters(in: .whitespacesAndNewlines) else {
            return nil
        }
        guard let dataDetector = try? NSDataDetector(types: NSTextCheckingResult.CheckingType.link.rawValue) else {
            return nil
        }
        let range = NSMakeRange(0, NSString(string: trimmedText).length)
        let allMatches = dataDetector.matches(in: trimmedText, options: [], range: range)
        if allMatches.count == 1, allMatches.first?.url?.absoluteString.contains("mailto:") == true {
            return trimmedText
        }
        return nil
    }
}
