//
//  OficinaRepository.swift
//  HinovaOficinas
//
//  Created by Paulo Santana on 23/03/22.
//

import Foundation

protocol OficinaRepositoryProtocol {
    func obterOficinas(codigoAssociacao: Int, cpfAssociado: String) async throws -> [OficinaViewModel]
}

class OficinaRepository: OficinaRepositoryProtocol {
    
    private let oficinaService: OficinaServiceProtocol
    
    init(_ oficinaService: OficinaServiceProtocol = OficinaService()) {
        self.oficinaService = oficinaService
    }
    
    func obterOficinas(codigoAssociacao: Int, cpfAssociado: String) async throws -> [OficinaViewModel] {
        let oficinas = try await oficinaService.obterOficinas(codigoAssociacao: codigoAssociacao, cpfAssociado: cpfAssociado)
        var oficinasViewModel: [OficinaViewModel] = []
        for oficina in oficinas {
            oficinasViewModel.append(OficinaViewModel(oficina))
        }
        return oficinasViewModel
    }
    
}
