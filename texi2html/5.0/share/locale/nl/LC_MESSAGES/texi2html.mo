��    ?        Y         p  E  q     �  6   �               1  1   G  @   y  D   �  <   �  F   <     �  "   �  %   �  /   �  E   	     ^	  2   ~	  R   �	  &   
     +
     C
  l  c
  �   �  �   �  (   d  ^  �      �  $     d  2  �  �  w  �     �  )        /  >   F  (   �  �  �  �  /  :  �  #      -   7   ,   e      �   �   �   &   E!     l!     �!  !   �!     �!  &   �!  2   �!  "   !"  '   D"  #   l"  *   �"     �"     �"  J   �"     @#     S#     s#  �  �#  d  2%     �&  2   �&     �&     '     '  6   1'  L   h'  U   �'  E   (  ^   Q(  !   �(  ,   �(      �(  /    )  B   P)  %   �)  4   �)  f   �)  5   U*     �*     �*  	  �*  )  �-  �   �.  ,   �/  i  0  *   x2  -   �2  �  �2  �  [5  ~  8     �9  >   �9     �9  `   :  .   o:  �  �:  �  H<  	  �?  :   �@  ?   A  3   _A     �A  �   �A  &   ZB     �B     �B  #   �B     �B  +   �B  A   C  &   QC  &   xC  ,   �C  .   �C  $   �C  !    D  P   BD     �D     �D  $   �D     -           8                 =   +             3      2   !                       $   )             9          5   6       &   0   >   ;                 '             <   .   4   "                ?            7   %       #      	       :           /   *                               
   1                   (          ,      The defaults for the @if... conditionals depend on the output format:
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
 Misplaced %c Must be in `@%s' environment to use `@%s' No matching `%cend %s' Node `%s' lacks menu item for `%s' despite being its Up target Only @%s 10 or 11 is supported, not `%s' Options for HTML:
      --css-include=FILE      include FILE in HTML <style> output;
                                read stdin if FILE is -.
      --css-ref=URL           generate reference to a CSS file.
      --internal-links=FILE   produce list of internal links in FILE.
      --transliterate-file-names
                              produce file names in ASCII transliteration.
 Options for Info and plain text:
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
 Use braces to give a command as an argument to @%s `@end' expected `%s', but saw `%s' here is the previous definition of `%s' ignoring @tab outside of multitable ignoring stray text `%s' after @multitable macro `%s' previously defined mismatched @end %s with @%s perhaps your @top node should be wrapped in @ifnottex rather than @ifinfo? undefined flag: %s unrecognized encoding name `%s' unreferenced node `%s' Project-Id-Version: texinfo-4.12.94
Report-Msgid-Bugs-To: bug-texinfo@gnu.org
POT-Creation-Date: 2010-07-01 00:03+0200
PO-Revision-Date: 2008-08-17 23:34+0200
Last-Translator: Benno Schulenberg <benno@vertaalt.nl>
Language-Team: Dutch <vertaling@vrijschrift.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Generator: KBabel 1.11.4
Plural-Forms: nplurals=2; plural=(n != 1);
   De standaarden voor de '@if...'-opdrachten hangen af van de uitvoeropmaak:
  als HTML gemaakt wordt, staat '--ifhtml' aan en de anderen niet;
  als Info gemaakt wordt, staat '--ifinfo' aan en de anderen niet;
  als platte tekst gemaakt wordt, staat '--ifplaintext' aan en de anderen niet;
  als XML gemaakt wordt, staat '--ifxml' aan en de anderen niet.
 %c%s verwachtte '{...}' %c%s verwacht één enkele 'i' of 'j' als argument %c%s ontbrekende sluitaccolade %c%s vereist een naam %cend-macro niet gevonden %s vereist een argument: de formatteerder voor %c-item %s: Argument van --footnote-style moet 'separate' of 'end' zijn, niet '%s'.
 %s: Argument van --paragraph-indent moet numeriek, 'none' of 'asis' zijn, niet '%s'.
 %s: Onbekende waarde '%s' van TEXINFO_OUTPUT_FORMAT wordt genegeerd.
 %s: Uitvoerbestand '%s' wordt verwijderd wegens fouten;
gebruik '--force' om het te behouden.
 %s: Ontbrekend bestandsargument.
 %s:%d: '--css'-bestand eindigt in commentaar @%s is zinloos in een '@%s'-blok @%s is niet zinvol buiten een '@float'-omgeving @%s is niet zinvol buiten '@titlepage'- en '@quotation'-omgevingen @image-bestand '%s' is onleesbaar: %s @sp vereist een postief numeriek argument, niet '%s' @strong{Noot...} produceert een loze kruisverwijzing in Info; kies een ander woord om dat te vermijden Verkeerd argument '%s' van '@%s'; '%s' wordt gebruikt Fout argument van @%s: %s Kan map '%s' niet aanmaken: %s Conditionele verwerking van de invoer:
  --ifdocbook       '@ifdocbook' en '@docbook' altijd verwerken
  --ifhtml          '@ifhtml' en '@html' altijd verwerken
  --ifinfo          '@ifinfo' altijd verwerken
  --ifplaintext     '@ifplaintext' altijd verwerken
  --iftex           '@iftex' en '@tex' verwerken; impliceert '--no-split'
  --ifxml           '@ifxml' en '@xml' verwerken
  --no-ifdocbook    '@ifdocbook' en '@docbook' niet verwerken
  --no-ifhtml       '@ifhtml' en '@html' niet verwerken
  --no-ifinfo       '@ifinfo' niet verwerken
  --no-ifplaintext  '@ifplaintext' niet verwerken
  --no-iftex        '@iftex' en '@tex' niet verwerken
  --no-ifxml        '@ifxml' en '@xml' niet verwerken

  Voor de '--no-ifOPMAAK'-opties geldt: '@ifnotOPMAAK' _wel_ verwerken.
 Copyright (C) %s Free Software Foundation, Inc.
Dit is vrije software: u mag het vrijelijk wijzigen en verder verspreiden.
De precieze licentie is GPLv3+: GNU GPL versie 3 of later;
zie http://gnu.org/licenses/gpl.html voor de volledige tekst.
Er is GEEN GARANTIE, voor zover de wet dit toestaat.
 Stuur foutrapportages naar <bug-texinfo@gnu.org>,
algemene vragen en commentaar naar <help-texinfo@gnu.org>,
en opmerkingen over de vertaling naar <vertaling@vrijschrift.org>.
Texinfo-homepagina: http://www.gnu.org/software/texinfo/ Item voor index '%s' valt buiten elke pagina Voorbeelden:
  makeinfo foo.texi                 Info schrijven (naar foo's @setfilename)
  makeinfo --html foo.texi          HTML schrijven (naar foo's @setfilename)
  makeinfo --xml foo.texi           Texinfo-XML schrijven (naar @setfilename)
  makeinfo --docbook foo.texi       DocBook-XML schrijven (naar @setfilename)
  makeinfo --no-headers foo.texi    platte tekst naar standaarduitvoer

  makeinfo --html --no-headers foo.texi  HTML zonder kopregels en menu's
  makeinfo --number-sections foo.texi    Info met genummerde secties
  makeinfo --no-split foo.texi           één Info-bestand ongeacht de grootte
 @%s 'on' of 'off' werd verwacht, niet '%s' Voetnoot gedefinieerd zonder referentiepagina Algemene opties:
      --error-limit=AANTAL    na dit aantal fouten stoppen (standaard %d)
      --document-language=TAALCODE  te gebruiken taalregio (standaard C) bij
                                      het vertalen van Texinfo-sleutelwoorden
      --force                 uitvoerbestand behouden ook bij fouten
      --help                  deze hulptekst tonen en stoppen
      --no-validate           controle van kruisverwijzingen onderdrukken
      --no-warn               waarschuwingen onderdrukken (maar fouten niet)
  -v, --verbose               tonen wat er gedaan wordt
      --version               versie-informatie tonen en stoppen
 Algemene uitvoeropties:
  -E, --macro-expand=BESTAND  macro-geëxpandeerde brontekst naar dit bestand
                                schrijven, eventuele @setfilename's negeren
      --no-headers            kopregels en menu's weglaten, zodat Info-uitvoer
                                platte tekst wordt en HTML-uitvoer korter;
                                standaard naar standaarduitvoer schrijven
      --no-split              splitsing van Info- of HTML-uitvoer onderdrukken,
                                slechts één uitvoerbestand aanmaken
      --number-sections       hoofdstuk- en sectienummers produceren
  -o, --output=BESTAND        uitvoerbestand (of map indien gesplitste HTML)
 Invoerbestandopties:
      --commands-in-node-names  @-commando's in paginanamen toestaan
  -D VAR                      de variabele VAR definiëren (als met '@set')
  -I MAP                      MAP achteraantoevoegen aan @include-zoekpad
  -P MAP                      MAP vooraantoevoegen aan @include-zoekpad
  -U VAR                      variabele VAR wissen (als met '@clear')
 Verkeerd geplaatste %c Moet in een '@%s'-omgeving zitten om '@%s' te kunnen gebruiken Geen overeenkomende '%cend %s' Pagina '%s' bevat geen menu-item voor '%s'
ondanks dat de eerste het 'Up'-doel van de laatste is Bij @%s is alleen 10 of 11 mogelijk, niet '%s' Opties voor HTML:
      --css-include=BESTAND   dit bestand in de uitvoer opnemen;
                                als BESTAND '-' is, dan standaardinvoer lezen
      --css-ref=URL           een referentie naar een CSS-bestand genereren
      --internal-links=BSTAND tabel met interne verwijzingen hierin opslaan
      --transliterate-file-names
                              bestandsnamen met alleen ASCII-tekens produceren
 Opties voor Info en platte tekst:
      --disable-encoding      geen tekens met accenten in de uitvoer produceren
      --enable-encoding       tekens met accenten toestaan (standaard)
      --fill-column=AANTAL    regels afbreken op deze lengte (standaard %d)
      --footnote-style=STIJL  voetnoten produceren volgens deze stijl; indien
                                'end', dan aan het einde van de pagina waarin
                                ze zijn gedefinieerd (standaard); indien
                                'separate', dan in een aparte pagina
      --paragraph-indent=XX   alinea's inspringen met XX spaties (standaard %d);
                                indien 'none', dan niet inspringen; indien
                                'asis', dan bestaande inspringing behouden
      --split-size=GETAL      bestanden opsplitsen vanaf deze grootte
                                (standaard %d bytes)
 Opmaakselectie (standaard wordt Info-opmaak geproduceerd):
      --docbook               Docbook-XML produceren
      --html                  HTML produceren
      --plaintext             platte tekst produceren
      --xml                   Texinfo-XML produceren
 Bestandseinde werd bereikt vóór een bijbehorende @end %s Het gevraagde drijvendekommatype '%s' werd niet eerder gebruikt Te veel kolommen in 'multitable'-item (maximaal %d) Te veel fouten!  Gestopt.
 Texinfo-bestanden omzetten naar een bepaalde opmaak.
Standaard worden 'Info'-bestanden aangemaakt.  Deze kunnen
gelezen worden met 'emacs' of met het zelfstandige 'info'.
 Typ '%s --help' voor meer informatie.
 Onbekend commando '%s' Onbekende index '%s' Onbekende index '%s' in @printindex Ongepaarde '%c%s' Gebruik:  %s [OPTIE]... TEXINFO-BESTAND...
 Gebruik '{...}' om een commando als argument mee te geven aan @%s '@end' verwachtte '%s', maar vond '%s' hier was de eerdere definitie van '%s' @tab buiten een 'multitabel' wordt genegeerd loze tekst '%s' na @multitable wordt genegeerd macro '%s' is al eerder gedefinieerd @end %s komt niet overeen met @%s uw @top-pagina moet mogelijk ingepakt worden in @ifnottex in plaats van @ifinfo? ongedefinieerde vlag: %s onbekende coderingsnaam '%s' naar pagina '%s' wordt niet verwezen 