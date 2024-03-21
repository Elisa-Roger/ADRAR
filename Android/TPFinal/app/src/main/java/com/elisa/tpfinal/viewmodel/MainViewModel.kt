package com.elisa.tpfinal.viewmodel

import androidx.compose.runtime.mutableStateListOf
import androidx.lifecycle.ViewModel
import com.elisa.tpfinal.model.CocktailBean
import com.elisa.tpfinal.model.cocktailList

class MainViewModel: ViewModel() {

    val myList = mutableStateListOf<CocktailBean>()


    fun loadData() {
        myList.addAll(cocktailList)
    }


}

