//Récupere mon element carré noire et mes images coiffure noire
let couleur1 = document.getElementById('noire');
let couleur2 = document.getElementById('jaune');
let couleur3 = document.getElementById('bleu');

let image = document.getElementById('b1');

let flechedroite = document.getElementById('fleched');
let flechegauche = document.getElementById('flecheg');

//tableau d'image
let imagenoire = ['img/hair-black-1.png','img/hair-black-2.png','img/hair-black-3.png'];
console.log(imagenoire);

let imagejaune = ['img/hair-blond-1.png','img/hair-blond-2.png','img/hair-blond-3.png'];
console.log(imagejaune);

let imagebleu = ['img/hair-turquoise-1.png','img/hair-turquoise-2.png','img/hair-turquoise-3.png'];
console.log(imagebleu);

//changement de coiffure
let index=0;

flechedroite.addEventListener('click',() => {
    index = (index+1) % imagenoire.length;
    image.src = imagenoire[index];
    
},false);

couleur1.addEventListener('click',()=>{
    image.src = imagenoire[index];
})

couleur2.addEventListener('click',() =>{
    image.src = imagejaune[index];
});

couleur3.addEventListener('click',() =>{
    image.src = imagebleu[index];
});