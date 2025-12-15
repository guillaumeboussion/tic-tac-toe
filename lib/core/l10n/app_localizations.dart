import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';
import 'app_localizations_fr.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
      : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
    delegate,
    GlobalMaterialLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
  ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('en'),
    Locale('fr')
  ];

  /// No description provided for @empty_field_error.
  ///
  /// In en, this message translates to:
  /// **'This field cannot be empty'**
  String get empty_field_error;

  /// No description provided for @app_title.
  ///
  /// In en, this message translates to:
  /// **'Tic Tac Toe'**
  String get app_title;

  /// No description provided for @page_title_tic_tac_toe.
  ///
  /// In en, this message translates to:
  /// **'TIC TAC TOE'**
  String get page_title_tic_tac_toe;

  /// No description provided for @ultimate_edition.
  ///
  /// In en, this message translates to:
  /// **'⚡ ULTIMATE EDITION ⚡'**
  String get ultimate_edition;

  /// No description provided for @select_game_mode.
  ///
  /// In en, this message translates to:
  /// **'Select Game Mode'**
  String get select_game_mode;

  /// No description provided for @play_vs_computer.
  ///
  /// In en, this message translates to:
  /// **'Play vs Computer'**
  String get play_vs_computer;

  /// No description provided for @play_vs_friend.
  ///
  /// In en, this message translates to:
  /// **'Play vs Friend'**
  String get play_vs_friend;

  /// No description provided for @challenge_the_ai.
  ///
  /// In en, this message translates to:
  /// **'Challenge the AI'**
  String get challenge_the_ai;

  /// No description provided for @local_multiplayer.
  ///
  /// In en, this message translates to:
  /// **'Local multiplayer'**
  String get local_multiplayer;

  /// No description provided for @lets_play_together.
  ///
  /// In en, this message translates to:
  /// **'Let\'s play together!'**
  String get lets_play_together;

  /// No description provided for @loading_experience.
  ///
  /// In en, this message translates to:
  /// **'Loading experience...'**
  String get loading_experience;

  /// No description provided for @attribution.
  ///
  /// In en, this message translates to:
  /// **'by Guillaume Boussion ©'**
  String get attribution;

  /// No description provided for @settings.
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get settings;

  /// No description provided for @language.
  ///
  /// In en, this message translates to:
  /// **'Language'**
  String get language;

  /// No description provided for @current_language.
  ///
  /// In en, this message translates to:
  /// **'Current Language'**
  String get current_language;

  /// No description provided for @english.
  ///
  /// In en, this message translates to:
  /// **'English'**
  String get english;

  /// No description provided for @french.
  ///
  /// In en, this message translates to:
  /// **'French'**
  String get french;

  /// No description provided for @player_1_turn.
  ///
  /// In en, this message translates to:
  /// **'Player 1\'s Turn'**
  String get player_1_turn;

  /// No description provided for @player_2_turn.
  ///
  /// In en, this message translates to:
  /// **'Player 2\'s Turn'**
  String get player_2_turn;

  /// No description provided for @ai_turn.
  ///
  /// In en, this message translates to:
  /// **'AI\'s Turn'**
  String get ai_turn;

  /// No description provided for @your_turn.
  ///
  /// In en, this message translates to:
  /// **'Your Turn'**
  String get your_turn;

  /// No description provided for @trophies.
  ///
  /// In en, this message translates to:
  /// **'Trophies'**
  String get trophies;

  /// No description provided for @restart.
  ///
  /// In en, this message translates to:
  /// **'Restart'**
  String get restart;

  /// No description provided for @new_game.
  ///
  /// In en, this message translates to:
  /// **'New Game'**
  String get new_game;

  /// No description provided for @back_to_home.
  ///
  /// In en, this message translates to:
  /// **'Back to Home'**
  String get back_to_home;

  /// No description provided for @victory.
  ///
  /// In en, this message translates to:
  /// **'VICTORY!'**
  String get victory;

  /// No description provided for @defeat.
  ///
  /// In en, this message translates to:
  /// **'DEFEAT!'**
  String get defeat;

  /// No description provided for @draw.
  ///
  /// In en, this message translates to:
  /// **'DRAW!'**
  String get draw;

  /// No description provided for @game_time.
  ///
  /// In en, this message translates to:
  /// **'Game Time'**
  String get game_time;

  /// No description provided for @vs_ai.
  ///
  /// In en, this message translates to:
  /// **'VS AI'**
  String get vs_ai;

  /// No description provided for @vs_friend.
  ///
  /// In en, this message translates to:
  /// **'VS FRIEND'**
  String get vs_friend;

  /// No description provided for @trophies_earned.
  ///
  /// In en, this message translates to:
  /// **'+{count} Trophies!'**
  String trophies_earned(int count);

  /// No description provided for @game_history.
  ///
  /// In en, this message translates to:
  /// **'Game History'**
  String get game_history;

  /// No description provided for @previous_games.
  ///
  /// In en, this message translates to:
  /// **'Previous Games'**
  String get previous_games;

  /// No description provided for @wins.
  ///
  /// In en, this message translates to:
  /// **'Wins'**
  String get wins;

  /// No description provided for @losses.
  ///
  /// In en, this message translates to:
  /// **'Losses'**
  String get losses;

  /// No description provided for @draws.
  ///
  /// In en, this message translates to:
  /// **'Draws'**
  String get draws;

  /// No description provided for @ai.
  ///
  /// In en, this message translates to:
  /// **'AI'**
  String get ai;

  /// No description provided for @friend.
  ///
  /// In en, this message translates to:
  /// **'Friend'**
  String get friend;

  /// No description provided for @no_games_yet.
  ///
  /// In en, this message translates to:
  /// **'No games played yet. Start playing to build your history!'**
  String get no_games_yet;

  /// No description provided for @error_loading_history.
  ///
  /// In en, this message translates to:
  /// **'Error loading game history'**
  String get error_loading_history;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['en', 'fr'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en':
      return AppLocalizationsEn();
    case 'fr':
      return AppLocalizationsFr();
  }

  throw FlutterError(
      'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
      'an issue with the localizations generation tool. Please file an issue '
      'on GitHub with a reproducible sample app and the gen-l10n configuration '
      'that was used.');
}
