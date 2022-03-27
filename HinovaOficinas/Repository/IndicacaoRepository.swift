//
//  IndicacaoRepository.swift
//  HinovaOficinas
//
//  Created by Paulo Santana on 26/03/22.
//

import Foundation

protocol IndicacaoRepositoryProtocol {
    func enviarIndicacao(_ indicacao: IndicacaoViewModel, associado: Associado) async throws -> String
}

class IndicacaoRepository: IndicacaoRepositoryProtocol {
    
    private var service: IndicacaoServiceProtocol
    
    init(service: IndicacaoServiceProtocol = IndicacaoService()) {
        self.service = service
    }
    
    func enviarIndicacao(_ indicacao: IndicacaoViewModel, associado: Associado) async throws -> String {
        let indicacao = Indicacao(
            codigoAssociacao: associado.codigioAssociacao,
            dataCriacao: DataHelper.formatarData(Date(), formato: "yyyy-MM-dd"),
            cpfAssociado: associado.cpfAssociado,
            emailAssociado: associado.emailAssociado,
            nomeAssociado: associado.nomeAssociado,
            telefoneAssociado: associado.telefoneAssociado,
            placaVeiculoAssociado: associado.placaVeiculoAssociado,
            nomeAmigo: indicacao.nomeAmigo,
            telefoneAmigo: indicacao.telefoneAmigo,
            emailAmigo: indicacao.emailAmigo
        )
        return try await service.enviarIndicacao(indicacao)
    }

}
