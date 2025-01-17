��    ?        Y         p  E  q     �  6   �               1  1   G  @   y  D   �  <   �  F   <     �  "   �  %   �  /   �  E   	     ^	  2   ~	  R   �	  &   
     +
     C
  l  c
  �   �  �   �  (   d  ^  �      �  $     d  2  �  �  w  �     �  )        /  >   F  (   �  �  �  �  /  :  �  #      -   7   ,   e      �   �   �   &   E!     l!     �!  !   �!     �!  &   �!  2   �!  "   !"  '   D"  #   l"  *   �"     �"     �"  J   �"     @#     S#     s#  n  �#  �  �$     �&  @   �&     �&  *   	'  8   4'  @   m'  I   �'  O   �'  A   H(  v   �(  0   )  ,   2)  =   _)  >   �)  Y   �)  -   6*  5   d*  `   �*  ;   �*     7+  '   W+  �  +    -0    =1  A   S2     �2  *   �:  9   �:  !  ;  ^  =?  �  �C     tG  E   �G  /   �G  ^   H  +   gH  �  �H  �  bJ  ^  P  R   cQ  A   �Q  9   �Q  L   2R  �   R  3   S     SS     lS  )   �S  $   �S  (   �S  6   �S  3   4T  0   hT  <   �T  :   �T  3   U  2   EU  y   xU     �U  A   
V     LV     -           8                 =   +             3      2   !                       $   )             9          5   6       &   0   >   ;                 '             <   .   4   "                ?            7   %       #      	       :           /   *                               
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
PO-Revision-Date: 2008-09-04 23:50+0200
Last-Translator: Benno Schulenberg <benno@vertaalt.nl>
Language-Team: Spanish <es@li.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Generator: KBabel 1.11.4
   Las acciones por defecto para primitivas condicionales del tipo `@if...'
  dependen en gran medida del formato de salida seleccionado:
  si este es HTML, --ifhtml estará activo, mientras el resto no;
  si este es Info, --ifinfo estará activo, mientras el resto no;
  si este es texto plano, --ifplaintext estará activo, mientras el resto no;
  si este es XML, --ifxml estará activo, mientras el resto no;
 %c%s se esperaban llaves el uso `%c%s' presupone como argumentos los caracteres `i' o `j' %c%s se esperaba leer `}' la construcción `%c%s' requiere un nombre no se encontró declaración de final de macro (`%cend') `%s' requiere un argumento: el procesador de formato para %citem %s: `--footnote-style' toma como argumentos `separate' o `end', no `%s'.
 %s: `--paragraph-indent' toma un argumento numérico/`none'/`asis', y no `%s'.
 %s: Ignorando valor desconocido de TEXINFO_OUTPUT_FORMAT (`%s').
 %s: El fichero `%s' será borrado debido a la cantidad de errores encontrados; use `--force' para preservar el mismo.
 %s: se necesita nombre de fichero que procesar.
 %s:%d: --css-file finaliza con un comentario `@%s' carece de sentido bajo la influencia de un bloque `@%s' @%s carece de sentido si se da fuera de entornos como `@float' `@%s' carece de sentido fuera de influencias de entornos como `@titlepage' o `@quotation' El fichero de imagen `%s' no es accesible: %s @sp requiere un argumento numérico positivo, no `%s' @strong{Note...} produce una referencia no deseada en Info; reescríbalo para que esto no ocurra `%s' no es un argumento correcto para `@%s', se usará `%s' Argumento erróneo para @%s: %s No se pudo crear el directorio `%s': %s Opciones para el proceso condicional de ficheros de entrada:
  --ifdocbook       procesar primitivas `@ifdocbook' y `@docbook' incluso cuando
                      el formato de salida no es Docbook.
  --ifhtml          procesar primitivas `@ifhtml' y `@html' incluso cuando el
                      formato de salida no es HTML.
  --ifinfo          procesar primitivas `@ifinfo' incluso cuando el formato de
                      salida no es Info.
  --ifplaintext     procesar primitivas `@ifplaintext' incluso cuando el formato
                      de salida no es texto plano.
  --iftex           procesar primitivas `@iftex' y `@tex', conlleva
                      `--no-split'.
  --ifxml           procesar primitivas `@ifxml' y `@xml'.
  --no-ifdocbook    no procesar primitivas `@ifdocbook' o `@docbook'.
  --no-ifhtml       no procesar primitivas `@ifhtml' o `@html'.
  --no-ifinfo       no procesar primitivas `@ifinfo'.
  --no-ifplaintext  no procesar primitivas `@ifplaintext'.
  --no-iftex        no procesar primitivas `@iftex' o `@tex'.
  --no-ifxml        no procesar primitivas `@ifxml' o `@xml'.

  También, para las opciones de tipo --no-ifFORMATO, procesar `@ifnotFORMATO'.
 Copyright (C) %s Free Software Foundation, Inc.
Licencia GPLv3+: GNU GPL versión 3 o posterior <http://gnu.org/licenses/gpl.html>
Esto es software libre: usted es libre de cambiarlo y redistribuirlo.
Dicho software es provisto SIN GARANTÍA, hasta donde permite la ley.
 Reporte cualquier tipo de problema que usted encuentra en el funcionamiento
de esta programa <bug-texinfo@gnu.org>.  Preguntas y discusiones sobre
Texinfo en general pueden ser dirigidas a <help-texinfo@gnu.org>.
El sitio web de Texinfo es: http://www.gnu.org/software/texinfo/ La entrada para el índice `%s' se encuentra fuera de nodo alguno Ejemplos:

  makeinfo foo.texi                      escribe el fichero cuyo nombre viene
                                         dado por el contenido de la primitiva
                                         `@setfilename' en el fichero de
                                         entrada, en formato Info.

  makeinfo --html foo.texi               escribe el fichero cuyo nombre viene
                                         dado por el contenido de la primitiva
                                         `@setfilename' en el fichero de
                                         entrada, en formato html.

  makeinfo --docbook foo.texi            escribe el fichero cuyo nombre viene
                                         dado por el contenido de la primitiva
                                         `@setfilename' en el fichero de
                                         entrada, en formato docbook.

  makeinfo --html --no-headers foo.texi  escribe el fichero cuyo nombre viene
                                         dado por el contenido de la primitiva
                                         `@setfilename' en el fichero de
                                         entrada, en formato HTML, sin menus o
                                         información alguna sobre nodos o
                                         líneas.

  makeinfo --number-sections foo.texi    escribe el fichero cuyo nombre viene
                                         dado por el contenido de la primitiva
                                         `@setfilename' en el fichero de
                                         entrada, en formato Info, numerando
                                         secciones y capítulos.

  makeinfo --no-split foo.texi           escribe el fichero cuyo nombre viene
                                         dado por el contenido de la primitiva
                                         `@setfilename' en el fichero de
                                         entrada, en formato Info, todo en un
                                         mismo fichero.
 Se esperaba leer @%s "on" u "off", no `%s' Nota de pie de página definida sin nodo al que referirse Opciones generales;
      --error-limit=NÚMERO    dar por finalizado el proceso del fichero en
                                cuestión tras un número de errors mayor o igual
                                a NÚMERO (por defecto %d).
      --document-language=TEXTO
                              locale a usar con el fin de traducir primitivas
                                Texinfo para el documento final (C por defecto).
      --force                 generar documento de salida incluso si se
                                encontraron errores durante el proceso.
      --help                  mostrar este mensaje de ayuda.
      --no-validate           suprimir la validación de enlaces.
      --no-warn               suprimir mensajes de precaución (pero no errores).
  -v, --verbose               explicar que se está haciendo durante el proceso
                                del documento en cuestión.
      --version               mostrar información sobre la versión de esta
                                aplicación informática.
 Opciones generales de salida:
  -E, --macro-expand=FICHERO  escribir un fichero FICHERO en el que cualquier
                                macro presente es expandido (primitivas
                                `@setfilename' serán ignoradas).
      --no-headers            suprimir separadores de nodos, líneas de `Nodo:'
                                y menús del fichero Info (produciendo así
                                texto plano) o de HTML (produciendo así un
                                documento menor); también se escribe por
                                defecto a la salida estándar (stdout).
      --no-split              no generar un documento Info o HTML multi-página;
                                generar un sólo documento que ocurre en una
                                sóla página.
      --number-sections       numerar capítulos y secciones.
  -o, --output=FICHERO        escribir en fichero FICHERO (se toma como nombre
                               de directorio si el formato de salida es HTML
                               en modo multi-documento/multi-página).
 Opciones para ficheros de entrada:
      --commands-in-node-names  permitir comandos `@' en nombres de nodo.
  -D VARIABLE                   definir la variable VARIABLE, tal y como si así
                                  hubiera sido especificado en el propio
                                  documento mediante el uso de `@set VARIABLE'.
  -I DIRECTORIO                 añadir el directorio DIRECTORIO al final de la
                                  lista de búsqueda para primitivas `@include'.
  -P DIRECTORIO                 añadir el directorio DIRECTORIO al principio
                                  de la lista de búsqueda para primitivas
                                  `@include'.
  -U VARIABLE                   definir como nula la variable VARIABLE, tal y
                                  como si así hubiera sido especificado en el
                                  propio documento mediante el uso de
                                  `@clear VARIABLE'.
 Carácter `%c' fuera de lugar Debe estar bajo la influencia del entorno `@%s' para poder usar `@%s' No hay constancia de final de bloque `%cend %s' El nodo `%s' carece de elemento de menú alguno para `%s' aunque consta como destino para `Up' Sólo @%s 10 or 11 está soportado, no `%s' Opciones para HTML:
      --css-include=FICHERO   incluir FICHERO dentro de directivas <style>;
                                leer entrada estándar si FICHERO es -.
      --css-ref=URL           generar referencias a una hoja de estilo CSS.
      --internal-links=FICHERO
                              producir lista de enlaces internos en FICHERO.
      --transliterate-file-names
                              producir nombres de ficheros en formato ASCII.
 Opciones para Info y texto plano:
      --disable-encoding      no generar acentos y caracteres especiales en el
                                documento de salida, ignorar la primitiva
                                `@documentencoding' si está presente.
      --enable-encoding       contradecir `--disable-encoding' (por defecto).
      --fill-column=NÚMERO    no generar líneas que contengan un número de
                                caracteres mayor que NÚMERO (por defecto %d).
      --footnote-style=ESTILO generar notas a pie de página de acuerdo a ESTILO:
                                `separate' para emplazarlas en un nodo propio;
                                `end' para emplazarlas al final de cada nodo
                                en el que son definidas (este es el estilo por
                                defecto).
      --paragraph-indent=NÚMERO
                              proveer a párrafos con un márgen dado por el
                                número de espacios NÚMERO (por defecto %d). Si
                                NÚMERO fuese `none' no se insertarán márgenes;
                                si NÚMERO es `asis', se preservarán los márgenes
                                tal cual son leídos desde el fichero.
      --split-size=NÚMERO     generar un documento multi-página, en el que cada
                                una es de un tamaño NÚMERO (por defecto %d).
 Selección de formato de salida (por defecto se producen ficheros Info):
      --docbook               generar un fichero en formato Docbook XML.
      --html                  generar un fichero en formato HTML.
      --xml                   generar un fichero en formato Texinfo XML.
      --plaintext             generar un fichero en texto plano.
 Se ha alcanzado el fin de fichero y no hay constancia de fin de bloque (`@end %s') El tipo de construccion `float' `%s' no ha sido usado previamente Demasiadas columnas para el elemento multi-tabla (max %d) Demasiados errores!  Se da por finalizado el proceso de este fichero aquí.
 Convierte ficheros escritos en Texinfo a varios otros formatos, por defecto a
formato Info, que puede ser leído con Emacs o el visor de ficheros Info de GNU.
 Pruebe `%s --help' para obtener más información.
 Comando desconocido `%s' Índice desconocido `%s' Índice desconocido `%s' en `@printindex' Final de bloque inexistente (`%c%s') Uso: %s [OPCIÓN]... FICHERO-TEXINFO...
 Use llaves para suplir un comando como argumento a @%s Se esperaba ver `@end' `%s', pero se ha leído `%s' la definición previa de `%s' se encuentra aquí ignorando `@tab' no influenciado por el entorno `multitable' ignorando texto incoherente `%s' después de `@multitable' el macro `%s' ya ha sido definido en este documento se esperaba leer `@end %s' pero se ha leído `@%s' ¿Quizás su nodo `@top' debería quedar bajo la influencia de un bloque `@ifnottex' en vez de la de un bloque `@ifinfo'? etiqueta indefinida: %s `%s' no se corresponde con ningún tipo de codificación conocido Nodo `%s' no referenciado 