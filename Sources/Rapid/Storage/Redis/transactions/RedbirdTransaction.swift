import Redbird
import LoggerAPI

class RedbirdTransaction {
    private var redbirdClient: Redbird

    init(_ redbirdClient: Redbird) {
        self.redbirdClient = redbirdClient
    }

    public func object(forKey key: String) -> [String:String]? {
        var obj: [String: String] = [:]

        do {
            var lastKey: String?

            let response = try self.redbirdClient.command("HGETALL", params: [key]).toArray()

            for entry in response {
                let data = try entry.toString()

                if lastKey == nil {
                    lastKey = data
                } else {
                    obj[lastKey!] = data
                    lastKey = nil
                }
            }
        
        } catch {
            Log.error("Failed to fetch object by key \(key), \(error)")
        }

        return obj.isEmpty ? nil : obj
    }

    public func string(fromMap map: String, key: String) -> String? {
        var data: String?

        do {
            let response = try self.redbirdClient.command("HGET", params: [map, key]).toString()

            return response
        } catch {
            Log.error("Failed to fetch string from map: \(map) by key: \(key), \(error)")
        }

        return nil
    }

    public func client() -> Redbird {
        return self.redbirdClient
    }
}