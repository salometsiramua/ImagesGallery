//
//  NetworkManager.swift
//  ImageGallery
//
//  Created by Salome Tsiramua on 3/11/21.
//

import Foundation

protocol MappableResponse {
    init(data: Data) throws
}

final class ServiceManager<Response: MappableResponse> {
    
    private(set) var isRunning: Bool = false
    typealias ResponseObject = Response
    
    private let service: Endpoint
    private let session: NetworkSession
    public let httpService: HTTPRequestSession
    
    private var onSuccessCallback: ServiceSuccessCallback?
    private var onFailureCallback: ServiceFailureCallback?
    
    init(session: NetworkSession = URLSession.shared, _ service: Endpoint) {
        self.session = session
        self.service = service
        self.httpService = HTTPSession(session: session)
    }
    
    @discardableResult
    convenience init(session: NetworkSession = URLSession.shared, _ service: Endpoint, onSuccess: @escaping ServiceSuccessCallback, onFailure: @escaping ServiceFailureCallback) {
        
        self.init(session: session, service)
        onSuccessCallback = onSuccess
        onFailureCallback = onFailure
        
        call()
    }
    
}

extension ServiceManager {
    
    private func call() {
       
        guard let request = HTTPServiceRequest(endpoint: service) else {
            onFailureCallback?(NetworkError.urlIsInvalid)
            return
        }
        
        isRunning = true
        
        httpService.request(request) { (data, response, error) in
            
            self.isRunning = false
            if let error = error {
                self.onFailureCallback?(error)
                return
            }
            
            guard let data = data else {
                self.onFailureCallback?(NetworkError.responseDataIsNil)
                return
            }
            
            do {
                let mapped = try Response(data: data)
                self.onSuccessCallback?(mapped)
            } catch {
                self.onFailureCallback?(error)
            }
        }
    }
}

//MARK: - HTTPManagerService functions
extension ServiceManager: HTTPManagerService {
    
    func onSuccess(_ callback: @escaping ServiceSuccessCallback) -> Self {
        onSuccessCallback = callback
        return self
    }
    
    func onFail(_ callback: @escaping ServiceFailureCallback) -> Self {
        onFailureCallback = callback
        return self
    }
    
}

