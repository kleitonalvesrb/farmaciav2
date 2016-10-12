//
//  ViewController.swift
//  Minha Farmacia
//
//  Created by Kleiton Batista on 12/10/16.
//  Copyright © 2016 Kleiton Batista. All rights reserved.
//

import UIKit
import Alamofire
class ViewController: UIViewController,UITextFieldDelegate {

    @IBOutlet weak var senha: UITextField!
    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var btnFacebook: UIButton!
    @IBOutlet weak var btnCadastrar: UIButton!
    @IBOutlet weak var btnLogin: UIButton!
    @IBOutlet weak var info: UILabel!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    /**
        Instancia sigleton de usuario
     */
    var user = Usuario.sharedInstance
    
    // padrao da url
    let urlPadrao = UrlWS()
    let utilidades = Util()
  
  
   
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        btnLogin.layer.cornerRadius = 5
        btnFacebook.layer.cornerRadius = 5
        utilidades.configuraLabelInformacao(info, comInvisibilidade: true, comIndicador: activityIndicator, comInvisibilidade: true, comAnimacao: false)
        //        utilidades.configuraLabelInformacao(info, comVisibilidade: true, comIndicador: activityIndicator, comVisibilidade: true, comStatus: false)
        
        // scroll.scrollEnabled = false
        self.senha.delegate = self
        self.email.delegate = self
        
        let tap:UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(ViewController.dismissKeyboard))
        view.addGestureRecognizer(tap)
        

        // Do any additional setup after loading the view, typically from a nib.
    }
    /**
     Apresenta alerta na tela
     */
    func showAlert(title: String, msg: String, titleBtn: String){
        let alerta = UIAlertController(title: title, message:msg, preferredStyle: .Alert)
        alerta.addAction(UIAlertAction(title: titleBtn, style: .Default, handler: { (action) in
            //self.dismissViewControllerAnimated(true, completion: nil)
        }))
        self.presentViewController(alerta, animated: true, completion: nil)
    }
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        
        textField.resignFirstResponder()
        if email == textField{
            senha.becomeFirstResponder() // passa para o proximo campo
        }else{
            login(self) // chama a acao do botao
        }
        return true
    }

    override func viewWillAppear(animated: Bool) {
        configuraNavBar()
        self.tabBarController?.tabBar.hidden = true
    }
    func dismissKeyboard() ->Void{
        self.view.endEditing(true)
    }
    /**
        CONFIGURA NAV VAR
     
     */
    func configuraNavBar(){
        UINavigationBar.appearance().titleTextAttributes = [NSForegroundColorAttributeName : UIColor.whiteColor()]
        self.navigationController?.navigationBar.hidden = true
        self.navigationController?.navigationBar.barStyle = UIBarStyle.Black
    }

    @IBOutlet weak var loginFacebook: UIButton!
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func Cadastrar(sender: AnyObject) {
    }
    @IBAction func login(sender: AnyObject) {
        let util = Util()
        if (util.isVazio(email.text!) || util.isVazio(senha.text!)){
            showAlert("Ops!", msg: "Os campos email e senha devem ser informados!", titleBtn: "OK")
        }else{
            UIApplication.sharedApplication().beginIgnoringInteractionEvents()
            
            utilidades.configuraLabelInformacao(info, comInvisibilidade: false, comIndicador: activityIndicator, comInvisibilidade: false, comAnimacao: true)
            
            fazLogin(email.text!, senha: senha.text!)
        }

    }
    /**
     Recuperar senha
     O metodo irá gerar um alert que irá receber o email do usuario e posteriormente irá fazer uma requisição
     no ws pendido a recuperação da senha
     */
    @IBAction func recuperarSenha(sender: AnyObject) {
        let alert = UIAlertController(title: "Recuperar Senha", message: "Digite o email cadastrado", preferredStyle: .Alert)
        let recuperaSenha = UIAlertAction(title: "Recuperar", style: .Default) { (_) in
            let emailText = alert.textFields![0] as UITextField
            // realizar a requisição com o email informado
            if emailText.text!.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceCharacterSet()) != ""{
                let dicEmail = ["email":emailText.text!]
                // apresenta o carregamento
                self.info.hidden = false
                self.activityIndicator.hidden = false
                self.activityIndicator.startAnimating()
                
                //Solicitar a requisição com email inforamdo
                Alamofire.request(.GET,self.urlPadrao.urlRecuperarSenha(emailText.text!),parameters: dicEmail ).responseJSON(completionHandler: { (response) in
                    if let JSON = response.result.value{ // verifica se a responsta é valida
                        if JSON.count != nil{ // verifica se possui conteudo
                            if JSON.objectForKey("email") as! String != ""{ // verifica se o servidor repondeu que encontrou o email
                                self.showAlert("Recuperação de Senha", msg: "Em instantes você receberá um e-mail com sua senha", titleBtn: "OK")
                            }else{// não encontrou o email da mensagem de alerta
                                self.showAlert("Recuperação de Senha", msg: "O e-mail informado não está cadastrado", titleBtn: "OK")
                            }
                        }
                    }
                    // retira o carregamento da view
                    self.info.hidden = true
                    self.activityIndicator.hidden = true
                    self.activityIndicator.stopAnimating()
                })
            }
            
            
        }
        
        
        alert.addTextFieldWithConfigurationHandler { (textField) in
            textField.placeholder = "E-mail"
            textField.keyboardType = .EmailAddress
        }
        let cancelAction = UIAlertAction(title: "Cancelar", style: .Destructive) { (_) in }
        alert.addAction(recuperaSenha)
        alert.addAction(cancelAction)
        
        self.presentViewController(alert, animated: true, completion: nil)
        

    }
    @IBAction func loginFacebook(sender: AnyObject) {
    }
    
    /**
        Método resposavel por tratar todos os dados do login
     */
    func fazLogin(email:String, senha:String) -> Void{
        
        //        Alamofire.request(.POST, "").authenticate(user: <#T##String#>, password: <#T##String#>)
        
        
        
        let url = urlPadrao.urlRealizaLogin(email, senha: senha)
        //let url = "http://minhafarmacia-env.us-west-2.elasticbeanstalk.com:80/cliente/login/\(email)-\(senha)"
        print(url)
        Alamofire.request(.GET,  url).authenticate(user: email, password: senha).responseJSON { (response) in
            if let JSON = response.result.value{
                print("------->\(response.result.isSuccess) ")
                if JSON.count != nil{
                    print(JSON)
                    if let idUsuario = JSON.objectForKey("idUsuario") as? String{
                        self.user.id = Int(idUsuario)
                        
                    }
                    if let nomeUsuario = JSON.objectForKey("nome") as? String{
                        self.user.nome = nomeUsuario
                    }
                    if let email = JSON.objectForKey("email") as? String{
                        self.user.email = email
                    }
                    if let idFacebook = JSON.objectForKey("idFacebook") as? String{
                        self.user.idFacebook = idFacebook
                    }else{
                        self.user.idFacebook = "Não Informado"
                    }
                    if let dataString = JSON.objectForKey("dataNascimento") as? String{
                        //            trataData(dataString)
                        print("acertar a data de nascimento")
                    }
                    if let senha = JSON.objectForKey("senha") as? String{
                        self.user.senha = senha
                    }
                    if let sexo = JSON.objectForKey("sexo") as? String{
                        self.user.sexo = sexo
                    }
                    if let fotoString = JSON.objectForKey("foto") as? String{
                        self.user.foto = self.tratarImagemUsuario(fotoString)
                    }else{
                        self.user.foto = UIImage(named: "homem.png")
                    }
                    
                    self.utilidades.configuraLabelInformacao(self.info, comInvisibilidade: true, comIndicador: self.activityIndicator, comInvisibilidade: true, comAnimacao: false)
                    UIApplication.sharedApplication().endIgnoringInteractionEvents()
                    
                    
                    let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
                    
                   /* let resultViewController = storyBoard.instantiateViewControllerWithIdentifier("ListaMedicamentos") as! MedicamentoViewController
                    
                    let navController = UINavigationController(rootViewController: resultViewController) // Creating a navigation controller with resultController at the root of the navigation stack.
                    self.presentViewController(navController, animated:true, completion: nil)
                    */
                    self.showAlert("Tratar", msg: "Tratar o encaminhamento para a tela de Medicamentos", titleBtn: "ok")
                    
                }else{
                    
                    self.showAlert("Ops", msg: "Usuário ou Senha incorreto!", titleBtn: "ok")
                }
            }
            
            self.utilidades.configuraLabelInformacao(self.info, comInvisibilidade: true, comIndicador: self.activityIndicator, comInvisibilidade: true, comAnimacao: false)
            UIApplication.sharedApplication().endIgnoringInteractionEvents()
            
        }
    }
    func tratarImagemUsuario(imgStr: String)-> UIImage{
        var image = UIImage()
        let util = Util()
        if imgStr.characters.count > 10{
            image = util.convertStringToImage(imgStr)
        }else{
            image = UIImage(named: "homem.png")!
        }
        return image
    }
    
    func trataData(dataString:String) ->NSDate{
        let strDate = dataString //"2015-10-06T15:42:34Z"
        let dateFormatter = NSDateFormatter()
        
        dateFormatter.dateStyle = NSDateFormatterStyle.MediumStyle
        dateFormatter.timeStyle = NSDateFormatterStyle.NoStyle
        dateFormatter.locale = NSLocale(localeIdentifier: "pt-BR")
        var date = NSDate()
        date = dateFormatter.dateFromString(strDate)!
        print(date)
        return date
    }

    
}

