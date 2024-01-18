//Excercice 3 calculatrice

let nombre1 = parseFloat(prompt("Donnez moi votre premier nombre"));
let nombre2 = parseFloat(prompt("donnez moi votre second nombre"));
let operateur = prompt("Quel est l'opération a effectué? (+ - * /)");

let resultA;

if(!isNaN(nombre1)&& !isNaN(nombre2)){
    switch(operateur){
        case"+": resultA = nombre1 + nombre2
        break;
        case"-": resultA = nombre1 - nombre2
        break;
        case"*": resultA = nombre1 * nombre2
        break;
        case"/": resultA = nombre1 / nombre2
        break;
        default:alert("Attention erreur");
    }
}else{
    alert("Il semble y avoir une erreur dans les nombres");
}
if(!isNaN(resultA)){
    alert(resultA);
}





/*let nombreUn = Math.round(Math.random()*10);
let nombreDeux = Math.round(Math.random()*10);
let nombreTrois = nombreUn * nombreDeux;*/
