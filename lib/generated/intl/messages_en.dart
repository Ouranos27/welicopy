// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a en locale. All the
// messages from the main program should be duplicated here with the same
// function name.

// Ignore issues from commonly used lints in this file.
// ignore_for_file:unnecessary_brace_in_string_interps, unnecessary_new
// ignore_for_file:prefer_single_quotes,comment_references, directives_ordering
// ignore_for_file:annotate_overrides,prefer_generic_function_type_aliases
// ignore_for_file:unused_import, file_names, avoid_escaping_inner_quotes
// ignore_for_file:unnecessary_string_interpolations, unnecessary_string_escapes

import 'package:intl/intl.dart';
import 'package:intl/message_lookup_by_library.dart';

final messages = new MessageLookup();

typedef String MessageIfAbsent(String messageStr, List<dynamic> args);

class MessageLookup extends MessageLookupByLibrary {
  String get localeName => 'en';

  static String m0(count) =>
      "${Intl.plural(count, zero: '0 carte disponible', one: '1 carte disponible', other: '${count} cartes disponibles')}";

  static String m1(name) => "Vous avez été retiré du salon ${name}";

  static String m2(name) => "Le salon ${name} a été supprimé”";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
        "accessToLounge":
            MessageLookupByLibrary.simpleMessage("Accéder aux salons"),
        "area": MessageLookupByLibrary.simpleMessage("Surface"),
        "budgetQuestion": MessageLookupByLibrary.simpleMessage(
            "Quel est le budget approximatif pour votre projet d’investissement ?"),
        "buyerType": MessageLookupByLibrary.simpleMessage("Profil acquéreur"),
        "cannotLeaveDefaultRoomChat": MessageLookupByLibrary.simpleMessage(
            "Impossible de quitter la salle de chat par défaut"),
        "cardAvailableCount": m0,
        "cardLikedNotification": MessageLookupByLibrary.simpleMessage(
            "Un potentiel acheteur a aimé votre bien"),
        "city": MessageLookupByLibrary.simpleMessage("Ville"),
        "company": MessageLookupByLibrary.simpleMessage("Entreprise"),
        "connection": MessageLookupByLibrary.simpleMessage("Connexion"),
        "contactToSeller":
            MessageLookupByLibrary.simpleMessage("Contacter le vendeur"),
        "create": MessageLookupByLibrary.simpleMessage("Créer"),
        "createSalon": MessageLookupByLibrary.simpleMessage("Créer son salon"),
        "createSalonSuccess":
            MessageLookupByLibrary.simpleMessage("Salon créé !"),
        "defaultSalon": MessageLookupByLibrary.simpleMessage("Vos salons"),
        "deleteCard":
            MessageLookupByLibrary.simpleMessage("Supprimer cette annonce"),
        "deleteRoom":
            MessageLookupByLibrary.simpleMessage("Supprimer le groupe"),
        "department": MessageLookupByLibrary.simpleMessage("Département"),
        "disabled_account":
            MessageLookupByLibrary.simpleMessage("Compte désactivé."),
        "email": MessageLookupByLibrary.simpleMessage("Mail"),
        "email_already_exists":
            MessageLookupByLibrary.simpleMessage("Cet email est déjà utilisé"),
        "empty_field_error":
            MessageLookupByLibrary.simpleMessage("Veuillez remplir ce champ."),
        "error": MessageLookupByLibrary.simpleMessage("Erreur"),
        "favoriteSection": MessageLookupByLibrary.simpleMessage("Favoris"),
        "financingType": MessageLookupByLibrary.simpleMessage("Financement"),
        "financingTypeQuestion": MessageLookupByLibrary.simpleMessage(
            "Comment financez vous vos acquisitions ?"),
        "firstName": MessageLookupByLibrary.simpleMessage("Prénom"),
        "forgotPassword":
            MessageLookupByLibrary.simpleMessage("Mot de passe oublié"),
        "forgotPasswordTitle":
            MessageLookupByLibrary.simpleMessage("MDP oublié"),
        "generalChatroom": MessageLookupByLibrary.simpleMessage("Salon Weli"),
        "goods": MessageLookupByLibrary.simpleMessage("Typologie de biens"),
        "idleText": MessageLookupByLibrary.simpleMessage(
            "Tirez pour charger davantage"),
        "invalid_email": MessageLookupByLibrary.simpleMessage(
            "L\'adresse email est invalide."),
        "invalid_field_error":
            MessageLookupByLibrary.simpleMessage("Invalide."),
        "invalid_password": MessageLookupByLibrary.simpleMessage(
            "Le mot de passe comporter au moins 6 caractères."),
        "investmentDuration":
            MessageLookupByLibrary.simpleMessage("Investissement"),
        "investmentType":
            MessageLookupByLibrary.simpleMessage("Types d’investissement"),
        "investorTypeQuestion": MessageLookupByLibrary.simpleMessage(
            "Quel est votre profil d’investisseur ?"),
        "inviteParticipants": MessageLookupByLibrary.simpleMessage(
            "“Participants invités par nom/mail"),
        "invitedNotification": MessageLookupByLibrary.simpleMessage(
            "Vous avez été invité dans un salon"),
        "job": MessageLookupByLibrary.simpleMessage("Votre secteur d’activité"),
        "joinRoom": MessageLookupByLibrary.simpleMessage("Rejoindre ce salon"),
        "labels": MessageLookupByLibrary.simpleMessage("Vignettes"),
        "landArea": MessageLookupByLibrary.simpleMessage("Terrain"),
        "lastName": MessageLookupByLibrary.simpleMessage("Nom"),
        "livingSpace":
            MessageLookupByLibrary.simpleMessage("Surface habitable"),
        "loadingText": MessageLookupByLibrary.simpleMessage("Chargement…"),
        "location": MessageLookupByLibrary.simpleMessage("Localisation"),
        "login": MessageLookupByLibrary.simpleMessage("Se connecter"),
        "loginTitleDescription":
            MessageLookupByLibrary.simpleMessage("We love invest"),
        "logout": MessageLookupByLibrary.simpleMessage("Se déconnecter"),
        "messenger": MessageLookupByLibrary.simpleMessage("Messagerie"),
        "modifiedAt":
            MessageLookupByLibrary.simpleMessage("En cours de création"),
        "modify": MessageLookupByLibrary.simpleMessage("Modifier"),
        "moreDetails": MessageLookupByLibrary.simpleMessage("Les +"),
        "myAccount": MessageLookupByLibrary.simpleMessage("Mon compte"),
        "myAnnouncement": MessageLookupByLibrary.simpleMessage("Mon annonce"),
        "myProfile": MessageLookupByLibrary.simpleMessage("Mon profil"),
        "myRooms":
            MessageLookupByLibrary.simpleMessage("Vos salons personnalisés"),
        "myRooms2":
            MessageLookupByLibrary.simpleMessage("Salons personnalisés"),
        "nameTheRoom":
            MessageLookupByLibrary.simpleMessage("Nom du salon privé"),
        "newPassword":
            MessageLookupByLibrary.simpleMessage("Nouveau mot de passe"),
        "newSection": MessageLookupByLibrary.simpleMessage("Nouveau"),
        "next": MessageLookupByLibrary.simpleMessage("Continuer"),
        "no": MessageLookupByLibrary.simpleMessage("Non"),
        "noCardFavorite": MessageLookupByLibrary.simpleMessage(
            "Les biens que vous ajoutez en favoris apparaissent ici."),
        "noDataText":
            MessageLookupByLibrary.simpleMessage("Aucune autre donnée"),
        "no_account": MessageLookupByLibrary.simpleMessage(
            "Aucun compte n\'est relié à cet email."),
        "no_data": MessageLookupByLibrary.simpleMessage("Pas de données"),
        "not_identical_password": MessageLookupByLibrary.simpleMessage(
            "Les deux mots de passe doivent être identiques."),
        "numberOfBatches":
            MessageLookupByLibrary.simpleMessage("Nombre de lots"),
        "numeric": MessageLookupByLibrary.simpleMessage(
            "La valeur doit être numérique"),
        "offeredInvestmentTypesQuestion": MessageLookupByLibrary.simpleMessage(
            "Quel(s) type(s) d’investissement immobilier souhaitez-vous proposer ?"),
        "offeredPropertyTypesQuestion": MessageLookupByLibrary.simpleMessage(
            "Quel(s) type(s) de biens souhaitez-vous proposer ?"),
        "other": MessageLookupByLibrary.simpleMessage("Vos #"),
        "otherSalons":
            MessageLookupByLibrary.simpleMessage("Salons disponibles"),
        "password": MessageLookupByLibrary.simpleMessage("Mot de passe"),
        "password2":
            MessageLookupByLibrary.simpleMessage("Confirmation mot de passe"),
        "phoneNumber": MessageLookupByLibrary.simpleMessage("Téléphone"),
        "photos": MessageLookupByLibrary.simpleMessage("Photos"),
        "placeAnAds":
            MessageLookupByLibrary.simpleMessage("Déposer une annonce"),
        "plus": MessageLookupByLibrary.simpleMessage("Les +"),
        "price": MessageLookupByLibrary.simpleMessage("Prix"),
        "privateChatroom":
            MessageLookupByLibrary.simpleMessage("Message privé"),
        "privateMessage":
            MessageLookupByLibrary.simpleMessage("Messages privés"),
        "privateMessageNotification": MessageLookupByLibrary.simpleMessage(
            "Vous avez un nouveau message sur Weli"),
        "profile": MessageLookupByLibrary.simpleMessage("Profil"),
        "profitability": MessageLookupByLibrary.simpleMessage("Rentabilité"),
        "propertyState": MessageLookupByLibrary.simpleMessage("État du bien"),
        "propertyType": MessageLookupByLibrary.simpleMessage("Type de bien"),
        "publish_warning": MessageLookupByLibrary.simpleMessage(
            "Voulez-vous publier ce bien ? Il ne pourra plus être modifiée."),
        "publishedAt": MessageLookupByLibrary.simpleMessage("Publiée"),
        "quitRoom": MessageLookupByLibrary.simpleMessage("Quitter le groupe"),
        "redirectToProfile":
            MessageLookupByLibrary.simpleMessage("Consulter le profil"),
        "register": MessageLookupByLibrary.simpleMessage("S’inscrire"),
        "register_error":
            MessageLookupByLibrary.simpleMessage("Erreur à l\'inscription"),
        "rejectedAt": MessageLookupByLibrary.simpleMessage("Rejetée"),
        "removeFromRoom":
            MessageLookupByLibrary.simpleMessage("Retirer du groupe"),
        "remove_like_warning": MessageLookupByLibrary.simpleMessage(
            "Voulez-vous retirer ce bien de vos favoris ?"),
        "removedNotification": m1,
        "requirePhoto": MessageLookupByLibrary.simpleMessage(
            "Veuillez choisir une photo de profil"),
        "resetPasswordMessage": MessageLookupByLibrary.simpleMessage(
            "Un mail de réinitialisation sera envoyé si un compte est lié à cet e-mail."),
        "roomCount": MessageLookupByLibrary.simpleMessage("Nombre de pièces"),
        "salon": MessageLookupByLibrary.simpleMessage("Salons"),
        "salonRemovedNotification": m2,
        "searchContact":
            MessageLookupByLibrary.simpleMessage("Recherche un contact"),
        "searchSalon":
            MessageLookupByLibrary.simpleMessage("Recherche un salon"),
        "send": MessageLookupByLibrary.simpleMessage("Envoyer"),
        "stateOfGoods": MessageLookupByLibrary.simpleMessage("Etat du bien"),
        "status": MessageLookupByLibrary.simpleMessage("Statut"),
        "submittedAt": MessageLookupByLibrary.simpleMessage("En attente"),
        "success": MessageLookupByLibrary.simpleMessage("Succès"),
        "t_and_c_text":
            MessageLookupByLibrary.simpleMessage("J’ai lu et j’accepte les"),
        "title": MessageLookupByLibrary.simpleMessage("Titre"),
        "uses": MessageLookupByLibrary.simpleMessage(
            "Quels sont vos principaux besoins sur l’application ?"),
        "wanna_save_card": MessageLookupByLibrary.simpleMessage(
            "Voulez-vous enregister ce bien ?"),
        "wantedInvestmentTypesQuestion": MessageLookupByLibrary.simpleMessage(
            "Quels types d\'opportunités vous intéressent le plus ?"),
        "wantedPropertyTypesQuestion": MessageLookupByLibrary.simpleMessage(
            "Quel(s) type(s) de biens recherchez-vous ?"),
        "weli": MessageLookupByLibrary.simpleMessage("Weli"),
        "wrong_password":
            MessageLookupByLibrary.simpleMessage("Mauvais mot de passe."),
        "yes": MessageLookupByLibrary.simpleMessage("Oui")
      };
}
