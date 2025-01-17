��    3      �  G   L      h  E  i     �  6   �     �          )  1   ?  @   q  D   �  <   �  F   4     {  "   �  %   �  /   �  E        V  2   v  R   �  &   �     #	  l  C	  (   �  $   �  w  �     v  )   �     �  >   �  #     ,   '     T  �   p  &        .     C  !   V     x  &   �  2   �  "   �  '     #   .  *   R     }     �  J   �               5  x  L  ?  �       9   $  &   ^     �     �  /   �  D   �  F   &  ?   m  M   �     �  &     )   <  +   f  A   �     �  3   �  V   (  +     $   �     �  &   �  "     �  ;     �  *   �     	  C   &  *   j  -   �     �  �   �  &   e     �     �      �     �  &   �  A      "   N   )   q   "   �   *   �   "   �      !  K   %!     q!     �!     �!         1   )   #                    *   
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
PO-Revision-Date: 2004-12-05 15:37+0100
Last-Translator: Trond Endrest�l <Trond.Endrestol@gtf.ol.no>
Language-Team: Norwegian Bokmaal <i18n-nb@lister.ping.uio.no>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8bit
   Standardverdiene for @if...-betingelsene avhenger av outputformatet:
  dersom HTML genereres er --ifhtml p�sl�tt og de andre av;
  dersom Info genereres er --ifinfo p�sl�tt og de andre av;
  dersom ren tekst genereres er --ifplaintext p�sl�tt og de andre av;
  dersom XML genereres er --ifxml p�sl�tt og de andre av.
 %c%s forventet kr�llparanteser %c%s forventer et enkelt tegn, �i� eller �j� som argument %c%s mangler avsluttende kr�llparentes %c%s krever et navn %cend macro ikke funnet %s krever et argument: formattereren for %citem %s: --footnote-style arg m� v�re �separate� eller �end�, ikke �%s�.
 %s: --paragraph-indent arg m� v�re numerisk/�none�/�asis�, ikke �%s�.
 %s: Ignorerer ugjenkjennelig TEXINFO_OUTPUT_FORMAT-verdi �%s�.
 %s: Fjerner utskriftsfilen �%s� p� grunn av feil; bruk --force for � bevare.
 %s: mangler filargument.
 %s:%d: --css-file endte i en kommentar @%s er meningsl�s innenfor en �@%s�-blokk @%s er meningsl�s utenfor et �@float�-milj� @%s gir ikke mening utenfor �@titlepage�- og �@quotation�-milj�er @image-fil �%s� er uleselig: %s @sp krever et positivt numerisk argument, ikke `%s' @strong{Note...} lager en overfl�dig kryssreferanse i Info; skriv om for � unng� dette Ugyldig argument �%s� til �%s�, bruker �%s� Kan ikke opprette katalogen �%s�: %s Betinget behandling av input:
  --ifdocbook        behandle @ifdocbook og @docbook selv om
                       DocBook ikke skal genereres.
  --ifhtml           behandle @ifhtml og @html selv om HTML ikke skal genereres.
  --ifinfo           behandle @ifinfo selv n�r info ikke skal genereres.
  --ifplaintext      behandle @ifplaintext selv om ren tekst ikke skal genereres.
  --iftex            behandle @iftex og @tex; inneb�rer --no-split.
  --ifxml            behandle @ifxml og @xml.
  --no-ifdocbook     ikke behandle @ifdocbook og @docbook.
  --no-ifhtml        ikke behandle @ifhtml og @html.
  --no-ifinfo        ikke behandle @ifinfo.
  --no-ifplaintext   ikke behandle @ifplaintext.
  --no-iftex         ikke behandle @iftex og @tex.
  --no-ifxml         ikke behandle @ifxml og @xml.
 Innslag for indeksen �%s� utenfor node Fotnote definert uten foreldrenode Valg for inputfil:
      --commands-in-node-names   tillate @-kommandoer i nodenavn.
  -D VAR                         definer variabelen VAR, som om @set brukes.
  -I KAT                         legg til KAT p� slutten av @include-s�kestien.
  -P KAT                         legg til KAT p� starten av @include-s�kestien.
  -U VAR                         udefiner variabelen VAR, som om @clear brukes.
 Feilplassert %c M� v�re i et �@%s�-milj� for � bruke �@%s� Ingen tilsvarende �%cend %s� Noden �%s� mangler et menypunkt for �%s� selv om den er dens oppm�l Traff slutt-p�-filen f�r matchende @end %s For mange kolonner i multitabellrad (maks %d) For mange feil!  Ga opp.
 Oversette Texinfodokumentasjon til forskjellige andre formater:
Infofiler for lesing online med Emacs eller den frittst�ende GNU Info.
 Pr�v �%s --help� for mer informasjon.
 Ukjent kommando �%s� Ukjent indeks �%s� Ukjent indeks �%s� i @printindex Umatchet �%c%s� Bruksm�te: %s [VALG]... TEXINFOFIL...
 Bruk kr�llparenteser for � gi en kommando som et argument til @%s `@end' forventet �%s�, men s� �%s� her er den tidligere definisjonen av �%s� ignorerer @tab utenfor multitabell ignorerer l�s tekst �%s� etter @multitable makroen �%s� er tidligere definert umatchet @end %s med @%s kanskje burde din @top-node bli pakket inn i @ifnottex istedet for @ifinfo? udefinert flagg: %s ugjenkjennelig kodingsnavn �%s� ureferert node �%s� 