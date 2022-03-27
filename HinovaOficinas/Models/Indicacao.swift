//
//  Indicacao.swift
//  HinovaOficinas
//
//  Created by Paulo Santana on 26/03/22.
//

import Foundation

struct Indicacao: Codable {
    let codigoAssociacao: String?
    let dataCriacao: String?
    let cpfAssociado: String?
    let emailAssociado: String?
    let nomeAssociado: String?
    let telefoneAssociado: String?
    let placaVeiculoAssociado: String?
    let nomeAmigo: String?
    let telefoneAmigo: String?
    let emailAmigo: String?

    static func toJson(_ data: Data?) -> [String: Any]? {
        do {
            if (data == nil) {
                return nil
            }
            return try JSONSerialization.jsonObject(with: data!, options: []) as? [String: Any]
        } catch {
            print(error)
            return nil
        }
    }
}

extension Indicacao {
    enum CodingKeys: String, CodingKey {
        case codigoAssociacao = "CodigoAssociacao"
        case dataCriacao = "DataCriacao"
        case cpfAssociado = "CpfAssociado"
        case emailAssociado = "EmailAssociado"
        case nomeAssociado = "NomeAssociado"
        case telefoneAssociado = "TelefoneAssociado"
        case placaVeiculoAssociado = "PlacaVeiculoAssociado"
        case nomeAmigo = "NomeAmigo"
        case telefoneAmigo = "TelefoneAmigo"
        case emailAmigo = "EmailAmigo"
    }
}
