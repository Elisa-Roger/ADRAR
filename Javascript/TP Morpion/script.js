//Créer un tableau pour faire la grill du jeu 

// let tableau = [
//     ['','',''],
//     ['','',''],
//     ['','','']
// ];

// let joueur1 = "X";

// function makeMove(row,col){
//     if(tableau[row][col]===''){
//         tableau[row][col]=joueur1;

//         displayTableau();

//         if(win(joueur1)){
//             alert('Le joueur'+joueur1+ 'a gagné !');
//             resetGame();
//             return;
//         }
//         if(nul()){
//             alert("Match nul");
//             resetGame();
//             return;
//         }
//         joueur1 = (joueur1 === 'X') ? 'O' : 'X';
//     }

// }

// function win(player){
//     for(let row = 0; row<3; row++){
//         if(tableau[row][0]===player && tableau[row][1] === player && tableau[row][2]===player){
//             return true;
//         }
//     }
//     for(let col = 0; col<3; col++){
//         if(tableau[0][col]===player && tableau[1][col] === player && tableau[2][col]===player){
//             return true;
//         }
//     }
//     if(tableau [0][0]=== player && tableau[1][1]=== player && tableau[2][2]=== player){
//         return true;
//     }
    
//     if(tableau [0][2]=== player && tableau[1][1]=== player && tableau[2][0]=== player){
//         return true;
//     }
//     return false; 
// }

// function nul(){
//     for(let row=0; row<3; row++){
//         for(let col=0; col<3; col++){
//             if(tableau[row][col]===''){
//                 return false;
//             }
//         }
//     }
//     return true;
// }

// function displayTableau(){
//     const boardContainer = document.querySelector("#tableau");
//     boardContainer.innerHTML='';
//     for(let row=0; row<3; row++){
//         for(let col=0; col<3; col++){
//            const cell = document.createElement('div');
//            cell.classList.add("cell");
//            cell.textContent = tableau[row][col];

//            cell.addEventListener("click",()=>{
//             makeMove(row,col);
//            });

//            boardContainer.appendChild(cell);
//         }
//     }
// }    

// function resetGame(){
    
//     tableau = [
//         ['','',''],
//         ['','',''],
//         ['','','']
//     ];
//     joueur1 = 'X';
//     displayTableau();
// }

// displayTableau();


const cells = document.querySelectorAll('[data-cell]');
const gameStatus = document.getElementById('gameStatus');
const endGameStatus = document.getElementById('endGameStatus');
const playerOne = "O";
const playerTwo = "X";
let playerTurn = playerOne;

const winningPatterns = [
    [0,1,2],
    [3,4,5],
    [6,7,8],
    [0,3,6],
    [1,4,7],
    [2,5,8],
    [0,4,8],
    [2,4,6],
];

cells.forEach(cell =>{
    cell.addEventListener('click',playGame,{ once:true});
});

function playGame(e){
    e.target.innerHTML = playerTurn;

    if(checkWin(playerTurn)){
        updateGameStatus("wins"+playerTurn);
        return endGame();
    }else if(checkDraw()){
        updateGameStatus("draw");
        return endGame();
    }

    updateGameStatus(playerTurn);
    playerTurn == playerOne ? playerTurn = playerTwo : playerTurn = playerOne;
}

function checkWin(playerTurn){
    return winningPatterns.some(combination =>{     //on teste chaque pattern
        return combination.every(index =>{
            return cells[index].innerHTML == playerTurn;
        });
    });
}

function checkDraw(){
    return [...cells].every(cell => {
        return cell.innerHTML == playerOne || cell.innerHTML == playerTwo;
    });
}

function updateGameStatus(status){
    let statusText;

    switch(status){
        case'X': statusText ="Au tour du joueur 2 (0)";
        break;
        case'O': statusText ="Au tour du joueur 1 (X)";
        break;
        case'winsX': statusText ="Le joueur 1 (X) a gagné !";
        break;
        case'winsO': statusText ="Le joueur 2 (O) a gagné !";
        break;
        case'draw': statusText ="Egalité";
        break;
    }
    gameStatus.innerHTML = statusText;
    endGameStatus.innerHTML = statusText;
}

function endGame(){document.getElementById('gameEnd').style.display = "block";
} 


function reloadGame(){
    window.location.reload();
}