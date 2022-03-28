//
//  UITextField+Extension.swift
//  HinovaOficinas
//
//  Created by Paulo Santana on 28/03/22.
//

import UIKit

extension UITextField {
    
    func mask(_ mascara: String, range: NSRange, novaString: String) {
        
        let positionOriginal = self.beginningOfDocument
        let cursorLocation = self.position(from: positionOriginal, offset: (range.location + novaString.count))
        
        //texto com o novo valor
        guard let valor = self.text as NSString? else { return }
        let novoValor = valor.replacingCharacters(in: range, with: novaString)
        
        //Deletou um caracter
        if (novaString.isEmpty) {
            self.text = novoValor
        } else {
            let antigoValor = UtilsHelper.removerMascara(self.text) ?? ""
            let novoTextoSemMascara = UtilsHelper.removerMascara(novoValor) ?? ""
            
            var masked = ""
            let arrayMask = Array(mascara)
            let arrayValue = Array(novoTextoSemMascara)
            
            var i = 0
            for m in arrayMask {
                if (m != "#" && novoTextoSemMascara.count > antigoValor.count) {
                    masked += String(m)
                } else if i < arrayValue.count {
                    masked = masked + String(arrayValue[i])
                    i += 1
                } else {
                    break
                }
            }
            self.text = masked
        }
        // cursorLocation será nil se o novo caracter seta sendo inserido no fim no texto. Se é no fim, não precisa modificar o cursor
        if (cursorLocation != nil) {
            self.selectedTextRange = self.textRange(from: cursorLocation!, to: cursorLocation!)
        }
    }

}
