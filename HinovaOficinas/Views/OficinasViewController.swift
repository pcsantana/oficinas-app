//
//  ViewController.swift
//  HinovaOficinas
//
//  Created by Paulo Santana on 22/03/22.
//

import UIKit

class OficinasViewController: UIViewController {
    
    @IBOutlet weak var oficinasTableView: UITableView!

    let oficinas: Array<OficinaViewModel> = []

    override func viewDidLoad() {
        super.viewDidLoad()
        configuraTableView()
    }
    
    func configuraTableView() {
        oficinasTableView.register(UINib(nibName: "OficinaTableViewCell", bundle: nil), forCellReuseIdentifier: "OficinaTableViewCell")
        oficinasTableView.dataSource = self
        oficinasTableView.delegate = self
    }

}

extension OficinasViewController: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return oficinas.count
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "OficinaTableViewCell") as? OficinaTableViewCell else {
            fatalError("Erro ao criar OficinaTableViewCell")
        }
//        let viewModel = oficinas[indexPath.section]
        cell.configuraTableViewCell(nil)
        return cell
    }
}

extension OficinasViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
}

