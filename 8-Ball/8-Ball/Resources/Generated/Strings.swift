// swiftlint:disable all
// Generated using SwiftGen — https://github.com/SwiftGen/SwiftGen

import Foundation

// swiftlint:disable superfluous_disable_command file_length implicit_return

// MARK: - Strings

// swiftlint:disable explicit_type_interface function_parameter_count identifier_name line_length
// swiftlint:disable nesting type_body_length type_name vertical_whitespace_opening_braces
internal enum L10n {

  internal enum Answer {
    /// Magic Ball
    internal static let title = L10n.tr("Localizable", "answer.title")
  }

  internal enum AnswersHistory {
    /// Answers History
    internal static let title = L10n.tr("Localizable", "answersHistory.title")
  }

  internal enum Ball {
    /// record.circle
    internal static let image = L10n.tr("Localizable", "ball.image")
  }

  internal enum Cancel {
    internal enum Error {
      /// Ups! Try again later!
      internal static let title = L10n.tr("Localizable", "cancel.error.title")
      internal enum NoAnswers {
        /// Add some answers by yourself!
        internal static let title = L10n.tr("Localizable", "cancel.error.noAnswers.title")
      }
    }
  }

  internal enum Cancelled {
    /// Ups! Try again!
    internal static let title = L10n.tr("Localizable", "cancelled.title")
  }

  internal enum FirstResponse {
    /// Ask any question
    /// and Shake me!
    internal static let title = L10n.tr("Localizable", "firstResponse.title")
  }

  internal enum History {
    /// book
    internal static let image = L10n.tr("Localizable", "history.image")
  }

  internal enum Magic {
    /// Chalkduster
    internal static let font = L10n.tr("Localizable", "magic.font")
    /// Magic 8 Ball
    internal static let label = L10n.tr("Localizable", "magic.label")
  }

  internal enum Motion {
    internal enum Began {
      /// Look into the future
      internal static let title = L10n.tr("Localizable", "motion.began.title")
    }
  }

  internal enum SaveButton {
    /// Save
    internal static let title = L10n.tr("Localizable", "saveButton.title")
  }

  internal enum Settings {
    /// gearshape.fill
    internal static let image = L10n.tr("Localizable", "settings.image")
    /// User Answers
    internal static let title = L10n.tr("Localizable", "settings.title")
  }

  internal enum Triangle {
    /// triangle
    internal static let name = L10n.tr("Localizable", "triangle.name")
  }
}
// swiftlint:enable explicit_type_interface function_parameter_count identifier_name line_length
// swiftlint:enable nesting type_body_length type_name vertical_whitespace_opening_braces

// MARK: - Implementation Details

extension L10n {
  private static func tr(_ table: String, _ key: String, _ args: CVarArg...) -> String {
    let format = BundleToken.bundle.localizedString(forKey: key, value: nil, table: table)
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
