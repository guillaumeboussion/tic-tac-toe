// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get empty_field_error => 'This field cannot be empty';

  @override
  String get app_title => 'Tic Tac Toe';

  @override
  String get page_title_tic_tac_toe => 'TIC TAC TOE';

  @override
  String get ultimate_edition => '⚡ ULTIMATE EDITION ⚡';

  @override
  String get select_game_mode => 'Select Game Mode';

  @override
  String get play_vs_computer => 'Play vs Computer';

  @override
  String get play_vs_friend => 'Play vs Friend';

  @override
  String get challenge_the_ai => 'Challenge the AI';

  @override
  String get local_multiplayer => 'Local multiplayer';

  @override
  String get lets_play_together => 'Let\'s play together!';

  @override
  String get loading_experience => 'Loading experience...';

  @override
  String get attribution => 'by Guillaume Boussion ©';

  @override
  String get settings => 'Settings';

  @override
  String get language => 'Language';

  @override
  String get current_language => 'Current Language';

  @override
  String get english => 'English';

  @override
  String get french => 'French';

  @override
  String get player_1_turn => 'Player 1\'s Turn';

  @override
  String get player_2_turn => 'Player 2\'s Turn';

  @override
  String get ai_turn => 'AI\'s Turn';

  @override
  String get your_turn => 'Your Turn';

  @override
  String get trophies => 'Trophies';

  @override
  String get restart => 'Restart';

  @override
  String get new_game => 'New Game';

  @override
  String get back_to_home => 'Back to Home';

  @override
  String get victory => 'VICTORY!';

  @override
  String get defeat => 'DEFEAT!';

  @override
  String get draw => 'DRAW!';

  @override
  String get player_1_wins => 'PLAYER 1 WINS!';

  @override
  String get player_2_wins => 'PLAYER 2 WINS!';

  @override
  String get game_time => 'Game Time';

  @override
  String get vs_ai => 'VS AI';

  @override
  String get vs_friend => 'VS FRIEND';

  @override
  String trophies_earned(int count) {
    return '+$count Trophies!';
  }

  @override
  String get game_history => 'Game History';

  @override
  String get previous_games => 'Previous Games';

  @override
  String get statistics => 'Statistics';

  @override
  String get wins => 'Wins';

  @override
  String get losses => 'Losses';

  @override
  String get draws => 'Draws';

  @override
  String get ai => 'AI';

  @override
  String get friend => 'Friend';

  @override
  String get no_games_yet =>
      'No games played yet. Start playing to build your history!';

  @override
  String get error_loading_history => 'Error loading game history';
}
