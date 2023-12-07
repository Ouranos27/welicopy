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

class S {
  S();

  static S? _current;

  static S get current {
    assert(_current != null,
        'No instance of S was loaded. Try to initialize the S delegate before accessing S.current.');
    return _current!;
  }

  static const AppLocalizationDelegate delegate = AppLocalizationDelegate();

  static Future<S> load(Locale locale) {
    final name = (locale.countryCode?.isEmpty ?? false)
        ? locale.languageCode
        : locale.toString();
    final localeName = Intl.canonicalizedLocale(name);
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      final instance = S();
      S._current = instance;

      return instance;
    });
  }

  static S of(BuildContext context) {
    final instance = S.maybeOf(context);
    assert(instance != null,
        'No instance of S present in the widget tree. Did you add S.delegate in localizationsDelegates?');
    return instance!;
  }

  static S? maybeOf(BuildContext context) {
    return Localizations.of<S>(context, S);
  }

  /// `Mail`
  String get email {
    return Intl.message(
      'Mail',
      name: 'email',
      desc: '',
      args: [],
    );
  }

  /// `Mot de passe`
  String get password {
    return Intl.message(
      'Mot de passe',
      name: 'password',
      desc: '',
      args: [],
    );
  }

  /// `Confirmation mot de passe`
  String get password2 {
    return Intl.message(
      'Confirmation mot de passe',
      name: 'password2',
      desc: '',
      args: [],
    );
  }

  /// `Nouveau mot de passe`
  String get newPassword {
    return Intl.message(
      'Nouveau mot de passe',
      name: 'newPassword',
      desc: '',
      args: [],
    );
  }

  /// `Mot de passe oublié`
  String get forgotPassword {
    return Intl.message(
      'Mot de passe oublié',
      name: 'forgotPassword',
      desc: '',
      args: [],
    );
  }

  /// `Se connecter`
  String get login {
    return Intl.message(
      'Se connecter',
      name: 'login',
      desc: '',
      args: [],
    );
  }

  /// `S’inscrire`
  String get register {
    return Intl.message(
      'S’inscrire',
      name: 'register',
      desc: '',
      args: [],
    );
  }

  /// `Prénom`
  String get firstName {
    return Intl.message(
      'Prénom',
      name: 'firstName',
      desc: '',
      args: [],
    );
  }

  /// `Nom`
  String get lastName {
    return Intl.message(
      'Nom',
      name: 'lastName',
      desc: '',
      args: [],
    );
  }

  /// `Téléphone`
  String get phoneNumber {
    return Intl.message(
      'Téléphone',
      name: 'phoneNumber',
      desc: '',
      args: [],
    );
  }

  /// `Statut`
  String get status {
    return Intl.message(
      'Statut',
      name: 'status',
      desc: '',
      args: [],
    );
  }

  /// `Entreprise`
  String get company {
    return Intl.message(
      'Entreprise',
      name: 'company',
      desc: '',
      args: [],
    );
  }

  /// `Quels sont vos principaux besoins sur l’application ?`
  String get uses {
    return Intl.message(
      'Quels sont vos principaux besoins sur l’application ?',
      name: 'uses',
      desc: '',
      args: [],
    );
  }

  /// `Quels types d'opportunités vous intéressent le plus ?`
  String get wantedInvestmentTypesQuestion {
    return Intl.message(
      'Quels types d\'opportunités vous intéressent le plus ?',
      name: 'wantedInvestmentTypesQuestion',
      desc: '',
      args: [],
    );
  }

  /// `Quel(s) type(s) de biens recherchez-vous ?`
  String get wantedPropertyTypesQuestion {
    return Intl.message(
      'Quel(s) type(s) de biens recherchez-vous ?',
      name: 'wantedPropertyTypesQuestion',
      desc: '',
      args: [],
    );
  }

  /// `Quel est le budget approximatif pour votre projet d’investissement ?`
  String get budgetQuestion {
    return Intl.message(
      'Quel est le budget approximatif pour votre projet d’investissement ?',
      name: 'budgetQuestion',
      desc: '',
      args: [],
    );
  }

  /// `Quel(s) type(s) d’investissement immobilier souhaitez-vous proposer ?`
  String get offeredInvestmentTypesQuestion {
    return Intl.message(
      'Quel(s) type(s) d’investissement immobilier souhaitez-vous proposer ?',
      name: 'offeredInvestmentTypesQuestion',
      desc: '',
      args: [],
    );
  }

  /// `Quel(s) type(s) de biens souhaitez-vous proposer ?`
  String get offeredPropertyTypesQuestion {
    return Intl.message(
      'Quel(s) type(s) de biens souhaitez-vous proposer ?',
      name: 'offeredPropertyTypesQuestion',
      desc: '',
      args: [],
    );
  }

  /// `Quel est votre profil d’investisseur ?`
  String get investorTypeQuestion {
    return Intl.message(
      'Quel est votre profil d’investisseur ?',
      name: 'investorTypeQuestion',
      desc: '',
      args: [],
    );
  }

  /// `Comment financez vous vos acquisitions ?`
  String get financingTypeQuestion {
    return Intl.message(
      'Comment financez vous vos acquisitions ?',
      name: 'financingTypeQuestion',
      desc: '',
      args: [],
    );
  }

  /// `Investissement`
  String get investmentDuration {
    return Intl.message(
      'Investissement',
      name: 'investmentDuration',
      desc: '',
      args: [],
    );
  }

  /// `Types d’investissement`
  String get investmentType {
    return Intl.message(
      'Types d’investissement',
      name: 'investmentType',
      desc: '',
      args: [],
    );
  }

  /// `Type de bien`
  String get propertyType {
    return Intl.message(
      'Type de bien',
      name: 'propertyType',
      desc: '',
      args: [],
    );
  }

  /// `Vignettes`
  String get labels {
    return Intl.message(
      'Vignettes',
      name: 'labels',
      desc: '',
      args: [],
    );
  }

  /// `Localisation`
  String get location {
    return Intl.message(
      'Localisation',
      name: 'location',
      desc: '',
      args: [],
    );
  }

  /// `Surface`
  String get area {
    return Intl.message(
      'Surface',
      name: 'area',
      desc: '',
      args: [],
    );
  }

  /// `Terrain`
  String get landArea {
    return Intl.message(
      'Terrain',
      name: 'landArea',
      desc: '',
      args: [],
    );
  }

  /// `Prix`
  String get price {
    return Intl.message(
      'Prix',
      name: 'price',
      desc: '',
      args: [],
    );
  }

  /// `Rentabilité`
  String get profitability {
    return Intl.message(
      'Rentabilité',
      name: 'profitability',
      desc: '',
      args: [],
    );
  }

  /// `État du bien`
  String get propertyState {
    return Intl.message(
      'État du bien',
      name: 'propertyState',
      desc: '',
      args: [],
    );
  }

  /// `Profil acquéreur`
  String get buyerType {
    return Intl.message(
      'Profil acquéreur',
      name: 'buyerType',
      desc: '',
      args: [],
    );
  }

  /// `Financement`
  String get financingType {
    return Intl.message(
      'Financement',
      name: 'financingType',
      desc: '',
      args: [],
    );
  }

  /// `Nombre de pièces`
  String get roomCount {
    return Intl.message(
      'Nombre de pièces',
      name: 'roomCount',
      desc: '',
      args: [],
    );
  }

  /// `Publiée`
  String get publishedAt {
    return Intl.message(
      'Publiée',
      name: 'publishedAt',
      desc: '',
      args: [],
    );
  }

  /// `Rejetée`
  String get rejectedAt {
    return Intl.message(
      'Rejetée',
      name: 'rejectedAt',
      desc: '',
      args: [],
    );
  }

  /// `En attente`
  String get submittedAt {
    return Intl.message(
      'En attente',
      name: 'submittedAt',
      desc: '',
      args: [],
    );
  }

  /// `En cours de création`
  String get modifiedAt {
    return Intl.message(
      'En cours de création',
      name: 'modifiedAt',
      desc: '',
      args: [],
    );
  }

  /// `Veuillez remplir ce champ.`
  String get empty_field_error {
    return Intl.message(
      'Veuillez remplir ce champ.',
      name: 'empty_field_error',
      desc: '',
      args: [],
    );
  }

  /// `Invalide.`
  String get invalid_field_error {
    return Intl.message(
      'Invalide.',
      name: 'invalid_field_error',
      desc: '',
      args: [],
    );
  }

  /// `Voulez-vous enregister ce bien ?`
  String get wanna_save_card {
    return Intl.message(
      'Voulez-vous enregister ce bien ?',
      name: 'wanna_save_card',
      desc: '',
      args: [],
    );
  }

  /// `Voulez-vous publier ce bien ? Il ne pourra plus être modifiée.`
  String get publish_warning {
    return Intl.message(
      'Voulez-vous publier ce bien ? Il ne pourra plus être modifiée.',
      name: 'publish_warning',
      desc: '',
      args: [],
    );
  }

  /// `L'adresse email est invalide.`
  String get invalid_email {
    return Intl.message(
      'L\'adresse email est invalide.',
      name: 'invalid_email',
      desc: '',
      args: [],
    );
  }

  /// `Cet email est déjà utilisé`
  String get email_already_exists {
    return Intl.message(
      'Cet email est déjà utilisé',
      name: 'email_already_exists',
      desc: '',
      args: [],
    );
  }

  /// `Mauvais mot de passe.`
  String get wrong_password {
    return Intl.message(
      'Mauvais mot de passe.',
      name: 'wrong_password',
      desc: '',
      args: [],
    );
  }

  /// `Le mot de passe comporter au moins 6 caractères.`
  String get invalid_password {
    return Intl.message(
      'Le mot de passe comporter au moins 6 caractères.',
      name: 'invalid_password',
      desc: '',
      args: [],
    );
  }

  /// `Les deux mots de passe doivent être identiques.`
  String get not_identical_password {
    return Intl.message(
      'Les deux mots de passe doivent être identiques.',
      name: 'not_identical_password',
      desc: '',
      args: [],
    );
  }

  /// `Aucun compte n'est relié à cet email.`
  String get no_account {
    return Intl.message(
      'Aucun compte n\'est relié à cet email.',
      name: 'no_account',
      desc: '',
      args: [],
    );
  }

  /// `Compte désactivé.`
  String get disabled_account {
    return Intl.message(
      'Compte désactivé.',
      name: 'disabled_account',
      desc: '',
      args: [],
    );
  }

  /// `Voulez-vous retirer ce bien de vos favoris ?`
  String get remove_like_warning {
    return Intl.message(
      'Voulez-vous retirer ce bien de vos favoris ?',
      name: 'remove_like_warning',
      desc: '',
      args: [],
    );
  }

  /// `Connexion`
  String get connection {
    return Intl.message(
      'Connexion',
      name: 'connection',
      desc: '',
      args: [],
    );
  }

  /// `We love invest`
  String get loginTitleDescription {
    return Intl.message(
      'We love invest',
      name: 'loginTitleDescription',
      desc: '',
      args: [],
    );
  }

  /// `Mon profil`
  String get myProfile {
    return Intl.message(
      'Mon profil',
      name: 'myProfile',
      desc: '',
      args: [],
    );
  }

  /// `Déposer une annonce`
  String get placeAnAds {
    return Intl.message(
      'Déposer une annonce',
      name: 'placeAnAds',
      desc: '',
      args: [],
    );
  }

  /// `Accéder aux salons`
  String get accessToLounge {
    return Intl.message(
      'Accéder aux salons',
      name: 'accessToLounge',
      desc: '',
      args: [],
    );
  }

  /// `Typologie de biens`
  String get goods {
    return Intl.message(
      'Typologie de biens',
      name: 'goods',
      desc: '',
      args: [],
    );
  }

  /// `Vos #`
  String get other {
    return Intl.message(
      'Vos #',
      name: 'other',
      desc: '',
      args: [],
    );
  }

  /// `Continuer`
  String get next {
    return Intl.message(
      'Continuer',
      name: 'next',
      desc: '',
      args: [],
    );
  }

  /// `La valeur doit être numérique`
  String get numeric {
    return Intl.message(
      'La valeur doit être numérique',
      name: 'numeric',
      desc: '',
      args: [],
    );
  }

  /// `Ville`
  String get city {
    return Intl.message(
      'Ville',
      name: 'city',
      desc: '',
      args: [],
    );
  }

  /// `Département`
  String get department {
    return Intl.message(
      'Département',
      name: 'department',
      desc: '',
      args: [],
    );
  }

  /// `Votre secteur d’activité`
  String get job {
    return Intl.message(
      'Votre secteur d’activité',
      name: 'job',
      desc: '',
      args: [],
    );
  }

  /// `Erreur`
  String get error {
    return Intl.message(
      'Erreur',
      name: 'error',
      desc: '',
      args: [],
    );
  }

  /// `Un mail de réinitialisation sera envoyé si un compte est lié à cet e-mail.`
  String get resetPasswordMessage {
    return Intl.message(
      'Un mail de réinitialisation sera envoyé si un compte est lié à cet e-mail.',
      name: 'resetPasswordMessage',
      desc: '',
      args: [],
    );
  }

  /// `Erreur à l'inscription`
  String get register_error {
    return Intl.message(
      'Erreur à l\'inscription',
      name: 'register_error',
      desc: '',
      args: [],
    );
  }

  /// `Envoyer`
  String get send {
    return Intl.message(
      'Envoyer',
      name: 'send',
      desc: '',
      args: [],
    );
  }

  /// `MDP oublié`
  String get forgotPasswordTitle {
    return Intl.message(
      'MDP oublié',
      name: 'forgotPasswordTitle',
      desc: '',
      args: [],
    );
  }

  /// `Pas de données`
  String get no_data {
    return Intl.message(
      'Pas de données',
      name: 'no_data',
      desc: '',
      args: [],
    );
  }

  /// `Weli`
  String get weli {
    return Intl.message(
      'Weli',
      name: 'weli',
      desc: '',
      args: [],
    );
  }

  /// `Salons`
  String get salon {
    return Intl.message(
      'Salons',
      name: 'salon',
      desc: '',
      args: [],
    );
  }

  /// `Messagerie`
  String get messenger {
    return Intl.message(
      'Messagerie',
      name: 'messenger',
      desc: '',
      args: [],
    );
  }

  /// `Nouveau`
  String get newSection {
    return Intl.message(
      'Nouveau',
      name: 'newSection',
      desc: '',
      args: [],
    );
  }

  /// `Favoris`
  String get favoriteSection {
    return Intl.message(
      'Favoris',
      name: 'favoriteSection',
      desc: '',
      args: [],
    );
  }

  /// `Profil`
  String get profile {
    return Intl.message(
      'Profil',
      name: 'profile',
      desc: '',
      args: [],
    );
  }

  /// `Mon compte`
  String get myAccount {
    return Intl.message(
      'Mon compte',
      name: 'myAccount',
      desc: '',
      args: [],
    );
  }

  /// `Modifier`
  String get modify {
    return Intl.message(
      'Modifier',
      name: 'modify',
      desc: '',
      args: [],
    );
  }

  /// `Titre`
  String get title {
    return Intl.message(
      'Titre',
      name: 'title',
      desc: '',
      args: [],
    );
  }

  /// `Surface habitable`
  String get livingSpace {
    return Intl.message(
      'Surface habitable',
      name: 'livingSpace',
      desc: '',
      args: [],
    );
  }

  /// `Nombre de lots`
  String get numberOfBatches {
    return Intl.message(
      'Nombre de lots',
      name: 'numberOfBatches',
      desc: '',
      args: [],
    );
  }

  /// `Etat du bien`
  String get stateOfGoods {
    return Intl.message(
      'Etat du bien',
      name: 'stateOfGoods',
      desc: '',
      args: [],
    );
  }

  /// `Les +`
  String get moreDetails {
    return Intl.message(
      'Les +',
      name: 'moreDetails',
      desc: '',
      args: [],
    );
  }

  /// `Mon annonce`
  String get myAnnouncement {
    return Intl.message(
      'Mon annonce',
      name: 'myAnnouncement',
      desc: '',
      args: [],
    );
  }

  /// `Photos`
  String get photos {
    return Intl.message(
      'Photos',
      name: 'photos',
      desc: '',
      args: [],
    );
  }

  /// `Créer`
  String get create {
    return Intl.message(
      'Créer',
      name: 'create',
      desc: '',
      args: [],
    );
  }

  /// `Les +`
  String get plus {
    return Intl.message(
      'Les +',
      name: 'plus',
      desc: '',
      args: [],
    );
  }

  /// `Contacter le vendeur`
  String get contactToSeller {
    return Intl.message(
      'Contacter le vendeur',
      name: 'contactToSeller',
      desc: '',
      args: [],
    );
  }

  /// `Oui`
  String get yes {
    return Intl.message(
      'Oui',
      name: 'yes',
      desc: '',
      args: [],
    );
  }

  /// `Non`
  String get no {
    return Intl.message(
      'Non',
      name: 'no',
      desc: '',
      args: [],
    );
  }

  /// `Succès`
  String get success {
    return Intl.message(
      'Succès',
      name: 'success',
      desc: '',
      args: [],
    );
  }

  /// `Salon Weli`
  String get generalChatroom {
    return Intl.message(
      'Salon Weli',
      name: 'generalChatroom',
      desc: '',
      args: [],
    );
  }

  /// `{count,plural, zero{0 carte disponible} one{1 carte disponible} other{{count} cartes disponibles}}`
  String cardAvailableCount(num count) {
    return Intl.plural(
      count,
      zero: '0 carte disponible',
      one: '1 carte disponible',
      other: '$count cartes disponibles',
      name: 'cardAvailableCount',
      desc: '',
      args: [count],
    );
  }

  /// `Créer son salon`
  String get createSalon {
    return Intl.message(
      'Créer son salon',
      name: 'createSalon',
      desc: '',
      args: [],
    );
  }

  /// `Vos salons personnalisés`
  String get myRooms {
    return Intl.message(
      'Vos salons personnalisés',
      name: 'myRooms',
      desc: '',
      args: [],
    );
  }

  /// `Message privé`
  String get privateChatroom {
    return Intl.message(
      'Message privé',
      name: 'privateChatroom',
      desc: '',
      args: [],
    );
  }

  /// `Recherche un contact`
  String get searchContact {
    return Intl.message(
      'Recherche un contact',
      name: 'searchContact',
      desc: '',
      args: [],
    );
  }

  /// `“Participants invités par nom/mail`
  String get inviteParticipants {
    return Intl.message(
      '“Participants invités par nom/mail',
      name: 'inviteParticipants',
      desc: '',
      args: [],
    );
  }

  /// `Nom du salon privé`
  String get nameTheRoom {
    return Intl.message(
      'Nom du salon privé',
      name: 'nameTheRoom',
      desc: '',
      args: [],
    );
  }

  /// `Salon créé !`
  String get createSalonSuccess {
    return Intl.message(
      'Salon créé !',
      name: 'createSalonSuccess',
      desc: '',
      args: [],
    );
  }

  /// `Quitter le groupe`
  String get quitRoom {
    return Intl.message(
      'Quitter le groupe',
      name: 'quitRoom',
      desc: '',
      args: [],
    );
  }

  /// `Supprimer le groupe`
  String get deleteRoom {
    return Intl.message(
      'Supprimer le groupe',
      name: 'deleteRoom',
      desc: '',
      args: [],
    );
  }

  /// `Retirer du groupe`
  String get removeFromRoom {
    return Intl.message(
      'Retirer du groupe',
      name: 'removeFromRoom',
      desc: '',
      args: [],
    );
  }

  /// `Impossible de quitter la salle de chat par défaut`
  String get cannotLeaveDefaultRoomChat {
    return Intl.message(
      'Impossible de quitter la salle de chat par défaut',
      name: 'cannotLeaveDefaultRoomChat',
      desc: '',
      args: [],
    );
  }

  /// `Recherche un salon`
  String get searchSalon {
    return Intl.message(
      'Recherche un salon',
      name: 'searchSalon',
      desc: '',
      args: [],
    );
  }

  /// `Messages privés`
  String get privateMessage {
    return Intl.message(
      'Messages privés',
      name: 'privateMessage',
      desc: '',
      args: [],
    );
  }

  /// `Veuillez choisir une photo de profil`
  String get requirePhoto {
    return Intl.message(
      'Veuillez choisir une photo de profil',
      name: 'requirePhoto',
      desc: '',
      args: [],
    );
  }

  /// `Salons personnalisés`
  String get myRooms2 {
    return Intl.message(
      'Salons personnalisés',
      name: 'myRooms2',
      desc: '',
      args: [],
    );
  }

  /// `Chargement…`
  String get loadingText {
    return Intl.message(
      'Chargement…',
      name: 'loadingText',
      desc: '',
      args: [],
    );
  }

  /// `Aucune autre donnée`
  String get noDataText {
    return Intl.message(
      'Aucune autre donnée',
      name: 'noDataText',
      desc: '',
      args: [],
    );
  }

  /// `Tirez pour charger davantage`
  String get idleText {
    return Intl.message(
      'Tirez pour charger davantage',
      name: 'idleText',
      desc: '',
      args: [],
    );
  }

  /// `Rejoindre ce salon`
  String get joinRoom {
    return Intl.message(
      'Rejoindre ce salon',
      name: 'joinRoom',
      desc: '',
      args: [],
    );
  }

  /// `Vous avez été invité dans un salon`
  String get invitedNotification {
    return Intl.message(
      'Vous avez été invité dans un salon',
      name: 'invitedNotification',
      desc: '',
      args: [],
    );
  }

  /// `Vous avez été retiré du salon {name}`
  String removedNotification(String name) {
    return Intl.message(
      'Vous avez été retiré du salon $name',
      name: 'removedNotification',
      desc: '',
      args: [name],
    );
  }

  /// `Le salon {name} a été supprimé”`
  String salonRemovedNotification(String name) {
    return Intl.message(
      'Le salon $name a été supprimé”',
      name: 'salonRemovedNotification',
      desc: '',
      args: [name],
    );
  }

  /// `Vous avez un nouveau message sur Weli`
  String get privateMessageNotification {
    return Intl.message(
      'Vous avez un nouveau message sur Weli',
      name: 'privateMessageNotification',
      desc: '',
      args: [],
    );
  }

  /// `Un potentiel acheteur a aimé votre bien`
  String get cardLikedNotification {
    return Intl.message(
      'Un potentiel acheteur a aimé votre bien',
      name: 'cardLikedNotification',
      desc: '',
      args: [],
    );
  }

  /// `Supprimer cette annonce`
  String get deleteCard {
    return Intl.message(
      'Supprimer cette annonce',
      name: 'deleteCard',
      desc: '',
      args: [],
    );
  }

  /// `Salons disponibles`
  String get otherSalons {
    return Intl.message(
      'Salons disponibles',
      name: 'otherSalons',
      desc: '',
      args: [],
    );
  }

  /// `Vos salons`
  String get defaultSalon {
    return Intl.message(
      'Vos salons',
      name: 'defaultSalon',
      desc: '',
      args: [],
    );
  }

  /// `Les biens que vous ajoutez en favoris apparaissent ici.`
  String get noCardFavorite {
    return Intl.message(
      'Les biens que vous ajoutez en favoris apparaissent ici.',
      name: 'noCardFavorite',
      desc: '',
      args: [],
    );
  }

  /// `Se déconnecter`
  String get logout {
    return Intl.message(
      'Se déconnecter',
      name: 'logout',
      desc: '',
      args: [],
    );
  }

  /// `J’ai lu et j’accepte les`
  String get t_and_c_text {
    return Intl.message(
      'J’ai lu et j’accepte les',
      name: 't_and_c_text',
      desc: '',
      args: [],
    );
  }

  /// `Consulter le profil`
  String get redirectToProfile {
    return Intl.message(
      'Consulter le profil',
      name: 'redirectToProfile',
      desc: '',
      args: [],
    );
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<S> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'en'),
      Locale.fromSubtags(languageCode: 'fr'),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<S> load(Locale locale) => S.load(locale);
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
