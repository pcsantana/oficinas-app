//
//  UsuarioRepository.swift
//  HinovaOficinas
//
//  Created by Paulo Santana on 23/03/22.
//

import Foundation

protocol AssociadoRepositoryProtocol {
    func obterAssociado() async throws -> Associado
}

class AssociadoRepository: AssociadoRepositoryProtocol {
    
    private let associadoService: AssociadoServiceProtocol
    
    init(_ associadoService: AssociadoServiceProtocol = AssociadoService()) {
        self.associadoService = associadoService
    }
    
    func obterAssociado() async throws -> Associado {
        return try await associadoService.obterAssociado()
    }
    
}
