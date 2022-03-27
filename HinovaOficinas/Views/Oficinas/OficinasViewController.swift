//
//  ViewController.swift
//  HinovaOficinas
//
//  Created by Paulo Santana on 22/03/22.
//

import UIKit

class OficinasViewController: UIViewController {
    
    @IBOutlet weak var topView: UIView!
    @IBOutlet weak var oficinasTableView: UITableView!
    @IBOutlet weak var nenhumContentView: UIView!
    @IBOutlet weak var nenhumContentViewConstraint: NSLayoutConstraint!
    
    private var oficinas: [OficinaViewModel] = []
    private var associado: Associado? = nil
    
    private var associadoRepository: AssociadoRepositoryProtocol!
    private var oficinaRepository: OficinaRepositoryProtocol!

    
    // MARK: Métodos ciclo de vida
    
    override func viewDidLoad() {
        super.viewDidLoad()
        associadoRepository = AssociadoRepository()
        oficinaRepository = OficinaRepository()

        configuraTableView()
        obterDados()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.title = "Oficinas"
    }
    
    // MARK: - Metodos da clase
    
    func configuraTableView() {
        oficinasTableView.register(UINib(nibName: "OficinaTableViewCell", bundle: nil), forCellReuseIdentifier: "OficinaTableViewCell")
        oficinasTableView.dataSource = self
        oficinasTableView.delegate = self
        
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(obterOficinas(_:)), for: .valueChanged)
        oficinasTableView.refreshControl = refreshControl
        
        topView.arredondarCantos([.topLeft, .topRight], radius: 25)
        mostrarLabelNenhumContrado(false)
    }
    
    func obterDados() {
        Task.init {
            do {
                associado = try await associadoRepository.obterAssociado()
                obterOficinas(nil)
            } catch {
                print(error)
                AlertaHelper.mostrarAlerta(titulo: "Ops!", mensagem: error.localizedDescription, controller: self)
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
                AlertaHelper.mostrarAlerta(titulo: "Ops!", mensagem: error.localizedDescription, controller: self)
            }
        }
    }
    
    private func mostrarLabelNenhumContrado(_ mostrar: Bool) {
        nenhumContentViewConstraint.constant = mostrar ? 50 : 0
        nenhumContentView.isHidden = !mostrar
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

        let viewModel = oficinas[indexPath.row]
        let viewController = DetalhesOficinaViewController(nibName: "DetalhesOficinaViewController", bundle: nil)
        viewController.detalhesOficina = viewModel
        
        navigationController?.pushViewController(viewController, animated: true)
    }
    
}

