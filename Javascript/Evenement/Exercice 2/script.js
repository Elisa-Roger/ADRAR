let evenement = document.getElementById("ajouter");
let titre = document.querySelector("h1");
evenement.addEventListener("click", () =>{
   titre.classList.add("h1");
   // titre.style.color = 'green';
  //  titre.style.fontStyle = 'italic';
},false);


let evenement2 = document.getElementById("supprimer");
evenement2.addEventListener('click', ()=>{
    titre.classList.remove("h1");
    //titre.style.color = 'black';
    //titre.style.fontStyle = 'normal';
})


let evenement3 = document.getElementById("inverser");
evenement3.addEventListener('click', ()=>{
    titre.classList.toggle("h1");
})
