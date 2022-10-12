// swiftlint:disable all
// Generated using SwiftGen — https://github.com/SwiftGen/SwiftGen

import Foundation

// swiftlint:disable superfluous_disable_command file_length implicit_return prefer_self_in_static_references

// MARK: - Strings

// swiftlint:disable explicit_type_interface function_parameter_count identifier_name line_length
// swiftlint:disable nesting type_body_length type_name vertical_whitespace_opening_braces
internal enum L10n {
  internal enum Answer {
    /// Magic Ball
    internal static let title = L10n.tr("Localizable", "answer.title", fallback: "Magic Ball")
  }
  internal enum AnswersHistory {
    /// Answers History
    internal static let title = L10n.tr("Localizable", "answersHistory.title", fallback: "Answers History")
  }
  internal enum Ball {
    /// Localizable.strings
    ///   8-Ball
    /// 
    ///   Created by Mykyta Khlamov on 13.11.2021.
    internal static let image = L10n.tr("Localizable", "ball.image", fallback: "record.circle")
  }
  internal enum Cancelled {
    /// Something went wrong!
    /// Try again!
    internal static let title = L10n.tr("Localizable", "cancelled.title", fallback: "Something went wrong!\nTry again!")
  }
  internal enum Error {
    internal enum DataBase {
      /// Data base adding error: 
      internal static let adding = L10n.tr("Localizable", "error.dataBase.adding", fallback: "Data base adding error: ")
      /// Data base deleting error: 
      internal static let deleting = L10n.tr("Localizable", "error.dataBase.deleting", fallback: "Data base deleting error: ")
      /// Data base fetching error: 
      internal static let fetching = L10n.tr("Localizable", "error.dataBase.fetching", fallback: "Data base fetching error: ")
    }
    internal enum UserAnswers {
      /// Unable to decode user answers. Error: 
      internal static let decode = L10n.tr("Localizable", "error.userAnswers.decode", fallback: "Unable to decode user answers. Error: ")
      /// Unable to encode user answers. Error: 
      internal static let encode = L10n.tr("Localizable", "error.userAnswers.encode", fallback: "Unable to encode user answers. Error: ")
    }
  }
  internal enum FirstResponse {
    /// Ask any question
    /// and Shake me!
    internal static let title = L10n.tr("Localizable", "firstResponse.title", fallback: "Ask any question\nand Shake me!")
  }
  internal enum History {
    /// book
    internal static let image = L10n.tr("Localizable", "history.image", fallback: "book")
  }
  internal enum Magic {
    /// Chalkduster
    internal static let font = L10n.tr("Localizable", "magic.font", fallback: "Chalkduster")
    /// Magic 8 Ball
    internal static let label = L10n.tr("Localizable", "magic.label", fallback: "Magic 8 Ball")
  }
  internal enum Motion {
    internal enum Began {
      /// Look into the future
      internal static let title = L10n.tr("Localizable", "motion.began.title", fallback: "Look into the future")
    }
  }
  internal enum NoAnswers {
    /// Add some answers by yourself!
    internal static let title = L10n.tr("Localizable", "noAnswers.title", fallback: "Add some answers by yourself!")
  }
  internal enum SaveButton {
    /// Save
    internal static let title = L10n.tr("Localizable", "saveButton.title", fallback: "Save")
  }
  internal enum Settings {
    /// gearshape.fill
    internal static let image = L10n.tr("Localizable", "settings.image", fallback: "gearshape.fill")
    /// User Answers
    internal static let title = L10n.tr("Localizable", "settings.title", fallback: "User Answers")
  }
  internal enum Triangle {
    /// triangle
    internal static let name = L10n.tr("Localizable", "triangle.name", fallback: "triangle")
  }
}
// swiftlint:enable explicit_type_interface function_parameter_count identifier_name line_length
// swiftlint:enable nesting type_body_length type_name vertical_whitespace_opening_braces

// MARK: - Implementation Details

extension L10n {
  private static func tr(_ table: String, _ key: String, _ args: CVarArg..., fallback value: String) -> String {
    let format = BundleToken.bundle.localizedString(forKey: key, value: value, table: table)
    return String(format: format, locale: Locale.current, arguments: args)
  }
}

// swiftlint:disable convenience_type
private final class BundleToken {
  static let bundle: Bundle = {
    #if SWIFT_PACKAGE
    return Bundle.module
    #else
    return Bundle(for: BundleToken.self)
    #endif
  }()
}
// swiftlint:enable convenience_type
