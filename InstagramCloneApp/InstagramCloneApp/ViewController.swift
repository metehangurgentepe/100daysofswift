//
//  ViewController.swift
//  InstagramCloneApp
//
//  Created by Metehan Gürgentepe on 24.08.2024.
//

import UIKit

class ViewController: UITableViewController, UIImagePickerControllerDelegate & UINavigationControllerDelegate {
    
    var selectedImage: UIImage?
    var places = [Place]()
    var caption: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addImage))
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .trash, target: self, action: #selector(deleteItems))
        
        getPlace()
    }
    
    @objc func addImage() {
        let vc = UIImagePickerController()
        vc.sourceType = .camera
        vc.delegate = self
        vc.allowsEditing = true
        present(vc, animated: true)
    }
    
    @objc func deleteItems() {
        let defaults = UserDefaults.standard
        defaults.removeObject(forKey: "place")
    }
    
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        picker.dismiss(animated: true)
        
        guard let image = info[.editedImage] as? UIImage else {
            print("No image found")
            return
        }
        saveCaption()
        save(image: image)
    }
    
    func getPlace() {
        let defaults = UserDefaults.standard
        
        let decoder = JSONDecoder()
        
        if let savedPlace = defaults.object(forKey: "place") as? Data {
            do{
                places = try decoder.decode([Place].self, from: savedPlace)
                print(places)
            } catch {
                print("\(error)")
            }
        }
    }
    
    func save(image: UIImage) {
        let defaults = UserDefaults.standard
        
        let image = image.jpegData(compressionQuality: 0.8)
        
        let place = Place(name: caption ?? "Unknown", image: image ?? Data())
        
        places.append(place)
        
        let encoder = JSONEncoder()
        if let savedData = try? encoder.encode(places) {
            defaults.setValue(savedData, forKey: "place")
            getPlace()
        } else {
            print("false")
        }
    }
    
    func saveCaption() {
        let ac = UIAlertController(title: "Add Caption", message: nil, preferredStyle: .alert)
        ac.addTextField()
        ac.addAction(UIAlertAction(title: "Add", style: .default){_ in
            self.caption = ac.textFields![0].text
            self.tableView.reloadData()
        })
        present(ac, animated: true)
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        places.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Place", for: indexPath)
        let image = UIImage(data: places[indexPath.row].image)
        cell.imageView?.image = image
        cell.textLabel?.text = places[indexPath.row].name
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = DetailViewController()
        vc.place = places[indexPath.row]
        navigationController?.pushViewController(vc, animated: true)
    }
}

