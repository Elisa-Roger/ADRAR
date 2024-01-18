//Exercice 2

let number = Math.round(Math.random() * 100);

let nombre;
let compteur = 0;
console.log(number);
console.log(nombre);

function a() {
  while (number != nombre) {
    nombre = prompt("Trouve le nombre entre 1 et 100 " +" "+ compteur);
    if(nombre == null){
      alert("Partie Annulée");
      return;
    } else if (compteur == 10) {
      alert("Perdu");
    } else if (number > nombre) {
      alert("Plus haut");
      compteur++;
    } else if (number == nombre) {
      alert("Gagné");
    } else {
      alert("Plus bas");
      compteur++;
    }
  }
}
a();
/*Correction
// Génère un nombre aléatoire entre 1 et 100 et arrondi à l'entier le plus proche
let nombre = Math.round(Math.random() * 100);

// Variable pour stocker le nombre entré par l'utilisateur
let chiffre;

// Compteur pour suivre le nombre d'essais
let compteur = 0;

// Affiche les valeurs initiales dans la console
console.log(nombre); // Affiche le nombre généré aléatoirement
console.log(chiffre); // Affiche la valeur actuelle de 'chiffre' (initialement undefined)
console.log(compteur); // Affiche la valeur actuelle de 'compteur' (initialement 0)

// Définition de la fonction 'decompteur'
function decompteur() {
  // Boucle 'while' continue tant que le nombre généré aléatoirement n'est pas égal au nombre entré par l'utilisateur
  while (nombre != chiffre) {
    // Demande à l'utilisateur d'entrer un nombre via la boîte de dialogue prompt
    chiffre = prompt(" Donne un nombre entre 1 et 100 " + compteur);

    // Vérifie si l'utilisateur a annulé la partie (clic sur 'Annuler' ou fermeture de la boîte de dialogue)
    if (chiffre == null) {
      alert("Partie annulée");
      return; // Termine la fonction si la partie est annulée
    } else if (compteur == 10) {
      // Si l'utilisateur atteint 10 essais sans deviner le bon nombre, affiche "Looser !"
      alert("Looser !");
    } else if (chiffre > nombre) {
      // Si le nombre entré est supérieur au nombre généré, affiche "Plus bas" et incrémente le compteur
      alert("Plus bas");
      compteur++;
    } else if (nombre == chiffre) {
      // Si le nombre entré est égal au nombre généré, affiche "Bien joué !"
      alert("Bien joué !");
    } else {
      // Si le nombre entré est inférieur au nombre généré, affiche "Plus haut" et incrémente le compteur
      alert("Plus haut !");
      compteur++;
    }
  }
}

// Appel de la fonction 'decompteur'
decompteur();
*/