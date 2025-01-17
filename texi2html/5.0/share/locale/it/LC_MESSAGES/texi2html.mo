��    ?        Y         p  E  q     �  6   �               1  1   G  @   y  D   �  <   �  F   <     �  "   �  %   �  /   �  E   	     ^	  2   ~	  R   �	  &   
     +
     C
  l  c
  �   �  �   �  (   d  ^  �      �  $     d  2  �  �  w  �     �  )        /  >   F  (   �  �  �  �  /  :  �  #      -   7   ,   e      �   �   �   &   E!     l!     �!  !   �!     �!  &   �!  2   �!  "   !"  '   D"  #   l"  *   �"     �"     �"  J   �"     @#     S#     s#  S  �#  2  �$  %   &  C   7&  #   {&     �&     �&  1   �&  Q   �&  W   Q'  C   �'  K   �'     9(  )   R(  :   |(  >   �(  T   �(  $   K)  7   p)  U   �)  1   �)     0*  *   M*  _  x*    �-  �   �.  3   �/  2  �/  9   3  ;   <3  �  x3  }  ,6  �  �9     ?;  3   N;  "   �;  Y   �;  .   �;  �  .<  �  �=  7  �A  ?   �B  @   9C  2   zC     �C  �   �C  /   uD     �D     �D  (   �D     E  %   !E  @   GE  P   �E  (   �E  $   F  /   'F  *   WF     �F  Z   �F     �F  8   G     KG     -           8                 =   +             3      2   !                       $   )             9          5   6       &   0   >   ;                 '             <   .   4   "                ?            7   %       #      	       :           /   *                               
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
 Use braces to give a command as an argument to @%s `@end' expected `%s', but saw `%s' here is the previous definition of `%s' ignoring @tab outside of multitable ignoring stray text `%s' after @multitable macro `%s' previously defined mismatched @end %s with @%s perhaps your @top node should be wrapped in @ifnottex rather than @ifinfo? undefined flag: %s unrecognized encoding name `%s' unreferenced node `%s' Project-Id-Version: texinfo 4.13
Report-Msgid-Bugs-To: bug-texinfo@gnu.org
POT-Creation-Date: 2010-07-01 00:03+0200
PO-Revision-Date: 2009-07-18 16:17+0200
Last-Translator: Francesco Groccia <fgr@anche.no>
Language-Team: Italian <tp@lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
   L'azione predefinita per gli @if... condizionali dipende dal formato di output:
  se è HTML, --ifhtml è attivo e tutti gli altri no;
  se è Info, --ifinfo è attivo e tutti gli altri no;
  se è testo, --ifplaintext è attivo e tutti gli altri no;
  se è XML, --ifxml è attivo e tutti gli altri no.
 %c%s si aspettava le parentesi graffe %c%s si aspettava un singolo carattere «i» o «j» come argomento %c%s parentesi di chiusura mancante %c%s richiede un nome %cend macro non trovata %s richiede un argomento: formattatore per %citem %s: l'argomento --footnote-style deve essere «separate» o «end», non «%s».
 %s: l'argomento --paragraph-indent deve essere numerico/«none»/«asis», non «%s».
 %s: ignora il valore sconosciuto di TEXINFO_OUTPUT_FORMAT («%s»)
 %s: Rimuovi file «%s» a causa degli errori; usa --force per preservarlo.
 %s: nome file mancante.
 %s:%d: --css-file termina con un commento @%s è privo di significato all'interno del blocco «@%s» @%s è privo di significato aldifuori dell'ambiente «@float» @%s è privo di significato aldifuori degli ambienti «@titlepage» e «@quotation» file @image «%s» non leggibile: %s @sp richiede un argomento numerico positivo, non «%s» @strong{Nota...} produce un riferimento falso; riscrivilo per evitare che non succeda Argomento «%s» errato per «@%s», usare «%s» Argomento errato per @%s: %s Impossibile creare la directory «%s»: %s Elaborazione condizionale in input:
  --ifdocbook       processa @ifdocbook e @docbook anche quando il formato non è Docbook.
  --ifhtml          processa @ifhtml e @html anche quando il formato non è HTML.
  --ifinfo          processa @ifinfo anche quando il formato non è Info.
  --ifplaintext     processa @ifplaintext anche quando il formato non è testo.
  --iftex           processa @iftex e @tex; implica l'opzione --no-split.
  --ifxml           processa @ifxml e @xml.
  --no-ifdocbook    non processare @no-ifdocbook e @ifdocbook.
  --no-ifhtml       non processare @ifhtml e @html.
  --no-ifinfo       non processare @ifinfo.
  --no-ifplaintext  non processare @ifplaintext.
  --no-iftex        non processare @iftex e @tex.
  --no-ifxml        non processare @ifxml e @xml.

  Inoltre, per le opzioni «--no-ifFORMAT» non processare @ifnotFORMAT.
 © Copyright %s Free Software Foundation, Inc.
Licenza GPLv3+: GNU GPL versione 3 o successive <http://gnu.org/licenses/gpl.html>.
Questo è software libero: siete liberi di modificarlo e ridistribuirlo.
Non c'è ALCUNA GARANZIA, per quanto consentito dalle leggi vigenti.
 Per segnalare un bug inviare un'email a bug-texinfo@gnu.org,
per domande generali e discussioni: help-texinfo@gnu.org.
Sito web di Texinfo: http://www.gnu.org/software/texinfo/ Voce per l'indice «%s» non presente in alcun nodo Esempi:
  makeinfo foo.texi                      scrive in formato Info; il nome viene ricavato dalla variabile @setfilename
  makeinfo --html foo.texi               scrive in formato HTML; il nome viene ricavato dalla variabile @setfilename
  makeinfo --xml foo.texi                scrive in formato Texinfo XML; il nome viene ricavato dalla variabile @setfilename
  makeinfo --docbook foo.texi            scrive in formato DocBook XML; il nome viene ricavato dalla variabile @setfilename
  makeinfo --no-headers foo.texi         scrive in formato testo sullo standard output
  makeinfo --html --no-headers foo.texi  scrive in formato HTML senza righe e menù
  makeinfo --number-sections foo.texi    scrive in formato Info con le sezioni numerate
  makeinfo --no-split foo.texi           scrive in un solo file Info
 Si aspettava la lettura @%s "on" oppure "off", non «%s» Note a piè di pagina definite senza un nodo di riferimento       --error-limit=NUM       esci dopo NUM errori (predefinito %d).
      --document-language=STR localizzazione da usare nella traduzione delle
                                parole chiavi di Texinfo per il documento di
                                output (predefinito C).
      --force                 genera il documento di output anche in presenza di errori.
      --help                  mostra questa guida ed esce.
      --no-validate           ignora la convalida dei link.
      --no-warn               ignora gli avvertimenti (ma non gli errori).
  -v, --verbose               spiega cosa sta facendo.
      --version               mostra le informazioni di versione ed esce.
 Opzioni generali di output:
  -E, --macro-expand=FILE     scrivi un file FILE con i sorgenti macro-expanded,
                                ignorando qualunque @setfilename.
      --no-headers            ignora i separatori dei nodi, le righe del «Nodo:»
                                e i menù dal file di output (generando un file di
                                testo) o dal formato HTML (generando un file più corto);
                                in modo predefinito scrive sullo standard output.
      --no-split              ignora la scrittura multipagina del formato Info o HTML,
                              generando un solo file di output.
      --number-sections       scrive capitoli e numeri di sezione.
  -o, --output=FILE           scrive sul file FILE (o viene considerato come cartella se
                              il formato di output è HTML multipagina).
 Opzioni file input:
      --commands-in-node-names  consenti comandi «@» nei nomi del nodo.
  -D VAR                        definisce la variabile VAR, simile a @set.
  -I DIR                        aggiungi DIR al percorso di ricerca @include.
  -P DIR                        anteponi DIR al percorso di ricerca @include.
  -U VAR                        indefinisci la variabile VAR, simile a @clear.
 %c fuori luogo Deve essere nell'ambiente «@%s» per usare «@%s» Nessun corrispondente «%cend %s» Il nodo «%s» non ha alcuna voce di menù per «%s», nonostante sia destinata ad «Up» Solo @%s "10" o "11" è supportata, non «%s» Opzioni per HTML:
      --css-include=FILE      include il file FILE nella direttiva <style>;
                                legge lo standard input se FILE è «-».
      --css-ref=URL           genera un riferimento al file CSS.
      --internal-links=FILE   genera una lista dei collegamenti interni nel file FILE.
      --transliterate-file-names
                              genera nomi di file nella traslitterazione ASCII.
 Opzioni per il formato Info e testo:
      --disable-encoding      non scrivere gli accenti e i caratteri speciali
                                nel file in formato Info basati su @documentencoding.
      --enable-encoding       ignora l'opzione --disable-encoding (predefinito).
      --fill-column=NUM       non generare un file con righe maggiori di NUM caratteri (predefinito %d).
      --footnote-style=STILE  scrivi le note a piè di pagina in accordo con lo stile STILE:
                                «separate» situato su nodo a sé;
                                «end» situato alla fine di ogni nodo nei quali sono stati definiti
                                (predefinito).
      --paragraph-indent=VAL  rientra i paragrafi di VAL spazi (predefinito %d). Se il numero è «none»,
                                non rientra; se è «asis» mantiene il rientro esistente.
      --split-size=NUM        genera un documento multipagina di dimensioni NUM (predefinito %d).
 Selezione del formato di output (predefinito Info):
      --docbook               genera un file in formato Docbook XML.
      --html                  genera un file in formato HTML.
      --xml                   genera un file in formato Texinfo.
      --plaintext             genera un file in formato testo.
 Raggiunta la fine del file prima del blocco di chiusura @end %s Il tipo a virgola mobile «%s» non è stato usato in precedenza Troppe colonne nell'elemento multitabella (max %d) Troppi errori! Rinuncio.
 Tradurre il sorgente della documentazione di Texinfo in vari altri formati,
per impostazione predefinita i file Info sono adatti alla lettura con Emacs
oppure con GNU Info.
 Usare «%s --help» per maggiori informazioni.
 Comando «%s» sconosciuto Indice «%s» sconosciuto Indice «%s» sconosciuto in @printindex «%c%s» senza corrispondenza Uso: %s [OPZIONE]... FILE-TEXINFO...
 Usa le parentesi graffe per dare un comando come argomento a @%s «@end» si aspettava il carattere «%s», ma è stato letto il carattere «%s» ecco la definizione precedente di «%s» ignora @tab fuori della multitabella ignora il testo vagante «%s» dopo @multitable macro «%s» già definita precedentemente @end %s mancante con @%s forse, il nodo @top dovrebbe essere sotto un blocco @ifnottex piuttosto che sotto @ifinfo? indicatore non definito: %s il nome «%s» non corrisponde ad alcun nome di codifica nodo «%s» non referenziato 