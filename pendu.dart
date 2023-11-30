import 'dart:io';

void main() {
  print("Bienvenue au Jeu du Pendu !");
  String motADeviner = choisirMot();
  List<String> lettresProposees = [];
  int tentativesRestantes = 6;

  while (tentativesRestantes > 0) {
    afficherPendu(tentativesRestantes);
    afficherMotActuel(motADeviner, lettresProposees);

    try {
      print("Entrez une lettre : ");
      String? lettre = lireLettre();

      if (lettresProposees.contains(lettre)) {
        print("Vous avez déjà proposé cette lettre. Essayez une autre.");
      } else if (motADeviner.contains(lettre)) {
        print("Bonne réponse !");
        lettresProposees.add(lettre!);
      } else {
        print("Incorrect ! Cette lettre n'est pas dans le mot.");
        lettresProposees.add(lettre!);
        tentativesRestantes--;
      }

      if (motDevine(motADeviner, lettresProposees)) {
        afficherMotActuel(motADeviner, lettresProposees);
        print("Félicitations ! Vous avez deviné le mot : $motADeviner");
        break;
      }
    } catch (e) {
      print("Erreur : $e");
    }
  }

  if (tentativesRestantes == 0) {
    afficherPendu(tentativesRestantes);
    print("Dommage ! Le mot était : $motADeviner");
  }
}

String choisirMot() {
  List<String> mots = ["programmation", "pendu", "dart", "joueur", "missionaire", "cheval", "poker", "fille", "claire"];
  return mots[(DateTime.now().millisecondsSinceEpoch % mots.length)];
}

void afficherPendu(int tentativesRestantes) {
  print("Pendu : $tentativesRestantes tentatives restantes");
}

void afficherMotActuel(String mot, List<String> lettresProposees) {
  String motPartiel = "";
  for (int i = 0; i < mot.length; i++) {
    if (lettresProposees.contains(mot[i])) {
      motPartiel += mot[i];
    } else {
      motPartiel += "_";
    }
    motPartiel += " ";
  }
  print("Mot actuel : $motPartiel");
}

bool motDevine(String mot, List<String> lettresProposees) {
  for (int i = 0; i < mot.length; i++) {
    if (!lettresProposees.contains(mot[i])) {
      return false;
    }
  }
  return true;
}

String lireLettre() {
  String? lettre = stdin.readLineSync();

  if (lettre == null || lettre.isEmpty || lettre.length > 1 || !lettre.contains(RegExp(r'[a-z]'))) {
    throw FormatException("Veuillez entrer une seule lettre valide.");
  }

  return lettre.toLowerCase();
}
