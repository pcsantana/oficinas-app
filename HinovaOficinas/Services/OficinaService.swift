//
//  OficinaService.swift
//  HinovaOficinas
//
//  Created by Paulo Santana on 23/03/22.
//

import Foundation

protocol OficinaServiceProtocol {
    func obterOficinas(codigoAssociacao: Int, cpfAssociado: String) async throws -> [Oficina]
}

class OficinaService: OficinaServiceProtocol {
    
    func obterOficinas(codigoAssociacao: Int, cpfAssociado: String) async throws -> [Oficina] {
        let retorno = try await RequisicaoService.shared.get("\(Api.baseUrl)/Oficina?codigoAssociacao=\(codigoAssociacao)&cpfAssociado=\(cpfAssociado)")
        var oficinas: [Oficina] = []
        if let json = retorno as? [String: Any] {
            if let listaOficina = json["ListaOficinas"] as? [[String: Any]] {
                for oficinaDict in listaOficina {
                    if let oficinaData = Oficina.jsonToData(oficinaDict) {
                        if let oficina = Oficina.decodeJsonData(oficinaData) {
                            oficinas.append(oficina)
                        }
                    }
                }
            }
        }
        return oficinas
    }
    
}
