//Creation d'un user pour ne pas ajouter tout les evenement dessus
var dob = new Date("07/07/1999");
    //calculate month difference from current date in time
    var month_diff = Date.now() - dob.getTime();
    
    //convert the calculated difference in date format
    var age_dt = new Date(month_diff); 
    
    //extract year from date    
    var year = age_dt.getUTCFullYear();
    
    //now calculate the age of the user
    var age = Math.abs(year - 1970);
    

let user ={
  firstname : "John",
  lastname : "Delavega",
  mail : "john.doe@exemple.com",
  age : age,
  birthDay: dob.toLocaleDateString(),
  princess : true,

}
console.log(user)


//Création de l'image
let image1 = document.createElement("img");
image1.src = "/Image1.png";
document.body.append(image1);


//Redimentionner l'image
const images = document.getElementsByTagName('img');
for (let i = 0; i < images.length; i++) {
  images[i].style.height = '300px';
  images[i].style.width = '300px';
}

// Creer le texte

let paragraphe1 = document.createElement("p");
paragraphe1.innerText = user.firstname + " " +user.lastname;
document.body.append(paragraphe1);

let paragraphe2 = document.createElement("p");
paragraphe2.innerText = user.mail;
document.body.append(paragraphe2);

let paragraphe3 = document.createElement("p");
paragraphe3.innerText = user.age;
document.body.append(paragraphe3);

let paragraphe4 = document.createElement("p");
paragraphe4.innerText = user.birthDay;
document.body.append(paragraphe4);

let paragraphe5 = document.createElement("p");
paragraphe5.innerText = user.princess;
document.body.append(paragraphe5);

//Mettre le texte en blanc

const textBlanc = document.querySelectorAll('p');
for (let i = 0; i < textBlanc.length; i++) {
  textBlanc[i].style.color = 'white';
};

//Mettre le background

const background = document.querySelector('body');
background.style.background = 'pink';


