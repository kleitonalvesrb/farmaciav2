//
//  ViewController.swift
//  Minha Farmacia
//
//  Created by Kleiton Batista on 12/10/16.
//  Copyright © 2016 Kleiton Batista. All rights reserved.
//

import UIKit
import Alamofire
class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        verificaDisponibilidadeEmail("kleiton.a.batista@gmail.com")
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func verificaDisponibilidadeEmail(email:String) -> Void{
        
        let emailDic = ["email":email]
        
        Alamofire.request(.GET, urlConsultaDisponibilidadeEmail(email), parameters: emailDic).responseJSON { (response) in
            if let JSON = response.result.value{
                print(JSON)
                if JSON.count != nil{
                    if JSON["email"] as! String == ""{
                       // self.imgInfoEmail.image = UIImage(named: "ok.png")
                        //self.btnCadastrar.userInteractionEnabled = true
                    }else{
                        //self.imgInfoEmail.image = UIImage(named: "negado.png")
                        //self.btnCadastrar.userInteractionEnabled = false
                    }
                    
                }else{// else de verificacao do retorno diferente de nulo
                    //self.geraAlerta("Erro", mensagem: "Ocorreu um erro inesperado, tente novamente mais tarde!")
                }
            }else{// else verificacao da conversao para json
               // self.geraAlerta("Erro", mensagem: "Ocorreu um erro inesperado, tente novamente mais tarde!")
                print(response.timeline.latency)
            }
            
        }//fim requisica
    }//fim da funcao

    private let host = "minhafarmacia-env.us-west-2.elasticbeanstalk.com"
    //private let host = "192.168.15.6"
    // private let porta = "8080/WebService"
    private let porta = "80"
    private let rota = "/cliente/"
    private let rotaMedicamento = "/medicamento/"
    func urlConsultaDisponibilidadeEmail(email: String) ->String{
        return "http://\(host):\(porta)\(rota)consulta-email/\(email)"
    }
}

