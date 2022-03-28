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

class Type(db.Model):
    type_nom = db.Column(db.Text, unique=True, nullable=False, primary_key=True)
    boook = db.relationship("Book", back_populates="has_type")

# On crée notre modèle
class Book(db.Model):
    book_id = db.Column(db.Integer, unique=True, nullable=False, primary_key=True, autoincrement=True)
    book_nom = db.Column(db.Text, nullable=False)
    book_date = db.Column(db.Integer, nullable=False)
    book_type = db.Column(db.Text, db.ForeignKey("type.type_nom"))
    book_description = db.Column(db.Text)
    authorships = db.relationship("Authorship", back_populates="book")
    has_type = db.relationship("Type", back_populates="boook")

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

class Writer(db.Model):
    writer_id = db.Column(db.Integer, unique=True, nullable=False, primary_key=True, autoincrement=True)
    writer_nom = db.Column(db.Text, nullable=False)
    writer_prenom = db.Column(db.Text)
    writer_naissance = db.Column(db.Integer)
    writer_mort = db.Column(db.Integer)
    writer_sameas = db.Column(db.Text)
    writer_description = db.Column(db.Text)
    authorships = db.relationship("Authorship", back_populates="writer")

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
                "json": url_for("api_writers_single", writer_id=self.writer_id, _external=True)
            },
            "relationships": {
                 "editions": [
                     author.author_to_json()
                     for author in self.authorships
                 ]
            }
        }
