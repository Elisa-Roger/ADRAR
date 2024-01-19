// Ecouter la page
let progressBarre = document.getElementById('bar');


window.addEventListener('scroll', ()=>{
    let hauteur = document.body.scrollHeight;
    let scrollY = window.scrollY;
    let scrollMax = document.body.scrollHeight - window.innerHeight;
    let pourcentage = (scrollY / scrollMax) * 100;
    
    console.log( window.innerHeight);
    console.log(scrollMax);
    console.log(scrollY);
    console.log(pourcentage);

    progressBarre.style.width = pourcentage + '%' ;

});