//
//  PlacefierServiceClient.swift
//  Placefier-iOS
//
//  Created by Anton Lyapov on 11/15/17.
//  Copyright © 2017 Anton Lyapov. All rights reserved.
//

import UIKit
import ObjectMapper

class APIServiceClient: BaseServiceClient {
    
    private let BASE_URL        = "http://www.nationalgeographic.com/"
    private let BASE_API_PATH   = "bin/services/core/public/query/"
    
    private let METHOD_CONTENT = "content.json"
//
    private let PARAM_PAGE_SIZE         = "pageSize"
    private let PARAM_PAGE              = "page"
    private let PARAM_CONTENT_TYPES     = "contentTypes"
    private let PARAM_SORT              = "sort"
    private let PARAM_OPERATOR          = "operator"
    private let PARAM_INCLUDED_TAGS     = "includedTags"
    private let PARAM_EXCLUDED_TAGS     = "excludedTags"
    private let PARAM_EXCLUDED_GUIDS    = "excludedGuids"
//    private let PARAM_PER_PAGE      = "per_page"
//    private let PARAM_CATEGORIES    = "categories"
//    private let PARAM_PARENT        = "parent"
//
    //http://obichamvicove.com/wp-json/wp/v2/posts?per_page=6&categories=3
    func getContent(
        page: Int,
        size: Int,
        successBlock: ((_ posts: [Content]) -> ())? = nil,
        failureBlock: ((_ errorMessage: String?) -> ())? = nil) {
        
        let params: [String: Any] = [
            PARAM_PAGE: page,
            PARAM_PAGE_SIZE: size,
            PARAM_CONTENT_TYPES: "adventure/components/pagetypes/story/article,adventure/components/pagetypes/story/gallery,adventure/components/pagetypes/story/interactive,adventure/components/pagetypes/story/multipage,animals/components/pagetypes/story/article,animals/components/pagetypes/story/gallery,animals/components/pagetypes/story/interactive,animals/components/pagetypes/story/multipage,archaeologyandhistory/components/pagetypes/story/article,archaeologyandhistory/components/pagetypes/story/gallery,archaeologyandhistory/components/pagetypes/story/interactive,archaeologyandhistory/components/pagetypes/story/multipage,environment/components/pagetypes/story/article,environment/components/pagetypes/story/gallery,environment/components/pagetypes/story/interactive,environment/components/pagetypes/story/multipage,magazine/components/pagetypes/story/article,magazine/components/pagetypes/story/gallery,magazine/components/pagetypes/story/interactive,magazine/components/pagetypes/story/multipage,news/components/pagetypes/story/article,news/components/pagetypes/story/gallery,news/components/pagetypes/story/interactive,news/components/pagetypes/story/multipage,parks/components/pagetypes/story/article,parks/components/pagetypes/story/gallery,parks/components/pagetypes/story/interactive,parks/components/pagetypes/story/multipage,peopleandculture/components/pagetypes/story/article,peopleandculture/components/pagetypes/story/gallery,peopleandculture/components/pagetypes/story/interactive,peopleandculture/components/pagetypes/story/multipage,photography/components/pagetypes/story/article,photography/components/pagetypes/story/gallery,photography/components/pagetypes/story/interactive,photography/components/pagetypes/story/multipage,science/components/pagetypes/story/article,science/components/pagetypes/story/gallery,science/components/pagetypes/story/interactive,science/components/pagetypes/story/multipage,travel/components/pagetypes/story/article,travel/components/pagetypes/story/gallery,travel/components/pagetypes/story/interactive,travel/components/pagetypes/story/multipage",
            PARAM_SORT: "newest",
            PARAM_OPERATOR: "or",
            //PARAM_INCLUDED_TAGS: "",
            PARAM_EXCLUDED_TAGS: "ngs_genres:reference,ngs_visibility:omit_from_hp",
            PARAM_EXCLUDED_GUIDS: "beda7baa-e63b-4276-8122-34e47a4e653e",
        ]
        
        executeGetRequest(
            method: METHOD_CONTENT,
            parameters: params,
            successBlock: { (result) in
                var posts = [Content]()
                
                for res in result as! [Any] {
                    let post = Content(JSON: res as! [String: Any])
                    posts.append(post!)
                }
                
                successBlock?(posts)
        }, failureBlock: failureBlock)

    }
    
    override func getAPIPath() -> String {
        return getBaseUrl() + BASE_API_PATH
    }
    
    override func getBaseUrl() -> String {
        return BASE_URL;
    }
}
