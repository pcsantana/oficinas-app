//
//  DetalhesOficinaViewController.swift
//  HinovaOficinas
//
//  Created by Paulo Santana on 24/03/22.
//

import UIKit
import MapKit

class DetalhesOficinaViewController: UIViewController {

    @IBOutlet weak var fotoImageView: UIImageView!
    @IBOutlet weak var tituloLabel: UILabel!
    @IBOutlet weak var descricaoTextView: UITextView!
    
    @IBOutlet weak var mapaView: MKMapView!
    @IBOutlet weak var enderecoLabel: UILabel!
    @IBOutlet weak var comoChegarButton: UIButton!
    
    @IBOutlet weak var telefoneContentView: UIStackView!
    @IBOutlet weak var telefoneLabel: UILabel!
    @IBOutlet weak var ligarButton: UIButton!
    
    @IBOutlet weak var emailContentView: UIStackView!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var emailButton: UIButton!
    
    
    var detalhesOficina: OficinaViewModel?
    
    // MARK: Métodos ciclo de vida
    
    override func viewDidLoad() {
        super.viewDidLoad()
        prepararView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.isHidden = true
        navigationController?.navigationBar.prefersLargeTitles = false
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        navigationController?.navigationBar.isHidden = false
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    // MARK: Métodos classe
    
    func prepararView() {
        fotoImageView.image = detalhesOficina?.foto
        tituloLabel.text = detalhesOficina?.nome
        descricaoTextView.text = detalhesOficina?.descricao
        enderecoLabel.text = detalhesOficina?.endereco
        telefoneLabel.text = detalhesOficina?.telefone1
        emailLabel.text = detalhesOficina?.email
        
        telefoneContentView.isHidden = detalhesOficina?.telefone1 == nil && detalhesOficina?.telefone2 == nil
        emailContentView.isHidden = detalhesOficina?.email == nil

        adicionarPinoMapa()
        configurarLayout()
    }
    
    func configurarLayout() {
        comoChegarButton.adicionarBorda(cornerRadius: 8, color: UIColor.lightGray)
        ligarButton.adicionarBorda(cornerRadius: 8, color: UIColor.lightGray)
        emailButton.adicionarBorda(cornerRadius: 8, color: UIColor.lightGray)
    }
    
    func adicionarPinoMapa() {
        guard let latitude = detalhesOficina?.latitude, let longitude = detalhesOficina?.longitude else {
            mapaView.isHidden = true
            return
        }
        let span = MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01)
        let regiao = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: latitude, longitude: longitude), span: span)
        mapaView.setRegion(regiao, animated: true)
        
        let annotation = MKPointAnnotation()
        annotation.coordinate.latitude = latitude
        annotation.coordinate.longitude = longitude
        mapaView.addAnnotation(annotation)
    }
    
    // MARK: - IBActions
    
    @IBAction func voltar(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func abrirMapa(_ sender: Any) {
        guard let latitude = detalhesOficina?.latitude, let longitude = detalhesOficina?.longitude else {
            return
        }
        let coordinate = CLLocationCoordinate2DMake(latitude, longitude)
        let mapItem = MKMapItem(placemark: MKPlacemark(coordinate: coordinate, addressDictionary: nil))
        mapItem.name = detalhesOficina?.nome
        mapItem.openInMaps(launchOptions: [MKLaunchOptionsDirectionsModeKey: MKLaunchOptionsDirectionsModeDriving])
    }
    
    @IBAction func ligar(_ sender: Any) {
        if let telefone = detalhesOficina?.telefone1 {
            UtilsHelper.abrirAppUrl("tel://\(telefone)", nomeApp: "Telefone", controller: self)
        }
    }

    @IBAction func enviarEmail(_ sender: Any) {
        if let email = detalhesOficina?.email {
            UtilsHelper.abrirAppUrl("mailto://\(email)", nomeApp: "E-mail", controller: self)
        }
    }
}
