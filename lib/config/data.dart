import 'package:flutter/material.dart';

class AppData {
  AppData._();

  static const weliDefaultRoomId = "guSKdonraw7NcmrYTufk";

  static List<String> typeInvestment = [
    'Achat part d’une SCPi',
    'Achat/revente en l’état',
    'Construction',
    'Promotion',
    'Lotissement',
    'Rénovation',
    'Cowfunding immobilier',
    'Déficit foncier',
    'Loi de Normandie',
    'Loi Malraux',
    'Loi Pinel',
    'Forêt ou vignoble',
    'LMNP',
    'LMP',
    'Locatif meublé',
    'Locatif nu',
    'Locatif courte durée',
    'Locatif de luxe',
    'Locatif mixte',
    'Locatif en colocation',
    'Coliving',
    'Nue-propriété',
    'Résidence de vacances',
    'Achat action - Société immobilière',
    'Terrain agricole',
    'Viager libre',
    'Viager occupé',
    'Tiny house',
  ];
  static List<String> industry = [
    'Agent immobilier',
    'Mandataire immobilier',
    'Prospecteur foncier',
    'Constructeur',
    'Marchand de biens',
    'Particulier',
    'Promoteur',
    'Notaire',
    'Lotisseur',
    'Investisseur débutant',
    'Investisseur confirmé',
    'Géomètre',
    'Gestionnaire de patrimoine',
    'Architecte'
  ];
  static List<String> goods = [
    'Appartement',
    'Château / manoir',
    'Commerce / bureau',
    'Ensemble immobilier',
    'Garage, box, parking',
    'Immeuble',
    'Maison',
    'Maison avec terrain détachable',
    'Maison à rénover',
    'Remise / hangar',
    'Terrain nu constructible',
    'Terrain nu non constructible / de loisirs',
  ];
  static List<String> goodTypes = [
    'Neuf',
    'Ancien',
    'Å rénover',
  ];
  static List<String> labels = [
    'Baisse de prix',
    'Bonne affaire',
    'Faire offre',
    'Rare',
    'Urgent',
    'À saisir',
  ];
  static const userFields = {
    'email': {'titleInForm': 'E-mail', 'type': 'text', 'textType': 'email'},
    'password': {
      'titleInForm': 'Mot de passe',
      'type': 'text',
      'hidden': true,
    },
    'password2': {
      'titleInForm': 'Confirmer le mot de passe',
      'type': 'text',
      'hidden': true,
    },
    'newPassword': {
      'titleInForm': 'Nouveau mot de passe',
      'type': 'text',
      'hidden': true,
    },
    'firstName': {
      'titleInForm': 'Prénom',
      'type': 'text',
    },
    'lastName': {
      'titleInForm': 'Nom',
      'type': 'text',
    },
    'phoneNumber': {
      'titleInForm': 'Téléphone',
      'type': 'text',
      'textType': 'phoneNumber',
      'regex': '0[1-9]( [0-9]{2}){4}',
      'regexError': 'Le numéro doit commencer par 0 et comporter 10 chiffres.',
      'optional': true,
    },
    'status': {
      'titleInForm': 'Statut',
      'type': 'status',
    },
    'company': {'titleInForm': 'Entreprise', 'type': 'text', 'optional': true},
    'uses': {
      'titleInForm': 'Quels sont vos principaux besoins sur l’application ?',
      'type': 'useCase',
      'multi': true,
      'optional': true,
    },
    'wantedInvestmentTypes': {
      'titleInForm': "Quels types d'opportunités vous intéressent le plus ?",
      'type': 'investmentType',
      'multi': true,
      'optional': true,
      'showIf': {
        'field': 'uses',
        'in': ['0']
      }
    },
    'wantedPropertyTypes': {
      'titleInForm': 'Quel(s) type(s) de biens recherchez-vous ?',
      'type': 'propertyType',
      'multi': true,
      'optional': true,
      'showIf': {
        'field': 'uses',
        'in': ['0']
      }
    },
    'budget': {
      'titleInForm': 'Quel est le budget approximatif pour votre projet d’investissement ?',
      'type': 'budget',
      'optional': true,
      'showIf': {
        'field': 'uses',
        'in': ['0']
      }
    },
    'offeredInvestmentTypes': {
      'titleInForm': "Quel(s) type(s) d’investissement immobilier souhaitez-vous proposer ?",
      'type': 'investmentType',
      'multi': true,
      'optional': true,
      'showIf': {
        'field': 'uses',
        'in': ['1']
      }
    },
    'offeredPropertyTypes': {
      'titleInForm': 'Quel(s) type(s) de biens souhaitez-vous proposer ?',
      'type': 'propertyType',
      'multi': true,
      'optional': true,
      'showIf': {
        'field': 'uses',
        'in': ['1']
      }
    },
    'investorType': {
      'titleInForm': 'Quel est votre profil d’investisseur ?',
      'type': 'investorType',
      'showIf': {
        'field': 'status',
        'in': ['10']
      },
    },
    'financingType': {
      'titleInForm': 'Comment financez vous vos acquisitions ?',
      'type': 'financingType',
      'showIf': {
        'field': 'status',
        'in': ['10']
      },
    }
  };
  static const cardFields = {
    'investmentDuration': {
      'title': 'Investissement',
      'titleInForm': 'DURÉE D’INVESTISSEMENT',
      'type': 'investmentDuration',
      'hint': ' ',
    },
    'investmentType': {
      'title': "Type d'investissement",
      'titleInForm': "TYPE D’INVESTISSEMENT",
      'type': 'investmentType',
      'hint': ' ',
    },
    'propertyType': {
      'title': 'Type de bien',
      'titleInForm': 'TYPE DE BIEN',
      'type': 'propertyType',
      'hint': ' ',
    },
    'labels': {
      'title': 'Vignettes',
      'titleInForm': 'VIGNETTES',
      'type': 'cardLabel',
      'hint': ' ',
      'multi': true,
      'optional': true,
      'max': 2,
    },
    'location': {
      'title': 'Localisation',
      'titleInForm': 'LOCALISATION',
      'type': 'text',
      'textType': 'location',
      'hint': ' ',
    },
    'area': {
      'title': 'Surface',
      'titleInForm': 'SURFACE HABITABLE',
      'type': 'text',
      'textType': 'number',
      'hint': ' ',
      'unit': 'm²',
      'showIf': {
        'field': 'propertyType',
        'notIn': ['10', '11']
      },
    },
    'landArea': {'title': 'Terrain', 'titleInForm': 'SURFACE DU TERRAIN', 'type': 'text', 'textType': 'number', 'hint': ' ', 'unit': 'm²'},
    'price': {'title': 'Prix', 'titleInForm': 'PRIX', 'hint': ' ', 'type': 'text', 'textType': 'number', 'unit': '€'},
    'profitability': {'title': 'Rentabilité', 'titleInForm': 'RENTABILITÉ', 'hint': ' ', 'type': 'text', 'textType': 'number', 'unit': '%'},
    'propertyState': {
      'title': 'État du bien',
      'titleInForm': 'ÉTAT DU BIEN',
      'type': 'propertyState',
      'hint': ' ',
      'showIf': {
        'field': 'propertyType',
        'notIn': ['10', '11']
      },
    },
    'state': {'type': 'cardState'},
    'buyerType': {
      'type': 'buyerType',
      'title': 'Profil acquéreur',
      'titleInForm': 'PROFIL ACQUÉREUR',
    },
    'financingType': {'title': 'Financement', 'titleInForm': 'Financement', 'type': 'financingType'},
    'roomCount': {
      'title': 'Nombre de pièces',
      'titleInForm': 'NOMBRE DE PIÈCES',
      'type': 'text',
      'textType': 'number',
      'unit': '',
      'showIf': {
        'field': 'propertyType',
        'notIn': ['10', '11']
      },
    },
  };

  static const types = {
    'investmentDuration': {
      'options': {
        '0': 'Court terme : inférieur à 1 an',
        '1': 'Moyen terme : entre 1 et 5 ans',
        '2': 'Long terme : supérieur à 5 ans',
      },
      'order': ['0', '1', '2'],
    },
    'propertyType': {
      'options': {
        '0': 'Appartement',
        '1': 'Château / manoir',
        '2': 'Commerce / bureau',
        '3': 'Ensemble immobilier',
        '4': 'Garage, box, parking',
        '5': 'Immeuble',
        '6': 'Maison',
        '7': 'Maison avec terrain détachable',
        '8': 'Maison à rénover',
        '9': 'Remise / hangar',
        '10': 'Terrain nu constructible',
        '11': 'Terrain nu non constructible / de loisirs'
      },
      'order': ['0', '1', '2', '3', '4', '5', '6', '7', '8', '9', '10', '11'],
    },
    'status': {
      'options': {
        '0': 'Agent immobilier',
        '1': "Apporteur d'affaires",
        '2': 'Architecte',
        '3': 'Avocat',
        '4': 'Chasseur foncier',
        '5': 'Constructeur',
        '6': 'Financement',
        '7': 'Gestionnaire de patrimoine',
        '8': 'Géomètre',
        '9': 'Huissier',
        '10': 'Investisseur',
        '11': 'Lotisseur',
        '12': 'Mandataire immobilier',
        '13': 'Marchand de biens',
        '14': 'Notaire',
        '15': 'Particulier',
        '16': 'Promoteur',
      },
      'order': [
        '0',
        '1',
        '2',
        '3',
        '4',
        '5',
        '6',
        '7',
        '8',
        '9',
        '10',
        '11',
        '12',
        '13',
        '14',
        '15',
        '16',
      ],
    },
    'investmentType': {
      'options': {
        '0': 'Achat part d’une SCPi',
        '1': 'Achat revente rapide',
        '2': 'Construction',
        '3': 'Crowdfunding immobilier',
        '4': 'Déficit foncier',
        '5': 'Défiscalisation',
        '6': 'Forêt au vignoble',
        '7': 'Hôtel',
        '8': 'LMNP',
        '9': 'LMP',
        '10': 'Locatif',
        '11': 'Location saisonnière',
        '12': 'Loi Malraux',
        '13': 'Loi Pinel',
        '14': 'Lotissement',
        '15': 'Nue-propriété',
        '16': 'Promotion',
        '17': 'Rénovation',
        '18': 'Résidence de vacances',
        '19': 'Société immobilière - action',
        '20': 'Terrain agricole',
        '21': 'Viager libre',
        '22': 'Viager occupé',
      },
      'order': [
        '0',
        '1',
        '2',
        '3',
        '4',
        '5',
        '6',
        '7',
        '8',
        '9',
        '10',
        '11',
        '12',
        '13',
        '14',
        '15',
        '16',
        '17',
        '18',
        '19',
        '20',
        '21',
        '22',
      ],
    },
    'propertyState': {
      'options': {'0': 'Neuf', '1': 'Ancien', '2': 'À rénover'},
      'order': ['0', '1', '2'],
    },
    'cardState': {
      'options': {
        '0': 'En cours de création',
        '1': 'En attente de validation',
        '2': 'Publiée',
      },
      'order': ['0', '1', '2'],
    },
    'useCase': {
      'options': {
        '0': 'Je souhaite proposer des produits d’investissement immobilier',
        '1': 'Je cherche des opportunités d’investissement immobilier',
      },
      'order': ['0', '1'],
    },
    'budget': {
      'options': {'0': '< 100 000 €', '1': '100 000 € à 499 000 €', '2': '500 000 € à 999 000 €', '3': '> 1 000 000 €'},
      'order': ['0', '1', '2', '3']
    },
    'investorType': {
      'options': {
        '0': 'Débutant',
        '1': 'Confirmé',
        '2': 'Expert',
      },
      'order': ['0', '1', '2']
    },
    'financingType': {
      'options': {'0': 'Comptant', '1': 'Financement', '2': 'Apport', '3': 'Tous'},
      'order': ['0', '1', '2', '3']
    },
    'cardLabel': {
      'options': {
        '0': 'Baisse de prix',
        '1': 'Bonne affaire',
        '2': 'Faire offre',
        '3': 'Rare',
        '4': 'Urgent',
        '5': 'À saisir',
      },
      'order': ['0', '1', '2', '3', '4', '5']
    },
    'buyerType': {
      'options': {
        '0': 'Résidence principale',
        '1': 'Locatif',
        '2': 'Résidence secondaire',
        '3': 'Clientèle internationale',
        '4': 'Primo-accédant',
        '5': 'Marché local',
        '6': 'Promoteur',
        '7': 'Lotisseur',
        '8': 'Rénovateur',
      },
      'order': ['0', '1', '2', '3', '4', '5', '6', '7', '8']
    }
  };

  static const cardOverviewFields = ['area', 'price', 'location', 'profitability'];
  static const portraitCardFields = [
    'location',
    'price',
    'area',
    'landArea',
    'profitability',
    'roomCount',
    'propertyState',
    'buyerType',
    'financingType',
    'investmentDuration',
  ];
  static const horizontalCardFields = ['location', 'price', 'area'];

  var data2 = {
    'objects': {'card': cardFields, 'filter': filterFields, 'user': userFields},
    'types': types,
    'forms': forms,
    'strings': strings,
    'cardStateMapping': cardStateMapping,
    'onBoarding': [
      {
        'text':
            'Sur la page principale, vous pouvez visualiser les biens des autres utilisateurs, et indiquer si vous êtes intérréssé ou non en utilisant les boutons, ou en faisant glisser le bien.',
        'image':
            'https://firebasestorage.googleapis.com/v0/b/weli-prod.appspot.com/o/onBoarding%2Fswipe_screen.jpg?alt=media&token=417efdb4-6928-4fb0-b6b4-17b8ef069063'
      },
      {
        'image':
            'https://firebasestorage.googleapis.com/v0/b/weli-prod.appspot.com/o/onBoarding%2Fswipe_details.jpg?alt=media&token=04728c51-61e8-48fa-97a9-23c0f29420c0',
        'text': 'Vous pouvez voir toutes les informations du bien en cliquant dessus.'
      },
      {
        'text': 'Vous revenez sur la page principale en cliquant une cliquant à nouveau sur le bien.',
        'image':
            'https://firebasestorage.googleapis.com/v0/b/weli-prod.appspot.com/o/onBoarding%2Fswipe_screen.jpg?alt=media&token=417efdb4-6928-4fb0-b6b4-17b8ef069063'
      },
      {
        'text': "L'icone \"curseurs\" vous permet d'accéder à la page filtres pour séléctionner les biens qui vous seront présentées.",
        'image':
            'https://firebasestorage.googleapis.com/v0/b/weli-prod.appspot.com/o/onBoarding%2Ffilters.jpg?alt=media&token=559623e7-3b7f-46a9-9d4e-f712f36a2454'
      },
      {
        'image':
            'https://firebasestorage.googleapis.com/v0/b/weli-prod.appspot.com/o/onBoarding%2Fnotifications.jpg?alt=media&token=e0d2acb7-cf1b-4194-861b-90e3bcc659fa',
        'text': "L'icone cloche vous permet d'accéder à la page des notifications."
      },
      {
        'text': 'Vous pouvez voir les biens que vous avez aimées sur la page "mes favoris". ',
        'image':
            'https://firebasestorage.googleapis.com/v0/b/weli-prod.appspot.com/o/onBoarding%2Fliked_cards.jpg?alt=media&token=03ab76a9-dc00-4fb3-b4d1-9543f9d0b8dc'
      },
      {
        'text': 'Ce bouton vous permet de voir le bien en détail.',
        'image':
            'https://firebasestorage.googleapis.com/v0/b/weli-prod.appspot.com/o/onBoarding%2Fsee_liked_card.jpg?alt=media&token=d008a50f-329c-413d-800b-d62049928c35'
      },
      {
        'image':
            'https://firebasestorage.googleapis.com/v0/b/weli-prod.appspot.com/o/onBoarding%2Fone_liked_card.jpg?alt=media&token=8bbe9d3c-7952-4592-906b-818ad54edfbf',
        'text': 'Vous pouvez ensuite voir le profil du créateur du bien pour le contacter ou consulter ses autres biens.'
      },
      {
        'text': "La page \"mes biens\" vous permet de consulter vos biens et d'en créer de nouvelles.",
        'image':
            'https://firebasestorage.googleapis.com/v0/b/weli-prod.appspot.com/o/onBoarding%2Fmy_cards.jpg?alt=media&token=12696ed5-fd32-43a0-bc8c-e1376ed0cc05'
      },
      {
        'text':
            "Vous pouvez enregistrer un bien pour la modifier plus tard ou la publier pour qu'elle soit visible par les autres utilisateurs. Un bien publiée ne peut plus être modifiée.",
        'image':
            'https://firebasestorage.googleapis.com/v0/b/weli-prod.appspot.com/o/onBoarding%2Fcard_creation.jpg?alt=media&token=89a9bf30-b047-4486-8201-546ef540a90d'
      },
      {
        'text': 'Pour les biens publiées vous pouvez voir la liste des utilisateurs ayant aimé ce bien.',
        'image':
            'https://firebasestorage.googleapis.com/v0/b/weli-prod.appspot.com/o/onBoarding%2Fmy_card_likes.jpg?alt=media&token=d5c66f5e-d26d-4473-9328-0719d87a37f1'
      },
      {
        'image':
            'https://firebasestorage.googleapis.com/v0/b/weli-prod.appspot.com/o/onBoarding%2Fprofile_edit.jpg?alt=media&token=10348a7d-4b77-4050-8024-3dbb452edf42',
        'text': 'La page profil vous permet de visualiser et modifier vos informations.'
      }
    ]
  };
  static const cardStateMapping = {
    'publishedAt': 'Publiée',
    'rejectedAt': 'Rejetée',
    'submittedAt': 'En attente',
    'modifiedAt': 'En cours de création',
  };
  static const strings = {
    'empty_field_error': 'Veuillez remplir ce champ.',
    'invalid_field_error': 'Invalide.',
    'wanna_save_card': 'Voulez-vous enregister ce bien ?',
    'publish_warning': 'Voulez-vous publier ce bien ? Il ne pourra plus être modifié.',
    'invalid_email': "L'adresse email est invalide.",
    'email_already_exists': 'Cet email est déjà utilisé.',
    'wrong_password': 'Mauvais mot de passe.',
    'invalid_password': 'Le mot de passe doit comporter au moins 6 caractères.',
    'not_identical_password': 'Les deux mots de passe doivent être identiques.',
    'no_account': "Aucun compte n'est relié à cet email.",
    'disabled_account': 'Compte désactivé.',
    'remove_like_warning': 'Voulez-vous retirer ce bien de vos favoris ?',
    'register_error': "Erreur à l'inscription",
    'weak_password': 'Le mot de passe doit comporter au moins 6 caractères.',
    'user_not_found': "Aucun compte n'est relié à cet email.",
    'reset_password_success': 'Un mail vous a été envoyé afin de réinitialiser votre mot de passe.',
  };

  static const forms = {
    'cardEditing': {
      'object': 'card',
      'fields': [
        'investmentDuration',
        'investmentType',
        'propertyType',
        'propertyState',
        'location',
        'area',
        'landArea',
        'roomCount',
        'price',
        'profitability',
        'buyerType',
        'financingType',
        'labels'
      ],
    },
    'filterEditing': {
      'object': 'filter',
      'fields': ['investmentDuration', 'investmentType', 'propertyType', 'location', 'area', 'landArea', 'price', 'profitability', 'propertyState']
    },
    'alertEditing': {
      'object': 'filter',
      'fields': [
        'name',
        'investmentDuration',
        'investmentType',
        'propertyType',
        'location',
        'area',
        'landArea',
        'price',
        'profitability',
        'propertyState'
      ],
    },
    'login': {
      'object': 'user',
      'fields': ['email', 'password']
    },
    'register': {
      'object': 'user',
      'fields': ['email', 'password', 'password2'],
    },
    'completeUserInfo': {
      'object': 'user',
      'fields': ['firstName', 'lastName', 'phoneNumber', 'status', 'company'],
    },
    'questions': {
      'object': 'user',
      'fields': [
        'uses',
        'wantedInvestmentTypes',
        'wantedPropertyTypes',
        'budget',
        'offeredInvestmentTypes',
        'offeredPropertyTypes',
      ],
    },
  };

  static const filterFields = {
    'name': {'title': 'Nom', 'titleInForm': 'NOM', 'type': 'text'},
    'investmentDuration': {
      'title': 'Investissement',
      'titleInForm': "DURÉE D’INVESTISSEMENT",
      'hint': ' ',
      'type': 'investmentDuration',
      'multi': true,
    },
    'investmentType': {
      'title': "Type d'investissement",
      'titleInForm': "TYPE D’INVESTISSEMENT",
      'hint': ' ',
      'type': 'investmentType',
      'multi': true,
    },
    'propertyType': {
      'title': 'Type de bien',
      'titleInForm': 'TYPE DE BIEN',
      'hint': ' ',
      'type': 'propertyType',
      'multi': true,
    },
    'location': {'title': 'Localisation', 'titleInForm': 'LOCALISATION', 'hint': ' ', 'type': 'text'},
    'area': {
      'title': 'Surface',
      'titleInForm': 'SURFACE HABITABLE',
      'hint': ' ',
      'type': 'minmax',
    },
    'landArea': {
      'title': 'Terrain',
      'titleInForm': 'SURFACE DU TERRAIN',
      'hint': ' ',
      'type': 'minmax',
    },
    'price': {
      'title': 'Prix',
      'titleInForm': 'PRIX',
      'hint': ' ',
      'type': 'minmax',
    },
    'profitability': {
      'title': 'Rentabilité',
      'titleInForm': 'RENTABILITÉ',
      'hint': ' ',
      'type': 'minmax',
    },
    'propertyState': {
      'title': 'État du bien',
      'titleInForm': 'ÉTAT DU BIEN',
      'hint': ' ',
      'type': 'propertyState',
      'multi': true,
    }
  };

  static const inputTypes = {
    'number': TextInputType.number,
    'email': TextInputType.emailAddress,
    'phoneNumber': TextInputType.phone,
    'location': TextInputType.streetAddress
  };
}
