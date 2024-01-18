// Exercie 1 demander son nom et son age

let nom = prompt("Quel est ton nom ?");
let age;
//console.log(nom,age);



while(isNaN(age)){
 age=prompt("Quel est ton age");
 if(isNaN(age)){
    alert("Erreur!")
  } else if(parseInt(age)<18){
    alert("Tu es mineur");
  } else{
    alert("Tu es majeur");
  }
 }


