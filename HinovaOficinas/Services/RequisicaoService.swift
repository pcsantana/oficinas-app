//
//  RequisicaoService.swift
//  HinovaOficinas
//
//  Created by Paulo Santana on 23/03/22.
//

import UIKit
import Alamofire

protocol RequisicaoServiceProtocol {
    func get(_ url: String) async throws -> Any?
    func get(_ url: String, headers: HTTPHeaders?) async throws -> Any?
}

class RequisicaoService: RequisicaoServiceProtocol {
    
    static let shared: RequisicaoServiceProtocol = RequisicaoService()
    
    // MARK: Inicializador
    
    private init() { }
    
    // MARK: RequisicaoServiceProtocol
    
    func get(_ url: String) async throws -> Any? {
        return try await get(url, headers: nil)
    }

    func get(_ url: String, headers: HTTPHeaders?) async throws -> Any? {
        return try await withCheckedThrowingContinuation { continuation in
            AF.request(url, method: .get, headers: headers).validate().responseData { resposta in
                switch resposta.result {
                case .success:
                    guard let json = self.obterObjetoJson(resposta.value) else {
                        continuation.resume(throwing: AppErro(mensagem: "Nenhum resultado encontrado"))
                        return
                    }
                    if let retornoErro = json["RetornoErro"] as? [String: Any] {
                        if let erro = retornoErro["retornoErro"] {
                            if let erroMensagem = erro as? String {
                                continuation.resume(throwing: AppErro(mensagem: erroMensagem))
                                return
                            }
                        }
                    }
                    continuation.resume(returning: json)
                    break
                case .failure:
                    continuation.resume(throwing: AppErro(mensagem: resposta.error?.localizedDescription ?? "Ocorreu um erro de comunicação com o Servidor, tente novamente mais tarde"))
                    break
                }
            }
        }
    }
    
    func post() {
        
    }
    
    // MARK: Métodos
    
    private func obterObjetoJson(_ jsonData: Data?) -> [String: Any]? {
        do {
            if (jsonData == nil) {
                return nil
            }
            return try JSONSerialization.jsonObject(with: jsonData!, options: []) as? [String: Any]
        } catch {
            print(error)
            return nil
        }
    }

}
