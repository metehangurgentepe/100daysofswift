//
//  DetailViewController.swift
//  NotesImitation
//
//  Created by Metehan Gürgentepe on 28.08.2024.
//

import UIKit

class DetailViewController: UIViewController {
    var selectedNotes: Note?
    var textField: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTextField()
        
        if let note = selectedNotes {
            textField.text = note.text
        }
        
        let deleteNavButton = UIBarButtonItem(barButtonSystemItem: .trash, target: self, action: #selector(deleteNote))
        
        let composeNavButton = UIBarButtonItem(barButtonSystemItem: .compose, target: self, action: #selector(deleteNote))
        
        let saveNavButton = UIBarButtonItem(barButtonSystemItem: .save, target: self, action: #selector(saveNote))
        
        let shareButton = UIBarButtonItem(barButtonSystemItem: .action, target: self, action: #selector(shareTapped))
        
        let spacer = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: self, action: nil)
        
        navigationItem.leftBarButtonItems = [spacer,deleteNavButton, composeNavButton]
        
        
        navigationItem.rightBarButtonItems = [shareButton,saveNavButton]
        
    }
    
    func setupTextField() {
        textField = UITextView()
        textField.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(textField)
        
        textField.backgroundColor = .white
        textField.textColor = .black
        textField.sizeToFit()
        textField.frame = view.safeAreaLayoutGuide.layoutFrame
    }
    
    @objc func shareTapped() {
        let text = textField.text
        let activity = UIActivityViewController(activityItems: [text], applicationActivities: [])
        activity.popoverPresentationController?.barButtonItem = navigationItem.rightBarButtonItem
        present(activity,animated: true)
    }
    
    @objc func deleteNote() {
        let defaults = UserDefaults.standard
        let decoder = JSONDecoder()
        let encoder = JSONEncoder()
        
        if let notesData = defaults.object(forKey: "NotesArr") as? Data {
            do{
                var notes = try decoder.decode([Note].self, from: notesData)
                for i in 0..<notes.count {
                    if selectedNotes?.id == notes[i].id {
                        notes.remove(at: i)
                        break
                    }
                }
                
                let encodedNotes = try encoder.encode(notes)
                defaults.setValue(encodedNotes, forKey: "NotesArr")
                
                navigationController?.popViewController(animated: true)
            } catch {
                
            }
        }
    }
    
    @objc func saveNote() {
        let defaults = UserDefaults.standard
        let decoder = JSONDecoder()
        let encoder = JSONEncoder()
        
        if let notesData = defaults.object(forKey: "NotesArr") as? Data {
            do{
                var notes = try decoder.decode([Note].self, from: notesData)
                let note = Note(id: nil, text: textField.text, date: Date(),title: nil)
                print(note)
                notes.append(note)
                let encodedNotes = try encoder.encode(notes)
                defaults.setValue(encodedNotes, forKey: "NotesArr")
            } catch {
                
            }
        } else {
            do{
                var notes = [Note]()
                let note = Note(id: nil, text: textField.text, date: Date())
                notes.append(note)
                let encodedNotes = try encoder.encode(notes)
                defaults.setValue(encodedNotes, forKey: "NotesArr")
            } catch{
                
            }
        }
       
        let ac = UIAlertController(title: "Note is saved", message: nil, preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "Ok", style: .default){_ in 
            self.navigationController?.popViewController(animated: true)
        })
        present(ac,animated: true)
    }

}
