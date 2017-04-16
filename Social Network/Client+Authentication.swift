import Alamofire

// MARK: - Public methods

extension SocialNetworkClient {
    
    func authenticate(parameters: [String:Any], completion:  ((_ response: ServerResponse?) -> Void)? ) {
        guard let grantType = parameters[OAuth.ParameterKeys.GrantType] as? OAuth.GrantType else {
            return
        }
        
        switch grantType {
        case .Code:
            authenticateWithCode(parameters: parameters, completion: { response in
                completion?(response)
            })
            
        case .Password:
            authenticateWithPassword(parameters: parameters, completion: { response in
                completion?(response)
            })

        case .ClientCredentials, .Implicit:
            // Do Nothing
            break
        }
    }
    
}

// MARK: - Private methods

extension SocialNetworkClient {

    private typealias ParameterKeys = SocialNetworkClient.OAuth.ParameterKeys
    
    private func authenticateWithPassword(parameters: [String:Any], completion: @escaping (_ response: ServerResponse?) -> Void) {
        guard let username = parameters[ParameterKeys.Username] as? String,
            let password = parameters[ParameterKeys.Password] as? String else {
                return
        }
        
        OAuthInstance.Default.username = username
        OAuthInstance.Default.password = password
        setOAuth(oauth2: OAuthInstance.Default)
        
        alamofireManager?
            .request("https://localhost:8443/api/secured")
            .validate()
            .responseString(completionHandler: { response in
                print(response.description)
                completion(nil)                                     // TODO: Return server response
            })

    }
    
    private func authenticateWithCode(parameters: [String:Any], completion: @escaping (_ response: ServerResponse?) -> Void) {
        guard let service = parameters[ParameterKeys.Service]
            as? SocialNetworkClient.OAuth.Service else {
                return
        }
        
        switch service {
        case .Facebook:
            break
            
        case .Google:
            break
        }
    }
    
}