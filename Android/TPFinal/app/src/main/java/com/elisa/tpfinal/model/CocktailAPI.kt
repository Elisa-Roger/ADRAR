package com.elisa.tpfinal.model

import com.google.gson.Gson
import com.google.gson.annotations.SerializedName
import okhttp3.OkHttpClient
import okhttp3.Request

fun main() {
    val res =CocktailAPI.loadListOfDrink()
    println(res.joinToString("\n") {
        "-${it.title} : ${it.difficulty}"
    })

    var detail = (CocktailAPI.drinkDetail("45"))
    println(detail)

}

object CocktailAPI {

    val gson = Gson()
    val client = OkHttpClient()

    fun drinkDetail(id: String): CocktailBean {
        //Eventuel contrôle
        //Réaliser la requête.
        val json: String = sendGet("/$id")

        //Parser le JSON avec le bon bean et GSON
        val data = gson.fromJson(json, CocktailBean::class.java)

        //Eventuel contrôle ou extraction de données

        //Retourner la donnée
        return data
    }
    //Charge la liste des recettes avec image et id
    fun loadListOfDrink(): List<CocktailBean> {
        val json = sendGet("")
        return CocktailAPI.gson.fromJson(json, Array<CocktailBean>::class.java).toList()
    }

    //Méthode qui prend en entrée une url, execute la requête
    //Retourne le code HTML/JSON reçu
    fun sendGet(url: String): String {
        println("url : $url")
        //Création de la requête
        val request = Request.Builder()
            .url("https://the-cocktail-db3.p.rapidapi.com$url")
            .get()
            .addHeader("X-RapidAPI-Key", "f225caf65dmshea7beab44a3e9d4p159dabjsnf7304a59645f")
            .addHeader("X-RapidAPI-Host", "the-cocktail-db3.p.rapidapi.com")
            .build()

        //Execution de la requête
        return client.newCall(request).execute().use { //it:Response
            //use permet de fermer la réponse qu'il y ait ou non une exception
            //Analyse du code retour
            if (!it.isSuccessful) {
                throw Exception("Réponse du serveur incorrect :${it.code}")
            }
            //Résultat de la requête
            it.body.string()
        }
    }
}

data class CocktailBean(
    var id: Int,
    var title: String,
    var difficulty: String,
    var portion: String? = null,
    var time: String? =null,
    var description: String,
    var ingredients: List<String>? = null,
    var method: List<Method>? = null,
    var image: String
)
data class Method(
    @SerializedName("Step 1")
    var step1: String?,
    @SerializedName("Step 2")
    var step2: String?,
    @SerializedName("Step 3")
    var step3: String?,
    @SerializedName("Step 4")
    var step4: String?,
    @SerializedName("Step 5")
    var step5: String?,
    @SerializedName("Step 6")
    var step6: String?
)

//jeu de donnée
val method = listOf(
    "Chill the bottle of prosecco and Aperol in the fridge.",
    "Fill 6 or 8 wine glasses or tall tumblers with a couple of ice cubes and roughly three parts prosecco to one part Aperol.",
    "Add a splash of soda water and a slice of orange. Serve straightaway so that the fizz stays lively."
)
val ingredients = listOf(
    "750ml bottle of prosecco",
    "Bag of ice",
    "Bottle of Aperol",
    "Bottle of soda water",
    "Slice of orange"
)
val cocktailList = arrayListOf(CocktailBean(45,"Aperol spritz","Easy","Serves 6-8","Hands-on time 5 min","Get into the spirit of summer with this classic Italian recipe. Chilled prosecco and Aperol come together to create the beloved Aperol spritz.",
    ingredients,null, "https://apipics.s3.amazonaws.com/coctails_api/45.jpg"),
    CocktailBean(1,"Nutella and cognac coffee cocktail","Easy","","","",null,null,"https://apipics.s3.amazonaws.com/coctails_api/1.jpg"),
    CocktailBean(2,"Easy rhubarb cordial","Easy","","","",null,null,"https://apipics.s3.amazonaws.com/coctails_api/2.jpg"),
    CocktailBean(3,title="Bottled chocolate orange negroni", difficulty = "Easy", description = "",image="https://apipics.s3.amazonaws.com/coctails_api/3.jpg"))