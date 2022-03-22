from flask import render_template, request

from .app import app
from .modeles.donnees import Book

@app.route("/")
def accueil():
    livres = Book.query.order_by(Book.book_date.asc()).all()
    return render_template("pages/accueil.html", nom="Base Beauvoir", livres=livres)

@app.route("/book/<int:book_id>")
def livre(book_id):
    unique_livre = Book.query.get(book_id)
    return render_template("pages/book.html", nom="Base Beauvoir", livre=unique_livre)

@app.route("/recherche")
def recherche():
    # On préfèrera l'utilisation de .get() ici
    #   qui nous permet d'éviter un if long (if "clef" in dictionnaire and dictonnaire["clef"])
    motclef = request.args.get("keyword", None)
    # On crée une liste vide de résultat (qui restera vide par défaut
    #   si on n'a pas de mot clé)
    resultats = []
    # On fait de même pour le titre de la page
    titre = "Recherche"
    if motclef:
        resultats = Book.query.filter(
            Book.book_nom.like("%{}%".format(motclef))
        ).all()
        titre = "Résultat pour la recherche `" + motclef + "`"
    return render_template("pages/recherche.html", resultats=resultats, titre=titre)