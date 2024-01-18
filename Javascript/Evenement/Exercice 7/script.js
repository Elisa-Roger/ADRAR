// Ecouter la page

let bar = document.querySelector('.bar');
let scrollMax = document.body.scrollHeight - window.innerHeight;
let percentage = window.scrollY / scrollMax * 100;
bar.style.width = `${percentage}%`;