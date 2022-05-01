BEGIN TRANSACTION;
DROP TABLE IF EXISTS `user`;
CREATE TABLE IF NOT EXISTS `user` (
	`user_id`	integer NOT NULL PRIMARY KEY AUTOINCREMENT,
	`user_nom`	VARCHAR( 45 ) NOT NULL,
	`user_login`	VARCHAR ( 45 ) NOT NULL,
	`user_email`	VARCHAR ( 45 ) NOT NULL,
	`user_password`	VARCHAR ( 100 ) NOT NULL
);
DROP TABLE IF EXISTS `type`;
CREATE TABLE IF NOT EXISTS `type` (
	`type_nom`	VARCHAR ( 45 ) NOT NULL PRIMARY KEY UNIQUE
);
DROP TABLE IF EXISTS `book`;
CREATE TABLE IF NOT EXISTS `book` (
	`book_id`	integer NOT NULL PRIMARY KEY AUTOINCREMENT,
	`book_nom`	TEXT NOT NULL,
	`book_date`	NUMERIC NOT NULL,
	`book_type`	VARCHAR ( 45 ) NOT NULL,
	`book_description` TEXT,
	FOREIGN KEY(book_type) REFERENCES type(type_nom)
);
DROP TABLE IF EXISTS `mentions`;
CREATE TABLE IF NOT EXISTS `mentions` (
	`mentions_id`	integer NOT NULL PRIMARY KEY AUTOINCREMENT,
	`mentions_book_id`	integer NOT NULL,
	`is_mentioned_book_id`	integer NOT NULL,
	`mentions_chapter`	TEXT,
	`mentions_comment`	TEXT,
	FOREIGN KEY(mentions_book_id) REFERENCES book(book_id),
	FOREIGN KEY(is_mentioned_book_id) REFERENCES book(book_id)
);
DROP TABLE IF EXISTS `writer`;
CREATE TABLE IF NOT EXISTS `writer` (
	`writer_id`	integer NOT NULL PRIMARY KEY AUTOINCREMENT,
	`writer_nom`	TEXT NOT NULL,
	`writer_prenom`	TEXT,
	`writer_naissance`	NUMERIC,
	`writer_mort`	NUMERIC,
	`writer_sameas`	TEXT,
	`writer_description`	TEXT
);
DROP TABLE IF EXISTS `authorship`;
CREATE TABLE IF NOT EXISTS `authorship` (
	`authorship_id`	integer NOT NULL PRIMARY KEY AUTOINCREMENT,
	`authorship_user_id`	integer NOT NULL,
	`authorship_book_id`	integer,
	`authorship_writer_id`	integer,
	`authorship_date`	DATETIME DEFAULT current_timestamp,
	FOREIGN KEY(authorship_user_id) REFERENCES user(user_id),
	FOREIGN KEY(authorship_writer_id) REFERENCES writer(writer_id),
	FOREIGN KEY(authorship_book_id) REFERENCES book(book_id)
);
COMMIT;

BEGIN TRANSACTION;

INSERT INTO `type` (`type_nom`) VALUES ('Récit autobiographique');
INSERT INTO `type` (`type_nom`) VALUES ('Roman');
INSERT INTO `type` (`type_nom`) VALUES ('Théâtre');
INSERT INTO `type` (`type_nom`) VALUES ('Essai philosophique');
INSERT INTO `type` (`type_nom`) VALUES ('Recueil de nouvelles');
INSERT INTO `type` (`type_nom`) VALUES ('Autre');

INSERT INTO `book` (`book_nom`, `book_date`, `book_type`, `book_description`) VALUES ('Mémoires d''une jeune fille rangée', '1958', 'Récit autobiographique', '"Je rêvais d''être ma propre cause et ma propre fin ; je pensais à présent que la littérature me permettrait de réaliser ce voeu. Elle m''assurerait une immortalité qui compenserait l''éternité perdue ; il n''y avait plus de Dieu pour m''aimer, mais je brûlerais dans des millions de coeurs. En écrivant une oeuvre nourrie de mon histoire, je me créerais moi-même à neuf et je justifierais mon existence. En même temps, je servirais l''humanité : quel plus beau cadeau lui faire que des livres ? Je m''intéressais à la fois à moi et aux autres ; j''acceptais mon "incarnation" mais je ne voulais pas renoncer à l''universel : ce projet conciliait tout ; il flattait toutes les aspirations qui s''étaient développées en moi au cours de ces quinze années".');
INSERT INTO `book` (`book_nom`, `book_date`, `book_type`, `book_description`) VALUES ('La Force de l''âge', '1960', 'Récit autobiographique', 'Sa réussite au concours de l''agrégation marque pour Simone de Beauvoir la fin de l''existence étroite et dépendante qu''elle a relatée dans Les mémoires d''une jeune fille rangée. Elle est désormais libre de vivre à sa guise et d''explorer ce monde des adultes qu''elle connaît si peu et si mal. Elle a rencontré Jean-Paul Sartre et désormais leurs existences sont liées. Sur le fonds orageux de l''entre-deux-guerres, dix ans passent à l''apprentissage de la vie. Découvertes, amitiés, voyages et premiers essais d''écrivain. Puis 1939 amorce une nouvelle période où va prédominer l''engagement historique et littéraire. C''est sur l''apothéose de la Libération de Paris que s''achève cette chronique de quinze années, celles de La force de l''âge pour deux êtres exceptionnels.');
INSERT INTO `book` (`book_nom`, `book_date`, `book_type`, `book_description`) VALUES ('La Force des choses', '1963', 'Récit autobiographique', '"Peu de temps après le jour V, je passai une nuit très gaie avec Camus, Chauffard, Loleh Bellon, Vitold, et une ravissante Portugaise qui s''appelait Viola. D''un bar de Montparnasse qui venait de fermer, nous descendîmes vers l''hôtel de la Louisiane ; Loleh marchait pieds nus sur l''asphalte, elle disait : "C''est mon anniversaire, j''ai vingt ans." Nous avons acheté des bouteilles et nous les avons bues dans la chambre ronde ; la fenêtre était ouverte sur la douceur de mai et des noctambules nous criaient des mots d''amitié ; pour eux aussi, c''était le premier printemps de paix." Simone de Beauvoir, née en 1908 à Paris, a raconté son enfance et son adolescence dans Mémoires d''une jeune fille rangée, sa vie à Paris, ses débuts d''écrivain, la guerre et l''Occupation dans La force de l''âge. La troisième partie de ses souvenirs, La force des choses, commence dans le Paris de la Libération.');
INSERT INTO `book` (`book_nom`, `book_date`, `book_type`, `book_description`) VALUES ('Une mort très douce', '1964', 'Récit autobiographique', 'La journée du mardi se passa bien. La nuit, maman fit des cauchemars. "On me met dans une boîte", disait-elle à ma soeur. "Je suis là, mais je suis dans la boîte. Je suis moi, et ce n''est plus moi. Des hommes emportent la boîte !" Elle se débattait : "Ne les laisse pas m''emporter !" Longtemps Poupette a gardé la main posée sur son front : "Je te promets. Ils ne te mettront pas dans la boîte." Elle a réclamé un supplément d''Equanil. Sauvée enfin de ses visions, maman l''a interrogée : "Mais qu''est-ce que ça veut dire, cette boîte, ces hommes ? - Ce sont des souvenirs de ton opération ; des infirmiers t''emportent sur un brancard." Maman s''est endormie. ');
INSERT INTO `book` (`book_nom`, `book_date`, `book_type`, `book_description`) VALUES ('Tout compte fait', '1972', 'Récit autobiographique', 'Dissiper les mystifications, dire la vérité, c''est un des buts que j''ai le plus obstinément poursuivis à travers mes livres. Cet entêtement à ses racines dans mon enfance ; je haïssais ce que nous appelions ma sœur et moi la "bêtise" : une manière d''étouffer la vie et ses joies sous des préjugés, des routines, des faux-semblants, des consignes creuses. J''ai voulu échapper à cette oppression, je me suis promis de la dénoncer. ');
INSERT INTO `book` (`book_nom`, `book_date`, `book_type`, `book_description`) VALUES ('La Cérémonie des adieux', '1991', 'Récit autobiographique', '«"Alors, c''est la cérémonie des adieux ?" m''a dit Sartre, comme nous nous quittions pour un mois, au début de l''été. J''ai pressenti le sens que devaient prendre un jour ces mots. La cérémonie a duré dix ans : ce sont ces dix années que je raconte dans ce livre.»');
INSERT INTO `book` (`book_nom`, `book_date`, `book_type`, `book_description`) VALUES ('L''invitée', '1943', 'Roman', 'Je me sens coupable, dit-il. Je me suis reposé bêtement sur les bons sentiments que cette fille me porte, mais ce n''est pas d''une moche petite tentative de séduction qu''il s''agissait. Nous voulions bâtir un vrai trio, une vie à trois bien équilibrée ou personne ne se serait sacrifié : c''était peut-être une gageure, mais au moins ça méritait d''être essayé ! Tandis que si Xavière se conduit comme une petite garce jalouse, si tu es une pauvre victime pendant que je m''amuse à faire le joli coeur, notre histoire devient ignoble. ');
INSERT INTO `book` (`book_nom`, `book_date`, `book_type`, `book_description`) VALUES ('Le sang des autres', '1945', 'Roman', 'Quand il ouvrit la porte, tous les yeux se tournèrent vers lui. - Que me voulez-vous ? Dit-il. Laurent était assis à califourchon sur une chaise devant le feu. - Il faut que je sache si c''est décidé ou non pour demain matin, dit Laurent. Demain. Il regarda autour de lui. La pièce sentait la lessive et la soupe aux choux. Madeleine fumait, les coudes sur la nappe. Denise avait un livre devant elle. Ils étaient vivants. Pour eux, cette nuit aurait une fin ; il y aurait une aube...');
INSERT INTO `book` (`book_nom`, `book_date`, `book_type`, `book_description`) VALUES ('Tous les hommes sont mortels', '1946', 'Roman', 'Si l''on nous offrait l''immortalité sur la terre, qui est-ce qui accepterait ce triste présent ? demande Jean-Jacques Rousseau dans l’Émile. Ce livre est l''histoire d''un homme qui a accepté. ');
INSERT INTO `book` (`book_nom`, `book_date`, `book_type`, `book_description`) VALUES ('Les Mandarins', '1954', 'Roman', 'On a toujours embarrassé les écrivains en leur demandant : pourquoi écrivez-vous ? Mais jamais sans doute ne se sont-ils sentis aussi perplexes qu''au lendemain de la dernière guerre. Étonnés par quatre années d''horreur et les perspectives qui s''ouvraient soudain au monde, ils découvraient que les vieilles valeurs avaient fait long feu et qu''une nouvelle figure de l''homme était en train de naître : quel rôle l''avenir leur réservait-il ? les mots pouvaient-ils encore servir ? à qui ? pour quoi ? Entre le nihilisme, l''esthétisme, l''action politique, où se situait la littérature ? Ce livre n''apporte aucune réponse à ces questions : c''est un roman. Il relate seulement l''histoire de gens qui se les sont posées. On dit volontiers que les écrivains ne sont pas des personnages romanesques : pourtant les aventures de la pensée sont aussi réelles que les autres et elles mettent en jeu l''individu tout entier ; pourquoi ne tenterait-on pas de les raconter ? L''expérience dont ce livre rend compte a été concrètement vécue par bon nombre d''intellectuels français ; entre ceux-ci et les héros des Mandarins, il y a donc identité de situation : c''est la seule clef que ce livre comporte. Le lecteur se tromperait fort s''il prétendait en trouver d''autres.');
INSERT INTO `book` (`book_nom`, `book_date`, `book_type`, `book_description`) VALUES ('Les Belles Images', '1966', 'Roman', '" Non ", elle a crié tout haut. Pas Catherine. Je ne permettrai pas qu''on lui fasse ce qu''on m''a fait. Qu''a-t-on fait de moi ? Cette femme qui n''aime personne, insensible aux beautés du monde, incapable même de pleurer, cette femme que je vomis. Catherine : au contraire lui ouvrir les yeux tout de suite et peut-être un rayon de lumière filtrera jusqu''à elle, peut-être elle s''en sortira... De quoi ? De cette nuit. De l''ignorance, de l''indifférence. ');
INSERT INTO `book` (`book_nom`, `book_date`, `book_type`, `book_description`) VALUES ('Les Inséparables', '2020', 'Roman', 'Ecrite en 1954, cette nouvelle d''inspiration autobiographique raconte l''amitié intense entre Sylvie et Andrée, dite Zaza. Les deux filles se sont connues et appréciées dès leur première rencontre sur les bancs de l''école et ne se sont plus quittées jusqu''à la mort d''Andrée. ');
INSERT INTO `book` (`book_nom`, `book_date`, `book_type`, `book_description`) VALUES ('Les Bouches inutiles', '1958', 'Théâtre', 'Les Bouches inutiles est l''unique pièce de théâtre de Simone de Beauvoir, écrite vers 1944 et publiée le 7 décembre 1945 aux éditions Gallimard. Elle est constituée de deux actes et de huit tableaux.');
INSERT INTO `book` (`book_nom`, `book_date`, `book_type`, `book_description`) VALUES ('La Femme Rompue', '1967', 'Recueil de nouvelles', '"- Dis-moi pourquoi tu rentres si tard. Il n''a rien répondu. - Vous avez bu ? Joué au poker ? Vous êtes sortis ? Tu as oublié l''heure ? Il continuait à se taire, avec une espèce d''insistance, en faisant tourner son verre entre ses doigts. J''ai jeté par hasard des mots absurdes pour le faire sortir de ses gonds et lui arracher une explication : - Qu''est-ce qui se passe ? Il y a une femme dans ta vie ?Sans me quitter des yeux, il a dit : - Oui, Monique, il y a une femme dans ma vie."');
INSERT INTO `book` (`book_nom`, `book_date`, `book_type`, `book_description`) VALUES ('Quand prime le spirituel', '1979', 'Recueil de nouvelles', 'Dans La Force de l''âge, Simone de Beauvoir a raconté comment, de 1935 à 1937, elle a écrit Quand prime le spirituel, son premier livre, resté inédit jusqu''à ce jour. "Je résolus cette fois de composer des récits brefs [...] je me limiterais aux choses, aux gens que je connaissais ; j''essaierais de rendre sensible une vérité que j''avais personnellement éprouvée [...] j''indiquai le thème par un titre ironiquement emprunté à Maritain. La première nouvelle décrit l''étiolement d''une jeune fille à l''institut Sainte-Marie. Dans la seconde, je m''amusais à imaginer, chez une adulte, la dégradation de la religiosité en chiennerie. Dans la troisième, l''héroïne, par son entêtement à jouer un rôle, jetait dans des désastres deux jeunes élèves qui l''admiraient [...] j''avais réussi à rendre cette distance de soi à soi qu''est la mauvaise foi. Dans la quatrième, je tentai à nouveau de ressusciter Zaza [...] J''échouai [...] Cinquième nouvelle : [...] une satire de ma jeunesse. [...] mon enfance au cours Désir et la crise religieuse de mon adolescence. [...] Ce récit était de loin le meilleur [...] "Sartre en approuva de nombreux passages."');
INSERT INTO `book` (`book_nom`, `book_date`, `book_type`, `book_description`) VALUES ('Pyrrhus et Cinéas', '1944', 'Essai philosophique', 'Plutarque raconte qu''un jour Pyrrhus faisait des projets de conquête. ');
INSERT INTO `book` (`book_nom`, `book_date`, `book_type`, `book_description`) VALUES ('Pour une morale de l''ambiguïté', '1947', 'Essai philosophique', 'Insérer ici une description');
INSERT INTO `book` (`book_nom`, `book_date`, `book_type`, `book_description`) VALUES ('Le Deuxième Sexe', '1949', 'Essai philosophique', 'Les hommes d''aujourd''hui semblent ressentir plus vivement que jamais le paradoxe de leur condition. Ils se reconnaissent pour la fin suprême à laquelle doit se subordonner toute action : mais les exigences de l''action les acculent à se traiter les uns les autres comme des instruments ou des obstacles : des moyens [...] Chacun d''entre eux a sur les lèvres le goût incomparable de sa propre vie, et cependant chacun se sent plus insignifiant qu''un insecte au sein de l''immense collectivité dont les limites se confondent avec celles de la terre ; à aucune époque peut-être ils n''ont manifesté avec plus d''éclat leur grandeur, à aucune époque cette grandeur n''a été si atrocement bafouée. Malgré tant de mensonges têtus, à chaque instant, en toute occasion, la vérité se fait jour : la vérité de la vie et de la mort, de ma solitude et de ma liaison au monde, de ma liberté et de ma servitude, de l''insignifiance et de la souveraine importance de chaque homme et de tous les hommes [...] Puisque nous ne réussissons pas à la fuir, essayons donc de regarder en face la vérité. Essayons d''assumer notre fondamentale ambiguïté. C''est dans la connaissance des conditions authentiques de notre vie qu''il nous faut puiser la force de vivre et des raisons d''agir.');
INSERT INTO `book` (`book_nom`, `book_date`, `book_type`, `book_description`) VALUES ('La Vieillesse', '1970', 'Essai philosophique', 'Les vieillards sont-ils des hommes ? À voir la manière dont notre société les traite, il est permis d''en douter. Elle admet qu''ils n''ont ni les mêmes besoins ni les mêmes droits que les autres membres de la collectivité puisqu''elle leur refuse le minimum que ceux-ci jugent nécessaire ; elle les condamne délibérément à la misère, aux taudis, aux infirmités, à la solitude, au désespoir. ');
INSERT INTO `book` (`book_nom`, `book_date`, `book_type`, `book_description`) VALUES ('La Longue Marche', '1957', 'Essai philosophique', '"Ce livre n''est pas un reportage : le reporter explore un présent stable, dont les éléments plus ou moins contingents se servent réciproquement de clés. En Chine, aujourd''hui, rien n''est contingent ; chaque chose tire son sens de l''avenir qui leur est commun à toutes ; le présent se définit par le passé qu''il dépasse et les nouveautés qu''il annonce : on le dénaturerait si on le considérait comme arrêté. Il n''est qu''une étape de cette "longue marche" qui achemine pacifiquement la Chine de la révolution démocratique à la révolution socialiste. Il ne suffit donc pas de le décrire : il faut l''expliquer. C''est à quoi je me suis efforcée. Certes, je ne tiens pas du tout pour négligeable ce qu''au cours d''un voyage de six semaines j''ai pu voir de mes yeux : se promener dans une rue, c''est une expérience irrécusable, irremplaçable, qui en enseigne plus long sur une ville que les plus ingénieuses hypothèses. Mais toutes les connaissances acquises sur place par des visites, conférences, conversations, etc., j''ai tenté de les éclairer à la lumière de la Chine d''hier, et dans la perspective de ses transformations futures. C''est seulement quand on le saisit dans son devenir que ce pays apparaît sous un jour véritable : ni paradis, ni infernale fourmilière, mais une région bien terrestre, où des hommes qui viennent de briser le cycle sans espoir d''une existence animale luttent durement pour édifier un monde humain." ');
INSERT INTO `book` (`book_nom`, `book_date`, `book_type`, `book_description`) VALUES ('Faut-il brûler Sade ?', '1972', 'Essai philosophique', 'Comment les privilégiés peuvent-ils penser leur situation ? L''auteur étudie trois cas : les rapports de l''intellectuel avec la classe dominante, l''idéologie de la droite d''aujourd''hui et, en analysant son oeuvre, l''échec de Sade dans sa recherche d''une synthèse impossible entre deux classes, entre le rationalisme des philosophes bourgeois et les privilèges de la noblesse. Les privilèges sont toujours égoïste nous montre Simone de Beauvoir, et il est impossible de les légitimer aux yeux de tous. Or, la pensée vise toujours l''universalité.');
INSERT INTO `book` (`book_nom`, `book_date`, `book_type`, `book_description`) VALUES ('L''Amérique au jour le jour', '1948', 'Autre', '"J''ai passé quatre mois en Amérique : c''est peu ; en outre j''ai voyagé pour mon plaisir et au hasard des occasions ; il y a d''immenses zones du nouveau monde sur lesquelles je n''ai pas eu la moindre échappée ; en particulier, j''ai traversé ce grand pays industriel sans visiter ses usines, sans voir ses réalisations techniques, sans entrer en contact avec la classe ouvrière. Je n''ai pas pénétré non plus dans les hautes sphères où s''élaborent la politique et l''économie des U.S.A. Cependant, il ne me paraît pas inutile, à côté des grands tableaux en pied que de plus compétents ont tracés, de raconter au jour le jour comment l''Amérique s''est dévoilée à une conscience : la mienne." J''ai adopté la forme d''un journal, [...] j''ai respecté l''ordre chronologique des mes étonnements, de mes admirations, de mes indignations, mes hésitations, mes erreurs. [...] Voilà ce que j''ai vu et comment je l''ai vu ; je n''ai pas essayé d''en dire davantage."');

INSERT INTO `writer` (`writer_nom`, `writer_prenom`, `writer_naissance`, `writer_mort`, `writer_sameas`, `writer_description`) VALUES ('de Beauvoir', 'Simone', '1908/01/09', '1986/04/14', 'https://data.bnf.fr/fr/11890854/simone_de_beauvoir/', 'Simone de Beauvoir est une femme de lettres, entre autres philosophe, romancière et mémorialiste.');

INSERT INTO `mentions` (`mentions_book_id`, `is_mentioned_book_id`, `mentions_chapter`, `mentions_comment`) VALUES (2, 8, 'Partie II, Chapitre VI', 'A propos des personnages.'),
(2, 8, 'Partie II, Chapitre VII', 'A propos de ses sources d''inspiration pour les personnages, de ses volontés d''écriture, de son regard critique sur cette oeuvre.'),
(2, 16, 'Partie II, Chapitre VII', 'Commentaires sur les raisons de l''écriture de Pyrrhus et Cinéas.'),
(2, 18, 'Partie II, Chapitre V', 'Sur les présumées contradictions entre le Deuxième Sexe et ses mémoires.'),
(2, 7, 'Partie II, Chapitre V', 'Sur ses hésitations scénaristiques, ses choix esthétiques. Regard critique.'),
(2, 7, 'Partie II, Introduction', 'A propos de son processus d''écriture.'),
(2, 7, 'Partie II, Chapitre VII', 'A propos de l''acceptation de l''Invitée par Gallimard, et du choix du titre.'),
(2, 7, 'Partie II, Chapitre VI', 'Sur la ressemblance de sujet avec les Monstres Sacrés de Cocteau.'),
(2, 7, 'Partie II, Chapitre VIII', 'Sur la réception de L''Invitée.'),
(2, 13, 'Partie II, Chapitre VIII', 'Sur ses volontés stylistiques, l''émergence du theme. Critique sur son travail.'),
(2, 9, 'Partie II, Chapitre VIII', 'A propos du thème de Tous les hommes sont mortels.'),
(3, 2, 'Introduction', 'Reconnait des erreurs au sein de La Force de l''âge'),
(3, 16, 'Première partie, Chapitre premier', 'Sur la sortie de Pyrrhus et Cinéas dans le contexte de la Libération.'),
(3, 9, 'Première partie, Chapitre premier', 'Sur son processus de travail pour Tous les hommes sont mortels.'),
(3, 10, 'Première partie, Chapitre premier', 'Sur ses inspirations tirées de ses expériences personnelles pour Les Mandarins.'),
(3, 8, 'Première partie, Chapitre II', 'Sur la réception de l''oeuvre.'),
(3, 22, 'Première partie, Chapitre III', 'Sur sa volonté d''écrire sur l''Amérique.'),
(3, 10, 'Première partie, Chapitre III', 'Raconte des épisodes de sa vie qui lui ont inspiré des passages des Mandarins.'),
(3, 18, 'Première partie, Chapitre IV', 'Sur la réception du Deuxième Sexe.'),
(3, 20, 'Première partie, Chapitre IV', 'Sur le contenu de l''oeuvre.'),
(3, 10, 'Première partie, Chapitre V', 'Sur la réception des Mandarins.'),
(3, 10, 'Intermède', 'Sur les thèmes des Mandarins et la réception du roman par les critiques.'),
(3, 10, 'Deuxième partie, Chapitre VI', 'Sur la sortie des Mandarins et la réception du Goncourt.'),
(3, 1, 'Deuxième partie, Chapitre VIII', 'Sur ses volontés de raconter son enfance.'),
(3, 1, 'Epilogue', 'Sur des réflexions de Sartre qu''elle a retrouvé dans ses Mémoires.'),
(5, 19, 'Prologue', 'Sur la réception de son essai et les conséquences sur sa volonté de continuer ses Mémoires.'),
(5, 14, 'Chapitre premier', 'Sur les illustrations de l''oeuvre.'),
(5, 4, 'Chapitre II', 'Sur la parution de l''oeuvre.');

INSERT INTO `user` (`user_nom`, `user_login`, `user_email`, `user_password`) VALUES ('Administrator', 'admin', 'admin@supersite.com', '5e884898da28047151d0e56f8dc6292773603d0d6aabbdd62a11ef721d1542d8');

COMMIT;