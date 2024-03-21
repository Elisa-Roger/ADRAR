package com.elisa.tpfinal.ui.theme.screens

import android.content.res.Configuration
import androidx.compose.foundation.background
import androidx.compose.foundation.clickable
import androidx.compose.foundation.layout.Arrangement
import androidx.compose.foundation.layout.Column
import androidx.compose.foundation.layout.Row
import androidx.compose.foundation.layout.Spacer
import androidx.compose.foundation.layout.fillMaxHeight
import androidx.compose.foundation.layout.fillMaxSize
import androidx.compose.foundation.layout.fillMaxWidth
import androidx.compose.foundation.layout.height
import androidx.compose.foundation.layout.padding
import androidx.compose.foundation.layout.size
import androidx.compose.foundation.layout.width
import androidx.compose.foundation.lazy.LazyColumn
import androidx.compose.material3.MaterialTheme
import androidx.compose.material3.Surface
import androidx.compose.material3.Text
import androidx.compose.runtime.Composable
import androidx.compose.runtime.LaunchedEffect
import androidx.compose.ui.Modifier
import androidx.compose.ui.layout.ContentScale
import androidx.compose.ui.tooling.preview.Preview
import androidx.compose.ui.unit.dp
import androidx.compose.ui.unit.sp
import androidx.lifecycle.viewmodel.compose.viewModel
import androidx.navigation.NavHostController
import com.bumptech.glide.integration.compose.ExperimentalGlideComposeApi
import com.bumptech.glide.integration.compose.GlideImage
import com.bumptech.glide.integration.compose.placeholder
import com.elisa.tpfinal.R
import com.elisa.tpfinal.model.CocktailBean
import com.elisa.tpfinal.model.cocktailList
import com.elisa.tpfinal.ui.theme.Routes
import com.elisa.tpfinal.ui.theme.TPFinalTheme
import com.elisa.tpfinal.viewmodel.MainViewModel


@Preview(showBackground = true, showSystemUi = true)
@Preview(showBackground = true, showSystemUi = true, uiMode = Configuration.UI_MODE_NIGHT_YES)
@Composable
fun FirstScreenPreview() {
    TPFinalTheme {
        Surface(modifier = Modifier.fillMaxSize(), color = MaterialTheme.colorScheme.background) {
            //Jeu de donnée pour la Preview
            val mainViewModel: MainViewModel = viewModel()
            mainViewModel.myList.addAll(cocktailList)
            FirstScreen(mainViewModel = mainViewModel)
        }
    }
}

@Composable
fun FirstScreen(
    navHostController: NavHostController? = null,
    mainViewModel: MainViewModel
) {
    LaunchedEffect(key1 = "") {
        mainViewModel.loadData()
    }
    Column {
        Text(
            text = ("Cocktail : "),
            fontSize = 30.sp,
            color = MaterialTheme.colorScheme.primary
        )
        Spacer(Modifier.size(8.dp))
        LazyColumn(
            verticalArrangement = Arrangement.spacedBy(8.dp),
            modifier = Modifier.weight(1f)
        ) {

            val filterList = mainViewModel.myList

            items(filterList.size) {
                PictureRowItem(
                    modifier = Modifier.padding(8.dp),
                    data = filterList[it],
                    onPictureClick = {
                        navHostController?.navigate(
                            Routes.DetailScreen.withObject(
                                filterList[it]
                            )
                        )
                    }
                )

            }
        }
    }
}

@OptIn(ExperimentalGlideComposeApi::class)
@Composable
fun PictureRowItem(modifier: Modifier = Modifier, data: CocktailBean, onPictureClick: () -> Unit) {
    Row(
        modifier = modifier
            .height(100.dp)
            .fillMaxWidth()
            .background(MaterialTheme.colorScheme.surface)
    ) {
        GlideImage(
            model = data.image,
            contentDescription = "Pas de description",
            // Image d'attente. Permet également de voir l'emplacement de l'image dans la Preview
            loading = placeholder(R.mipmap.ic_launcher_round),
            // Image d'échec de chargement
            failure = placeholder(R.mipmap.ic_launcher),
            contentScale = ContentScale.Fit,
            //même autres champs qu'une Image classique
            modifier = Modifier
                .width(100.dp)
                .fillMaxHeight()
                .clickable(onClick = onPictureClick)
        )

        Column(Modifier.weight(1f)) {
            Text(
                text = data.title,
                fontSize = 20.sp,
                modifier = Modifier
                    .padding(8.dp)
                    .fillMaxWidth()
            )
            Text(
                text = data.description.take(20) + "...",
                fontSize = 14.sp,
                color = MaterialTheme.colorScheme.primary,
                modifier = Modifier
                    .padding(8.dp)
                    .fillMaxWidth()
            )
        }
    }
}