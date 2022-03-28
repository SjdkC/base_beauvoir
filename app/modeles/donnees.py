from flask import url_for
import datetime

from .. app import db

#Moddèle pour la table de relation de création / modification de contenu
class Authorship(db.Model):
    __tablename__ = "authorship"
    authorship_id = db.Column(db.Integer, nullable=True, autoincrement=True, primary_key=True)
    authorship_book_id = db.Column(db.Integer, db.ForeignKey('book.book_id'))
    authorship_user_id = db.Column(db.Integer, db.ForeignKey('user.user_id'))
    authorship_date = db.Column(db.DateTime, default=datetime.datetime.utcnow)
    user = db.relationship("User", back_populates="authorships")
    book = db.relationship("Book", back_populates="authorships")

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
                "name": self.book_nom,
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
