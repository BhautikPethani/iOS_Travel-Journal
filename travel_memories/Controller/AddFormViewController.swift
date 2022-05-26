//
//  AddFormViewController.swift
//  travel_memories
//
//  Created by Swapnil Kumbhar on 2022-05-25.
//

import UIKit
import UniformTypeIdentifiers

class AddFormViewController: UIViewController {
    
    @objc func fileSelectorAction(gestureReconizer: UITapGestureRecognizer) {
        if gestureReconizer.state == .ended {
            let pickerController = UIImagePickerController()
            pickerController.delegate = self
            pickerController.mediaTypes = ["public.image"]
            pickerController.sourceType = .photoLibrary
            present(pickerController, animated: true)
        }
        
    }
    

    @IBOutlet weak var uploadMediaView: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()

        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(self.fileSelectorAction))
        uploadMediaView.addGestureRecognizer(tapGestureRecognizer)
    }

}

extension AddFormViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        guard let media = info.first else { return }
        print(media.value)

        dismiss(animated: true)
    }
    
    
//    func getDocumentsDirectory() -> URL {
//        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
//        return paths[0]
//    }
}
