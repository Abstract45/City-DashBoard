//
//  NewsItem.swift
//  News API
//
//  Created by Alexander Besson on 2016-02-02.
//  Copyright © 2016 Alexander Besson. All rights reserved.
//

import Foundation

class NewsItem {
    
    private var _title: String?
    private var _section: String?
    
    var title: String {
        get {
            if _title != nil {
                return _title!
            } else {
                return ""
            }
        }
        set(newValue) {
            _title = newValue
        }
    }
    
    var section: String {
        get {
            if _section != nil {
                return _section!
            } else {
                return ""
            }
        }
        set(newValue) {
            _section = newValue
        }
    }
    
    // description
    private var _abstract: String?
    private var _kicker: String?
    private var _subSection: String?
    
    var abstract: String {
        get {
            if _abstract != nil {
                return _abstract!
            } else {
                return ""
            }
        }
        set(newValue) {
            _abstract = newValue
        }
    }
    
    var kicker: String {
        get {
            if _kicker != nil {
                return _kicker!
            } else {
                return ""
            }
        }
        set(newValue) {
            _kicker = newValue
        }
    }

    var subSection: String {
        get {
            if _subSection != nil {
                return _subSection!
            } else {
                return ""
            }
        }
        set(newValue) {
            _subSection = newValue
        }
    }
    
    // article info
    private var _url: String?
    private var _author: String?
    private var _dateCreated: String?
    private var _datePublished: String?
    private var _dateUpdated: String?
    
    var url: String {
        get {
            if _url != nil {
                return _url!
            } else {
                return ""
            }
        }
        set(newValue) {
            _url = newValue
        }
    }
    
    var author: String {
        get {
            if _author != nil {
                return _author!
            } else {
                return ""
            }
        }
        set(newValue) {
            _author = newValue
        }
    }
    
    var dateCreated: String {
        get {
            if _dateCreated != nil {
                
                return _dateCreated!
            } else {
                return ""
            }
        }
        set(newValue) {
            _dateCreated = newValue
        }
    }
    
    var datePublished: String {
        get {
            if _datePublished != nil {
                return _datePublished!
            } else {
                return ""
            }
        }
        set(newValue) {
            _datePublished = newValue
        }
    }
    
    var dateUpdated: String {
        get {
            if _dateUpdated != nil {
                return _dateUpdated!
            } else {
                return ""
            }
        }
        set(newValue) {
            _dateUpdated = newValue
        }
    }
    
    // facets
    private var _facetDescription: [String]?
    private var _facetOrganization: [String]?
    private var _facetPerson: [String]?
    private var _facetGeo: [String]?
    
    var facetDescription: [String] {
        get {
            if _facetDescription != nil {
                return _facetDescription!
            } else {
                return [""]
            }
        }
        set(newValue) {
            _facetDescription = newValue
        }
    }
    
    var facetOrganization: [String] {
        get {
            if _facetOrganization != nil {
                return _facetOrganization!
            } else {
                return [""]
            }
        }
        set(newValue) {
            _facetOrganization = newValue
        }
    }
    
    var facetPerson: [String] {
        get {
            if _facetPerson != nil {
                return _facetPerson!
            } else {
                return [""]
            }
        }
        set(newValue) {
            _facetPerson = newValue
        }
    }
    
    var facetGeo: [String] {
        get {
            if _facetGeo != nil {
                return _facetGeo!
            } else {
                return [""]
            }
        }
        set(newValue) {
            _facetGeo = newValue
        }
    }
    
    // multimedia
    private var _multimedia: [Multimedia]?
    
    var multimedia: [Multimedia] {
        get {
            if _multimedia != nil {
                return _multimedia!
            } else {
                return [Multimedia()]
            }
        }
        set(newValue) {
            _multimedia = newValue
        }
    }
    
    init() {
        
    }
}