��    ?        Y         p  E  q     �  6   �               1  1   G  @   y  D   �  <   �  F   <     �  "   �  %   �  /   �  E   	     ^	  2   ~	  R   �	  &   
     +
     C
  l  c
  �   �  �   �  (   d  ^  �      �  $     d  2  �  �  w  �     �  )        /  >   F  (   �  �  �  �  /  :  �  #      -   7   ,   e      �   �   �   &   E!     l!     �!  !   �!     �!  &   �!  2   �!  "   !"  '   D"  #   l"  *   �"     �"     �"  J   �"     @#     S#     s#  }  �#  W  %  #   `&  J   �&  "   �&     �&     '  6   ('  \   _'  f   �'  H   #(  [   l(     �(  1   �(  3   )  9   G)  S   �)  &   �)  @   �)  b   =*  =   �*      �*  +   �*  �  ++     /  �   	0  8   �0  �  1  )   �3  1   �3  �  �3  &  �6  �  �9     Q;  ?   b;  &   �;  m   �;  /   7<  �  g<  2  
>  P  =B  3   �C  >   �C  :   D     <D  �   WD  ,   *E     WE     sE  )   �E  #   �E  (   �E  R   F  4   XF  -   �F  5   �F  E   �F      7G  %   XG  X   ~G     �G  '   �G  $   H     -           8                 =   +             3      2   !                       $   )             9          5   6       &   0   >   ;                 '             <   .   4   "                ?            7   %       #      	       :           /   *                               
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
 Use braces to give a command as an argument to @%s `@end' expected `%s', but saw `%s' here is the previous definition of `%s' ignoring @tab outside of multitable ignoring stray text `%s' after @multitable macro `%s' previously defined mismatched @end %s with @%s perhaps your @top node should be wrapped in @ifnottex rather than @ifinfo? undefined flag: %s unrecognized encoding name `%s' unreferenced node `%s' Project-Id-Version: texinfo 4.12.94
Report-Msgid-Bugs-To: bug-texinfo@gnu.org
POT-Creation-Date: 2010-07-01 00:03+0200
PO-Revision-Date: 2008-08-25 10:25+0200
Last-Translator: Michael Piefel <piefel@informatik.hu-berlin.de>
Language-Team: German <translation-team-de@lists.sourceforge.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8-bit
   Die Voreinstellungen für die @if...-Bedingungen hängen vom Ausgabeformat ab:
  wird HTML erzeugt, ist --ifhtml an und die anderen sind aus;
  wird Info erzeugt, ist --ifinfo an und die anderen sind aus;
  wird reiner Text erzeugt, ist --ifplaintext an und die anderen sind aus;
  wird XML erzeugt, ist --ifxml an und die anderen sind aus.
 %c%s erwartete geschweifte Klammern %c%s erwartet einen einzelnen Buchstaben „i“ oder „j“ als Argument %c%s fehlende schließende Klammer %c%s erfordert einen Namen %cend Makro nicht gefunden %s benötigt ein Argument: den Formatierer für %citem %s: Argument für --footnote-style muss „separate“ oder „end“ sein, nicht „%s“.
 %s: Argument für --paragraph-indent muss numerisch, „none“ oder „asis“ sein, nicht „%s“.
 %s: Ignoriere nicht erkannten Wert „%s“ für TEXINFO_OUTPUT_FORMAT.
 %s: Entferne Ausgabedatei „%s“ wegen Fehler; --force benutzen, um diese beizubehalten.
 %s: Datei-Angabe fehlt.
 %s:%d: CSS-Datei endete inmitten eines Kommentars @%s nicht sinnvoll innerhalb eines „@%s“-Blocks @%s nicht sinnvoll außerhalb einer „@float“-Umgebung @%s nicht sinnvoll außerhalb von „@titlepage“- und „@quotation“-Umgebungen @image-Datei „%s“ nicht lesbar: %s @sp erfordert ein positives numerisches Argument, nicht „%s“ @strong{Bemerkung...} erzeugt einen Pseudo-Querverweis in Info; umformulieren, um das zu vermeiden Fehlerhaftes Argument „%s“ zu „@%s“, benutze „%s“ Fehlerhafte Argumente zu @%s: %s Kann Verzeichnis „%s“ nicht anlegen: %s Bedingte Verarbeitung in Eingabe:
  --ifdocbook       @ifdocbook und @docbook bearbeiten, selbst wenn kein Docbook
                      erzeugt wird
  --ifhtml          @ifhtml und @html bearbeiten, selbst wenn kein HTML
                      erzeugt wird
  --ifinfo          @ifinfo bearbeiten, selbst wenn kein Info erzeugt wird
  --ifplaintext     @ifplaintext bearbeiten, selbst wenn kein Text erzeugt wird
  --iftex           @iftex und @tex bearbeiten; impliziert --no-split
  --ifxml           @ifxml und @xml bearbeiten
  --no-idocbook     @ifdocbook- und @docbook-Text nicht bearbeiten
  --no-ifhtml       @ifhtml- und @html-Text nicht bearbeiten
  --no-ifinfo       @ifinfo-Text nicht bearbeiten
  --no-ifplaintext  @ifplaintext-Text nicht bearbeiten
  --no-iftex        @iftex- und @tex-Text nicht bearbeiten
  --no-ifxml        @ifxml und @xml nicht bearbeiten

   Außerdem werden bei den --no-ifFORMAT-Optionen auch die entsprechenden
   @ifnoFORMAT-Abschnitte bearbeitet.
 Copyright © %s Free Software Foundation, Inc.
Lizenz GPLv3+: GNU GPL Version 3 oder höher <http://gnu.org/licenses/gpl.html>
Dies ist freie Software: Sie können sie ändern und weiter verteilen.
Es gibt KEINERLEI Garantie, soweit es das Gesetz erlaubt.
 Fehlerberichte (auf Englisch, mit LC_ALL=C) per E-Mail an bug-texinfo@gnu.org
schicken, allgemeine Fragen und Gedankenaustausch an help-texinfo@gnu.org.
Texinfos Homepage: http://www.gnu.org/software/texinfo/ Eintrag für Index „%s“ außerhalb jeglichen Knotens Beispiele:
  makeinfo foo.texi                    Info gemäß @setfilename von foo schreiben
  makeinfo --html foo.texi             HTML gemäß @setfilename schreiben
  makeinfo --xml foo.texi              Texinfo XML gemäß @setfilename schreiben
  makeinfo --docbook foo.texi          DocBook XML gemäß @setfilename schreiben
  makeinfo --no-headers foo.texi       reinen Text in Standardausgabe schreiben

  makeinfo --html --no-headers foo.texi  HTML ohne Menüs oder „Knoten“-Zeilen
  makeinfo --number-sections foo.texi    Info mit nummerierten Abschnitten
  makeinfo --no-split foo.texi           nur eine Info-Datei (kann groß sein)
 Erwartete @%s on oder off, nicht „%s“ Fußnote außerhalb eines Elternknotens definiert Allgemeine Optionen:
      --error-limit=ZAHL      nach ZAHL Fehlern beenden (Standard %d)
      --document-language=SPR  Locale für die Übersetzung von Texinfo-
                                Schlüsselwörtern im Ausgabedokument (Standard: C)
      --force                 Ausgabedatei auch bei Fehlern nicht löschen
      --help                  diese Hilfe zeigen und beenden
      --no-validate           Überprüfen der Knoten-Querverweise unterdrücken
      --no-warn               Warnungen (aber keine Fehler) unterdrücken
  -v, --verbose               ausführlich die Bearbeitungschritte anzeigen
      --version               Programmversion anzeigen und beenden
 Allgemeine Ausgabe-Optionen:
  -E, --macro-expand DATEI  originalen Quelltext mit expandierten Makros in
                              DATEI ausgeben, dabei @setfilename ignorieren
      --no-headers          Knoten-Unterteiler, „Knoten:“-Kopfzeilen und Menüs
                              unterdrücken in Info-Ausgabe (also reinen Text
                              erstellen) oder HTML (also kürzere Ausgabe erzeugen);
                              außerdem in die Standardausgabe schreiben
      --no-split            Aufteilen langer Info- oder HTML-Dateien unterdrücken,
                              nur eine Ausgabedatei erzeugen
      --number-sections     Kapitel-, Abschnitt- und Anhangzählungen ausgeben
  -o, --output=DATEI        Ausgabe in DATEI (Verzeichnis bei aufgeteiltem HTML)
 Eingabedatei-Optionen:
      --commands-in-node-names  @-Befehle in Knotennamen zulassen
  -D VAR                        eine Variable definieren (wie mit @set)
  -I VERZ                       VERZ an den Suchpfad für @include anhängen
  -P VERZ                       VERZ dem Suchpfad für @include voranstellen
  -U VAR                        eine Variable aufheben (wie mit @clear)
 Fehlplazierte %c Muss in einer „@%s“-Umgebung sein, um „@%s“ zu benutzen Kein übereinstimmendes „%cend %s“ Dem Knoten „%s“ fehlt ein Menüeintrag für „%s“, obwohl er dessen Ziel für „aufwärts“ (Up) ist Nur @%s 10 oder 11 unterstützt, nicht „%s“ Optionen für HTML:
      --css-include=DATEI     DATEI in HTML-<style>-Ausgabe einfügen;
                                aus Standardeingabe, wenn DATEI „-“ ist
      --css-ref=URL           Verweis auf eine CSS-Datei generieren
      --internal-links=DATEI  Liste interner Verweise in DATEI erzeugen
      --transliterate-file-names
                              Dateinamen in ASCII-Transliteration produzieren
 Optionen für Info und Nur-Text:
      --disable-encoding      keine akzentuierten und speziellen Zeichen in die
                                 Info-Ausgabe gemäß @documentencoding ausgeben
      --enable-encoding       Wirkung von --disable-encoding aufheben (Standard)
      --fill-column=ZAHL      Zeilen nach ZAHL Zeichen umbrechen (Standard %d)
      --footnote-style=STIL   Fußnoten in Info gemäß STIL ausgeben:
                                „separate“: Fußnoten in eigenen Knoten
                                            platzieren;
                                „end“: Fußnoten an das Ende des Knotens setzen,
                                       in dem sie definiert sind (Standard)
      --paragraph-indent=WERT Info-Absätze mit WERT Leerzeichen einziehen
                                (Standard %d);
                                WERT ist „none“: nicht einziehen;
                                WERT ist „asis“: existierende Einzüge behalten
      --split-size=GRÖSSE     in GRÖSSE große Dateien splitten (Standard %d)
 Optionen zur Wahl des Ausgabeformats (Voreinstellung ist Info):
      --docbook               DocBook XML anstelle von Info ausgeben
      --html                  HTML anstelle von Info ausgeben
      --xml                   Texinfo XML anstelle von Info ausgeben
      --plaintext             einfachen Text anstelle von Info ausgeben
 Dateiende vor erforderlichem „@end %s“ erreicht Angeforderter Fließumgebungstyp „%s“ vorher nicht benutzt Zu viele Spalten im „@multitable“-Eintrag (maximal %d) Zu viele Fehler! Abbruch.
 Übersetzt Texinfo-Quelldatei-Dokumentation in verschiedene andere Formate,
standardmäßig in Info-Dateien, die online mit einem Info-Leser wie
GNU Info (oder auch Emacs, TkInfo, etc.) gelesen werden können.
 „%s --help“ gibt weitere Informationen.
 Unbekannter Befehl „%s“ Unbekannter Index „%s“ Unbekannter Index „%s“ in @printindex Nicht übereinstimmendes „%c%s“ Aufruf: %s [OPTION]... TEXINFO-DATEI...
 Geschweifte Klammern verwenden, um einen Befehl als Argument an „@%s“ zu geben „@end“ erwartete „%s“, bekam jedoch „%s“ hier ist die frühere Definition von „%s“ @tab außerhalb einer „multitable“ wird ignoriert nicht interpretierbarer Text „%s“ nach @multitable wird ignoriert Makro „%s“ früher definiert @end %s stimmt nicht mit @%s überein vielleicht sollte der @top-Knoten eher von @ifnottex als von @ifinfo umschlossen werden? undefiniertes Flag: %s nicht erkannter Kodierungsname „%s“ Nicht referenzierter Knoten „%s“ 