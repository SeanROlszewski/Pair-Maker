func == (lhs: Engineer, rhs: Engineer) -> Bool {
    return lhs.name == rhs.name && lhs.company == rhs.company
}

struct Engineer: Equatable {
    let name: String
    let company: String
    let remote: Bool
    
    init(name: String, company: String) {
        self.name = name
        self.company = company
        self.remote = false
    }
    
    init(name: String, company: String, remote: Bool) {
        self.name = name
        self.company = company
        self.remote = remote
    }
}
