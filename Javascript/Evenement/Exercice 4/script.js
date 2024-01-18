let evenement1 = document.querySelector("input");
evenement1.addEventListener("focus", () => {
    evenement1.style.backgroundColor ='blue';
    evenement1.style.color = 'white'
}, false);

let evenement2 = document.querySelector("input");
evenement2.addEventListener("blur", () =>{
    evenement2.style.backgroundColor = 'white';
    evenement2.style.color ='black';
},false);

// let evenement3 = document.querySelector('p');
// evenement3.addEventListener("focus",()=>{
//     evenement3.style.backgroundColor = 'red';
// })




