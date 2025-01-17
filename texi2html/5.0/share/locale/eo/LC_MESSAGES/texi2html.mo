��    3      �  G   L      h  E  i     �  6   �     �          )  1   ?  @   q  D   �  <   �  F   4     {  "   �  %   �  /   �  E        V  2   v  R   �  &   �     #	  l  C	  (   �  $   �  w  �     v  )   �     �  >   �  #     ,   '     T  �   p  &        .     C  !   V     x  &   �  2   �  "   �  '     #   .  *   R     }     �  J   �               5    L  \  �     )  :   A     |     �     �  /   �  J   �  W   5  A   �  ^   �     .  &   M  )   t  ,   �  =   �  7   	  6   A  Q   x  4   �  ,   �  �  ,  4   �        U  /  
   �  )   �     �  G   �  3     >   Q     �  �   �  )   I      s      �   &   �      �   ,   �   9   !  3   I!  )   }!  .   �!  5   �!  "   "     /"  =   D"     �"  $   �"  #   �"         1   )   #                    *   
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
PO-Revision-Date: 2006-11-25 23:35+0600
Last-Translator: Sergio Pokrovskij <sergio.pokrovskij@gmail.com>
Language-Team: Esperanto <translation-team-eo@lists.sourceforge.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8-bit
 La defaŭlta konduto de la @if...-frazoj dependas je la celata formo:
se HTML estas generata, --ifhtml aktivas kaj la ceteraj, malaktivas;
ĉe Info-generado, --ifinfo aktivas kaj la ceteraj, malaktivas; 
se plata teksto estas generata, --ifplaintext aktivas kaj la ceteraj,
malaktivas; ĉe XML-generado, --ifxml aktivas kaj la ceteraj, malaktivas.
 %c%s postulas vinkulojn %c%s akceptas nur solsignan argumenton „i‟ aŭ „j‟ %c%s sen „}‟ %c%s bezonas nomon makroo %cend ne troviĝis %s bezonas argumenton: la aranĝilon por %citem %s: Post --footnote-style estu „separate‟ aŭ „end‟, ne „%s‟.
 %s: Post „--paragraph-indent‟ estu nombro, „none‟ aŭ „asis‟, ne „%s‟.
 %s: Nekonata valoro de TEXINFO_OUTPUT_FORMAT: «%s».  Ignorita.
 %s: La eligdosiero «%s» forigitas ĉar estis eraroj;
uzu la opcion --force por ĝin reteni.
 %s: mankas dosiera argumento.
 %s:%d: CSS-dosiero finiĝis en komento @%s estas sensenca ene de bloko „@%s‟ @%s estas sensenca ekster bloko „@float‟ @%s sencas nur en bloko „@titlepage‟ aŭ „@quotation‟ dosiero «%s» en la komando @image estas nelegebla: %s @sp bezonas ne «%s» sed pozitivan argumenton nombran «@strong{Note...}» estigas falsan referencon en Info; alivortigu por eviti tion Misa argumento «%s» por «%s»; estos uzata «%s» Provo krei dosierujon «%s» malsukcesis: %s Kondiĉa traktado ĉe enigo:
  --ifdocbook	   Traktu la pecojn sub @ifdocbook kaj @docbook eĉ se
		      ne Docbook estas generata
  --ifhtml	   Traktu la pecojn sub @ifhtml kaj @html eĉ se ne
		      HTML estas generata
  --ifinfo	   Traktu la pecojn sub @ifinfo eĉ se ne Info generatas
  --ifplaintext	   Traktu la pecojn sub @ifplaintext eĉ se alia formo ol
		      plata teksto estas generata
  --iftex	   Traktu la pecojn sub @iftex kaj @tex; implicas --no-split
  --ifxml	   Traktu la pecojn sub @ifxml kaj @xml
  --no-ifdocbook   Ne traktu la pecojn sub @ifdocbook kaj @docbook
  --no-ifhtml	   Ne traktu la pecojn sub @ifhtml kaj @html
  --no-ifinfo	   Ne traktu la pecojn sub @ifinfo
  --no-ifplaintext Ne traktu la pecojn sub @ifplaintext
  --no-iftex	   Ne traktu la pecojn sub @iftex kaj @tex
  --no-ifxml	   Ne traktu la pecojn sub @ifxml kaj @xml

  Krome, ĉe la opcioj --no-ifFORMO, ja traktu la pecojn sub @ifnotFORMO.
 Artikolo por indekso «%s» estas ekster iu ajn nodo Piednoto difinita sen patra nodo Opcioj pri la fontodosieroj:
  --commands-in-node-names    Permesu @-komandojn en nodnomoj
  -D VAR		      Difinu la variablon VAR, kvazaŭ per @set
  -I UJO		      Alkroĉu dosierUJOn al la serĉvojo de @include
  -P UJO		      Antaŭmetu dosierUJOn al la serĉvojo de @include
  -U VAR		      Maldifinu la variablon  VAR,  kiel per @clear
 Misloka %c Nur en „@%s‟-bloko uzeblas „@%s‟. Mankas para „%cend %s‟ En "%s„ mankas menuero por ‟%s„, malgraŭ ties ligilo ‟Up„‟ Pli frue ol la para @end %s renkontiĝis dosierfino Tro da kolumnoj en elemento de „multitable‟ (%d maksimume) Tro multe da eraroj!  Halt'.
 Traduku fontan Texinfo-dokumenton en diversajn aliajn formojn, defaŭlte en
Info-dosierojn taŭgajn por dialoga legado per Emakso aŭ aŭtonoma GNU-Info.
 Por pluaj detaloj tajpu „%s --help‟.
 Nekonata komando «%s». Nekonata indekso «%s» Nekonata indekso «%s» en @printindex Mankas para „%c%s‟ Uzmaniero: %s [OPCIO]... TEXINFO-DOSIERO...
 Uzu vinkulojn por pasigi al „@%s‟ komandan argumenton „@end‟ atendis „%s‟, sed renkontis „%s‟ ĉi tie estas la antaŭa difino de «%s» komando @tab ekster „multitable‟; ignorita la misa teksto «%s» post @multitable estas ignorita makroo «%s» jam difinita antaŭe misa @end %s por @%s eble via @top-nodo staru sub @ifnottex anstataŭ sub @ifinfo? Nedifinita flago: %s Nekonata nomo de kodosistemo: «%s» la nodo «%s» ne estas referencita 