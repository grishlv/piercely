//
//  CameraPickerView.swift
//  Piercely
//
//  Created by Grigorii Shiliaev on 13.12.25.
//

import SwiftUI
import UIKit
import AVFoundation

struct CameraPickerView: UIViewControllerRepresentable {
    let onImageCaptured: (UIImage) -> Void
    @Environment(\.dismiss) private var dismiss
    
    func makeUIViewController(context: Context) -> UIViewController {
        // Проверяем разрешение камеры
        let cameraAuthStatus = AVCaptureDevice.authorizationStatus(for: .video)
        
        switch cameraAuthStatus {
        case .authorized:
            // Разрешение есть — показываем камеру
            return makeImagePicker(context: context)
            
        case .notDetermined:
            // Разрешение не запрашивалось — запрашиваем
            let placeholderVC = UIViewController()
            
            AVCaptureDevice.requestAccess(for: .video) { granted in
                DispatchQueue.main.async {
                    if granted {
                        // Разрешение получено — показываем камеру
                        if let scene = placeholderVC.view.window?.windowScene,
                           let window = scene.windows.first,
                           let rootVC = window.rootViewController {
                            let picker = self.makeImagePicker(context: context)
                            rootVC.present(picker, animated: true)
                        }
                    } else {
                        // Отказано — закрываем
                        self.dismiss()
                    }
                }
            }
            return placeholderVC
            
        case .denied, .restricted:
            // Разрешение отклонено — показываем alert
            let alertVC = makePermissionDeniedAlert()
            return alertVC
            
        @unknown default:
            dismiss()
            return UIViewController()
        }
    }
    
    func updateUIViewController(_ uiViewController: UIViewController, context: Context) {}
    
    func makeCoordinator() -> Coordinator {
        Coordinator(parent: self)
    }
    
    // MARK: - Private Helpers
    
    private func makeImagePicker(context: Context) -> UIImagePickerController {
        let picker = UIImagePickerController()
        picker.sourceType = .camera
        picker.delegate = context.coordinator
        return picker
    }
    
    private func makePermissionDeniedAlert() -> UIViewController {
        let alertVC = UIViewController()
        
        DispatchQueue.main.async {
            let alert = UIAlertController(
                title: "Camera Access Required",
                message: "Please enable camera access in Settings to take photos.",
                preferredStyle: .alert
            )
            
            alert.addAction(UIAlertAction(title: "Settings", style: .default) { _ in
                if let settingsURL = URL(string: UIApplication.openSettingsURLString) {
                    UIApplication.shared.open(settingsURL)
                }
                self.dismiss()
            })
            
            alert.addAction(UIAlertAction(title: "Cancel", style: .cancel) { _ in
                self.dismiss()
            })
            
            alertVC.present(alert, animated: true)
        }
        
        return alertVC
    }
    
    // MARK: - Coordinator
    class Coordinator: NSObject, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
        let parent: CameraPickerView
        
        init(parent: CameraPickerView) {
            self.parent = parent
        }
        
        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
            if let image = info[.originalImage] as? UIImage {
                parent.onImageCaptured(image)
            }
            parent.dismiss()
        }
        
        func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
            parent.dismiss()
        }
    }
}
