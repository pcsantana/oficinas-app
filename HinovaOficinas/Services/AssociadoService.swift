//
//  AssociadoService.swift
//  HinovaOficinas
//
//  Created by Paulo Santana on 23/03/22.
//

import Foundation

protocol AssociadoServiceProtocol {
    func obterAssociado() async throws -> Associado
}

class AssociadoService: AssociadoServiceProtocol {
    
    private var associado: Associado?

    func obterAssociado() async throws -> Associado {
        if (associado == nil) {
            // Mock
            associado = Associado(
                id: 1,
                nomeAssociado: "Paulo",
                cpfAssociado: "12345678900",
                emailAssociado: "meuemail@gmail.com",
                telefoneAssociado: "11999999999",
                placaVeiculoAssociado: "ABC1234",
                codigioAssociacao: "601"
            )
        }
        return associado!
    }
}
