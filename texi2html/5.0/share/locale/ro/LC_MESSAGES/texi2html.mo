��    3      �  G   L      h  E  i     �  6   �     �          )  1   ?  @   q  D   �  <   �  F   4     {  "   �  %   �  /   �  E        V  2   v  R   �  &   �     #	  l  C	  (   �  $   �  w  �     v  )   �     �  >   �  #     ,   '     T  �   p  &        .     C  !   V     x  &   �  2   �  "   �  '     #   .  *   R     }     �  J   �               5  �  L  3  �        8   ;  $   t     �     �  3   �  G   �  J   G  <   �  T   �      $  /   E  ,   u  /   �  C   �  *     1   A  \   s  0   �       h  !  3   �  (   �  �  �     k  5   |     �  E   �  ,     1   @      r  �   �  6   !      X      q   $   �      �   ,   �   <   �   (   *!  )   S!  "   }!  '   �!     �!     �!  U   "     X"      m"     �"         1   )   #                    *   
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
 Use braces to give a command as an argument to @%s `@end' expected `%s', but saw `%s' here is the previous definition of `%s' ignoring @tab outside of multitable ignoring stray text `%s' after @multitable macro `%s' previously defined mismatched @end %s with @%s perhaps your @top node should be wrapped in @ifnottex rather than @ifinfo? undefined flag: %s unrecognized encoding name `%s' unreferenced node `%s' Project-Id-Version: texinfo 4.7.94
Report-Msgid-Bugs-To: bug-texinfo@gnu.org
POT-Creation-Date: 2010-07-01 00:03+0200
PO-Revision-Date: 2005-05-03 12:00+05
Last-Translator: Laurentiu Buzdugan <lbuz@rolix.org>
Language-Team: Romanian <translation-team-ro@lists.sourceforge.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-2
Content-Transfer-Encoding: 8bit
Plural-Forms: nplurals=2; plural=(n != 1);
   Valori implicite pentru condi�ionalele @if... depind de formatul de ie�ire:
  dac� genera�i HTML, --ifhtml este selectat iar restul sunt deselectate;
  dac� genera�i, --ifinfo este selectat iar restul sunt deselectate;
  dac� genera�i text simplu, --ifplaintext este selectat iar restul sunt deselectate;
 %c%s am a�teptat paranteze %c%s a�teapt� un singur caracter `i' sau `j' ca argument %c%s lipse�te paranteza de �nchidere %c%s necesit� un nume %cend macro nu a fost g�sit %s necesit� un argument: formatatorul pentru %citem %s: --footnote-style arg trebuie s� fie `separate' sau `end', nu `%s'.
 %s: --paragraph-indent arg trebuie s� fie numeric/`none'/`asis', nu `%s'.
 %s: Ignor valoare nerecunoscut� TEXINFO_OUTPUT_FORMAT `%s'.
 %s: fi�ierul de ie�ire `%s' din cauza erorilor; folosi�i --force pentru a-l p�stra.
 %s: lipse�te fi�ierul argument.
 %s:%d: --css-file s-a terminat cu un comentariu @%s nu are sens �n interiorul blocului `@%s' @%s nu are sens �n exteriorul mediului `@float' @%s nu are sens �n exteriorul mediilor `@titlepage' �i `@quotation' Fi�ierul @image `%s' nu poate fi citit: %s @sp necesit� un argument numeric pozitiv, nu `%s' @strong{Not�...] produce o referin�� �ncruci�at� fals� �n Info; reformula�i pentru a o evita Argument gre�it `%s' pentru `@%s', folosesc `%s' Nu pot crea directorul `%s': %s Procesare condi�ional� �n intrare:
  --ifdocbook       proceseaz� @ifdocbook � @docbook chiar dac�
                      nu generezi Docbook.
  --ifhtml          proceseaz� @ifhtml �i @html chiar dac� nu generezi HTML.
  --ifinfo          proceseaz� @ifinfo chiar dac� nu generezi Info.
  --ifplaintext     proceseaz� @ifplaintext chiar dac� nu generezi text simplu.
  --iftex           proceseaz� @iftex �i @tex; implic� --no-split.
  --ifxml           proceseaz� @ifxml �i @xml.
  --no-ifdocbook    nu procesa text @ifdocbook �i @docbook.
  --no-ifhtml       nu procesa text @ifhtml �i @html.
  --no-ifinfo       nu procesa text @ifinfo.
  --no-ifplaintext  nu procesa text @ifplaintext.
  --no-iftex        nu procesa text @iftex �i @tex.
  --no-ifxml        nu procesa text @ifxml �i @xml.

  De asemenea, pentru op�iunile --no-ifFORMAT, proceseaz� text @ifnotFORMAT.
 Intrarea pentru index-ul `%s' �n afara oric�rui nod Nota de subsol definit� f�r� nod p�rinte Op�iuni fi�ier de intrare:
      --commands-in-node-names  permite comenzi @ �n numele nodurilor.
  -D VAR                        define�te variabila VAR, ca �i @set.
  -I DIR                        adaug� DIR la calea de c�utare @include.
  -P DIR                        prepend DIR la calea de c�utare @include.
  -U VAR                        nedefine�te variabila VAR, ca �i @clear.
 %c nelalocul lui Trebuie s� fi�i �n mediul `@%s' pentru a folosi `@%s' Nici o potrivire %cend %s' Nodului `%s' �i lipse�te articolul pentru `%s' de�i �i este �inta Sus Am ajuns la eof �nainte de a potrivi @end %s Prea multe coloane �n articol multitabel (max %d) Prea multe erori!  Am renun�at.
 Translateaz� documenta�ia surs� Texinfo �n diferite alte formate, implicit
fi�iere Info potrivite pentru citit online cu Emacs sau GNU Info.
 �ncerca�i `%s --help' pentru informa�ii suplimentare.
 Comand� necunoscut� `%s' Index necunoscut `%s' Index necunoscut `%s' �n @printindex `%c%s' f�r� pereche Folosire: %s [OP�IUNE]... FI�IER-TEXINFO...
 Folosi�i paranteze pentru a da o comand� ca argument lui @%s `@end' a a�teptat `%s', dar a v�zut `%s' aici este defini�ia anterioar� a lui `%s' ignor @tab �n afara multitabelului ignor text aiurea `%s' dup� @multitable macro-ul `%s' definit anterior nepotrivire @end %s cu @%s probabil c� nodul d-voastr� @top ar trebui �mpachetat �n @ifnottex �n loc de @ifinfo? marcaj nedefinit: %s nume de codare nerecunoscut `%s' nod nereferit `%s' 