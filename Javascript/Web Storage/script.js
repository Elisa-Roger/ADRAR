const ta = document.querySelector('#saisie');
const div = document.querySelector('.preview');

ta.addEventListener('input', () => {
    div.innerHTML = ta.value;
});

//Exercice Web Storage

// const monTxt = document.querySelector('#saisie');
// const rendu = document.querySelector('.preview');


// monTxt.value = localStorage.getItem("monSuperTexte");
// if (monTxt.value) {
//     rendu.textContent = monTxt.value;
//   }
//   console.log(monTxt);

//   monTxt.addEventListener('input',function(){
//     localStorage.setItem("monSuperTexte", monTxt.value);
//     rendu.textContent = monTxt.value;
//     console.log(rendu.textContent);
//   })

// Exercice Session storage

const monTxt = document.querySelector('#saisie');
const rendu = document.querySelector('.preview');


monTxt.value = sessionStorage.getItem("monSuperTexte");
if (monTxt.value) {
    rendu.textContent = monTxt.value;
  };
  console.log(monTxt);

  monTxt.addEventListener('input',function(){
    sessionStorage.setItem("monSuperTexte", monTxt.value);
    rendu.textContent = monTxt.value;
    console.log(rendu.textContent);
  });