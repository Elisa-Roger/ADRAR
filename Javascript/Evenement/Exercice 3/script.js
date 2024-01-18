// document.onclick = function(event) {
//     console.log(event);
//     let x = event.pageX;
//     let y = event.pageY;

//     let img = document.createElement("img");
//     img.src = "https://th.bing.com/th/id/OIP.3l2nfzcHhMemSZooiH3B3AHaFj?rs=1&pid=ImgDetMain";
//     img.style.position = "absolute";
//     img.style.left = x + "px";
//     img.style.top = y + "px";

//     document.body.appendChild(img);
//   };


document.addEventListener("click", function(e) {
  let img2 = document.createElement("img");
  img2.src =
    "https://th.bing.com/th/id/OIP.ag77IUhQeW_A-FQGcASMLAHaFj?rs=1&pid=ImgDetMain";
  img2.style.width = "100px";
  img2.style.height = "100px";
  img2.style.position = "absolute";
  img2.style.left = `${e.pageX}px`;
  img2.style.top = `${e.pageY}px`;
  document.body.appendChild(img2);
  console.log(e);
});
