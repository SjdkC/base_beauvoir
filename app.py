from flask import Flask, render_template

app = Flask("Application")

livres = {
    0: {
        "nom": "Les Mandarins",
        "auteur": "Simone de Beauvoir",
        "date": "1954",
        "type": "roman",
        "dewey": "800",
        "description": "Roman qui a reçu le prix Goncourt."
    },
    1: {
        "nom": "L'invitée",
        "auteur": "Simone de Beauvoir",
        "date": "1943",
        "type": "roman",
        "dewey": "800",
        "description": "Premier roman publié de Simone de Beauvoir."
    }
}


@app.route("/")
def accueil():
    return render_template("accueil.html", nom="Base Beauvoir", livres=livres)


@app.route("/book/<int:book_id>")
def livre(book_id):
    return render_template("book.html", nom="Base Beauvoir", livre=livres[book_id])


# Ce if permet de vérifier que ce fichier est celui qui est courrament exécuté. Cela permet par exemple d'éviter
# de lancer une fonction quand on importe ce fichier depuis un autre fichier.
# En python, lorsque l'on exécute un script avec la commande `python script.py`
# Le fichier `script.py` a en __name__ la valeur __main__.
if __name__ == "__main__":
    app.run()
