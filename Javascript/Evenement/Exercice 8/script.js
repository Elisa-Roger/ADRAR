let textearea = document.getElementById("text");
let maDiv = document.getElementById("div1");

//evenement 1 quand on appuie sur une touche
textearea.addEventListener('keydown', () =>{
    textearea.style.backgroundColor = 'red';
},false);

//evenement2 quand on relache la touche
// Assigner la valeur de textarea au innerHTML de la div
textearea.addEventListener('keyup', () =>{
    textearea.style.backgroundColor = 'green';
    console.log(maDiv);
    maDiv.innerHTML=textearea.value;
},false);


