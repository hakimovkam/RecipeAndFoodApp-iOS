//
//  ImageRequest.swift
//  galleyRecipe
//
//  Created by Камиль Хакимов on 19.02.2023.
//

import UIKit

struct ImageRequest: DataRequest {
    
    var method: HTTPMethod {
        .get
    }
    
    //FIXME: NSError
    func decode(_ data: Data) throws -> UIImage {
        guard let image = UIImage(data: data) else {
            throw NSError(
                domain: ErrorResponse.invalidResponse.rawValue,
                code: 13,
                userInfo: nil
            )
        }
        return image
    }
}
