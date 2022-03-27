//
//  IndicacaoServiceProtocol.swift
//  HinovaOficinas
//
//  Created by Paulo Santana on 26/03/22.
//

import Foundation

protocol IndicacaoServiceProtocol {
    func enviarIndicacao(_ indicacao: Indicacao) async throws -> String
}

class IndicacaoService: IndicacaoServiceProtocol {
    
    func enviarIndicacao(_ indicacao: Indicacao) async throws -> String {
        let indicacaoData = try JSONEncoder().encode(indicacao)
        let jsonIndicacao = Indicacao.toJson(indicacaoData)
        let json = ["Indicacao": jsonIndicacao]
        
        let retorno = try await RequisicaoService.shared.post(Api.baseUrl + "/Indicacao", body: json as [String : Any])
        var sucesso = "Indicação enviada com sucesso!"
        if let json = retorno as? [String: Any] {
            if let mensagemSucesso = json["Sucesso"] as? String {
                sucesso = mensagemSucesso
            }
        }
        return sucesso
    }
}
