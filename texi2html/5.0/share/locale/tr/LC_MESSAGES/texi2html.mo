��    ?        Y         p  E  q     �  6   �               1  1   G  @   y  D   �  <   �  F   <     �  "   �  %   �  /   �  E   	     ^	  2   ~	  R   �	  &   
     +
     C
  l  c
  �   �  �   �  (   d  ^  �      �  $     d  2  �  �  w  �     �  )        /  >   F  (   �  �  �  �  /  :  �  #      -   7   ,   e      �   �   �   &   E!     l!     �!  !   �!     �!  &   �!  2   �!  "   !"  '   D"  #   l"  *   �"     �"     �"  J   �"     @#     S#     s#  �  �#  N  %     j&  :   �&     �&     �&     �&  7   '  L   ?'  M   �'  A   �'  Y   (     v(  *   �(  $   �(  *   �(  @   )  &   M)  6   t)  b   �)  4   *     C*  #   \*  7  �*  �   �-  �   �.  *   H/  a  s/  4   �1  $   
2  �  /2    �4  �  �7     f9  6   9     �9  N   �9  6   :  �  S:  �  �;  >  �?  .   �@  .   A  ,   NA     {A  �   �A  )   ;B     eB     {B  )   �B     �B  -   �B  6   �B  %   3C     YC  *   uC  7   �C      �C     �C  O   D     dD     }D     �D     -           8                 =   +             3      2   !                       $   )             9          5   6       &   0   >   ;                 '             <   .   4   "                ?            7   %       #      	       :           /   *                               
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
PO-Revision-Date: 2008-08-25 21:25-0500
Last-Translator: Ey�p Hakan Duran <hakan_duran@hotmail.com>
Language-Team: Turkish <gnu-tr-u12a@lists.sourceforge.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-9
Content-Transfer-Encoding: 8bit
X-Generator: KBabel 1.11.4
   @if... ko�ullular�n�n �ntan�ml�lar� ��kt� format�na ba�l�d�r:
  e�er HTML olu�turuluyorsa, --ifhtml a��k, di�erleri kapal�d�r;
  e�er Info olu�turuluyorsa, --ifinfo a��k, di�erleri kapal�d�r;
  e�er salt metin olu�turuluyorsa, --ifplaintext a��k, di�erleri kapal�d�r;
  e�er XML olu�turuluyorsa, --ifxml a��k, dei�erleri kapal�d�r.
 %c%s k�me parantezi bekledi %c%s arg�man olarak tek karakter, `i' ya da `j' gerektirir %c%s eksik kapama } %c%s bir isim gerektirir %cson makrosu bulunamad� %s bir arg�man gerektirir: %c ��esi i�in bi�imlendirici %1$s: --footnote-style arg. `separate' ya da `end' olmal�d�r, `%2$s' de�il.
 %1$s: --paragraph-indent arg. say�sal/`none'/`asis' olmal�d�r, `%2$s' de�il.
 %s: Tan�namayan TEXINFO_OUTPUT_FORMAT de�eri `%s' yok say�l�yor.
 %1$s: ��kt� dosyas� `%2$s' hatalardan dolay� siliniyor; korumak i�in --force kullan�n�z.
 %s: dosya arg�man� eksik.
 %s:%d: --css-dosyas� yorum i�inde sonland� `@%s' blo�u i�inde @%s anlaml� de�il `@float' �evresi d���nda @%s anlaml� de�il `@titlepage' ve `@quotation' �evreleri d���nda @%s anlaml� de�il @image dosyas� `%1$s' okunam�yor: %2$s @sp pozitif bir say�sal arg�man gerektirir, `%s' de�il @strong{Not...} Info'da sahte bir �apraz-ba�vuru olu�turur; bundan ka��nmak i�in yaz�m� de�i�tirin `%2$s''e hatal� arg�man, `%1$s', `%3$s' kullan�l�yor @%s:%s'ye hatal� arg�man `%1$s' dizini olu�turulam�yor: %2$s Girdide ko�ullu i�lem:
  --ifdocbook       Docbook olu�turulmuyorsa bile @ifdocbook
                      ve @docbook'u i�ler.
  --ifhtml          HTML olu�turulmuyorsa bile @ifhtml ve @html'yi i�ler.
  --ifinfo          Info olu�turulmuyorsa bile @ifinfo'yu i�ler.
  --ifplaintext     Salt metin olu�turulmuyorsa bile @ifplaintext'i i�ler.
  --iftex           @iftex ve @tex i�ler; --no-split anlam�na gelir.
  --ifxml           @ifxml ve @xml'i i�ler
  --no-ifdocbook    @ifdocbook ve @docbook metnini i�lemez.
  --no-ifhtml       @ifhtml ve @html metin i�lemez.
  --no-ifinfo       @ifinfo metin i�lemez.
  --no-ifplaintext  @ifplintext metin i�lemez.
  --no-iftex        @iftex ve @tex metin i�lemez.
  --no-ifxml        @ifxml ve @xml metin i�lemez.

  Ayr�ca --no-ifFORMAT se�enekleri i�in ifnotFORMAT metnini i�ler.
 Telif Hakk� (C) %s �zg�r Yaz�l�m Vakf� Inc.
Lisans GPLv3+: GNU GPL s�r�m 3 ya da sonras� <http://gnu.org/licenses/gpl.html>
Bu �zg�r yaz�l�md�r: de�i�tirip da��tma �zg�rl���ne sahipsiniz.
Yasalar�n elverdi�i �l��de H��B�R GARANT� yoktur.
 Yaz�l�m hatalar�n� bug-texinfo@gnu.org'a,
genel soru ve tart��malar� help-texinfo@gnu.org'a g�nderiniz.
Texinfo anasayfas�: http://www.gnu.org/software/texinfo/ `%s' indeks girdisi t�m d���mlerin d���nda �rnekler:
  makeinfo foo.texi                     foo'nun @setfilename'ine Info yazar
  makeinfo --html foo.texi              @setfilename'e HTML yazar
  makeinfo --xml foo.texi               @setfilename'e XML yazar
  makeinfo --docbook foo.texi           @setfilename'e DocBook XML yazar
  makeinfo --no-headers foo.texi        standart ��kt�ya salt metin yazar

  makeinfo --html --no-headres foo.texi d���m �izgisiz, men�s�z html yazar
  makeinfo --number-sections foo.texi   numaralanm�� k�s�mlar� olan Info yazar
  makeinfo --no-split foo.texi          ne b�y�kl�kte olursa olsun tek Info dosyas� yazar
 %1$s'de a��k ya da kapal� bakleniyordu, `%2$s' de�il Dipnot, ebeveyn d���ms�z tan�mlanm�� Genel se�enekler:
      --error-limit=ADET      ADET hatadan sonra ��kar (�ntan�ml� %d).
      --document-language=STR ��kt� belgesi i�in Texinfo anahtar s�zc�klerini 
                                �evirmekte kullan�lacak yerel (�ntan�ml� C).
      --force                 hatalarda dahi ��kt�y� korur.
      --help                  bu yard�m� g�r�nt�ler ve ��kar.
      --no-validate           d���m �apraz-ba�vuru onaylamas�n� bask�lar.
      --no-warn               uyar�lar� bask�lar (fakat hatalar� de�il).
  -v, --verbose               ne yap�l�yor oldu�unu a��klar.
      --version               s�r�m bilgisini g�r�nt�ler ve ��kar.
 Genel ��kt� se�enekleri:
  -E, --macro-expand DOSYA   makro-geni�letilmi� kaynak ��kt�s�n� herhangi bir
                             @setfilename'i yoksayarak DOSYA'ya yazar.
      --no-headers           Info ya da HTML ��kt�s�nda d���m ayra�lar�n�, Node:
                               sat�rlar�n� ve men�leri bask�lar (salt metinya da daha k�sa ��kt�
                               �retmek �zere); ayr�ca, �ntan�ml� olarak
                               standart ��kt�ya yazar.
      --no-split             Info ya da HTML ��kt�s�n�n b�l�nmesini bask�lar,
                             yaln�zca bir ��kt� dosyas� olu�turur.
      --number-sections      b�l�m ve k�s�m numaralar�n�n ��kt�s�n� al�r.
  -o, --output=DOSYA         ��kt�y� DOSYA'ya yazar (b�l�nm�� HTML ise dizine).
 Girdi dosyas� se�enekleri:
      --commands-in-node-names   d���m adlar�nda @ komutlar�na izin verir.
  -D VAR                         VAR de�i�kenini, @set ile oldu�u gibi tan�mlar.
  -I DIR                         DIR'� @include arama yolu sonuna ekler.
  -P DIR                         DIR'� @include arama yolu ba��na ekler.
  -U VAR                         VAR de�i�keninin tan�m�n�, @clear ile oldu�u gibi geri al�r.
 Yanl�� yerle�tirilmi� %c `@%s' kullanmak i�in `@%s' ortam� i�inde ol(un)mal�d�r E�le�en `%cend %s' yok D���m `%s', Yukar� hedefi olmas�na kar��n, `%s' i�in eksik men� ��esi i�eriyor Yaln�zca @%1$s 10 ya da 11 destekleniyor, `%2$s' de�il HTML se�enekleri:
      --css-include=DOSYA        DOSYA'y� HTML <style> ��kt�s�nda i�erir;
                                   e�er DOSYA - ise stdin'i okur.
      --css-ref=URL           bir CSS dosyas�na ba�vuru olu�turur.
      --internal-links=DOSYA   DOSYA i�inde i� linklerin listesini �retir.
      --transliterate-file-names
                              dosya isimlerini ASCII alfabesine d�n��t�rerek �retir.
 Info ve salt metin i�in se�enekler:
      --disable-encoding      aksanl� ve �zel karakterlerin ��kt�s�n� @documentencoding'e
                                dayal� olarak Info ��kt�s�na yazmaz.
      --enable-encoding       --disable encoding'i (�ntan�ml�) ge�ersiz k�lar.
      --fill-column=ADET       Info sat�rlar�n� ADET karakterde bitir (�ntan�ml� %d)
      --footnote-style=ST�L   Info'da dipnotlar�n ��kt�s�n� ST�L'e g�re yazar:
                                 kendi d���mlerine koymak i�in `separate';
                                 tan�mland�klar� d���m�n sonuna koymak i�in
                                 `end' (�ntan�ml�).
      --paragraph-indent=DEG   Info paragraflar�n� DEG bo�luk girintiler (�ntan�ml� %d).
                                E�er DEG `none' ise girintilemez; e�er DEG
                                `asis' ise mevcut girintiyi korur.
      --spilt-size=NUM        Info dosyalar�n� NUM boyutuna b�ler (�ntan�ml� %d).
 ��kt� bi�em se�imi (�ntan�ml�s� Info �retmektir):
      --docbook              Info yerine DocBook XML ��kt�s� �retir.
      --html                 Info yerine HTML ��kt�s� �retir.
      --xml                  Info yerine Texinfo XML ��kt�s� �retir.
      --plaintext            Info yerine salt metin ��kt�s� �retir.
 E�le�en @end %s'den �nce dosya sonuna ula��ld� �stenen y�zer t�r� `%s' daha �nce kullan�lmad� �ok-tablolu ��ede, �ok fazla s�tun (maks %d) �ok say�da hata!  Vazge�ildi.
 �ntan�ml� olarak Texinfo kaynak belgelerini di�er �e�itli bi�emlere �evirir
Info dosyalar� �evrimi�i Emacs ya da tek ba��na GNU Info'yla okunmak i�in uygundur.
 Daha fazla bilgi i�in `%s --help' yaz�n.
 Bilinmeyen komut `%s' Bilinmeyen indeks `%s' @printindex i�inde bilinmeyen indeks `%s' E�le�meyen `%c%s' Kullan�m: %s [SE�ENEK]... TEXINFO-DOSYASI...
 @%s'e arg�man olarak bir komut vermek i�in {} kullan�n `@end'  `%1$s' beklerdi, `%2$s' g�rd� i�te `%s''nin �nceki tan�m� �ok-tablolunun d���ndaki @tab yoksay�l�yor @multitable'dan sonraki ba��bo� metin `%s' yoksay�l�yor makro `%s' daha �nce tan�mlanm�� @%s ile e�le�meyen @end %s belki de sizin @top d���m�n�z, @ifinfo'dan ziyade @ifnottex i�ine sar�lmal�d�r? tan�mlanmam�� bayrak: %s tan�nmayan kodlama ad� `%s' ba�vurulmam�� d���m `%s' 