//
//  MinioServices.swift
//  iPay
//
//  Created by Thushara Wijekoon on 9/10/18.
//  Copyright © 2018 iPay. All rights reserved.
//

import Foundation
import AWSS3
import AWSCore

class MinioServices{
    func uploadImageToMinio(data : Data,fileName : String, BucketName :String, callbackFunc : @escaping (String, Int) -> Void){
        //        self.rootAuthManager?.getCustomActivityIndicator().start(view: (self.rootAuthManager?.getUIViewController().view)!)
        
        let accessKey = Settings.getMinioAccessKey()
        let secretKey = Settings.getMinioSecretKey()
        let minioUrl = Settings.getMinioServerIp()
        
        let credentialsProvider = AWSStaticCredentialsProvider(accessKey: accessKey, secretKey: secretKey)
        let configuration = AWSServiceConfiguration(region: .USEast1, endpoint: AWSEndpoint(region: .USEast1, service: .S3, url: URL(string:minioUrl)),credentialsProvider: credentialsProvider)
        
        AWSServiceManager.default().defaultServiceConfiguration = configuration
        
        var S3BucketName = BucketName

//        let S3BucketName = "customerprofilepic"
        //        let fileName = "prefix_test.jpg"
        let fileURL = URL(fileURLWithPath: NSTemporaryDirectory()).appendingPathComponent(fileName)
        //        let image = UIImage(named: "ft_favourite")
        //        let data = UIImageJPEGRepresentation(image, 0.9)
        do {
            try data.write(to: fileURL)
        }
        catch {}
        
        let uploadRequest = AWSS3TransferManagerUploadRequest()!
        uploadRequest.body = fileURL
        uploadRequest.key = fileName
        uploadRequest.bucket = S3BucketName
        uploadRequest.contentType = "image/jpeg"
        uploadRequest.acl = .publicRead
        
        let transferManager = AWSS3TransferManager.default()
        
        transferManager.upload(uploadRequest)
        
        transferManager.upload(uploadRequest).continueWith { (task: AWSTask<AnyObject>) -> Any? in
            
            DispatchQueue.main.async {
                //                self.rootAuthManager?.getCustomActivityIndicator().stop()
                
                if let error = task.error {
                    print("Upload failed with error: (\(error.localizedDescription))")
                    callbackFunc("error", 1)
                }else if task.result != nil {
                    let url = AWSS3.default().configuration.endpoint.url
                    let publicURL = url?.appendingPathComponent(uploadRequest.bucket!).appendingPathComponent(uploadRequest.key!)
                    print("Uploaded to:\(String(describing: publicURL!))")
                    callbackFunc(String(describing: publicURL!), 0)
                }
            }
            return nil
        }
    }
}
