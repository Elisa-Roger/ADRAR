let evenement = document.querySelector('p');
evenement.addEventListener('click', () =>{
    evenement.innerText = '--Félicitation--';
})

let monTitre = document.createElement('h1');
monTitre.innerText = "bonjour";
document.body.append(monTitre);

monTitre.addEventListener('dblclick', ()=>{
    let img = document.createElement('img');
    img.src= "https://th.bing.com/th/id/R.c05db3298062e01a796cff9cc559f39f?rik=AD10dgV6HQnoqg&riu=http%3a%2f%2fwww.ddesignerr.com%2fwp-content%2fuploads%2f2012%2f05%2f038.gif&ehk=%2fGTZgFJcNY5KhlBlbqI5nRCeiXKyHd%2b7UgPY76FalR8%3d&risl=&pid=ImgRaw&r=0";
    document.body.append(img);
})