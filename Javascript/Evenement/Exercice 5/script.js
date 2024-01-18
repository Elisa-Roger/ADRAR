let mesImages = document.querySelectorAll("img");
//console.log(mesImages);
mesImages = Array.from(mesImages); // Transforme la NodeList en Array
console.log(mesImages);

// const image = mesImages.map((image, index) => {
//       console.log(`Image ${index} vient de finir de charger.`);
//   });
//   //N'affiche pas le chargement des images dans le bon odre de chargement...

mesImages.map((image, index) => {
  image.addEventListener("load", () => {
    console.log(`Image ${index} vient de finir de charger.`);
  });
});
