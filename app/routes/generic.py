from flask import render_template, request, flash, redirect
from flask_login import current_user, login_user, logout_user, login_required

from ..app import app, login, db
from ..constantes import LIVRES_PAR_PAGE
from ..modeles.donnees import Book, Authorship, Type, Writer, Mentions
from ..modeles.utilisateurs import User

@app.route("/")
def accueil():
    """ Route permettant l'affichage d'une page accueil
    """
    livres = Book.query.order_by(Book.book_id.desc()).limit(5).all()
    return render_template("pages/accueil.html", nom="Base Beauvoir", livres=livres)

@app.route("/simone_de_beauvoir")
def simone_de_beauvoir():
    """ Route permettant l'affichage des données sur Simone de Beauvoir
    """
    simone_de_beauvoir = Writer.query.get(0)
    return render_template("pages/simone_de_beauvoir.html", nom="Base Beauvoir", auteur=simone_de_beauvoir)


@app.route("/book/<int:book_id>")
def livre(book_id):
    """ Route permettant l'affichage des données d'une oeuvre

    :param book_id: Identifiant numérique de l'oeuvre
    """
    unique_livre = Book.query.get(book_id)
    return render_template("pages/book.html",
                           nom="Base Beauvoir",
                           livre=unique_livre)

@app.route("/book/<int:book_id>/update", methods=["GET", "POST"])
@login_required
def book_update(book_id):
    """ Route permettant la modification des données d'une oeuvre

    :param book_id: Identifiant numérique de l'oeuvre
    """

    mon_livre = Book.query.get_or_404(book_id)
    book_types = Type.query.all()

    erreurs = []
    updated = False

    if request.method == "POST":
        # J"ai un formulaire
        if not request.form.get("book_nom", "").strip():
            erreurs.append("Veuillez renseigner le nom de l'oeuvre.")
        if not request.form.get("book_date", "").strip():
            erreurs.append("Veuillez renseigner la date de l'oeuvre.")
        if not request.form.get("type_nom", "").strip():
            erreurs.append("Veuillez renseigner le genre de l'oeuvre.")
        elif not Type.query.get(request.form["type_nom"]):
            erreurs.append("Veuillez renseigner le nom de l'oeuvre.")

        if not erreurs:
            print("Faire ma modifications")
            mon_livre.book_nom = request.form["book_nom"]
            mon_livre.book_date = request.form["book_date"]
            mon_livre.book_description = request.form["book_description"]
            mon_livre.book_type = request.form["type_nom"]
            # J'utilise la relationship
            #mon_livre.book_type = Type.query.get(request.form["type_nom"])

            db.session.add(mon_livre)
            db.session.add(Authorship(book=mon_livre, user=current_user))
            db.session.commit()
            updated = True

    return render_template(
        "pages/book_form_update.html",
        nom="Base Beauvoir",
        livre=mon_livre,
        types=book_types,
        erreurs=erreurs,
        updated=updated
    )

@app.route("/simone_de_beauvoir/update", methods=["GET", "POST"])
@login_required
def simone_de_beauvoir_update():
    """ Route permettant la modification des données de la page Simone de Beauvoir
    """

    mon_autrice = Writer.query.get_or_404(0)

    erreurs = []
    updated = False

    if request.method == "POST":
        # J"ai un formulaire

            print("Faire ma modifications")
            mon_autrice.writer_description = request.form["writer_description"]

            db.session.add(mon_autrice)
            db.session.add(Authorship(writer=mon_autrice, user=current_user))
            db.session.commit()
            updated = True

    return render_template(
        "pages/simone_de_beauvoir_update.html",
        nom="Base Beauvoir",
        auteur=mon_autrice,
        erreurs=erreurs,
        updated=updated
    )

@app.route("/recherche")
def recherche():
    """ Route permettant la recherche plein-texte
    """
    # On préfèrera l'utilisation de .get() ici
    #   qui nous permet d'éviter un if long (if "clef" in dictionnaire and dictonnaire["clef"])
    motclef = request.args.get("keyword", None)
    page = request.args.get("page", 1)

    if isinstance(page, str) and page.isdigit():
        page = int(page)
    else:
        page = 1

    # On crée une liste vide de résultat (qui restera vide par défaut
    #   si on n'a pas de mot clé)
    resultats = []

    # On fait de même pour le titre de la page
    titre = "Recherche"
    if motclef:
        resultats = Book.query.filter(
            Book.book_nom.like("%{}%".format(motclef))
        ).paginate(page=page, per_page=LIVRES_PAR_PAGE)
        titre = "Résultat pour la recherche `" + motclef + "`"

    return render_template(
        "pages/recherche.html",
        resultats=resultats,
        titre=titre,
        keyword=motclef
    )

@app.route("/browse")
def browse():
    """ Route permettant la recherche plein-texte
    """
    # On préfèrera l'utilisation de .get() ici
    #   qui nous permet d'éviter un if long (if "clef" in dictionnaire and dictonnaire["clef"])
    page = request.args.get("page", 1)

    if isinstance(page, str) and page.isdigit():
        page = int(page)
    else:
        page = 1

    resultats = Book.query.paginate(page=page, per_page=LIVRES_PAR_PAGE)

    return render_template(
        "pages/browse.html",
        resultats=resultats
    )

#Route donnant accès à la page de navigation dans l'API.

@app.route("/browse_api")
def browse_api():

    page = request.args.get("page", 1)

    if isinstance(page, str) and page.isdigit():
        page = int(page)
    else:
        page = 1

    resultats_books = Book.query.paginate(page=page, per_page=LIVRES_PAR_PAGE)
    resultats_description = Book.query.paginate(page=page, per_page=LIVRES_PAR_PAGE)

    return render_template(
        "pages/browse_api.html",
        resultats_books=resultats_books,
        resultats_description=resultats_description
    )

@app.route("/register", methods=["GET", "POST"])
def inscription():
    """ Route gérant les inscriptions
    """
    # Si on est en POST, cela veut dire que le formulaire a été envoyé
    if request.method == "POST":
        statut, donnees = User.creer(
            login=request.form.get("login", None),
            email=request.form.get("email", None),
            nom=request.form.get("nom", None),
            motdepasse=request.form.get("motdepasse", None)
        )
        if statut is True:
            flash("Enregistrement effectué. Vous êtes maintenant connecté.e !", "success")
            return redirect("/")
        else:
            flash("Les erreurs suivantes ont été rencontrées : " + ", ".join(donnees), "error")
            return render_template("pages/inscription.html")
    else:
        return render_template("pages/inscription.html")


@app.route("/connexion", methods=["POST", "GET"])
def connexion():
    """ Route gérant les connexions
    """
    if current_user.is_authenticated is True:
        flash("Vous êtes déjà connecté-e", "info")
        return redirect("/")
    # Si on est en POST, cela veut dire que le formulaire a été envoyé
    if request.method == "POST":
        utilisateur = User.identification(
            login=request.form.get("login", None),
            motdepasse=request.form.get("motdepasse", None)
        )
        if utilisateur:
            flash("Connexion effectuée", "success")
            login_user(utilisateur)
            return redirect("/")
        else:
            flash("Les identifiants n'ont pas été reconnus", "error")

    return render_template("pages/connexion.html")
login.login_view = 'connexion'


@app.route("/deconnexion", methods=["POST", "GET"])
def deconnexion():
    if current_user.is_authenticated is True:
        logout_user()
    flash("Vous êtes déconnecté-e", "info")
    return redirect("/")

@app.route("/new_book", methods=["GET", "POST"])
@login_required
def new_book():
    descending = Book.query.order_by(Book.book_id.desc())
    last_id = descending.first()
    if request.method == "POST":
        statut, informations = Book.ajout_book(
            ajout_book_id = request.form.get("ajout_book_id", None),
            ajout_book_nom = request.form.get("ajout_book_nom", None),
            ajout_book_date = request.form.get("ajout_book_date", None),
            ajout_book_type = request.form.get("ajout_book_type", None),
            ajout_book_description= request.form.get("ajout_book_description", None)
            )

        if statut is True:
            flash("L'oeuvre a bien été ajoutée à la base de données !", "success")
            return redirect("/")
        else:
            flash("L'ajout a échoué pour les raisons suivantes : " + " ".join(informations), "danger")
            return render_template("pages/new_book.html")
    else:
        return render_template("pages/new_book.html", last_id=last_id)

@app.route("/new_inter", methods=["GET", "POST"])
@login_required
def new_inter():
    descending = Mentions.query.order_by(Mentions.mentions_id.desc())
    last_id_mentions = descending.first()
    if request.method == "POST":
        statut, informations = Mentions.ajout_mentions(
            ajout_mentions_id = request.form.get("ajout_mentions_id", None),
            ajout_mentions_book_id = request.form.get("ajout_mentions_book_id", None),
            ajout_is_mentioned_book_id = request.form.get("ajout_is_mentioned_book_id", None),
            ajout_mentions_chapter= request.form.get("ajout_mentions_chapter", None))

        if statut is True:
            flash("La mention intertextuelle a bien été ajoutée à la base de données !", "success")
            return redirect("/")
        else:
            flash("L'ajout a échoué pour les raisons suivantes : " + " ".join(informations), "danger")
            return render_template("pages/new_inter.html")
    else:
        return render_template("pages/new_inter.html", last_id_mentions=last_id_mentions)

@app.route("/suppress_book/<int:book_id>", methods=["POST", "GET"])
@login_required
def suppress_book(book_id):

    suppr_book = Book.query.get(book_id)

    if request.method == "POST":
        statut = Book.supprimer_book(
            book_id=book_id
        )

        if statut is True:
            flash("Suppression réussie", "success")
            return redirect("/")
        else:
            flash("La suppression a échoué. Réessayez !", "error")
            return redirect("/")
    else:
        return render_template("pages/suppress_book.html", suppr_book=suppr_book)