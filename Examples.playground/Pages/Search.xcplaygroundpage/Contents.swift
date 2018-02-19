import AzureCognitive

AzureCognitive.environment = .playground

let host = (real: "api.cognitive.microsoft.com", dummy: "blah")
let key = (real: "", dummy: "blah")
let info = AzureCognitive.ServiceInfo(host: host.real, key: key.real)

let service = Search.AutoSuggest(info: info)
service.suggest(query: "dilber") { (status, payload) in
    print(status)
    print(payload)
}




