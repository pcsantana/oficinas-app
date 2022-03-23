//
//  OficinaViewModel.swift
//  HinovaOficinas
//
//  Created by Paulo Santana on 22/03/22.
//

import UIKit

class OficinaViewModel: NSObject {
    
    let nome: String
    let descricaoCurta: String
    let endereco: String
    let foto: UIImage?

    init(_ oficina: Oficina) {
        self.nome = oficina.nome
        self.descricaoCurta = oficina.descricaoCurta
        self.endereco = oficina.endereco
        
        if let data = Data(base64Encoded: oficina.foto), let image = UIImage(data: data) {
            self.foto = image
        } else {
            self.foto = nil
        }
    }
}
