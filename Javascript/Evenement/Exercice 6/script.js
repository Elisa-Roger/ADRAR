//  let titre = document.getElementById('monTitre');

//  document.addEventListener("mouseleave",() =>{
    
//      titre.style.display = "block";
//      titre.style.color = "yellow";
//      titre.style.backgroundColor = "green";
//  });

//  console.log(titre);


let title = document.createElement("h2");
 title.innerHTML = "Tu as gagné 1 million de dollars";
 document.body.append(title);


 title.addEventListener('mouseout',()=>{
     title.style.display = 'block';
     title.style.background = 'green';

 });

 title.addEventListener('mouseover',()=>{
     title.style.background = 'red';
     title.style.display = 'none';
 });
 console.log(title);