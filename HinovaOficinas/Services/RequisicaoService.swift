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
    
    func post(_ url: String, body: [String: Any]?) async throws -> Any?
    func post(_ url: String, body: [String: Any]?, headers: HTTPHeaders?) async throws -> Any?
}

class RequisicaoService: RequisicaoServiceProtocol {
    
    static let shared: RequisicaoServiceProtocol = RequisicaoService()
    
    // MARK: RequisicaoServiceProtocol
    
    func get(_ url: String) async throws -> Any? {
        return try await get(url, headers: nil)
    }

    func get(_ url: String, headers: HTTPHeaders?) async throws -> Any? {
        return try await withCheckedThrowingContinuation { continuation in
            AF.request(url, method: .get, headers: headers).validate().responseData { resposta in
                self.tratarResposta(resposta, continuacao: continuation)
            }
        }
    }
    
    func post(_ url: String, body: [String : Any]?) async throws -> Any? {
        return try await post(url, body: body, headers: nil)
    }
    
    func post(_ url: String, body: [String: Any]?, headers: HTTPHeaders?) async throws -> Any? {        
        return try await withCheckedThrowingContinuation { continuacao in
            AF.request(url, method: .post, parameters: body, headers: headers).validate().responseData { resposta in
                self.tratarResposta(resposta, continuacao: continuacao)
            }
        }
    }
    
    // MARK: Métodos auxiliares da classe
    
    private func tratarResposta(_ resposta: AFDataResponse<Data>, continuacao: CheckedContinuation<Any?, Error>) {
        switch resposta.result {
        case .success:
            guard let json = self.obterObjetoJson(resposta.value) else {
                continuacao.resume(returning: nil)
                return
            }
            if let retornoErro = json["RetornoErro"] as? [String: Any] {
                if let erro = retornoErro["retornoErro"] {
                    if let erroMensagem = erro as? String {
                        continuacao.resume(throwing: AppErro(mensagem: erroMensagem))
                        return
                    }
                }
            }
            continuacao.resume(returning: json)
            break
        case .failure:
            continuacao.resume(throwing: AppErro(mensagem: resposta.error?.localizedDescription ?? "Ocorreu um erro de comunicação com o Servidor, tente novamente mais tarde"))
            break
        }
    }
    
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
