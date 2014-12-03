//
//  ClubsFilters.swift
//  ClubsFinder
//
//  Created by Séverin de Beaulieu on 02/12/2014.
//  Copyright (c) 2014 Apik56. All rights reserved.
//
class ClubsFilters {
    
    var filters = [
                
        Filter(
            label: "Sort by",
            name: "sort",
            options: [
                Option(label: "Best Match", value: "0", selected: true),
                Option(label: "Distance", value: "1"),
                Option(label: "Rating", value: "2")
            ],
            type: .Single
        ),
        
        Filter(
            label: "Distance",
            name: "radius_filter",
            options: [
                Option(label: "Auto", value: "", selected: true),
                Option(label: "Within 4 blocks", value: "1000"),
                Option(label: "Walking (1 mile)", value: "1609"),
                Option(label: "Biking (2 miles)", value: "3218"),
                Option(label: "Driving (5 miles)", value: "8047")
            ],
            type: .Single
        )
    ]
    
    init(instance: ClubsFilters? = nil) {
        if instance != nil {
            self.copyStateFrom(instance!)
        }
    }
    
    func copyStateFrom(instance: ClubsFilters) {
        for var f = 0; f < self.filters.count; f++ {
            for var o = 0; o < self.filters[f].options.count; o++ {
                self.filters[f].options[o].selected = instance.filters[f].options[o].selected
            }
        }
    }
    
    var parameters: Dictionary<String, String> {
        get {
            var parameters = Dictionary<String, String>()
            for filter in self.filters {
                switch filter.type {
                case .Single:
                    if filter.name != nil {
                        let selectedOption = filter.options[filter.selectedIndex]
                        if selectedOption.value != "" {
                            parameters[filter.name!] = selectedOption.value
                        }
                    }
                case .Multiple:
                    if filter.name != nil {
                        let selectedOptions = filter.selectedOptions
                        if selectedOptions.count > 0 {
                            parameters[filter.name!] = ",".join(selectedOptions.map({ $0.value }))
                        }
                    }
                default:
                    for option in filter.options {
                        if option.selected && option.name != nil && option.value != "" {
                            parameters[option.name!] = option.value
                        }
                    }
                }
            }
            return parameters
        }
    }
    
    class var instance: ClubsFilters {
        struct Static {
            static let instance: ClubsFilters = ClubsFilters()
        }
        return Static.instance
    }
    
}

class Filter {
    
    var label: String
    var name: String?
    var options: Array<Option>
    var type: FilterType
    var numItemsVisible: Int?
    var opened: Bool = false
    
    init(label: String, name: String? = nil, options: Array<Option>, type: FilterType, numItemsVisible: Int? = 0) {
        self.label = label
        self.name = name
        self.options = options
        self.type = type
        self.numItemsVisible = numItemsVisible
    }
    
    var selectedIndex: Int {
        get {
            for var i = 0; i < self.options.count; i++ {
                if self.options[i].selected {
                    return i
                }
            }
            return -1
        }
        set {
            if self.type == .Single {
                self.options[self.selectedIndex].selected = false
            }
            self.options[newValue].selected = true
        }
    }
    
    var selectedOptions: Array<Option> {
        get {
            var options: Array<Option> = []
            for option in self.options {
                if option.selected {
                    options.append(option)
                }
            }
            return options
        }
    }
    
}

enum FilterType {
    case Default, Single, Multiple
}

class Option {
    
    var label: String
    var name: String?
    var value: String
    var selected: Bool
    
    init(label: String, name: String? = nil, value: String, selected: Bool = false) {
        self.label = label
        self.name = name
        self.value = value
        self.selected = selected
    }
    
}