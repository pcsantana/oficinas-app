//
//  Oficina.swift
//  HinovaOficinas
//
//  Created by Paulo Santana on 22/03/22.
//

import Foundation

struct Oficina: Codable {
    
    let id: Int
    let nome: String
    let descricao: String
    let descricaoCurta: String
    let endereco: String
    let latitude: String
    let longitude: String
    let foto: String
    let avaliacaoUsuario: Int
    let codigoAssociacao: Int
    let email: String
    let telefone1: String
    let telefone2: String
    let ativo: Bool
}
