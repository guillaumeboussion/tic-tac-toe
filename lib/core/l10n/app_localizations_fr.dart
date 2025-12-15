// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for French (`fr`).
class AppLocalizationsFr extends AppLocalizations {
  AppLocalizationsFr([String locale = 'fr']) : super(locale);

  @override
  String get empty_field_error => 'Ce champ ne peut pas être vide';

  @override
  String get app_title => 'Tic Tac Toe';

  @override
  String get page_title_tic_tac_toe => 'TIC TAC TOE';

  @override
  String get ultimate_edition => '⚡ ÉDITION ULTIME ⚡';

  @override
  String get select_game_mode => 'Sélectionner le mode de jeu';

  @override
  String get play_vs_computer => 'Jouer contre l\'ordinateur';

  @override
  String get play_vs_friend => 'Jouer contre un ami';

  @override
  String get challenge_the_ai => 'Défiez l\'IA';

  @override
  String get local_multiplayer => 'Multijoueur local';

  @override
  String get lets_play_together => 'Jouons ensemble !';

  @override
  String get loading_experience => 'Chargement de l\'expérience...';

  @override
  String get attribution => 'par Guillaume Boussion ©';

  @override
  String get settings => 'Paramètres';

  @override
  String get language => 'Langue';

  @override
  String get current_language => 'Langue actuelle';

  @override
  String get english => 'Anglais';

  @override
  String get french => 'Français';

  @override
  String get player_1_turn => 'Tour du joueur 1';

  @override
  String get player_2_turn => 'Tour du joueur 2';

  @override
  String get ai_turn => 'Tour de l\'IA';

  @override
  String get your_turn => 'Votre tour';

  @override
  String get trophies => 'Trophées';

  @override
  String get restart => 'Recommencer';

  @override
  String get new_game => 'Nouvelle partie';

  @override
  String get back_to_home => 'Retour à l\'accueil';

  @override
  String get victory => 'VICTOIRE !';

  @override
  String get defeat => 'DÉFAITE !';

  @override
  String get draw => 'ÉGALITÉ !';

  @override
  String get player_1_wins => 'JOUEUR 1 GAGNE !';

  @override
  String get player_2_wins => 'JOUEUR 2 GAGNE !';

  @override
  String get game_time => 'Temps de jeu';

  @override
  String get vs_ai => 'VS IA';

  @override
  String get vs_friend => 'VS AMI';

  @override
  String trophies_earned(int count) {
    return '+$count Trophées !';
  }

  @override
  String get game_history => 'Historique des parties';

  @override
  String get previous_games => 'Parties précédentes';

  @override
  String get statistics => 'Statistiques';

  @override
  String get wins => 'Victoires';

  @override
  String get losses => 'Défaites';

  @override
  String get draws => 'Égalités';

  @override
  String get ai => 'IA';

  @override
  String get friend => 'Ami';

  @override
  String get no_games_yet =>
      'Aucune partie jouée. Commencez à jouer pour construire votre historique !';

  @override
  String get error_loading_history =>
      'Erreur lors du chargement de l\'historique';
}
