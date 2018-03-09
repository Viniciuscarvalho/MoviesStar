import Foundation

enum NotificationConstants: String{
    case shouldLoadMovies
    case shouldHandleItemSelection
    case shouldChangeCurrentState
    case shouldApplyCustomFilter
    
    func post(){
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: self.rawValue), object: nil)
    }
    
    func post(withDictionary dictionary: [String: Any]) {
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: self.rawValue), object: nil, userInfo: dictionary)
    }
    
    func observe(target: Any, selector: Selector){
        NotificationCenter.default.addObserver(target, selector: selector, name: NSNotification.Name(rawValue: self.rawValue), object: nil)
    }
}
