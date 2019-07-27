/// The error thrown when an access range is initialized with an invalid raw value.
public struct InvalidAccessRangeError: Error, CustomStringConvertible, CustomDebugStringConvertible {
    /// The raw value of the access range that didn't pass validation.
    public let rawValue: String

    /// The type of the access range that was used to validate above's `rawValue`.
    public let accessRangeType: Any.Type

    public var description: String {
        return "The value '\(rawValue)' is not a valid scope access range!"
    }

    public var debugDescription: String {
        return "The value '\(rawValue)' is not a valid scope access range of \(accessRangeType)!"
    }
}

/// Describes an access range type. Typically an enum.
public protocol AccessRangeProtocol: RawRepresentable, Hashable where RawValue == String {
    /// Creates an access range with the given raw value or throws an error (typically `InvalidAccessRangeError`) if it's not a valid raw value.
    ///
    /// - Parameter rawValue: The raw value to use for the access range.
    /// - Throws: Any error (typically `InvalidAccessRangeError`) if it's not a vaild raw value.
    init<S: StringProtocol>(validating string: S) throws
}

extension AccessRangeProtocol {
    public init<S: StringProtocol>(validating string: S) throws {
        let rawValue = RawValue(string)
        guard let accessRange = Self(rawValue: rawValue)
            else { throw InvalidAccessRangeError(rawValue: rawValue, accessRangeType: Self.self) }
        self = accessRange
    }
}