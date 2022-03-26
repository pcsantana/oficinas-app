//
//  AppErro.swift
//  HinovaOficinas
//
//  Created by Paulo Santana on 24/03/22.
//

import Foundation

struct AppErro {
    
    let mensagem: String

    init(mensagem: String) {
        self.mensagem = mensagem
    }
}

extension AppErro: LocalizedError {
    var errorDescription: String? { return mensagem }
}
