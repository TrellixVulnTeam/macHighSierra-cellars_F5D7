��    3      �  G   L      h  E  i     �  6   �     �          )  1   ?  @   q  D   �  <   �  F   4     {  "   �  %   �  /   �  E        V  2   v  R   �  &   �     #	  l  C	  (   �  $   �  w  �     v  )   �     �  >   �  #     ,   '     T  �   p  &        .     C  !   V     x  &   �  2   �  "   �  '     #   .  *   R     }     �  J   �               5  �  L  m  �     M  :   f      �     �     �  .   �  _     i   {  @   �  h   &  #   �  ,   �  1   �  >     T   Q  4   �  <   �  g     2   �  &   �  �  �  7   �  4   �  �  �     �   =   �      �   X   !  7   m!  4   �!  #   �!  �   �!  1   �"     �"     �"  +   �"      #  )   5#  H   _#  /   �#  0   �#  =   	$  >   G$  &   �$  #   �$  W   �$     )%  !   =%     _%         1   )   #                    *   
   &   /            '             $   0      -              	       (   ,   3                                                  "                2           %   +          .                      !                      The defaults for the @if... conditionals depend on the output format:
  if generating HTML, --ifhtml is on and the others are off;
  if generating Info, --ifinfo is on and the others are off;
  if generating plain text, --ifplaintext is on and the others are off;
  if generating XML, --ifxml is on and the others are off.
 %c%s expected braces %c%s expects a single character `i' or `j' as argument %c%s missing close brace %c%s requires a name %cend macro not found %s requires an argument: the formatter for %citem %s: --footnote-style arg must be `separate' or `end', not `%s'.
 %s: --paragraph-indent arg must be numeric/`none'/`asis', not `%s'.
 %s: Ignoring unrecognized TEXINFO_OUTPUT_FORMAT value `%s'.
 %s: Removing output file `%s' due to errors; use --force to preserve.
 %s: missing file argument.
 %s:%d: --css-file ended in comment @%s not meaningful inside `@%s' block @%s not meaningful outside `@float' environment @%s not meaningful outside `@titlepage' and `@quotation' environments @image file `%s' unreadable: %s @sp requires a positive numeric argument, not `%s' @strong{Note...} produces a spurious cross-reference in Info; reword to avoid that Bad argument `%s' to `@%s', using `%s' Can't create directory `%s': %s Conditional processing in input:
  --ifdocbook       process @ifdocbook and @docbook even if
                      not generating Docbook.
  --ifhtml          process @ifhtml and @html even if not generating HTML.
  --ifinfo          process @ifinfo even if not generating Info.
  --ifplaintext     process @ifplaintext even if not generating plain text.
  --iftex           process @iftex and @tex; implies --no-split.
  --ifxml           process @ifxml and @xml.
  --no-ifdocbook    do not process @ifdocbook and @docbook text.
  --no-ifhtml       do not process @ifhtml and @html text.
  --no-ifinfo       do not process @ifinfo text.
  --no-ifplaintext  do not process @ifplaintext text.
  --no-iftex        do not process @iftex and @tex text.
  --no-ifxml        do not process @ifxml and @xml text.

  Also, for the --no-ifFORMAT options, do process @ifnotFORMAT text.
 Entry for index `%s' outside of any node Footnote defined without parent node Input file options:
      --commands-in-node-names  allow @ commands in node names.
  -D VAR                        define the variable VAR, as with @set.
  -I DIR                        append DIR to the @include search path.
  -P DIR                        prepend DIR to the @include search path.
  -U VAR                        undefine the variable VAR, as with @clear.
 Misplaced %c Must be in `@%s' environment to use `@%s' No matching `%cend %s' Node `%s' lacks menu item for `%s' despite being its Up target Reached eof before matching @end %s Too many columns in multitable item (max %d) Too many errors!  Gave up.
 Translate Texinfo source documentation to various other formats, by default
Info files suitable for reading online with Emacs or standalone GNU Info.
 Try `%s --help' for more information.
 Unknown command `%s' Unknown index `%s' Unknown index `%s' in @printindex Unmatched `%c%s' Usage: %s [OPTION]... TEXINFO-FILE...
 Use braces to give a command as an argument to @%s `@end' expected `%s', but saw `%s' here is the previous definition of `%s' ignoring @tab outside of multitable ignoring stray text `%s' after @multitable macro `%s' previously defined mismatched @end %s with @%s perhaps your @top node should be wrapped in @ifnottex rather than @ifinfo? undefined flag: %s unrecognized encoding name `%s' unreferenced node `%s' Project-Id-Version: texinfo 4.7.90
Report-Msgid-Bugs-To: bug-texinfo@gnu.org
POT-Creation-Date: 2010-07-01 00:03+0200
PO-Revision-Date: 2004-12-06 08:00-05:00
Last-Translator: Laurent Bourbeau <bourbeau@progiciels-bpi.ca>
Language-Team: French <traduc@traduc.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8-bit
Plural-Forms: nplurals=2; plural=(n > 1);
 Les valeurs par d�faut pour le @if... conditionnels d�pend du format de sortie:
en g�neration HTML, --ifhtml est � on � et les autres sont � off � ;
en g�n�ration Info, --ifinfo est � on � et les autres sont � off � ;
en g�n�ration plein texte, --ifplaintext est � on � et les autres sont � off � ;
en g�n�ration XML, --ifxml est � on � et les autres sont � off �.
 %c%s accolades attendues %c%s attend un argument d'un seul caract�re � i � ou � j � %c%s accolade fermante manquante %c%s exige un nom macro %cend non trouv�e %s exige un argument: le formateur pour %citem %s: l'argument de l'option --footnote-style doit �tre � separate � ou
� end �, non pas � %s �.
 %s: l'argument de l'option --paragraph-indent doit �tre num�rique, � none � ou
� asis �, non pas � %s �.
 %s: valeur TEXINFO_OUTPUT_FORMAT non reconnue est ignor� � %s �
 %s: Enl�vement du fichier de sortie � %s � � cause d'erreurs;
utiliser l'option --force pour pr�server.
 %s: absence d'un argument fichier.
 %s%d: --css-file termin� dans le commentaire macro @%s inactive � l'int�rieur d'un bloc � %s � @%s n'a aucun sens � l'ext�rieur de l'environnement � @float � @%s n'a aucun sens � l'ext�rieur des environnements � @titlepage � et � @quotation � commande @image avec un fichier � %s � illisible: %s La macro @sp exige un argument num�rique positif, pas � %s � @strong{Note...} produit une table douteuse de r�f�rences crois�es dans Info; r��crire pour �viter cela Mauvais argument � %s � � � @%s � utilisant � %s � Ne peut cr�er le r�pertoire � %s �: %s Traitement conditionel de l'entr�e:
  --ifdocbook              Traiter @ifdocbook et @docbook m�me s'il
                           n'y a pas de g�n�ration Docbook.
 --ifhtml                  Traiter le textuel sous @ifhtml et @html m�me
                            s'il n'y a pas de g�n�ration HTML.
 --ifinfo                  Traiter le textuel sous @ifinfo m�me
                            s'il n'y a pas de g�n�ration Info.
 --ifplaintext             Traiter le textuel sous @ifplaintext m�me
                            s'il n'y a pas de g�n�ration plein texte
 --iftex                   Traiter le textuel sous @iftex et @tex.
                             implique l'option --no-split.
 --ifxml                   Traiter le textuel sous @ifxml et sous @xml.
 --no-ifhtml               Ne pas traiter le textuel sous @ifhtml et @html.
 --no-ifinfo               Ne pas traiter le textuel sous @ifinfo.
 --no-ifplaintext          Ne pas traiter le textuel sous @ifplaintext.
 --no-iftex                Ne pas traiter le textuel sous @iftex et @tex.
 --no-ifxml                Ne pas traiter le textuel sous @ifxml et @xml.

  Aussi pour l'options --no-ifFORMAT, ne pas traiter le textuel @ifnotFORMAT.
 Entr�e pour l'index � %s � � l'ext�rieure de tout noeud La note de bas de page est d�finie sans noeud parent Options portant sur les fichier d'entr�e:
      --commands-in-node-names  permet les commandes @ dans les noms de noeuds.
 -D VAR                    D�finir une variable, comme avec @set.
 -I DIR                    Ajouter � la fin DIR au chemin de fouille @include.
 -P DIR                    Ajouter au d�but DIR au chemin de fouille @include.
 -U VAR                    Rendre ind�finie une variable, comme avec @clear.
 %c �gar�e ou mal plac�e Doit �tre dans une insertion � @%s � afin d'utiliser � @%s �. � %cend %s � non appari� Le noeud � %s � manque d'un item menu pour � %s � en d�pit d'�tre son noeud � Up � cible Fin de fichier rencontr� avant l'appariement de @end %s Trop de colonnes dans un item de multitable (%d max) Beaucoup trop d'erreurs!  Abandon.
 Traduire une documentation Texinfo source en divers autres formats:
Fichiers Info ad�quats pour lire en ligne avec Emacs ou GNU Info autonome
 Utiliser � %s --help � pour plus d'informations.
 Commande inconnue � %s �. Nom d'index inconnu � %s � Nom d'index � %s � inconnu dans @printindex � %c%s � non appari� Usage: %s [OPTION]... FICHIER-TEXINFO...
 Utiliser des accolades pour donner une commande comme argument � � @%s � � @end � s'attendait � � %s �, mais a vu � %s � ici se trouve la d�finition pr�c�dente de � %s � inhibition d'une commande @tab � l'ext�rieur d'une multitable abandon du texte orphelin � %s � apr�s la commande @multitable macro � %s � d�j� d�finie pr�c�demment macro @end %s non balanc�e avec @%s votre noeud @top devrait se retrouver peut-�tre dans @ifnottex plut�t que dans @ifinfo? fanion ind�fini: %s nom d'encodage non reconnu � %s � noeud � %s � non r�f�renc� 