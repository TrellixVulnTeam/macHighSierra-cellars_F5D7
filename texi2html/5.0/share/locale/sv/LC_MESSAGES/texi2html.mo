��    >        S   �      H  E  I     �  6   �     �     �     	  1     @   Q  D   �  <   �  F        [  "   w  %   �  /   �  E   �     6	  2   V	  R   �	  &   �	     
     
  l  ;
  �   �  �   �  (   <  ^  e      �  $   �  d  
  �  o  w  X     �  )   �       >     (   ]  �  �  :  /  #   j  -   �  ,   �     �  �     &   �     �     �  !   �        &      2   E   "   x   '   �   #   �   *   �      !     0!  J   L!     �!     �!     �!  ^  �!  %  @#     f$  =   �$     �$     �$     �$  1   %  O   @%  R   �%  8   �%  Q   &     n&  &   �&  +   �&  5   �&  K   '  "   \'  6   '  X   �'  2   (     B(  !   b(  �  �(  �  ,  �   �-  .   �.  g  �.  (   V1  &   1  �  �1    K4  �  j7      9  5   9     E9  D   `9  (   �9  �  �9  P  �>  &   �?  6   @  2   V@     �@  �   �@  (   7A     `A     uA     �A     �A  +   �A  B   �A  '   $B  *   LB  #   wB  *   �B      �B     �B  B   C     FC     ]C     vC         *   /   7   >   <            9   +       :           -   3   5          2      =   &      #   !                    0       	         
                 %   (              6   '   ;            4           )          $                        8                              ,       "   1   .            The defaults for the @if... conditionals depend on the output format:
  if generating HTML, --ifhtml is on and the others are off;
  if generating Info, --ifinfo is on and the others are off;
  if generating plain text, --ifplaintext is on and the others are off;
  if generating XML, --ifxml is on and the others are off.
 %c%s expected braces %c%s expects a single character `i' or `j' as argument %c%s missing close brace %c%s requires a name %cend macro not found %s requires an argument: the formatter for %citem %s: --footnote-style arg must be `separate' or `end', not `%s'.
 %s: --paragraph-indent arg must be numeric/`none'/`asis', not `%s'.
 %s: Ignoring unrecognized TEXINFO_OUTPUT_FORMAT value `%s'.
 %s: Removing output file `%s' due to errors; use --force to preserve.
 %s: missing file argument.
 %s:%d: --css-file ended in comment @%s not meaningful inside `@%s' block @%s not meaningful outside `@float' environment @%s not meaningful outside `@titlepage' and `@quotation' environments @image file `%s' unreadable: %s @sp requires a positive numeric argument, not `%s' @strong{Note...} produces a spurious cross-reference in Info; reword to avoid that Bad argument `%s' to `@%s', using `%s' Bad argument to @%s: %s Can't create directory `%s': %s Conditional processing in input:
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
 Copyright (C) %s Free Software Foundation, Inc.
License GPLv3+: GNU GPL version 3 or later <http://gnu.org/licenses/gpl.html>
This is free software: you are free to change and redistribute it.
There is NO WARRANTY, to the extent permitted by law.
 Email bug reports to bug-texinfo@gnu.org,
general questions and discussion to help-texinfo@gnu.org.
Texinfo home page: http://www.gnu.org/software/texinfo/ Entry for index `%s' outside of any node Examples:
  makeinfo foo.texi                      write Info to foo's @setfilename
  makeinfo --html foo.texi               write HTML to @setfilename
  makeinfo --xml foo.texi                write Texinfo XML to @setfilename
  makeinfo --docbook foo.texi            write DocBook XML to @setfilename
  makeinfo --no-headers foo.texi         write plain text to standard output

  makeinfo --html --no-headers foo.texi  write html without node lines, menus
  makeinfo --number-sections foo.texi    write Info with numbered sections
  makeinfo --no-split foo.texi           write one Info file however big
 Expected @%s on or off, not `%s' Footnote defined without parent node General options:
      --error-limit=NUM       quit after NUM errors (default %d).
      --document-language=STR locale to use in translating Texinfo keywords
                                for the output document (default C).
      --force                 preserve output even if errors.
      --help                  display this help and exit.
      --no-validate           suppress node cross-reference validation.
      --no-warn               suppress warnings (but not errors).
  -v, --verbose               explain what is being done.
      --version               display version information and exit.
 General output options:
  -E, --macro-expand=FILE     output macro-expanded source to FILE,
                                ignoring any @setfilename.
      --no-headers            suppress node separators, Node: lines, and menus
                                from Info output (thus producing plain text)
                                or from HTML (thus producing shorter output);
                                also, write to standard output by default.
      --no-split              suppress the splitting of Info or HTML output,
                                generate only one output file.
      --number-sections       output chapter and sectioning numbers.
  -o, --output=FILE           output to FILE (or directory if split HTML).
 Input file options:
      --commands-in-node-names  allow @ commands in node names.
  -D VAR                        define the variable VAR, as with @set.
  -I DIR                        append DIR to the @include search path.
  -P DIR                        prepend DIR to the @include search path.
  -U VAR                        undefine the variable VAR, as with @clear.
 Misplaced %c Must be in `@%s' environment to use `@%s' No matching `%cend %s' Node `%s' lacks menu item for `%s' despite being its Up target Only @%s 10 or 11 is supported, not `%s' Options for Info and plain text:
      --disable-encoding      do not output accented and special characters
                                in Info output based on @documentencoding.
      --enable-encoding       override --disable-encoding (default).
      --fill-column=NUM       break Info lines at NUM characters (default %d).
      --footnote-style=STYLE  output footnotes in Info according to STYLE:
                                `separate' to put them in their own node;
                                `end' to put them at the end of the node, in
                                which they are defined (this is the default).
      --paragraph-indent=VAL  indent Info paragraphs by VAL spaces (default %d).
                                If VAL is `none', do not indent; if VAL is
                                `asis', preserve existing indentation.
      --split-size=NUM        split Info files at size NUM (default %d).
 Output format selection (default is to produce Info):
      --docbook               output Docbook XML rather than Info.
      --html                  output HTML rather than Info.
      --xml                   output Texinfo XML rather than Info.
      --plaintext             output plain text rather than Info.
 Reached eof before matching @end %s Requested float type `%s' not previously used Too many columns in multitable item (max %d) Too many errors!  Gave up.
 Translate Texinfo source documentation to various other formats, by default
Info files suitable for reading online with Emacs or standalone GNU Info.
 Try `%s --help' for more information.
 Unknown command `%s' Unknown index `%s' Unknown index `%s' in @printindex Unmatched `%c%s' Usage: %s [OPTION]... TEXINFO-FILE...
 Use braces to give a command as an argument to @%s `@end' expected `%s', but saw `%s' here is the previous definition of `%s' ignoring @tab outside of multitable ignoring stray text `%s' after @multitable macro `%s' previously defined mismatched @end %s with @%s perhaps your @top node should be wrapped in @ifnottex rather than @ifinfo? undefined flag: %s unrecognized encoding name `%s' unreferenced node `%s' Project-Id-Version: texinfo 4.11.93
Report-Msgid-Bugs-To: bug-texinfo@gnu.org
POT-Creation-Date: 2010-07-01 00:03+0200
PO-Revision-Date: 2008-03-09 20:35+0100
Last-Translator: Christian Rose <menthos@menthos.com>
Language-Team: Swedish <tp-sv@listor.tp-sv.se>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
   Standardvärdena för @if...-villkoren beror på utdataformatet:
  om HTML genereras är --ifhtml på och de andra av;
  om Info genereras är --ifinfo på och de andra av;
  om vanlig text genereras är --ifplaintext på och de andra av;
  om XML genereras är --ifxml på och de andra av.
 %c%s förväntade klamrar %c%s förväntar ett ensamt tecken "i" eller "j" som argument %c%s saknar avslutande klammer %c%s kräver ett namn Makrot %cend hittades inte %s kräver ett argument: formateraren för %citem %s: argumentet --footnote-style måste vara "separate" eller "end", inte "%s".
 %s: argumentet --paragraph-indent måste vara numeriskt/"none"/"asis", inte "%s".
 %s: Ignorerar okänt TEXINFO_OUTPUT_FORMAT-värde "%s".
 %s: Tar bort utdatafilen "%s" på grund av fel; använd --force för att bevara.
 %s: filargument saknas.
 %s:%d: --css-fil slutade med kommentar @%s är inte meningsfullt inuti "@%s"-block @%s är inte meningsfullt utanför "@float"-omgivning @%s är inte meningsfullt utanför "@titlepage"- och "@quotation"-omgivning @image-filen "%s" är oläslig: %s @sp kräver ett positivt numeriskt argument, inte "%s" @strong{Obs...} skapar en falsk korsreferens i Info; formulera om för att undvika detta Felaktigt argument "%s" till "@%s", använder "%s" Felaktigt argument till @%s: %s Kan inte skapa katalogen "%s": %s Villkorlig behandling i indata:
  --ifdocbook       behandla @ifdocbook och @docbook även om inte
                      Docbook genereras.
  --ifhtml          behandla @ifhtml och @html även om inte HTML genereras.
  --ifinfo          behandla @ifinfo-text även om inte Info genereras.
  --ifplaintext     behandla @ifplaintext även om inte vanlig text
                    genereras.
  --iftex           behandla @iftex och @tex-text; medför --no-split.
  --ifxml           behandla @ifxml och @xml.
  --no-ifdocbook    behandla inte @ifdocbook- och @docbook-text.
  --no-ifhtml       behandla inte @ifhtml- och @html-text.
  --no-ifinfo       behandla inte @ifinfo-text.
  --no-ifplaintext  behandla inte @ifplaintext-text.
  --no-iftex        behandla inte @iftex- och @tex-text.
  --no-ifxml        behandla inte @ifxml- och @xml-text.

  Dessutom, för flaggorna --no-ifFORMAT, behandla @ifnotFORMAT-text.
 Copyright © %s Free Software Foundation, Inc.
Licens GPLv3+: GNU GPL version 3 eller senare <http://gnu.org/licenses/gpl.html>
(Följande text är en informell översättning som enbart tillhandahålls
 i informativt syfte. För alla juridiska tolkningar gäller den engelska
 originaltexten.)
Det här är fri programvara. Du kan fritt modifiera det och
vidaredistribuera det. Det finns INGEN GARANTI, i den omfattning som
medges av gällande lag.
 Skicka felrapporter till bug-texinfo@gnu.org,
allmänna frågor och diskussion till help-texinfo@gnu.org
och synpunkter på översättningen till tp-sv@listor.tp-sv.se.
Hemsida för texinfo: http://www.gnu.org/software/texinfo/ Posten för index "%s" är utanför alla noder Exempel:
  makeinfo apa.texi                      skriv Info till apas @setfilename
  makeinfo --html apa.texi               skriv HTML till @setfilename
  makeinfo --xml apa.texi                skriv Texinfo XML till @setfilename
  makeinfo --docbook apa.texi            skriv DocBook XML till @setfilename
  makeinfo --no-headers apa.texi         skriv vanlig text till standard ut
  makeinfo --html --no-headers apa.texi  skriv html utan nodrader och menyer
  makeinfo --number-sections apa.texi    skriv Info med numrerade avsnitt
  makeinfo --no-split apa.texi           skriv en Info-fil hur stor den än är
 Förväntade @%s on eller off, inte "%s" Fotnoten definierad utan föräldernod Allmänna flaggor:
      --error-limit=ANTAL     avsluta efter ANTAL fel (standardvärde %d).
      --document-language=STR lokal att använda vid översättning av
                                Texinfo-nyckelord för utdatadokumentet
                                (standardvärde C).
      --force                 bevara utdata även om fel.
      --help                  visa denna hjälptext och avsluta.
      --no-validate           undertryck korsreferensvalidering av noder.
      --no-warn               undertryck varningar (men inte fel).
  -v, --verbose               förklara vad som görs.
      --version               visa versionsinformation och avsluta.
 Allmänna utdataflaggor:
  -E, --macro-expand=FIL      generera makroexpanderad källkod till FIL,
                              ignorera alla @setfilename.
      --no-headers            undertryck nodseparatorer, Node:-rader och
                                menyer från Info-utdata (och skapa
                                därigenom vanlig text) eller från HTML
                                (och producera därigenom kortare utdata).
                                Skriv även till standard ut som standard.
      --no-split              undertryck delning av Info eller HTML-utdata,
                              generera endast en utdatafil.
      --number-sections       generera kapitel- och avsnittsnummer.
  -o, --output=FIL            generera till FIL (katalog om delad HTML).
 Flaggor för indatafil:
      --commands-in-node-names   tillåt @-kommandon i nodnamn.
  -D VARIABEL                    definiera variabeln VARIABEL, som med @set.
  -I KATALOG                     lägg till KATALOG till @include-sökvägen.
  -P KATALOG                     lägg till KATALOG först i @include-sökvägen.
  -U VARIABEL                    odefiniera variabeln VARIABEL, som med @clear.
 Felplacerat %c Måste vara i "@%s"-omgivning för att använda "@%s" Inget matchande "%cend %s" Noden "%s" saknar menypost för "%s" trots att den är dess Upp-mål Endast @%s 10 eller 11 stöds, inte "%s" Flaggor för Info och vanlig text:
      --disable-encoding      generera inte tecken med accent och
                                specialtecken i Info-utdata baserat på
                                @documentencoding.
      --enable-encoding       åsidosätt --disable-encoding (standard).
      --fill-column=ANTAL     radbryt Info-rader vid ANTAL tecken
                                (standardvärde %d).
      --footnote-style=STIL   generera fotnoter i Info som följer STIL:
                                "separate" för att placera fotnoter i sin
                                egen nod,
                                "end" för att placera fotnoter i slutet
                                av den nod där de är definierade
                                (standardalternativ).
      --paragraph-indent=VÄRDE gör indrag i Info-stycken med VÄRDE
                                blanksteg (standardvärde %d).
                                Om VÄRDE är "none" görs inga indrag; om
                                VÄRDE är "asis" bevaras befintliga
                                indrag.
      --split-size=ANTAL      dela upp Info-filer vid storleken ANTAL
                                (standardvärde %d).
 Val av utdataformat (standard är att producera Info):
      --docbook               generera Docbook XML istället för Info.
      --html                  generera HTML istället för Info.
      --xml                   generera Texinfo XML istället för Info.
      --plaintext             generera vanlig text istället för Info.
 Nådde filslut innan matchande @end %s Begärda flyttalstypen "%s" har inte tidigare använts För många kolumner i multitabellsobjekt (max %d) För många fel! Gav upp.
 Översätt Texinfo-källdokumentation till diverse andra format, som standard
infofiler som är lämpliga för läsning med Emacs eller GNU Info.
 Prova "%s --help" för mer information.
 Okänt kommando "%s" Okänt index "%s" Okänt index "%s" i @printindex Ensamt "%c%s" Användning: %s [FLAGGA]... TEXINFO-FIL...
 Använd klamrar för att ge ett komamndo som ett argument till @%s "@end" förväntade "%s", men såg "%s" här är den tidigare definitionen av "%s" ignorerar @tab utanför multitabell ignorerar lös text "%s" efter @multitable makrot "%s" är redan definierat @end %s och @%s passar inte din @top-nod ska kanske packas i @ifnottex istället för @ifinfo? odefinierad flagga: %s okänt kodningsnamn "%s" orefererad nod "%s" 