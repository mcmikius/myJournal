import Vapor

struct Entry: Content {
    var id: String?
    var title: String?
    var content: String?
    
    init(id: String, title: String? = nil, content: String? = nil) {
        self.id = id
        self.title = title
        self.content = content
    }
}

