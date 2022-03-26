//
//  Oficina.swift
//  HinovaOficinas
//
//  Created by Paulo Santana on 22/03/22.
//

import Foundation

struct Oficina: Decodable {
    
    let id: Int?
    let nome: String?
    let descricao: String?
    let descricaoCurta: String?
    let endereco: String?
    let latitude: String?
    let longitude: String?
    let foto: String?
    let avaliacaoUsuario: Int?
    let codigoAssociacao: Int?
    let email: String?
    let telefone1: String?
    let telefone2: String?
    let ativo: Bool?
    
    static func jsonToData(_ json: [String: Any]) -> Data? {
        do {
            return try JSONSerialization.data(withJSONObject: json, options: [])
        } catch {
            print(error.localizedDescription)
            return nil
        }
    }

    static func decodeJsonData(_ jsonData: Data) -> Oficina? {
        do {
            return try JSONDecoder().decode(Oficina.self, from: jsonData)
        } catch {
            print(error.localizedDescription)
            return nil
        }
    }
}

extension Oficina {
    enum CodingKeys: String, CodingKey {
        case id = "Id"
        case nome = "Nome"
        case descricao = "Descricao"
        case descricaoCurta = "DescricaoCurta"
        case endereco = "Endereco"
        case latitude = "Latitude"
        case longitude = "Longitude"
        case foto = "Foto"
        case avaliacaoUsuario = "AvaliacaoUsuario"
        case codigoAssociacao = "CodigoAssociacao"
        case email = "Email"
        case telefone1 = "Telefone1"
        case telefone2 = "Telefone2"
        case ativo = "Ativo"
    }
}
