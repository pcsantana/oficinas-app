//
//  IndicacaoViewModel.swift
//  HinovaOficinas
//
//  Created by Paulo Santana on 26/03/22.
//

import Foundation

class IndicacaoViewModel {

    let nomeAmigo: String?
    let telefoneAmigo: String?
    let emailAmigo: String?
    
    init(_ nome: String, _ telefone: String, _ email: String) {
        self.nomeAmigo = nome
        self.telefoneAmigo = telefone
        self.emailAmigo = email
    }
}
