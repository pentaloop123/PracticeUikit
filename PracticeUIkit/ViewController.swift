//
//  ViewController.swift
//  PracticeUIkit
//
//  Created by New User on 03/04/2024.
//

//#import "HelloViewController.h";

import UIKit
import AWSS3

typealias progressBlock = (_ progress: Double) -> Void //2
typealias completionBlock = (_ response: Any?, _ error: Error?) -> Void //3

class ViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet weak var imageView: UIImageView!
    let bucketName = "invoiceapptestbucket"
    let imagesFolder: String = "CustomerImages/"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    
    @IBAction func retriveFromBucket(_ sender: Any) {
        S3Manager.shared.listFilesInBucket()
    }
    
    
    @IBAction func didTapSelectImage(_ sender: Any) {
        openImagePicker()
    }
    
    @IBAction func didTapUploadToS3Bucket(_ sender: Any) {
        guard let image = imageView.image else {
            print("Failed to load image.")
            return
        }
        
        // Call the uploadImage function with the image
        S3Manager.shared.uploadImage(image: image, progress: { progress in
            // Handle progress update if needed
            print("Upload progress: \(progress)")
        }, completion: { urlString, error in
            if let urlString = urlString {
                // Image uploaded successfully, you can use the URL
                print("Image uploaded successfully. URL: \(urlString)")
            } else if let error = error {
                // Handle error
                print("Error uploading image: \(error.localizedDescription)")
            }
        })
    }
    
    func openImagePicker() {
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.allowsEditing = false
        imagePicker.sourceType = .photoLibrary
        present(imagePicker, animated: true, completion: nil)
    }

    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let selectedImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            imageView.image = selectedImage
        }
        dismiss(animated: true, completion: nil)
    }

    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    
    
    private func uploadfile(fileUrl: URL, fileName: String, contenType: String, progress: progressBlock?, completion: completionBlock?) {
        // Upload progress block
        let expression = AWSS3TransferUtilityUploadExpression()
        expression.progressBlock = {(task, awsProgress) in
            guard let uploadProgress = progress else { return }
            DispatchQueue.main.async {
                uploadProgress(awsProgress.fractionCompleted)
            }
        }
        // Completion block
        var completionHandler: AWSS3TransferUtilityUploadCompletionHandlerBlock?
        completionHandler = { (task, error) -> Void in
            DispatchQueue.main.async(execute: {
                if error == nil {
                    let url = AWSS3.default().configuration.endpoint.url
                    let publicURL = url?.appendingPathComponent(self.bucketName).appendingPathComponent(fileName)
                    print("Uploaded to:\(String(describing: publicURL))")
                    if let completionBlock = completion {
                        completionBlock(publicURL?.absoluteString, nil)
                    }
                } else {
                    if let completionBlock = completion {
                        completionBlock(nil, error)
                    }
                }
            })
        }
        // Start uploading using AWSS3TransferUtility
        let awsTransferUtility = AWSS3TransferUtility.default()
        awsTransferUtility.uploadFile(fileUrl, bucket: bucketName, key: fileName, contentType: contenType, expression: expression, completionHandler: completionHandler).continueWith { (task) -> Any? in
            if let error = task.error {
                print("error is: \(error.localizedDescription)")
            }
            if let _ = task.result {
                // your uploadTask
            }
            return nil
        }
    }
    
//    @objc func uploadImage(image: UIImage, progress: progressBlock?, completion: completionBlock?) {
//        
//        guard let imageData = image.jpegData(compressionQuality: 1.0) else {
//            let error = NSError(domain:"", code:402, userInfo:[NSLocalizedDescriptionKey: "invalid image"])
//            completion?(nil, error)
//            return
//        }
//        
//        
//        let tmpPath = NSTemporaryDirectory() as String
//        let user_id: String = UserDefaults.standard.object(forKey: "user_id") as? String ?? "Logo"
//        let initial_fileName: String = user_id
//        var fileName: String = initial_fileName + "-" + ProcessInfo.processInfo.globallyUniqueString + ".jpeg"
//        let filePath = tmpPath + "/" + fileName
//        let fileUrl = URL(fileURLWithPath: filePath)
//        fileName = imagesFolder + fileName
//        do {
//            try imageData.write(to: fileUrl)
//            loadImageFromTempURL(fileUrl)
//            
//            
//            
//        } catch {
//            let error = NSError(domain:"", code:402, userInfo:[NSLocalizedDescriptionKey: "invalid image"])
//            completion?(nil, error)
//        }
//    }
    
    
    
    
    func loadImageFromTempURL(_ url: URL) {
            // Create a URLSessionDataTask to fetch the image data from the URL
            URLSession.shared.dataTask(with: url) { data, response, error in
                // Check for errors
                guard let data = data, error == nil else {
                    print("Failed to load image: \(error?.localizedDescription ?? "Unknown error")")
                    return
                }
                
                // Create a UIImage from the fetched data
                if let image = UIImage(data: data) {
                    // Update UI elements on the main queue
                    DispatchQueue.main.async {
                        // Set the image to the UIImageView
                        self.imageView.image = image
                    }
                } else {
                    print("Failed to create UIImage from data")
                }
            }.resume() // Resume the data task
        }
    
    
    
//    func listObjectsInBucket(bucketName: String) {
//        // Create an AWSS3ListObjectsV2Request object
//        let listObjectsRequest = AWSS3ListObjectsV2Request()
//        listObjectsRequest?.bucket = bucketName
//        let s3 = AWSS3.default()
//        s3.listObjectsV2(listObjectsRequest!).continueWith { (task) -> Any? in
//            if let error = task.error {
//                print("Error listing objects: \(error.localizedDescription)")
//                return nil
//            }
//            
//            if let result = task.result {
//                for object in result.contents ?? [] {
//                    print("Object Key: \(object.key ?? "")")
//                }
//            }
//            
//            return nil
//        }
//    }
}



import AWSS3
//import S3



class S3Manager {
    
    static let shared = S3Manager()
    
    // Configure AWS credentials
    let accessKey = "AKIAWWJIQZH7WDGJSL5B"
    let secretKey = "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"
    let bucketName = "invoiceapptestbucket"
    
    private init() {
        // Configure AWS
        let credentialsProvider = AWSStaticCredentialsProvider(accessKey: accessKey, secretKey: secretKey)
        let configuration = AWSServiceConfiguration(region: .USEast1, credentialsProvider: credentialsProvider)
        AWSServiceManager.default()?.defaultServiceConfiguration = configuration
    }
    
    func listFilesInBucket() {
        let listRequest = AWSS3ListObjectsV2Request()
        listRequest?.bucket = bucketName
        
        let s3 = AWSS3.default()
        s3.listObjectsV2(listRequest!).continueWith { (task) -> Any? in
            if let error = task.error {
                print("Error listing objects: \(error.localizedDescription)")
                return nil
            }
            
            if let result = task.result {
                for object in result.contents ?? [] {
                    if let key = object.key {
                        print("Object Key: \(key)")
                    }
                }
            }
            
            return nil
        }
    }
    
    
    
    @objc func uploadImage(image: UIImage, progress: progressBlock?, completion: completionBlock?) {
        guard let imageData = image.jpegData(compressionQuality: 1.0) else {
            let error = NSError(domain:"", code:402, userInfo:[NSLocalizedDescriptionKey: "Invalid image"])
            completion?(nil, error)
            return
        }
        
        let transferUtility = AWSS3TransferUtility.default()
        let user_id: String = UserDefaults.standard.object(forKey: "user_id") as? String ?? "Logo"
        let initial_fileName: String = user_id
        let fileName: String = "CustomerImages/" + initial_fileName + "-" + ProcessInfo.processInfo.globallyUniqueString + ".jpeg"

        
        let expression = AWSS3TransferUtilityUploadExpression()
        expression.progressBlock = { (task, awsProgress) in
            progress?(awsProgress.fractionCompleted)
        }
        
        transferUtility.uploadData(imageData,
                                   bucket: bucketName,
                                   key: fileName,
                                   contentType: "image/jpeg",
                                   expression: expression,
                                   completionHandler: { (task, error) in
                                        if let error = error {
                                            completion?(nil, error)
                                        } else {
                                            let publicURL = AWSS3.default().configuration.endpoint.url?.appendingPathComponent(self.bucketName).appendingPathComponent(fileName)
                                            completion?(publicURL?.absoluteString, nil)
                                        }
                                    }).continueWith { (task) -> Any? in
                                        if let error = task.error {
                                            print("Error uploading image: \(error.localizedDescription)")
                                        }
                                        return nil
                                    }
    }
    

    
    
}
