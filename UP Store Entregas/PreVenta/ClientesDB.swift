//
//  ClientesDB.swift
//  UP Store Entregas
//
//  Created by Emanuel Morales on 15/12/22.
//  Copyright © 2020 ASNK. All rights reserved.
//

import UIKit
import CoreData
class ClientesDB: UIViewController,UITableViewDelegate, UITableViewDataSource{
// Variables
    var cliente = [Clientes]()
//Elementos
    @IBOutlet weak var estado: UILabel!
    @IBOutlet weak var Tabla: UITableView!
//Contexto
    func conexion ()-> NSManagedObjectContext{
        let delegate = UIApplication.shared.delegate as! AppDelegate
        return delegate.persistentContainer.viewContext
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        MostrarDatos()
    }
    @IBAction func actualizarDB(_ sender: UIButton) {
        Tabla.reloadData()
        MostrarDatos()
    }
    func MostrarDatos (){
        let contexto = conexion()
        let fetchRaquest : NSFetchRequest<Clientes> = Clientes.fetchRequest()
        do {
            cliente = try contexto.fetch(fetchRaquest)
            print("Se mostraros los datos con exito")
        } catch let error as NSError {
            print("Error al mostrar datos", error.localizedDescription)
        }
    }
//TableView
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cliente.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = Tabla.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        let usuarios = cliente[indexPath.row]
        cell.textLabel?.text = "\(usuarios.nombre!) \(usuarios.apellidopaterno!)"
        cell.detailTextLabel?.text = usuarios.numerocontacto
        return cell
    }
//Seleccionar celda
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "datosVenta", sender: self)
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "datosVenta"{
            if let id = Tabla.indexPathForSelectedRow{
                let fila = cliente[id.row]
                let destino = segue.destination as! CheckVenta
                destino.clienteVenta = fila
            }
        }
    }
//borrar
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
         let contexto = conexion()
         let user = cliente[indexPath.row]
         if editingStyle == .delete {
             contexto.delete(user)
             do{
                 try contexto.save()
             }catch let error as NSError {
                 print("Hubo un error al eliminar", error.localizedDescription)
             }
         }
         MostrarDatos()
         Tabla.reloadData()
     }
    @IBAction func Back(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
}
