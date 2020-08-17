# Comment rédiger de la documentation

## Les règles de structuration des dossiers et fichiers

L'ensemble de la documentation publiée se trouve sous le dossier `docs` à la base du projet.

Le premier niveau de dossier donnera le premier niveau de navigation et si la feature `tabs` est activée dans le fichier `mkdocs.yml`, ce premier niveau est extrait pour afficher la navigation comme liens dans l'entête du site.

![navigation](./assets/images/redaction/capture_site.png)

Le nom du dossier est utilisé pour la navigation sauf si un fichier `.pages` (fichier yaml) dans ce dossier, apporte un changement du titre.

Le fichier `.pages` peut également définir l'ordre d'affichage des pages et dossiers dans la navigation (attribut `arrange` dans ce fichier).

Chaque dossier qui publiera de la documentation, devra avoir un fichier `index.md`. Cela produira le fichier `index.html` du dossier.

![structure fichiers](./assets/images/redaction/structure_fichiers.png)

## La syntaxe Markdown utilisable avec l'image mkdocs utilisée

### Titres

Les titres sont constitués de 1 à 6 `#` suivi d'un espace puis du texte (`<h1>` à `<h6>` en HTML).

Usuellement il n'y a qu'un titre de niveau 1 car utilisé en titre de document.
Le titre de niveau 1 est exclus de la table des matières (titre de document)

### Les styles

**Mettre en gras** : `**texte**`

_Italique_ : `_texte_`

**_Gras et italique_** : `**_texte_**`

^^souligné^^ : ` ^^texte^^ `  (via l'extension PyMdown.caret)

{==surligné le texte==} : ` {== texte ==} ` (via l'extension PyMdown.critic)

### Listes

Les listes ordonnées et non-ordonnées commencent au premier caractère du niveau d'indentation.

Pour descendre de niveau, ajoutez une indentation de 4 espaces.

#### Liste non-ordonnée (à puces)

```
- item 1
- item 2
    - item 2.1
    - item 2.2
        - item 2.2.1
```

- item 1
- item 2
    - item 2.1
    - item 2.2
        - item 2.2.1

#### Liste ordonnée

```
1. item 1
1. item 2
    1. item 2.1
    1. item 2.2
        1. item 2.2.1
```

1. item 1
1. item 2
    1. item 2.1
    1. item 2.2
        1. item 2.2.1

#### Listes de tâches

```
- [X] item 1
    - [X] item A
    - [ ] item B
        more text
        - [x] item a
        - [ ] item b
        - [x] item c
    - [X] item C
- [ ] item 2
- [ ] item 3
```

- [X] item 1
    - [X] item A
    - [ ] item B
        more text
        - [x] item a
        - [ ] item b
        - [x] item c
    - [X] item C
- [ ] item 2
- [ ] item 3

### Séparateur horizontal

En mettant 3 `-` consécutifs seuls sur une ligne, on obtient une ligne (`<hr />` en HTML)

```
---
```

---

### Les tableaux

```
| First Header | Second Header | Third Header |
| ------------ | ------------- | ------------ |
| Content Cell | Content Cell  | Content Cell |
| Content Cell | Content Cell  | Content Cell |
```

| First Header | Second Header | Third Header |
| ------------ | ------------- | ------------ |
| Content Cell | Content Cell  | Content Cell |
| Content Cell | Content Cell  | Content Cell |

ou bien en ajoutant des `:` aux bons endroits :

```
| First Header | Second Header | Third Header |
| :----------- | :-----------: | -----------: |
| Left         |    Center     |        Right |
| Left         |    Center     |        Right |
```

| First Header | Second Header | Third Header |
| :----------- | :-----------: | -----------: |
| Left         |    Center     |        Right |
| Left         |    Center     |        Right |

### Les blocs de code

Pour les extraits multi-lignes de code, utilisez ` ``` ` avant et après le bloc de code.

Pour activer la colorisation syntaxique en fonction d'un langage, vous pouvez spécifier le langage de la colorisation sur les ` ``` ` d'ouverture du bloc de code.

Une ligne vide doit être ajoutée avant les ` ``` ` d'ouverture et après les ` ``` ` de fermeture.

```
    ```options
    def fn():
        pass
    ```
```

`options` peut être vide, contenir :

- le nom du langage (ex: `yaml`)pour la colorisation syntaxique,
- des options comme `hl_lines="1 2"` pour surligner les lignes 1 et 2 du bloc de code,
- ou bien `linenums="num"` pour afficher les numéros de lignes du bloc du code (en partant de `num`).

```
    ```bash linenums="1"
    #!/bin/bash

    ## Handle function ##
    # Function executed 120s before the end of the time limit
    sig_handler_USR1()
    {
            echo "   function sig_handler_USR1 called"
            # do whatever cleanup you want here
            echo "   Signal trapped -  `date`"
            # Do what you want :
            #    save data ...
            #    cleanup ...
            #    requeue job ...
            #    send signal to MPI job ...
            exit 2
    }
    ```
```

```bash linenums="1" hl_lines="3 5"
#!/bin/bash

## Handle function ##
# Function executed 120s before the end of the time limit
sig_handler_USR1()
{
        echo "   function sig_handler_USR1 called"
        # do whatever cleanup you want here
        echo "   Signal trapped -  `date`"
        # Do what you want :
        #    save data ...
        #    cleanup ...
        #    requeue job ...
        #    send signal to MPI job ...
        exit 2
}
```

### Les inline code

Afin de mettre en avant les chemins/noms de fichiers, ..., utilisez la syntaxe suivante :

```
`/home/projet/user/file` est le chemin vers le fichier spécifié
```

`/home/projet/user/file` est le chemin vers le fichier spécifié

On peut aussi utiliser les inline code pour mettre en avant l'intitulé d'un champ, une valeur ou une commande (une ligne)

```
- `Start Jabber Video when I log on to my computer` : doit être décoché
- IPv4 : `195.221.21.72`
- **Syntaxe en ligne de commande** : `ssh login@myria.criann.fr`
```

- `Start Jabber Video when I log on to my computer` : doit être décoché
- IPv4 : `195.221.21.72`
- **Syntaxe en ligne de commande** : `ssh login@myria.criann.fr`

### Les liens hypertexte et images

Le format des liens :

```
[texte affiché](url pointé)
```

Une variante lorsque le texte à afficher doit être égal à l'URL pointé :

```
<url>
```

Le format pour les images :

```
![texte affiché si url inaccessible](url image)
```

Pour appliquer du style, soit utiliser un fichier CSS de personnalisation du site soit écrire en HTML avec la balise `<img src="..." style="..."></img>`.

### Les blocs de notifications

Il est possible de mettre des blocs de notifications avec titre optionnel afin de porter une attention particulière à un message.

Les types supportés :

- `attention`
- `caution`
- `danger`
- `error`
- `hint`
- `important`
- `note`
- `tip`
- `warning`

```
!!! type "optional title"
    first line of text [insert 2 whitespace at the end of the line to force ligne break]  
    another line[insert 2 whitespace at the end of the line to force ligne break]  
    every line should start with a 4-space indent
```

!!! attention
    first line of text [insert 2 whitespace at the end of the line to force ligne break]  
    another line[insert 2 whitespace at the end of the line to force ligne break]  
    every line should start with a 4-space indent

Une variante est le bloc dépliable

```
??? type "optional title"
    first line of text [insert 2 whitespace at the end of the line to force ligne break]  
    another line[insert 2 whitespace at the end of the line to force ligne break]  
    every line should start with a 4-space indent
```

??? note "Une note"
    first line of text [insert 2 whitespace at the end of the line to force ligne break]  
    another line[insert 2 whitespace at the end of the line to force ligne break]  
    every line should start with a 4-space indent

Si vous souhaitez que le bloc soit par défaut déplié :

```
???+type "optional title"
    first line of text [insert 2 whitespace at the end of the line to force ligne break]  
    another line [or add an empty line]
    
    every line should start with a 4-space indent
```

???+success
    first line of text [insert 2 whitespace at the end of the line to force ligne break]  
    another line [or add an empty line]
    
    every line should start with a 4-space indent

### Les icônes et smileys

Il existe un panel d'icône et smiley inclus de base avec l'extension pymdown [Emoji](https://squidfunk.github.io/mkdocs-material/setup/changing-the-logo-and-icons/#additional-icons)

```
- :material-material-design: – [Material Design](https://materialdesignicons.com/)
- :fontawesome-brands-font-awesome-flag: – [FontAwesome](https://fontawesome.com/icons?d=gallery&m=free)
- :octicons-mark-github-16: – [Octicons](https://octicons.github.com/)
```

- :material-material-design: – [Material Design](https://materialdesignicons.com/)
- :fontawesome-brands-font-awesome-flag: – [FontAwesome](https://fontawesome.com/icons?d=gallery&m=free)
- :octicons-mark-github-16: – [Octicons](https://octicons.github.com/)

### Les extensions du langage markdown qui sont possibles

Certaines extensions et quelques plugins ont été activés pour étendre le langage et ajouter des fonctions de rendus intéressantes.

Pour voir la liste des extensions et plugins activéés, voir le fichier `mkdocs.yml`

- <https://squidfunk.github.io/mkdocs-material/extensions/admonition/>
- <https://facelessuser.github.io/pymdown-extensions/>
- <https://github.com/ignorantshr/mkdocs-add-number-plugin>
- <https://pypi.org/project/mkdocs-git-revision-date-localized-plugin/>
- <https://pypi.org/project/mkdocs-macros-plugin/>
- <https://github.com/pugong/mkdocs-mermaid-plugin>
    - <https://mermaid-js.github.io/mermaid/#/>
- <https://github.com/byrnereese/mkdocs-minify-plugin>
- <https://github.com/lukasgeiter/mkdocs-awesome-pages-plugin>
