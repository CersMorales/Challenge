//
//  AltaCliente.swift
//  UP Store Entregas
//
//  Created by Emanuel Morales on 15/12/22.
//  Copyright © 2020 ASNK. All rights reserved.
//

import UIKit
import CoreData
class AltaCliente: UIViewController {
//Elementos de interface
    @IBOutlet weak var nombre: UITextField!
    @IBOutlet weak var apellidoPaterno: UITextField!
    @IBOutlet weak var apellidoMaterno: UITextField!
    @IBOutlet weak var calle: UITextField!
    @IBOutlet weak var numero: UITextField!
    @IBOutlet weak var colonia: UITextField!
    @IBOutlet weak var ciudad: UITextField!
    @IBOutlet weak var numeroContacto: UITextField!
    @IBOutlet weak var referencia: UITextField!
//Contexto
    func conexion ()-> NSManagedObjectContext{
        let delegate = UIApplication.shared.delegate as! AppDelegate
        return delegate.persistentContainer.viewContext
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
//Funciones
    func AvisoGuardado () {
        let alerta = UIAlertController(title: "UP! Store", message: "Se guardo el usuario", preferredStyle: .alert)
        let accion = UIAlertAction(title: "Ok", style: .default, handler: { action in
            self.dismiss(animated: true, completion: nil)
            })
        alerta.addAction(accion)
        present(alerta, animated: true, completion: nil)
    }
//Guardar
    @IBAction func guardarCliente (_ sender: UIButton) {
        if nombre.text != "" && apellidoPaterno.text != "" && apellidoMaterno.text != "" && calle.text != "" && numero.text != "" && colonia.text != "" && ciudad.text != "" && numeroContacto.text != "" && referencia.text != "" {
        let contexto = conexion()
        let entidadCliente = NSEntityDescription.insertNewObject(forEntityName: "Clientes", into: contexto) as! Clientes
        entidadCliente.nombre = nombre.text
        entidadCliente.apellidopaterno = apellidoPaterno.text
        entidadCliente.apellidomaterno = apellidoMaterno.text
        entidadCliente.calle = calle.text
        entidadCliente.numero = numero.text
        entidadCliente.colonia = colonia.text
        entidadCliente.ciudad = ciudad.text
        entidadCliente.numerocontacto = numeroContacto.text
        entidadCliente.referencia = referencia.text
        do {
            try contexto.save()
            print("Se guardo usuario")
            nombre.text = ""
            apellidoPaterno.text = ""
            apellidoMaterno.text = ""
            calle.text = ""
            numero.text = ""
            colonia.text = ""
            ciudad.text = ""
            numeroContacto.text = ""
            referencia.text = ""
            AvisoGuardado()
        } catch let error as NSError {
            print("error al guardad", error.localizedDescription)
        }
            } else {
            let alerta = UIAlertController(title: "Faltan informacion", message: "Por favor ingresa los datos faltantes", preferredStyle: .alert)
            let accion = UIAlertAction(title: "Entendido", style: .default, handler: nil)
            alerta.addAction(accion)
            present(alerta, animated: true, completion: nil)
        }
    }
    @IBAction func Back(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
}
