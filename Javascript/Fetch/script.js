

//Selectionne l'élément HTML avec la classe "apiPoke" et le stocke dans la variable apiDiv
const apiDiv = document.querySelector('.apiPoke');
//Affiche les attributs de l'éléments apiDiv dans la console
console.log(apiDiv);

//Fonction asynchrone qui effectue une requete à l'API Pokémon
const pokeApi = async () => {
  //Data va récupérer toutes les données de l'API
  const data = await fetch('https://pokeapi.co/api/v2/pokemon?limit=20&offset=0');
  //console.log(data);
  
  //Transforme les données en format JSON
  const dataTransformed = await data.json(); 

  console.log(dataTransformed);
  
  apiDiv.innerHTML ="<ul>";
  for (let i=0 ; i < dataTransformed.results.length; i++){
    const liste = dataTransformed.results[i];
    //chercher Image Poke
    const dataImg = await fetch (liste.url)
    const dataImgTransformed = await dataImg.json();
    dataImgTransformed.sprites.front_default;
    console.log(dataImgTransformed.sprites.front_default);


    //Modifie le contenu de l'element apiDiv en ajoutant le nom du Pokemon suivi d'une balise espace
    apiDiv.innerHTML = apiDiv.outerHTML +"<li> "+ "<img src='"+dataImgTransformed.sprites.front_default+"'/>"+liste.name + "</li>";

    //Affiche le texte actuel de apiDiv dans la console
    console.log(apiDiv.outerText);
    
  };
  apiDiv.innerHTML = apiDiv.outerHTML + "</ul>";
};
//Appelle la fonction contactApi pour exécuter la requête Api
pokeApi();

/* //Correction : 
// Sélectionne l'élément HTML avec la classe "apiContact" et le stocke dans la variable apiDiv
const apiDiv = document.querySelector('.apiContact');

// Affiche les attributs de l'élément apiDiv dans la console
console.log(apiDiv.attributes);

// Fonction asynchrone qui effectue une requête à l'API Pokémon
const contactApi = async () => {
    // Effectue une requête fetch pour obtenir les données de l'API
    const data = await fetch('https://pokeapi.co/api/v2/pokemon?limit=20&offset=0');
    
    // Transforme les données en format JSON
    const dataTransformed = await data.json();
    
    // Parcourt la liste des résultats de l'API
    apiDiv.innerHTML = "<ul>"
    for (let index = 0; index < dataTransformed.results.length; index++) {
        const element = dataTransformed.results[index];
        const dataImg = await fetch(element.url);
        const dataImgTransformed = await dataImg.json();
        dataImgTransformed.sprites.front_default;
        console.log(dataImgTransformed.sprites.front_default);


        // Modifie le contenu de l'élément apiDiv en ajoutant le nom du Pokémon suivi d'une balise de saut de ligne
        apiDiv.innerHTML = apiDiv.outerHTML + "<li> " + "<img src='"+dataImgTransformed.sprites.front_default+"'>" + element.name + "</li>";  
    

        // Affiche le texte actuel de apiDiv dans la console
        console.log(apiDiv.outerText); 
    }
    apiDiv.innerHTML = apiDiv.outerHTML + "</ul>";

};
//Appelle la fonction contactApi pour exécuter la requête Api
pokeApi(); */
