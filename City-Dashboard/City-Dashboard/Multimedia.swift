//
//  Multimedia.swift
//  News API
//
//  Created by Alexander Besson on 2016-02-02.
//  Copyright © 2016 Alexander Besson. All rights reserved.
//

import Foundation

class Multimedia {
    
    private var _url: String?
    private var _format: String?
    
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
    
    var format: String {
        get {
            if _format != nil {
                return _format!
            } else {
                return ""
            }
        }
        set(newValue) {
            _format = newValue
        }
    }
    
    // size
    private var _height: Int?
    private var _width: Int?
    
    var height: Int {
        get {
            if _height != nil {
                return _height!
            } else {
                return 0
            }
        }
        set(newValue) {
            _height = newValue
        }
    }
    
    var width: Int {
        get {
            if _width != nil {
                return _width!
            } else {
                return 0
            }
        }
        set(newValue) {
            _width = newValue
        }
    }
    
    // description
    private var _type: String?
    private var _subtype: String?
    private var _caption: String?
    
    var type: String {
        get {
            if _type != nil {
                return _type!
            } else {
                return ""
            }
        }
        set(newValue) {
            _type = newValue
        }
    }
    
    var subtype: String {
        get {
            if _subtype != nil {
                return _subtype!
            } else {
                return ""
            }
        }
        set(newValue) {
            _subtype = newValue
        }
    }
    
    var caption: String {
        get {
            if _caption != nil {
                return _caption!
            } else {
                return ""
            }
        }
        set(newValue) {
            _caption = newValue
        }
    }
    
    private var _copyright: String?
    
    var copyright: String {
        get {
            if _copyright != nil {
                return _copyright!
            } else {
                return ""
            }
        }
        set(newValue) {
            _copyright = newValue
        }
    }
    
    init() {
        
    }
}