//
//  ViewController.swift
//  HinovaOficinas
//
//  Created by Paulo Santana on 22/03/22.
//

import UIKit

class OficinasViewController: UIViewController {
    
    @IBOutlet weak var oficinasTableView: UITableView!
    @IBOutlet weak var nenhumContentViewConstraint: NSLayoutConstraint!
    
    private var oficinas: [OficinaViewModel]
    private var associado: Associado?
    private let associadoRepository: AssociadoRepositoryProtocol
    private let oficinaRepository: OficinaRepositoryProtocol

    // MARK: Init

    required init?(coder: NSCoder) {
        self.associadoRepository = AssociadoRepository()
        self.oficinaRepository = OficinaRepository()
        self.oficinas = []
        self.associado = nil
        super.init(coder: coder)
    }
    
    // MARK: Métodos ciclo de vida
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configuraTableView()
        obterDados()
    }
    
    // MARK: - Metodos da clase
    
    func configuraTableView() {
        oficinasTableView.register(UINib(nibName: "OficinaTableViewCell", bundle: nil), forCellReuseIdentifier: "OficinaTableViewCell")
        oficinasTableView.dataSource = self
        oficinasTableView.delegate = self
        
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(obterOficinas(_:)), for: .valueChanged)
        oficinasTableView.refreshControl = refreshControl
        self.nenhumContentViewConstraint.constant = 0
    }
    
    func obterDados() {
        Task.init {
            do {
                associado = try await associadoRepository.obterAssociado()
                obterOficinas(nil)
            } catch {
                print(error)
                UtilsHelper.mostrarAlerta(titulo: "Ops!", mensagem: error.localizedDescription, controller: self)
            }
        }
    }
    
    @objc func obterOficinas(_ sender: Any?) {
        Task.init {
            do {
                defer {
                    DispatchQueue.main.async(execute: {
                        self.oficinasTableView.reloadData()
                        self.mostrarLabelNenhumContrado(self.oficinas.count == 0)
                        if let refresh = sender as? UIRefreshControl  {
                            refresh.endRefreshing()
                        }
                    })
                }
                if let associadoLogado = associado {
                    oficinas = try await oficinaRepository.obterOficinas(codigoAssociacao: associadoLogado.codigioAssociacao!, cpfAssociado: associadoLogado.cpfAssociado!)
                }
            } catch {
                print(error.localizedDescription)
                self.oficinas = []
                UtilsHelper.mostrarAlerta(titulo: "Ops!", mensagem: error.localizedDescription, controller: self)
            }
        }
    }
    
    private func mostrarLabelNenhumContrado(_ mostrar: Bool) {
        nenhumContentViewConstraint.constant = mostrar ? 50 : 0
    }
}

extension OficinasViewController: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return oficinas.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "OficinaTableViewCell") as? OficinaTableViewCell else {
            fatalError("Erro ao criar OficinaTableViewCell")
        }
        let viewModel = oficinas[indexPath.row]
        cell.configuraTableViewCell(viewModel)
        return cell
    }
}

extension OficinasViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let viewController = DetalhesOficinaViewController(nibName: "DetalhesOficinaViewController", bundle: nil)
            
        let viewModel = oficinas[indexPath.row]
        viewController.detalhesOficina = viewModel
        
        navigationController?.pushViewController(viewController, animated: true)
    }
    
}

