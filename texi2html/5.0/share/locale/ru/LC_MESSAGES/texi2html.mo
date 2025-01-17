��    3      �  G   L      h  E  i     �  6   �     �          )  1   ?  @   q  D   �  <   �  F   4     {  "   �  %   �  /   �  E        V  2   v  R   �  &   �     #	  l  C	  (   �  $   �  w  �     v  )   �     �  >   �  #     ,   '     T  �   p  &        .     C  !   V     x  &   �  2   �  "   �  '     #   .  *   R     }     �  J   �               5  N  L  B  �  "   �  9     !   ;     ]     |  :   �  K   �  W     B   t  q   �  &   )  (   P  &   y  &   �  ;   �  )     D   -  f   r  6   �  #       4  .   7  '   f  +  �     �  2   �        F      2   b   6   �   !   �   �   �   @   �!     �!  !   �!  /   
"     :"  ,   J"  L   w"  '   �"  "   �"     #  (   ,#  !   U#     w#  G   �#     �#      �#     $         1   )   #                    *   
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
PO-Revision-Date: 2005-02-07 09:27+0300
Last-Translator: Oleg S. Tihonov <ost@tatnipi.ru>
Language-Team: Russian <ru@li.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=koi8-r
Content-Transfer-Encoding: 8bit
 �� ��������� ��������� �������� ������ @if... ������� �� ��������� �������:
  ��� ������ HTML ������� --ifhtml, � ��������� ���������;
  ��� ������ Info ������� --ifinfo, � ��������� ���������;
  ��� ������ �������� ������ ������� --ifplaintext, ��������� ���������;
  ��� ������ XML ������� --ifxml, ��������� ���������.
 %c%s ������������� �������� ������ %c%s ������� � �������� ��������� ���� ������ `i' ��� `j' %c%s ��������� ����������� ������ ������� %c%s ����� ������� ��� �� ��������� %cend macro %s ������ �������������� c ����������: �������� ��� %citem %s: �������� --footnote-style ������ ���� `separate' ��� `end'; � �� `%s'.
 %s: �������� --paragraph-indent ������ ���� ��������, ���
`none', ��� `asis'; �� `%s'.
 %s: ����������� �������� TEXINFO_OUTPUT_FORMAT `%s' ������������.
 %s: �������� ��������� ����� `%s' -- ���� ������;
����������� --force, ����� ������������� ��������� ����������.
 %s: �������� ��������, �������� ����.
 %s:%d: css-���� ���������� � ����������� @%s �� ����� ������ ������ ����� `@%s' @%s �� ����� ������ ��� ����� `@float' @%s �� ����� ������ ��� ����� `@titlepage' ��� `@quotation' ���������� ��������� @image ���� `%s': %s ������� @sp ����� ������� ������������� �������� ��������, � �� `%s' @strong{Note...} ������� � Info ������ ������������ ������; �������������� �����, ����� �������� ����� ������ �������� `%s' ��� `@%s', ����� ����������� `%s' ���������� ������� ������� `%s': %s �������� ��������� ��������� ������:
  --ifhtml          ������������ ����� ������ ������ @ifhtml � @html,
                      ���� ��� ������ �� � ������� HTML.
  --ifinfo          ������������ ����� ������ ������ @ifinfo, ���� ���
                      ������ �� � ������� Info.
  --ifplaintext     ������������ ����� ������ ������ @ifplaintext, ���� ���
                      ������ �� � ������� �������� ������.
  --iftex           ������������ ����� ������ ������ @iftex � @tex;
                      ������������� --no-split.
  --ifxml           ������������ ����� ������ ������ @ifxml � @xml.
  --no-ifhtml       �� ������������ ����� ������ ������ @ifhtml � @html.
  --no-ifinfo       �� ������������ ����� ������ ������ @ifinfo.
  --no-ifplaintext  �� ������������ ����� ������ ������ @ifplaintext.
  --no-iftex        �� ������������ ����� ������ ������ @iftex � @tex.
  --no-ifxml        �� ������������ ����� ������ ������ @ifxml � @xml.

  ����� ����, ��� ������ --no-if������, ������������ ����� @ifnot������.
 ��������� ��� �������� ��������� `%s' ��� ���� ������ ���������� ��� ������������ ���� �����, ����������� �������� �������:
      --commands-in-node-names   ��������� ������������� @-������ � ������ ���.
 -D ����������           ���������� ����������, ���������� ������������� @set.
 -I �������              �������� ������� � ����� ������ ������ ����������
                           ������ @include.
 -P �������              �������� ������� � ������ ������ ������ ����������
                           ������ @include.
 -U ����������           ������� ���������� ��������������, ����������
                           ������������� @clear.
 ����� �� ������ ���� %c ����� ���� � ����� `@%s', ����� ������������ `@%s' ��� ������ `%cend %s' ���� `%s' �� ����� ������ ���� ��� `%s', ���� �� ��� ��������� ���� Up ����� ����� ������ ��������������� ������� @end %s ������� ����� ������� � �������� ������� (�������� %d) ������� ����� ������! ���������.
 ����������� ������������ � ������� Texinfo � ������ �������, ��
��������� � Info-�����, ������� ����� ������ � ������� Emacs ���
��������� ��������� GNU Info.
 ���������� `%s --help' ��� ��������� ����� ���������� ��������.
 ����������� ������� `%s' ������� ��������� `%s' ���������� ���������� ������� ��������� `%s' � @printindex �������� `%c%s' �������������: %s [����]... TEXINFO-����...
 ����������� �������� ������, ����� �������� @%s ������� � �������� ��������� ��������� `@end' � `%s', ��������� `%s' ����� ����������� ����������� `%s' @tab ��� ������� ����������� ����� `%s' ����� @multitable ����������� ����� `%s' ���� ���������� ������ �������� @end %s � @%s ��������, ���� ���� @top ������ ���� � ����� @ifnottex, � �� � @ifinfo? �������������� ����: %s ��� ��������� `%s' �� ���������� �� ���� `%s' ��� ������ 