//
//  HomeViewController.swift
//  HinovaOficinas
//
//  Created by Paulo Santana on 27/03/22.
//

import UIKit

class HomeViewController: UIViewController {
    
    @IBOutlet weak var topView: UIView!
    @IBOutlet weak var oficinasButton: UIButton!
    @IBOutlet weak var indiqueAmigoButton: UIButton!
    
    private var associado: Associado? = nil
    private var associadoRepository: AssociadoRepositoryProtocol!
    private var oficinaRepository: OficinaRepositoryProtocol!

    // MARK: Métodos ciclo de vida
    
    override func viewDidLoad() {
        super.viewDidLoad()
        associadoRepository = AssociadoRepository()
        
        obterDados()
        configurarLayout()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    // MARK: Métodos da classe
    
    func configurarLayout() {
        topView.arredondarCantos([.topLeft, .topRight], radius: 25)
        oficinasButton.adicionarBorda(cornerRadius: 8, color: UIColor.clear)
        indiqueAmigoButton.adicionarBorda(cornerRadius: 8, color: UIColor.clear)
    }
    
    func obterDados() {
        Task.init {
            do {
                associado = try await associadoRepository.obterAssociado()
                if (associado != nil) {
                    self.title = "Olá, \(associado!.nomeAssociado ?? "Associado")"
                }
            } catch {
                print(error)
                AlertaHelper.mostrarAlerta(titulo: "Ops!", mensagem: error.localizedDescription, controller: self)
            }
        }
    }
    
    // MARK: IBActions
    
    @IBAction func verOficinas(_ sender: Any) {
        let viewController = OficinasViewController(nibName: "OficinasViewController", bundle: nil)
        navigationController?.pushViewController(viewController, animated: true)
    }
    
    @IBAction func indicarAmigo(_ sender: Any) {
        let viewController = IndicacaoViewController(nibName: "IndicacaoViewController", bundle: nil)
        navigationController?.pushViewController(viewController, animated: true)
    }
    
}
