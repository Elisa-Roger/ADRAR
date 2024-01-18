let titre = document.getElementById('monTitre');

document.addEventListener("mouseleave",() =>{
    
    titre.style.display = "block";
    titre.style.color = "yellow";
    titre.style.backgroundColor = "green";
});

console.log(titre);