Þ    ?        Y         p  E  q     ·  6   Ì               1  1   G  @   y  D   º  <   ÿ  F   <       "     %   Â  /   è  E   	     ^	  2   ~	  R   ±	  &   
     +
     C
  l  c
  ÷   Ð     È  (   d  ^        ì  $     d  2  è    w       ø  )        /  >   F  (       ®  ¨  /  :  Ø  #      -   7   ,   e            ®   &   E!     l!     !  !   !     ¶!  &   Ç!  2   î!  "   !"  '   D"  #   l"  *   "     »"     Ù"  J   õ"     @#     S#     s#    #  d  %     x&  4   &     Â&     Ý&     õ&  0   '  Z   9'  ^   '  ?   ó'  P   3(     (  !    (  1   Â(  5   ô(  C   *)  #   n)  *   )  \   ½)  1   *     L*     d*    *  ÷   -  ¥   ý-  2   £.  z  Ö.  .   Q1     1  l  1  ä  4    ñ6     8  0   8     Ë8  L   é8  +   69    b9    ò:  -  >  0   °?  2   á?  9   @     N@     k@  .   ñ@      A     8A  &   PA     wA  *   A  2   ¹A  ,   ìA      B     :B  0   XB     B     §B  J   ÁB     C  #   #C     GC     -           8                 =   +             3      2   !                       $   )             9          5   6       &   0   >   ;                 '             <   .   4   "                ?            7   %       #      	       :           /   *                               
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
PO-Revision-Date: 2009-05-21 15:08ä¸­å½æ åæ¶é´
Last-Translator: Ji ZhengYu <zhengyuji@gmail.com>
Language-Team: Chinese (simplified) <translation-team-zh-cn@lists.sourceforge.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
   @if... æ¡ä»¶çé»è®¤å¼åèµäºè¾åºæ ¼å¼ï¼
  å¦æçæ HTMLï¼å --ifhtml é»è®¤å¼å¯èå¶å®çé»è®¤å³é­ï¼
  å¦æçæ Infoï¼å --ifinfo é»è®¤å¼å¯èå¶å®çé»è®¤å³é­ï¼
  å¦æçææ®éææ¬ï¼å --ifplaintext é»è®¤å¼å¯èå¶å®é»è®¤å³é­ï¼
  å¦æçæ XMLï¼å --ifxml é»è®¤å¼å¯èå¶å®é»è®¤å³é­ã
 %c%s éè¦è±æ¬å· %c%s éè¦ä»¥åä¸ªå­ç¬¦âiâæâjâä¸ºåæ° %c%s éæ¼é­åè±æ¬å· %c%s éè¦ä¸ä¸ªåå­ æ¾ä¸å°å® %cend %s éè¦ä¸ä¸ªåæ°: %citem çæ ¼å¼ååæ° %sï¼--footnote-style çåæ°å¿é¡»ä¸ºâseparateâæâendâï¼èä¸æ¯â%sâã
 %sï¼--paragraph-indent çåæ°å¿é¡»ä¸ºæ°å¼/ânoneâ/âasisâï¼èä¸æ¯â%sâã
 %s: å¿½ç¥ä¸å¯è¾¨è®¤ç TEXINFO_OUTPUT_FORMAT å¼â%sâã
 %sï¼ç±äºéè¯¯å é¤å®è¾åºæä»¶â%sâï¼ç¨ --force ä¿çå®è¾åºã
 %sï¼éæ¼æä»¶åæ°ã
 %s:%d: --css-file ä»¥æ³¨éç»å°¾ å¨â@%2$sâåä¸­â@%1$sâæ¯æ²¡ææä¹ç â@floatâç¯å¢åéå¤ç @%s æ¯æ²¡ææä¹ç å¨â@titlepageâåâ@quotationâç¯å¢åéå¤ @%s æ æä¹ @image æä»¶â%sâä¸å¯è¯»ï¼%s @sp éè¦æ­£æ°åæ°ï¼èä¸æ¯â%sâ @strong{Note...} å¨ Info ä¸­å½¢æäºä¸ä¸ªåçäº¤åå¼ç¨ï¼å¯éè¿éåé¿åæ­¤äº â%sâçéè¯¯åæ°â@%sâï¼ä½¿ç¨â%sâ @%s çéè¯¯åæ°: %s æ æ³åå»ºç®å½â%sâï¼%s è¾å¥ä¸­çæ¡ä»¶å¤çï¼
  --ifdocbook       å³ä½¿ä¸çæ Docbook 
                     ä¹å¤ç @ifdocbook å @docbookã
  --ifhtml          å³ä½¿ä¸æ¯çæ HTML ä¹å¤ç @ifhtml å @htmlã
  --ifinfo          å³ä½¿ä¸æ¯çæ Info ä¹å¤ç @ifinfoã
  --ifplaintext     å³ä½¿ä¸æ¯çææ®éææ¬ä¹å¤ç @ifplaintextã
  --iftex           å¤ç @iftex å @texï¼éå« --no-splitã
  --no-ifhtml       ä¸è¦å¤ç @ifhtml å @html ææ¬ã
  --no-ifinfo       ä¸è¦å¤ç @ifinfo ææ¬ã
  --no-ifplaintext  ä¸è¦å¤ç @ifplaintext ææ¬ã
  --no-iftex        ä¸è¦å¤ç @iftex å @tex ææ¬ã
 Copyright (C) %s Free Software Foundation, Inc.
License GPLv3+: GNU GPL version 3 or later <http://gnu.org/licenses/gpl.html>
This is free software: you are free to change and redistribute it.
There is NO WARRANTY, to the extent permitted by law.
 è¯·å°éè¯¯æ¥ååéå° bug-texinfo@gnu.orgï¼
ä¸è¬çé®é¢åè®¨è®ºè¯·åéå° help-texinfo@gnu.orgã
Texinfo ä¸»é¡µï¼http://www.gnu.org/software/texinfo/ å³äºç´¢å¼â%sâçæ¡ç®è¶åºäºææèç¹ ç¤ºä¾ï¼
  makeinfo foo.texi                     å° Info åå¥å° foo ç @setfilename
  makeinfo --html foo.texi              å° HTML åå¥å° @setfilename
  makeinfo --xml foo.texi               å° Texinfo XML åå¥å° @setfilename
  makeinfo --docbook foo.texi           å° DocBook XML åå¥å° @setfilename
  makeinfo --no-headers foo.texi        å°æ®éææ¬åå¥å°æ åè¾åº

  makeinfo --html --no-headers foo.texi è¾åº html èä¸è¾åºèç¹è¡åèå
  makeinfo --number-sections foo.texi   è¾åºå¸¦æç¼å·çèç Info
  makeinfo --no-split foo.texi          è¾åºåä¸ª Info æä»¶èä¸è®ºå¤§å°
 åºå½ @%s å¼å¯æå³é­ï¼èä¸æ¯â%sâ å®ä¹çèæ³¨æ²¡æç¶èç¹ éç¨éé¡¹ï¼
      --error-limit=NUM       å¨ NUM ä¸ªéè¯¯åéåº (é»è®¤ä¸º %d)ã
      --document-language=STR ä¸ºè¾åºçææ¡£ç¿»è¯ Texinfo å³é®å­æ¶æç¨
                               çå°åºä»£ç (é»è®¤ä¸º C)ã
      --force                 å³ä½¿åºç°éè¯¯ä¹ä¿çè¾åºæä»¶ã
      --help                  æ¾ç¤ºè¯¥æ±å©ä¿¡æ¯å¹¶éåºã
      --no-validate           ä¸è¿è¡äº¤åå¼ç¨æ£æ¥ã
      --no-warn               ä¸è¾åºè­¦å (ä¸æ¶åéè¯¯)ã
  -v, --verbose               è§£éé½åäºäºä»ä¹ã
      --version               æ¾ç¤ºçæ¬ä¿¡æ¯å¹¶éåºã
 éç¨è¾åºéé¡¹ï¼
  -E, --macro-expand FILE   å°å®æ©å±æºè¾åºå°æä»¶ FILEã
                            å¿½ç¥ææ @setfilenameã
      --no-headers          ä¸å¨ Info è¾åºæ HTML è¾åºä¸­çæèç¹åéç¬¦ï¼
                              èç¹ï¼è¡ï¼åèåãä»èçææ®éææ¬(Info
                              è¾åº)æè¾ç­çè¾åº(HTML è¾åº)ï¼
                              æ­¤å¤, é»è®¤è¾åºå°æ åè¾åºã
      --no-split            ä¸æ¯çæåå²ç Info æ HTML è¾åºï¼
                            èæ¯çæåä¸ªè¾åºæä»¶ã
      --number-sections     è¾åºç« èç¼å·ã
  -o, --output=FILE         è¾åºå°æä»¶ FILE (å¦ææ¯åå²ç HTML åä¸ºç®å½)ã
 è¾å¥æä»¶éé¡¹ï¼
      --commands-in-node-names   åè®¸å¨èç¹åä¸­ä½¿ç¨ @ å½ä»¤ã
  -D VAR                         å®ä¹åé VARï¼å°±è±¡ @setã
  -I DIR                         å° DIR éå å° @include æç´¢è·¯å¾ä¹åã
  -P DIR                         å° DIR è¿½å å° @include æç´¢è·¯å¾ä¹åã
  -U VAR                         åæ¶åé VAR çå®ä¹ï¼å°±è±¡ @clearã
 éè¯¯æ¾ç½®ç %c å¿é¡»å¨â@%sâç¯å¢åéä¸­ä½¿ç¨â@%sâ æ²¡æå¹éçâ%cend %sâ å°½ç®¡èç¹â%sâæ¯â%sâçä¸å±èç¹ï¼ä½ç¼ºå°ç¸å³çèåé¡¹ ä»æ¯æ @%s 10 æ 11ï¼èä¸æ¯â%sâ HTML éé¡¹:
      --css-include=FILE      å¨ HTML <style> è¾åºä¸­åå« FILEï¼
                                å¦æ FILE æ¯ - å°ä»æ åè¾å¥è¯»ååå®¹ã
      --css-ref=URL           çæä¸ä¸ª CSS æä»¶çåèã
      --internal-links=FILE   çæ FILE ä¸­åé¨è¿æ¥åè¡¨ã
      --transliterate-file-names
                              ä»¥ ASCII å­ä¹çææä»¶åã
 Info åæ®éææ¬éé¡¹ï¼
      --disable-encoding      ä¸è¦æ ¹æ® @documentencoding è¾åº Info è¾åºä¸­ç
                                éé³åç¹æ®å­ç¬¦ã
      --enable-encoding       è¦ç --disable-encoding è®¾ç½®(é»è®¤)ã
      --fill-column=NUM       å¨ç¬¬ NUM ä¸ªå­ç¬¦å¤åå Info è¡ (é»è®¤ä¸º %d)ã
      --footnote-style=STYLE  æ ¹æ® STYLE è¾åº Info ä¸­çèæ³¨ï¼
                                âseparateâå°èæ³¨ç½®äºç¬ç«çèç¹ï¼
                                âendâå°èæ³¨ç½®äºå®ä¹å®çèç¹çæ«å°¾(é»è®¤)ã
      --paragraph-indent=VAL  å° Info æ®µå¯¹é½å° VAL ä¸ªç©ºæ ¼ (é»è®¤ä¸º %d).
                                å¦æ VAL ä¸ºânoneâï¼åä¸å¯¹é½ï¼å¦æ VAL ä¸º
                                âasisâï¼ä¿çç°æçå¯¹é½ã
      --split-size=NUM        å¨å¤§å° NUM çæ¶åæå Info æä»¶ (é»è®¤ä¸º %d)ã
 è¾åºæ ¼å¼éæ© (é»è®¤çæ Info æä»¶)ï¼
      --docbook             è¾åº DocBook èä¸æ¯ Infoã
      --html                è¾åº HTML èä¸æ¯ Infoã
      --xml                 è¾åº XML (TexinfoML) èä¸æ¯ Infoã
      --plaintext           è¾åºæ®éææ¬èä¸æ¯ Infoã
 æä»¶å¨éå°å¹éç @end %s åå°±ç»æäº æè¦çæµ®ç¹ç±»åâ%sâä¸æ¯ä¸æ¬¡æç¨ç å¨å¤åè¡¨æ ¼é¡¹ç®ä¸­å«æå¤ªå¤çå (æå¤§ä¸º %d) è¿å¤çéè¯¯ï¼æ¾å¼ã
 å° Texinfo æºæä»¶è½¬æ¢ä¸ºå¶å®åç§æ ¼å¼ï¼é»è®¤è½¬æ¢ä¸ºéäº
ç± Emacs æç¬ç« GNU Info å¨çº¿æµè§ç Info æä»¶ã
 è¯ç¨â%s --helpâä»¥è·åæ´å¤ä¿¡æ¯ã
 æªç¥çå½ä»¤â%sâ æªç¥çç´¢å¼â%sâ @printindex ä¸­çæªç¥ç´¢å¼â%sâ æªå¹éçâ%c%sâ ç¨æ³ï¼%s [éé¡¹]... TEXINFO-æä»¶...
 ä½¿ç¨è±æ¬å·å°ä¸ä¸ªå½ä»¤ç¨ä½ @%s çåæ° â@endâéè¦â%sâï¼ä½çå°â%sâ è¿éæ¯â%sâåé¢çå®ä¹ å¿½ç¥å¤åè¡¨æ ¼å¤ç @tab å¿½ç¥ @multitable ä¹åçè¿å©ææ¬â%sâ å®â%sâå·²å¨åé¢å®ä¹ @end %s å @%s ä¸å¹é æ¨ç @top èç¹å¯è½åºè¯¥åå«å¨ @ifnottex èä¸æ¯ @ifinfo ä¸­ï¼ æªå®ä¹çæ è¯: %s ä¸è½è¯å«çç¼ç åç§°â%sâ æªå¼ç¨çèç¹â%sâ 