//
//  IndicacaoViewController.swift
//  HinovaOficinas
//
//  Created by Paulo Santana on 26/03/22.
//

import UIKit

class IndicacaoViewController: UIViewController {

    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var stackContentView: UIStackView!
    @IBOutlet weak var nomeTextField: UITextField!
    @IBOutlet weak var telefoneTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var enviarIndicacaoButton: UIButton!
    
    private var textFields: [UITextField] = []
    
    private var associadoRepository: AssociadoRepositoryProtocol!
    private var indicacaoRespository: IndicacaoRepositoryProtocol!
    
    
    // MARK: Métodos de ciclo de vida
    
    override func viewDidLoad() {
        super.viewDidLoad()        
        associadoRepository = AssociadoRepository()
        indicacaoRespository = IndicacaoRepository()
        prepararTela()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        registerKeyboardNotifications()
        navigationController?.navigationBar.prefersLargeTitles = false
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        deregisterKeyboardNotifications()
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    // MARK: Textfield notifications
    
    func registerKeyboardNotifications() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWasShown(_:)), name: UIResponder.keyboardDidShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillBeHidden(_:)), name:UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    func deregisterKeyboardNotifications() {
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardDidShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    @objc func keyboardWasShown(_ notification: Notification) {
        if let info = notification.userInfo {
            if let keyboardFrame = info[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue {
                let keyboardSize = keyboardFrame.cgRectValue.size
                let contentInsets = UIEdgeInsets.init(top: 0.0, left: 0.0, bottom: keyboardSize.height, right: 0.0)
                self.scrollView.contentInset = contentInsets
                self.scrollView.scrollIndicatorInsets = contentInsets
            }
        }
    }
    
    @objc func keyboardWillBeHidden(_ notification: Notification) {
        let contentInsets = UIEdgeInsets.init(top: 0.0, left: 0.0, bottom: 0.0, right: 0.0)
        self.scrollView.contentInset = contentInsets
        self.scrollView.scrollIndicatorInsets = contentInsets
        self.view.endEditing(false)
    }
    
    // MARK: Métodos da classe

    func prepararTela() {
        view.addGestureRecognizer(UITapGestureRecognizer(target: view, action: #selector(UIView.endEditing(_:))))
        
        scrollView.arredondarCantos([.topLeft, .topRight], radius: 25)
        enviarIndicacaoButton.adicionarBorda(cornerRadius: 8, color: .clear)
        inicializarTextFields()
    }
    
    func inicializarTextFields() {
        nomeTextField.delegate = self
        telefoneTextField.delegate = self
        emailTextField.delegate = self
        textFields =  [nomeTextField, telefoneTextField, emailTextField]
    }
    
    // MARK: IBActions
    
    @IBAction func enviarIndicacao(_ sender: Any?) {
        
        guard let nomeAmigo = nomeTextField.text, !nomeAmigo.isEmpty else {
            AlertaHelper.mostrarAlerta(titulo: "Campo obrigatório", mensagem: "Insira o nome do amigo para indicação", controller: self)
            return
        }
        guard let telefoneAmigo = telefoneTextField.text, !telefoneAmigo.isEmpty else {
            AlertaHelper.mostrarAlerta(titulo: "Campo obrigatório", mensagem: "Insira o telefone do amigo para indicação", controller: self)
            return
        }
        guard let emailAmigo = nomeTextField.text, !emailAmigo.isEmpty else {
            AlertaHelper.mostrarAlerta(titulo: "Campo obrigatório", mensagem: "Insira o e-mail do amigo para indicação", controller: self)
            return
        }
        Task.init {
            do {
                let indicacao = IndicacaoViewModel(nomeAmigo, telefoneAmigo, emailAmigo)
                let associado = try await associadoRepository.obterAssociado()
                let mensagem = try await indicacaoRespository.enviarIndicacao(indicacao, associado: associado)
                
                let voltarAlertaButton = UIAlertAction(title: "Ok, entendi", style: .default, handler: {_ in
                    self.navigationController?.popViewController(animated: true)
                })
                AlertaHelper.mostrarAlertaComAcao(titulo: "Obrigado", mensagem: mensagem, controller: self, listaAcoes: [voltarAlertaButton])
            } catch {
                print(error)
                AlertaHelper.mostrarAlerta(titulo: "Ops!", mensagem: error.localizedDescription, controller: self)
            }
        }
    }
    
}

extension IndicacaoViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if let indexAtual = textFields.firstIndex(of: textField), indexAtual < textFields.count - 1 {
            textFields[indexAtual + 1].becomeFirstResponder()
        } else {
            enviarIndicacao(nil)
            textField.resignFirstResponder()
        }
        return true
    }

}
