// Copyright SIX DAY LLC. All rights reserved.

import Foundation
import RealmSwift
import BigInt
import TrustKeystore

class TokenObject: Object {
    @objc dynamic var contract: String = ""
    @objc dynamic var name: String = ""
    @objc dynamic var symbol: String = ""
    @objc dynamic var decimals: Int = 0
    @objc dynamic var value: String = ""
    @objc dynamic var isDisabled: Bool = false
    var balance = List<TokenBalance>()
    @objc dynamic var rawType: String = TokenType.erc20.rawValue
    var type: TokenType {
        get {
            return TokenType(rawValue: rawType)!
        }
        set {
            rawType = newValue.rawValue
        }
    }

    var isERC721: Bool {
        return type == .erc721
    }

    var isERC875: Bool {
        return type == .erc875
    }
    
    var isERC20: Bool {
        return type == .erc20
    }

    convenience init(
            contract: String = "",
            name: String = "",
            symbol: String = "",
            decimals: Int = 0,
            value: String,
            isCustom: Bool = false,
            isDisabled: Bool = false,
            type: TokenType
    ) {
        self.init()
        self.contract = contract
        self.name = name
        self.symbol = symbol
        self.decimals = decimals
        self.value = value
        self.isDisabled = isDisabled
        self.type = type
    }

    var address: Address {
        return Address(string: contract)!
    }

    var valueBigInt: BigInt {
        return BigInt(value) ?? BigInt()
    }

    override static func primaryKey() -> String? {
        return "contract"
    }

    override static func ignoredProperties() -> [String] {
        return ["type"]
    }

    override func isEqual(_ object: Any?) -> Bool {
        guard let object = object as? TokenObject else { return false }
        return object.contract == self.contract
    }

    var title: String {
        return name.isEmpty ? symbol : (name + " (" + symbol + ")")
    }
}