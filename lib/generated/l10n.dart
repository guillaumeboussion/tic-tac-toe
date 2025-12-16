// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'intl/messages_all.dart';

// **************************************************************************
// Generator: Flutter Intl IDE plugin
// Made by Localizely
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, lines_longer_than_80_chars
// ignore_for_file: join_return_with_assignment, prefer_final_in_for_each
// ignore_for_file: avoid_redundant_argument_values, avoid_escaping_inner_quotes

class L10n {
  L10n();

  static L10n? _current;

  static L10n get current {
    assert(_current != null,
        'No instance of L10n was loaded. Try to initialize the L10n delegate before accessing L10n.current.');
    return _current!;
  }

  static const AppLocalizationDelegate delegate = AppLocalizationDelegate();

  static Future<L10n> load(Locale locale) {
    final name = (locale.countryCode?.isEmpty ?? false)
        ? locale.languageCode
        : locale.toString();
    final localeName = Intl.canonicalizedLocale(name);
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      final instance = L10n();
      L10n._current = instance;

      return instance;
    });
  }

  static L10n of(BuildContext context) {
    final instance = L10n.maybeOf(context);
    assert(instance != null,
        'No instance of L10n present in the widget tree. Did you add L10n.delegate in localizationsDelegates?');
    return instance!;
  }

  static L10n? maybeOf(BuildContext context) {
    return Localizations.of<L10n>(context, L10n);
  }

  /// `Ce champ ne peut pas être vide`
  String get empty_field_error {
    return Intl.message(
      'Ce champ ne peut pas être vide',
      name: 'empty_field_error',
      desc: '',
      args: [],
    );
  }

  /// `Tic Tac Toe`
  String get app_title {
    return Intl.message(
      'Tic Tac Toe',
      name: 'app_title',
      desc: '',
      args: [],
    );
  }

  /// `TIC TAC TOE`
  String get page_title_tic_tac_toe {
    return Intl.message(
      'TIC TAC TOE',
      name: 'page_title_tic_tac_toe',
      desc: '',
      args: [],
    );
  }

  /// `⚡ ÉDITION ULTIME ⚡`
  String get ultimate_edition {
    return Intl.message(
      '⚡ ÉDITION ULTIME ⚡',
      name: 'ultimate_edition',
      desc: '',
      args: [],
    );
  }

  /// `Sélectionner le mode de jeu`
  String get select_game_mode {
    return Intl.message(
      'Sélectionner le mode de jeu',
      name: 'select_game_mode',
      desc: '',
      args: [],
    );
  }

  /// `Jouer contre l'ordinateur`
  String get play_vs_computer {
    return Intl.message(
      'Jouer contre l\'ordinateur',
      name: 'play_vs_computer',
      desc: '',
      args: [],
    );
  }

  /// `Jouer contre un ami`
  String get play_vs_friend {
    return Intl.message(
      'Jouer contre un ami',
      name: 'play_vs_friend',
      desc: '',
      args: [],
    );
  }

  /// `Défiez l'IA`
  String get challenge_the_ai {
    return Intl.message(
      'Défiez l\'IA',
      name: 'challenge_the_ai',
      desc: '',
      args: [],
    );
  }

  /// `Multijoueur local`
  String get local_multiplayer {
    return Intl.message(
      'Multijoueur local',
      name: 'local_multiplayer',
      desc: '',
      args: [],
    );
  }

  /// `Jouons ensemble !`
  String get lets_play_together {
    return Intl.message(
      'Jouons ensemble !',
      name: 'lets_play_together',
      desc: '',
      args: [],
    );
  }

  /// `Chargement de l'expérience...`
  String get loading_experience {
    return Intl.message(
      'Chargement de l\'expérience...',
      name: 'loading_experience',
      desc: '',
      args: [],
    );
  }

  /// `par Guillaume Boussion ©`
  String get attribution {
    return Intl.message(
      'par Guillaume Boussion ©',
      name: 'attribution',
      desc: '',
      args: [],
    );
  }

  /// `Paramètres`
  String get settings {
    return Intl.message(
      'Paramètres',
      name: 'settings',
      desc: '',
      args: [],
    );
  }

  /// `Langue`
  String get language {
    return Intl.message(
      'Langue',
      name: 'language',
      desc: '',
      args: [],
    );
  }

  /// `Langue actuelle`
  String get current_language {
    return Intl.message(
      'Langue actuelle',
      name: 'current_language',
      desc: '',
      args: [],
    );
  }

  /// `Anglais`
  String get english {
    return Intl.message(
      'Anglais',
      name: 'english',
      desc: '',
      args: [],
    );
  }

  /// `Français`
  String get french {
    return Intl.message(
      'Français',
      name: 'french',
      desc: '',
      args: [],
    );
  }

  /// `Tour du joueur 1`
  String get player_1_turn {
    return Intl.message(
      'Tour du joueur 1',
      name: 'player_1_turn',
      desc: '',
      args: [],
    );
  }

  /// `Tour du joueur 2`
  String get player_2_turn {
    return Intl.message(
      'Tour du joueur 2',
      name: 'player_2_turn',
      desc: '',
      args: [],
    );
  }

  /// `Tour de l'IA`
  String get ai_turn {
    return Intl.message(
      'Tour de l\'IA',
      name: 'ai_turn',
      desc: '',
      args: [],
    );
  }

  /// `Votre tour`
  String get your_turn {
    return Intl.message(
      'Votre tour',
      name: 'your_turn',
      desc: '',
      args: [],
    );
  }

  /// `Trophées`
  String get trophies {
    return Intl.message(
      'Trophées',
      name: 'trophies',
      desc: '',
      args: [],
    );
  }

  /// `Recommencer`
  String get restart {
    return Intl.message(
      'Recommencer',
      name: 'restart',
      desc: '',
      args: [],
    );
  }

  /// `Nouvelle partie`
  String get new_game {
    return Intl.message(
      'Nouvelle partie',
      name: 'new_game',
      desc: '',
      args: [],
    );
  }

  /// `Retour à l'accueil`
  String get back_to_home {
    return Intl.message(
      'Retour à l\'accueil',
      name: 'back_to_home',
      desc: '',
      args: [],
    );
  }

  /// `VICTOIRE !`
  String get victory {
    return Intl.message(
      'VICTOIRE !',
      name: 'victory',
      desc: '',
      args: [],
    );
  }

  /// `DÉFAITE !`
  String get defeat {
    return Intl.message(
      'DÉFAITE !',
      name: 'defeat',
      desc: '',
      args: [],
    );
  }

  /// `ÉGALITÉ !`
  String get draw {
    return Intl.message(
      'ÉGALITÉ !',
      name: 'draw',
      desc: '',
      args: [],
    );
  }

  /// `JOUEUR 1 GAGNE !`
  String get player_1_wins {
    return Intl.message(
      'JOUEUR 1 GAGNE !',
      name: 'player_1_wins',
      desc: '',
      args: [],
    );
  }

  /// `JOUEUR 2 GAGNE !`
  String get player_2_wins {
    return Intl.message(
      'JOUEUR 2 GAGNE !',
      name: 'player_2_wins',
      desc: '',
      args: [],
    );
  }

  /// `Temps de jeu`
  String get game_time {
    return Intl.message(
      'Temps de jeu',
      name: 'game_time',
      desc: '',
      args: [],
    );
  }

  /// `VS IA`
  String get vs_ai {
    return Intl.message(
      'VS IA',
      name: 'vs_ai',
      desc: '',
      args: [],
    );
  }

  /// `VS AMI`
  String get vs_friend {
    return Intl.message(
      'VS AMI',
      name: 'vs_friend',
      desc: '',
      args: [],
    );
  }

  /// `+{count} Trophées !`
  String trophies_earned(Object count) {
    return Intl.message(
      '+$count Trophées !',
      name: 'trophies_earned',
      desc: '',
      args: [count],
    );
  }

  /// `Historique des parties`
  String get game_history {
    return Intl.message(
      'Historique des parties',
      name: 'game_history',
      desc: '',
      args: [],
    );
  }

  /// `Parties précédentes`
  String get previous_games {
    return Intl.message(
      'Parties précédentes',
      name: 'previous_games',
      desc: '',
      args: [],
    );
  }

  /// `Statistiques`
  String get statistics {
    return Intl.message(
      'Statistiques',
      name: 'statistics',
      desc: '',
      args: [],
    );
  }

  /// `Victoires`
  String get wins {
    return Intl.message(
      'Victoires',
      name: 'wins',
      desc: '',
      args: [],
    );
  }

  /// `Défaites`
  String get losses {
    return Intl.message(
      'Défaites',
      name: 'losses',
      desc: '',
      args: [],
    );
  }

  /// `Égalités`
  String get draws {
    return Intl.message(
      'Égalités',
      name: 'draws',
      desc: '',
      args: [],
    );
  }

  /// `IA`
  String get ai {
    return Intl.message(
      'IA',
      name: 'ai',
      desc: '',
      args: [],
    );
  }

  /// `Ami`
  String get friend {
    return Intl.message(
      'Ami',
      name: 'friend',
      desc: '',
      args: [],
    );
  }

  /// `Aucune partie jouée. Commencez à jouer pour construire votre historique !`
  String get no_games_yet {
    return Intl.message(
      'Aucune partie jouée. Commencez à jouer pour construire votre historique !',
      name: 'no_games_yet',
      desc: '',
      args: [],
    );
  }

  /// `Erreur lors du chargement de l'historique`
  String get error_loading_history {
    return Intl.message(
      'Erreur lors du chargement de l\'historique',
      name: 'error_loading_history',
      desc: '',
      args: [],
    );
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<L10n> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'fr'),
      Locale.fromSubtags(languageCode: 'en'),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<L10n> load(Locale locale) => L10n.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    for (var supportedLocale in supportedLocales) {
      if (supportedLocale.languageCode == locale.languageCode) {
        return true;
      }
    }
    return false;
  }
}
