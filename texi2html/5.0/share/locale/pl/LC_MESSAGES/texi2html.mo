��    ?        Y         p  E  q     �  6   �               1  1   G  @   y  D   �  <   �  F   <     �  "   �  %   �  /   �  E   	     ^	  2   ~	  R   �	  &   
     +
     C
  l  c
  �   �  �   �  (   d  ^  �      �  $     d  2  �  �  w  �     �  )        /  >   F  (   �  �  �  �  /  :  �  #      -   7   ,   e      �   �   �   &   E!     l!     �!  !   �!     �!  &   �!  2   �!  "   !"  '   D"  #   l"  *   �"     �"     �"  J   �"     @#     S#     s#  u  �#  n   %  #   o&  ;   �&  !   �&     �&     '  ,   '  K   K'  K   �'  B   �'  R   &(      y(  1   �(  '   �(  -   �(  @   ")      c)  9   �)  _   �)  (   *     G*  $   `*  �  �*    {.  �   �/  .   V0  �  �0  %   D3  *   j3  �  �3  �  Z6    O9     S;  -   f;     �;  G   �;  .   �;  �  &<  �  �=  J  �A  2   �B  ;   C  8   PC     �C  �   �C  .   ID     xD     �D  "   �D     �D  (   �D  J   E  *   QE     |E      �E  /   �E  #   �E     F  ?   ,F     lF  "   �F     �F     -           8                 =   +             3      2   !                       $   )             9          5   6       &   0   >   ;                 '             <   .   4   "                ?            7   %       #      	       :           /   *                               
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
PO-Revision-Date: 2008-08-16 22:12+0200
Last-Translator: Jakub Bogusz <qboosh@pld-linux.org>
Language-Team: Polish <translation-team-pl@lists.sourceforge.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-2
Content-Transfer-Encoding: 8bit
   Domy�lne opcje dla warunk�w @if... zale�� od formatu wyj�ciowego:
  je�li generowany jest HTML, --ifhtml jest w��czone, a reszta wy��czona;
  je�li generowane jest Info, --ifinfo jest w��czone, a reszta wy��czona;
  je�li generowany jest tekst, --ifplaintext jest w��czony, a inne wy��czone;
  je�li generowany jest XML, --ifxml jest w��czone, a reszta wy��czona.
 %c%s oczekiwa�o nawias�w klamrowych %c%s oczekuje pojedynczego znaku `i' lub `j' jako argumentu w %c%s brakuje klamry zamykaj�cej %c%s wymaga nazwy nie znaleziono makra %cend %s wymaga argumentu: formatowania dla %citem %s: argumentem --footnote-style musi by� `separate' lub `end', a nie `%s'.
 %s: argument --paragraph-indent musi by� liczb�/`none'/`asis', a nie `%s'.
 %s: Zignorowano nierozpoznan� warto�� TEXINFO_OUTPUT_FORMAT `%s'.
 %s: Usuwanie pliku wyj�ciowego `%s' z powodu b��d�w; --force pozwoli go zachowa�.
 %s: brakuj�cy argument plikowy.
 %s:%d: plik css zako�czy� si� wewn�trz komentarza @%s nic nie znaczy wewn�trz bloku `@%s' @%s nic nie znaczy poza �rodowiskiem `@float' @%s nic nie znaczy poza �rodowiskami `@titlepage' i `@quotation' Plik @image `%s' nieczytelny: %s @sp wymaga argumentu b�d�cego liczb� dodatni�, a nie `%s' @string{Note...} tworzy nieprawdziwe odniesienia w Info; nale�y przeredagowa� aby zapobiec temu Z�y argument `%s' dla `@%s', u�ycie `%s' Z�y argument dla @%s: %s Nie mo�na utworzy� katalogu `%s': %s Warunkowe przetwarzanie wej�cia:
  --ifdocbook       przetwarzanie @ifdocbook i @docbook nawet je�li nie jest
                      generowany Docbook.
  --ifhtml          przetwarzanie @ifhtml i @html nawet je�li nie jest
                      generowany HTML.
  --ifinfo          przetwarzanie @ifinfo nawet je�li nie jest generowane Info.
  --ifplaintext     przetwarzanie @ifplaintext nawet je�li nie jest generowany
                      czysty tekst.
  --iftex           przetwarzanie @iftex i @tex; wymusza --no-split.
  --ifxml           przetwarzanie @ifxml i @xml.
  --no-ifdocbook    nie przetwarzanie tekstu @ifdocbook i @docbook.
  --no-ifhtml       nie przetwarzanie tekstu @ifhtml i @html.
  --no-ifinfo       nie przetwarzanie tekstu @ifinfo.
  --no-ifplaintext  nie przetwarzanie tekstu @ifplaintext.
  --no-iftex        nie przetwarzanie tekstu @iftex i @tex.
  --no-ifxml        nie przetwarzanie tekstu @ifxml i @xml.

  Ponadto opcje --no-ifFORMAT powoduj� przetwarzanie tekstu @ifnotFORMAT.
 Copyright (C) %s Free Software Foundation, Inc.
Licencja GPLv3+: GNU GPL wersja 3 lub p�niejsza <http://www.gnu.org/licenses/gpl.html>
To jest oprogramowanie wolnodost�pne: mo�na je modyfikowa� i rozpowszechnia�.
Nie ma �ADNEJ GWARANCJI w zakresie dopuszczalnym przez prawo.
 Raporty o b��dach prosimy wysy�a� poczt� elektroniczn� na adres
bug-texinfo@gnu.org, a og�lne pytania i dyskusj� na help-texinfo@gnu.org.
Strona domowa texinfo: http://www.gnu.org/software/texinfo/ Wpis dla indeksu `%s' poza jakimkolwiek w�z�em Przyk�ady:
  makeinfo foo.texi                       zapisanie Info do @setfilename z foo
  makeinfo --html foo.texi                zapisanie HTML do @setfilename
  makeinfo --xml foo.texi                 zapisanie Texinfo XML do @setfilename
  makeinfo --docbook foo.texi             zapisanie DocBook XML do @setfilename
  makeinfo --no-headers foo.texi          zapisanie czystego tekstu na
                                            standardowe wyj�cie

  makeinfo --html --no-headers foo.texi   zapisanie HTML bez linii w�z��w i menu
  makeinfo --number-sections foo.texi     zapisanie Info z numerowanymi sekcjami
  makeinfo --no-split foo.texi            zapisanie jednego wielkiego pliku Info
 Oczekiwano @%s on lub off, a nie `%s' Zdefiniowano przypis bez w�z�a nadrz�dnego Opcje og�lne:
      --error-limit=ILE       zako�czenie po ILU b��dach (domy�lnie %d).
      --document-language=�A�C lokalizacja u�ywana przy t�umaczeniu s��w
                                kluczowych Texinfo dla dokumentu wyj�ciowego
                                (domy�lnie C).
      --force                 zachowanie wyj�cia nawet w przypadku b��d�w.
      --help                  wy�wietlenie tego opisu i zako�czenie.
      --no-validate           pomini�cie kontroli odsy�aczy mi�dzy w�z�ami.
      --no-warn               pomini�cie ostrze�e� (ale nie b��d�w).
  -v, --verbose               wyja�nianie co si� dzieje.
      --version               wy�wietlenie informacji o wersji i zako�czenie.
 Og�lne opcje dotycz�ce wyj�cia:
  -E, --macro-expand=PLIK     zapis �r�de� z rozwini�tymi makrami do PLIKU.
      --no-headers            pomini�cie separator�w w�z��w, linii Node oraz
                                menu z wyj�cia Info (zapisanie czystego tekstu)
                                lub z HTML (zapisanie kr�tszego pliku);
                                tak�e pisanie domy�lnie na standardowe wyj�cie.
      --no-split              pomini�cie dzielenia Info lub HTML, generowanie
                                tylko jednego pliku wyj�ciowego.
      --number-sections       zapisywanie numer�w rozdzia��w i sekcji.
  -o, --output=PLIK           zapisanie do PLIKU (lub katalogu w przypadku
                                dzielonego HTML),
 Opcje dla pliku wej�ciowego:
      --commands-in-node-names  dopuszczenie polece� @ w nazwach w�z��w.
  -D ZMIENNA                    zdefiniowanie ZMIENNEJ, tak jak przez @set.
  -I KATALOG                    do��czenie KATALOGU na pocz�tku �cie�ki
                                  poszukiwa� dla @include.
  -P KATALOG                    do��czenie KATALOGU na ko�cu �cie�ki
                                  poszukiwa� dla @include.
  -U ZMIENNA                    usuni�cie definicji ZMIENNEJ, tak jak @clear.
 �le umieszczone %c Trzeba by� w �rodowisku `@%s', aby u�y� `@%s' Brak pasuj�cego `%cend %s' W�ze� `%s' nie ma elementu menu dla `%s' pomimo bycia jego celem W g�r� Obs�ugiwane s� tylko @%s 10 lub 11, a nie `%s' Opcje dla HTML:
      --css-include=PLIK      do��czenie PLIKU w wyj�ciu HTML <style>;
                                je�li PLIK to -, czytane jest standardowe
                                wej�cie
      --css-ref=URL           wygenerowanie odniesienia do pliku CSS.
      --internal-links=PLIK   zapisanie listy wewn�trznych odno�nik�w do PLIKU.
      --transliterate-file-names
                              tworzenie nazw plik�w w transliteracji ASCII.
 Opcje dla Info i czystego tekstu:
      --disable-encoding      bez zapisu znak�w z akcentami i specjalnych do
                                pliku Info w zale�no�ci od @documentencoding.
      --fill-column=ILE       �amanie linii Info po ILU znakach (domy�lnie %d).
      --footnote-style=STYL   zapis stopek w Info zgodnie ze STYLEM:
                                `separate' - umieszczenie ich we w�asnym w�le;
                                `end' - umieszczenie na ko�cu w�z�a, w kt�rym
                                  zosta�y zdefiniowane (domy�lne).
      --paragraph-indent=ILE  wci�cia akapit�w Info o ILE spacji (domy�lnie %d).
                                Je�li ILE to `none' lub `brak', bez wci��;
                                je�li ILE to `asis' lub `zachowaj', zachowanie
                                istniej�cych wci��.
      --split-size=ROZMIAR    podzia� Info na pliki o ROZMIARZE (domy�lnie %d).
 Wyb�r formatu wyj�ciowego (domy�lnym jest info):
      --docbook               wyprodukowanie DocBook XML zamiast Info.
      --html                  wyprodukowanie HTML zamiast Info.
      --xml                   wyprodukowanie Texinfo XML zamiast Info.
      --plaintext             wyprodukowanie czystego tekstu zamiast Info.
 Osi�gni�to koniec pliku przed znalezieniem @end %s ��dany rodzaj �rodowiska float `%s' nie by� wcze�niej u�yty Zbyt du�o kolumn w elemencie multitable (maksymalnie %d) Zbyt du�o b��d�w! Poddaj� si�.
 T�umaczenie �r�d�owej dokumentacji Texinfo do r�nych innych format�w,
domy�lnie plik�w Info nadaj�cych si� do czytania pod Emacsem lub samodzielnym
GNU Info.
 Polecenie `%s --help' poda wi�cej informacji.
 Nieznane polecenie `%s' Nieznany indeks `%s' Nieznany indeks `%s' w @printindex Niedopasowane `%c%s' Sk�adnia: %s [OPCJA]... PLIK-TEXINFO...
 Nale�y u�y� nawias�w klamrowych, aby poda� polecenie jako argument dla @%s `@end' oczekiwa�o `%s', ale napotkano `%s' oto poprzednia definicja `%s' zignorowano @tab poza multitable zignorowano zab��kany tekst `%s' po @multitable makro `%s' ju� zosta�o zdefiniowane niedopasowane @end %s do @%s mo�e w�ze� @top powinien by� otoczony @ifnottex, a nie @ifinfo? niezdefiniowana flaga: %s nierozpoznana nazwa kodowania `%s' nie wskazywany w�ze� `%s' 