from flask import url_for
import datetime

from .. app import db

#Moddèle pour la table de relation de création / modification de contenu
class Authorship(db.Model):
    __tablename__ = "authorship"
    authorship_id = db.Column(db.Integer, nullable=True, autoincrement=True, primary_key=True)
    authorship_book_id = db.Column(db.Integer, db.ForeignKey('book.book_id'))
    authorship_writer_id = db.Column(db.Integer, db.ForeignKey('writer.writer_id'))
    authorship_user_id = db.Column(db.Integer, db.ForeignKey('user.user_id'))
    authorship_date = db.Column(db.DateTime, default=datetime.datetime.utcnow)
    user = db.relationship("User", back_populates="authorships")
    book = db.relationship("Book", back_populates="authorships")
    writer = db.relationship("Writer", back_populates="authorships")

    def author_to_json(self):
        return {
            "author": self.user.to_jsonapi_dict(),
            "on": self.authorship_date
        }

# Modèle pour la table des genres littéraires/types
class Type(db.Model):
    type_nom = db.Column(db.Text, unique=True, nullable=False, primary_key=True)
    boook = db.relationship("Book", back_populates="has_type")

# Modèle pour la table des oeuvres/livres
class Book(db.Model):
    book_id = db.Column(db.Integer, unique=True, nullable=False, primary_key=True, autoincrement=True)
    book_nom = db.Column(db.Text, nullable=False)
    book_date = db.Column(db.Integer, nullable=False)
    book_type = db.Column(db.Text, db.ForeignKey("type.type_nom"))
    book_description = db.Column(db.Text)
    authorships = db.relationship("Authorship", back_populates="book")
    has_type = db.relationship("Type", back_populates="boook")
    book_mentions = db.relationship("Mentions", back_populates="book_mentions",
                               foreign_keys="Mentions.mentions_book_id")
    is_mentioned = db.relationship("Mentions", back_populates="book_is_mentioned",
                                   foreign_keys="Mentions.is_mentioned_book_id")

    # Méthode statique permettant l'ajout d'une oeuvre à la BDD

    @staticmethod
    def ajout_book(ajout_book_nom, ajout_book_date, ajout_book_type,
                     ajout_book_description):
        erreurs = []
        if not ajout_book_nom:
            erreurs.append(
                "Veuillez renseigner le nom de cette oeuvre.")
        if not ajout_book_date:
            erreurs.append(
                "Veuillez renseigner la date de publication de cette oeuvre.")
        if not ajout_book_type:
            erreurs.append(
                "Veuillez renseigner le genre littéraire de cette oeuvre.")

            # S'il y a au moins une erreur, afficher un message d'erreur.
        if len(erreurs) > 0:
            return False, erreurs

            # Création de la nouvelle oeuvre
        nouvelle_oeuvre = Book(book_nom=ajout_book_nom,
                                  book_date=ajout_book_date,
                                  book_type=ajout_book_type,
                                  book_description=ajout_book_description)

        # Tentative d'ajout qui sera stoppée si une erreur apparaît.
        try:
            db.session.add(nouvelle_oeuvre)
            db.session.commit()
            return True, nouvelle_oeuvre

        except Exception as erreur:
            return False, [str(erreur)]


    # Méthode statique permettant la suppression d'une oeuvre
    @staticmethod
    def supprimer_book(book_id):

        suppr_book = Book.query.get(book_id)

        try:
            db.session.delete(suppr_book)
            db.session.commit()
            return True

        except Exception as erreur:
            return False, [str(erreur)]

    #prépare le format JSON pour l'API
    def to_jsonapi_dict(self):
        """ It ressembles a little JSON API format but it is not completely compatible

        :return:
        """
        return {
            "type": "book",
            "id": self.book_id,
            "attributes": {
                "nom": self.book_nom,
                "date": self.book_date,
                "genre": self.book_type,
                "description": self.book_description,
            },
            "links": {
                "self": url_for("livre", book_id=self.book_id, _external=True),
                "json": url_for("api_books_single", book_id=self.book_id, _external=True)
            },
            "relationships": {
                 "editions": [
                     author.author_to_json()
                     for author in self.authorships
                 ]
            }
        }

# Modèle pour la table des mentions intertextuelle
class Mentions(db.Model):
    mentions_id = db.Column(db.Integer, nullable=False, autoincrement=True, primary_key=True)
    mentions_book_id = db.Column(db.Integer, db.ForeignKey('book.book_id'))
    is_mentioned_book_id = db.Column(db.Integer, db.ForeignKey('book.book_id'))
    mentions_chapter = db.Column(db.Text)
    mentions_comment = db.Column(db.Text)
    book_mentions = db.relationship("Book", back_populates="book_mentions",
                                    primaryjoin="Mentions.mentions_book_id == Book.book_id")
    book_is_mentioned = db.relationship("Book", back_populates="is_mentioned",
                                        primaryjoin="Mentions.is_mentioned_book_id == Book.book_id")

    # Méthode statique qui permet d'ajouter une mention intertextuelle à la BDD
    @staticmethod
    def ajout_mentions(ajout_mentions_book_id, ajout_is_mentioned_book_id, ajout_mentions_chapter,
                       ajout_mentions_comment):
        erreurs_mentions = []
        if not ajout_mentions_book_id:
            erreurs_mentions.append(
                "Veuillez renseigner l'oeuvre qui contient la mention intertextuelle.")
        if not ajout_is_mentioned_book_id:
            erreurs_mentions.append(
                "Veuillez renseigner l'oeuvre qui est référencée par cette mention intertextuelle.")

            # S'il y a au moins une erreur, afficher un message d'erreur.
        if len(erreurs_mentions) > 0:
            return False, erreurs_mentions

            # Création de la nouvelle oeuvre
        nouvelle_mention = Mentions(mentions_book_id=ajout_mentions_book_id,
                               is_mentioned_book_id=ajout_is_mentioned_book_id,
                               mentions_chapter=ajout_mentions_chapter,
                               mentions_comment=ajout_mentions_comment)

        # Tentative d'ajout qui sera stoppée si une erreur apparaît.
        try:
            db.session.add(nouvelle_mention)
            db.session.commit()
            return True, nouvelle_mention

        except Exception as erreur_mentions:
            return False, [str(erreur_mentions)]

    # Méthode statique permettant la suppression d'une mention intertextuelle
    @staticmethod
    def supprimer_inter(mentions_id):

        suppr_inter = Mentions.query.get(mentions_id)

        try:
            db.session.delete(suppr_inter)
            db.session.commit()
            return True

        except Exception as erreur:
            return False, [str(erreur)]

# Modèle pour la table des auteur.rices
# Elle ne comprend pour le moment que Simone de Beauvoir, mais le modèle pourrait tre adapté
# (par la création d'une table de relation) pour inclure d'autres auteurs
class Writer(db.Model):
    writer_id = db.Column(db.Integer, unique=True, nullable=False, primary_key=True, autoincrement=True)
    writer_nom = db.Column(db.Text, nullable=False)
    writer_prenom = db.Column(db.Text)
    writer_naissance = db.Column(db.Integer)
    writer_mort = db.Column(db.Integer)
    writer_sameas = db.Column(db.Text)
    writer_description = db.Column(db.Text)
    authorships = db.relationship("Authorship", back_populates="writer")

    # prépare le format JSON pour l'API
    def writer_to_jsonapi(self):
        """ It ressembles a little JSON API format but it is not completely compatible

        :return:
        """
        return {
            "type": "writer",
            "id": self.writer_id,
            "attributes": {
                "nom": self.writer_nom,
                "prenom": self.writer_prenom,
                "date de naissance": self.writer_naissance,
                "date de mort": self.writer_mort,
                "uri": self.writer_sameas,
                "description": self.writer_description,
            },
            "links": {
                "self": url_for("auteur", writer_id=self.writer_id, _external=True),
                "json": url_for("api_writers_browse", writer_id=self.writer_id, _external=True)
            },
            "relationships": {
                 "editions": [
                     author.author_to_json()
                     for author in self.authorships
                 ]
            }
        }