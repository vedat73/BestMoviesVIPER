//
//  MediaService.swift
//  MediaAPI
//
//  Created by Vedat Ozlu on 26.08.2023.
//

import Foundation
import UIKit
import Kingfisher

public protocol MediaServiceProtocol {
    func  downloadImage(from url: String, resultHandler: @escaping (Result<UIImage>) -> Void)
}

public final class MediaService: MediaServiceProtocol {
    
    public enum MediaError: Error {
        case invalidURL
        case download
    }
    
    // MARK: - Initialization
    public init() {  }
    
    // MARK: - Functions
    public func downloadImage(from url: String, resultHandler: @escaping (Result<UIImage>) -> Void) {
        
        guard let imageURL = URL(string: url) else {
            resultHandler(.failure(MediaError.invalidURL))
            return
        }
        
        let resource = KF.ImageResource(downloadURL: imageURL)
        KingfisherManager.shared.retrieveImage(with: resource) { result in
            switch result {
                case .success(let imageResult):
                    resultHandler(.success(imageResult.image))
                case .failure(let error):
                    print("\(error)")
                    resultHandler(.failure(MediaError.download))
            }
        }
    }
}
