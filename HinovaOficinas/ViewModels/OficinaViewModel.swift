//
//  OficinaViewModel.swift
//  HinovaOficinas
//
//  Created by Paulo Santana on 22/03/22.
//

import UIKit
import CoreLocation

class OficinaViewModel: NSObject {
    
    let nome: String?
    var descricao: String?
    let descricaoCurta: String?
    let endereco: String?
    let foto: UIImage?
    let codigoAssociacao: Int?
    let email: String?
    let telefone1: String?
    let telefone2: String?
    let ativo: Bool?
    var latitude: CLLocationDegrees?
    var longitude: CLLocationDegrees?

    init(_ oficina: Oficina) {
        self.nome = oficina.nome
        self.descricao = oficina.descricao
        self.descricaoCurta = oficina.descricaoCurta
        self.endereco = oficina.endereco
        self.codigoAssociacao = oficina.codigoAssociacao
        self.email = oficina.email
        self.telefone1 = oficina.telefone1
        self.telefone2 = oficina.telefone2
        self.ativo = oficina.ativo
        self.latitude = nil
        self.longitude = nil
        
        if (descricao != nil) {
            descricao = descricao!.replacingOccurrences(of: "\\n", with: "\n")
        }
        if (oficina.latitude != nil && oficina.longitude != nil) {
            if let lat = Double(oficina.latitude!), let lng = Double(oficina.longitude!) {
                self.latitude = lat
                self.longitude = lng
            }
        }
        if let data = Data(base64Encoded: oficina.foto ?? ""), let image = UIImage(data: data) {
            self.foto = image
        } else {
            self.foto = nil
        }
    }
}
