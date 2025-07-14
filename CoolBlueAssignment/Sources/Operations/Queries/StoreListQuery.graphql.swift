// @generated
// This file was automatically generated and should not be edited.

@_exported import ApolloAPI

public class StoreListQuery: GraphQLQuery {
  public static let operationName: String = "StoreListQuery"
  public static let operationDocument: ApolloAPI.OperationDocument = .init(
    definition: .init(
      #"query StoreListQuery { stores { __typename id name address { __typename city country houseNumber postalCode street longitude latitude } todayOpeningHours { __typename openTime closeTime } } }"#
    ))

  public init() {}

  public struct Data: CoolBlueAssignment.SelectionSet {
    public let __data: DataDict
    public init(_dataDict: DataDict) { __data = _dataDict }

    public static var __parentType: any ApolloAPI.ParentType { CoolBlueAssignment.Objects.Query }
    public static var __selections: [ApolloAPI.Selection] { [
      .field("stores", [Store]?.self),
    ] }

    public var stores: [Store]? { __data["stores"] }

    /// Store
    ///
    /// Parent Type: `Store`
    public struct Store: CoolBlueAssignment.SelectionSet {
      public let __data: DataDict
      public init(_dataDict: DataDict) { __data = _dataDict }

      public static var __parentType: any ApolloAPI.ParentType { CoolBlueAssignment.Objects.Store }
      public static var __selections: [ApolloAPI.Selection] { [
        .field("__typename", String.self),
        .field("id", CoolBlueAssignment.ID.self),
        .field("name", String.self),
        .field("address", Address?.self),
        .field("todayOpeningHours", TodayOpeningHours?.self),
      ] }

      /// Unique identifier of the physical Coolblue store. This Id is the same as the stockLocationId from Oracle. (Source: Stores CMS)
      public var id: CoolBlueAssignment.ID { __data["id"] }
      /// Name of the localized Coolblue store. (Source: Oracle)
      public var name: String { __data["name"] }
      /// Returns the address in a given store. (Source: Oracle)
      public var address: Address? { __data["address"] }
      /// Returns the current opening and closing times in a given store. (Source: Oracle)
      public var todayOpeningHours: TodayOpeningHours? { __data["todayOpeningHours"] }

      /// Store.Address
      ///
      /// Parent Type: `StoreAddress`
      public struct Address: CoolBlueAssignment.SelectionSet {
        public let __data: DataDict
        public init(_dataDict: DataDict) { __data = _dataDict }

        public static var __parentType: any ApolloAPI.ParentType { CoolBlueAssignment.Objects.StoreAddress }
        public static var __selections: [ApolloAPI.Selection] { [
          .field("__typename", String.self),
          .field("city", String.self),
          .field("country", String.self),
          .field("houseNumber", String.self),
          .field("postalCode", String.self),
          .field("street", String.self),
          .field("longitude", Double.self),
          .field("latitude", Double.self),
        ] }

        /// Store City
        public var city: String { __data["city"] }
        /// Store Country
        public var country: String { __data["country"] }
        /// Store house number
        public var houseNumber: String { __data["houseNumber"] }
        /// Store postal code
        public var postalCode: String { __data["postalCode"] }
        /// Store street name
        public var street: String { __data["street"] }
        /// Store Longitude
        public var longitude: Double { __data["longitude"] }
        /// Store Latitude
        public var latitude: Double { __data["latitude"] }
      }

      /// Store.TodayOpeningHours
      ///
      /// Parent Type: `StoreTimeFrame`
      public struct TodayOpeningHours: CoolBlueAssignment.SelectionSet {
        public let __data: DataDict
        public init(_dataDict: DataDict) { __data = _dataDict }

        public static var __parentType: any ApolloAPI.ParentType { CoolBlueAssignment.Objects.StoreTimeFrame }
        public static var __selections: [ApolloAPI.Selection] { [
          .field("__typename", String.self),
          .field("openTime", CoolBlueAssignment.Time?.self),
          .field("closeTime", CoolBlueAssignment.Time?.self),
        ] }

        /// Store opening time. When both open and close times on the same date are 00:00, it means the location is closed all day on that date.
        public var openTime: CoolBlueAssignment.Time? { __data["openTime"] }
        /// Store closing time. When both open and close times on the same date are 00:00, it means the location is closed all day on that date.
        public var closeTime: CoolBlueAssignment.Time? { __data["closeTime"] }
      }
    }
  }
}
