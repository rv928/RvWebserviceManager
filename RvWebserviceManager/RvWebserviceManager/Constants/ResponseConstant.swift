//
//  ResponseConstant.swift
//  RvWebserviceManager
//
//  Created by Ravi Vora on 06/09/16.
//  Copyright © 2016 Ravi Vora. All rights reserved.
//

import Foundation


class ResponseConstant  {
    
    static let data = "data"
    static let status = "status"
    static let responseMessage = "message"
    static let token = "token"
    static let responseCode = "code"

    static let statusFail = "fail"
    static let statusTokenExpireMessage = "The access token provided has expired."

    struct Login {
        static let authTokenType = "token_type"
        static let accessToken = "access_token"
        static let expireTime = "expires_in"
        static let refreshToken = "refresh_token"
    }

}

