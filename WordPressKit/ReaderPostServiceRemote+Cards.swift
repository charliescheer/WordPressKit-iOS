extension ReaderPostServiceRemote {
    func fetchCards(for interests: [String],
                    success: @escaping ([RemoteReaderCard]) -> Void,
                    failure: @escaping (Error) -> Void) {
        guard let requestUrl = cardsEndpoint(for: interests) else {
            return
        }

        wordPressComRestApi.GET(requestUrl,
                                parameters: nil,
                                success: { (response, _) in

                                    do {
                                        let decoder = JSONDecoder()
                                        let data = try JSONSerialization.data(withJSONObject: response, options: [])
                                        let envelope = try decoder.decode(ReaderCardEnvelope.self, from: data)

                                        success(envelope.cards)
                                    } catch {
                                        DDLogError("\(error)")
                                        failure(error)
                                    }
        }, failure: { error, _ in
            DDLogError("\(error)")
            failure(error)
        })
    }

    private func cardsEndpoint(for interests: [String]) -> String? {
        var path = URLComponents(string: "read/tags/cards")
        path?.queryItems = interests.map { URLQueryItem(name: "tags[]", value: $0) }
        return self.path(forEndpoint: path!.string!, withVersion: ._1_2)
    }
}
