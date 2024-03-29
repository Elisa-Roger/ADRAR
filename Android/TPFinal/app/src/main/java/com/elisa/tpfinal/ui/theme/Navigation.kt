package com.elisa.tpfinal.ui.theme

import androidx.compose.runtime.Composable
import androidx.lifecycle.viewmodel.compose.viewModel
import androidx.navigation.NavHostController
import androidx.navigation.NavType
import androidx.navigation.compose.NavHost
import androidx.navigation.compose.composable
import androidx.navigation.compose.rememberNavController
import androidx.navigation.navArgument
import com.elisa.tpfinal.model.CocktailBean
import com.elisa.tpfinal.ui.theme.screens.DetailScreen
import com.elisa.tpfinal.ui.theme.screens.FirstScreen
import com.elisa.tpfinal.viewmodel.MainViewModel


//sealed permet de dire qu'une classe est héritable (ici par SearchScreen et DetailScreen)
//Uniquement par les sous classes qu'elle contient
sealed class Routes(val route: String) {
    //Route 1
    data object FirstScreen : Routes("homeScreen")

    //Route 2 avec paramètre
    data object DetailScreen : Routes("detailScreen/{id}") {
        //Méthode(s) qui vienne(nt) remplit le ou les paramètres
        fun withId(id: Int) = "detailScreen/$id"

        fun withObject(data : CocktailBean) = "detailScreen/${data.id}"
    }
}

@Composable
fun AppNavigation() {

    val navHostController : NavHostController = rememberNavController()

    //viewModel appartient au framework peremt de récupérer une instance déjà existante s'il en existe une
    val mainViewModel: MainViewModel = viewModel()


    //Import version avec Composable
    NavHost(navController = navHostController, startDestination = Routes.FirstScreen.route) {
        //Route 1 vers notre SearchScreen
        composable(Routes.FirstScreen.route) {
            //on peut passer le navHostController à un écran s'il déclenche des navigations
            FirstScreen(navHostController, mainViewModel = mainViewModel)
        }
        //Route 2 vers un écran de détail
        composable(
            route = Routes.DetailScreen.route,
            arguments = listOf(navArgument("id") { type = NavType.IntType })
        ) {
            val id = it.arguments?.getInt("id") ?: 1
            DetailScreen(id, navHostController, mainViewModel = mainViewModel)
        }
    }
}