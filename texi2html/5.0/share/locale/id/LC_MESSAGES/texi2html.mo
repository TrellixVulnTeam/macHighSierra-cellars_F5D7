��    ?        Y         p  E  q     �  6   �               1  1   G  @   y  D   �  <   �  F   <     �  "   �  %   �  /   �  E   	     ^	  2   ~	  R   �	  &   
     +
     C
  l  c
  �   �  �   �  (   d  ^  �      �  $     d  2  �  �  w  �     �  )        /  >   F  (   �  �  �  �  /  :  �  #      -   7   ,   e      �   �   �   &   E!     l!     �!  !   �!     �!  &   �!  2   �!  "   !"  '   D"  #   l"  *   �"     �"     �"  J   �"     @#     S#     s#  |  �#  f  %     n&  A   �&     �&     �&     �&  5   '  I   M'  K   �'  @   �'  X   $(     }(  )   �(  $   �(  ,   �(  @   )  )   V)  :   �)  f   �)  -   "*     P*  &   i*  ~  �*  "  .  �   2/  2   �/  `   0  "   a2  0   �2  }  �2    35  �  B8     �9  ;   �9     :  =   4:  .   r:  �  �:  �  B<  E  �?  "   =A  7   `A  8   �A  !   �A  �   �A  /   �B     �B     �B  -    C     .C  +   AC  J   mC  (   �C  +   �C  '   D  /   5D  )   eD     �D  L   �D     �D  $   E     ;E     -           8                 =   +             3      2   !                       $   )             9          5   6       &   0   >   ;                 '             <   .   4   "                ?            7   %       #      	       :           /   *                               
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
PO-Revision-Date: 2008-11-11 17:30+0700
Last-Translator: Arif E. Nugroho <arif_endro@yahoo.com>
Language-Team: Indonesian <translation-team-id@lists.sourceforge.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8bit
   Baku untuk kondisional @if... tergantung dari format keluaran:
  jika menghasilkan HTML, --ifhtml adalah on dan yang lain adalah off;
  jika menghasilkan Info, --ifinfo adalah on dan yang lain adalah off;
  jika menghasilkan plain text, --ifplaintext adalah on dan yang lain adalah off;
  jika menghasilkan XML, --ifxml adalah on dan yang lain adalah off.
 %c%s diduga kurung %c%s menduga sebuah karakter tunggal `i' atau `j' sebagai argumen %c%s hilang kurung penutup %c%s membutuhkan sebuah nama %cend makro tidak ditemukan %s membutuhkan sebuah argumen: peformat untuk %c item %s: --footnote-style arg harus berupa `separate' atau `end', bukan `%s'.
 %s: --paragraph-indent arg harus berupa numerik/`none'/`asis', bukan `%s'.
 %s: Mengabaikan nilai TEXINFO_OUTPUT_FORMAT tidak dikenal `%s'.
 %s: Menghapus berkas keluaran `%s' karena adanya errors; gunakan --force untuk menjaga.
 %s: hilang argumen berkas.
 %s:%d: --css-file berakhir dalam komentar @%s tidak berarti didalam blok `@%s' @%s tidak berarti diluar lingkungan `@float' @%s tidak berarti diluar lingkunga `@titlepage' dan `@quotation' @image berkas `%s' tidak dapat dibaca: %s @sp membutuhkan sebuah argumen numerik positif, bukan `%s' @strong{Note...} menghasilkan sebuah referensi silang spurious dalam Info; reword ke untuk menghindari Argumen `%s' ke `@%s' buruk, menggunakan `%s' Argumen ke @%s: %s buruk Tidak dapat membuat direktori `%s': %s Pemrosesan kondisional dalam masukan:
  --ifdocbook       proses @ifdocbook dan @docbook walaupun
                    tidak menghasilkan Docbook.
  --ifhtml          proses @ifhtml dan @html walaupun tidak menghasilkan HTML.
  --ifinfo          proses @ifinfo walaupun tidak menghasilkan Info.
  --ifplaintext     proses @ifplaintext walaupun tidak menghasilkan plain teks.
  --iftex           proses @iftex dan @tex; mengimplikasikan --no-split.
  --ifxml           proses @ifxml dan @xml.
  --no-ifdocbook    jangan proses @ifdocbook dan @docbook teks.
  --no-ifhtml       jangan proses @ifhtml dan @html teks.
  --no-ifinfo       jangan proses @ifinfo teks.
  --no-ifplainteks  jangan proses @ifplaintext teks.
  --no-iftex        jangan proses @iftex dan @tex teks.
  --no-ifxml        jangan proses @ifxml dan @xml teks.

  Juga, untuk opsi --no-ifFORMAT, jangan proses @ifnotFORMAT teks.
 Hak Cipta (C) %s Free Software Foundation, Inc.
Lisensi GPLv3+: GNU GPL versi 3 atau lebih lanjut <http://gnu.org/licenses/gpl.html>
Ini adalah aplikasi bebas: anda bebas untuk mengubah dan meredistribusikannya.
TIDAK ADA GARANSI, sampai batas yang masih diijinkan oleh hukum yang berlaku.
 Email laporan bug ke bug-texinfo@gnu.org,
pertanyaan umum dan diskusi ke help-texinfo@gnu.org.
Texinfo halaman rumah: http://www.gnu.org/software/texinfo/ Masukan untuk indeks `%s' diluar dari titik apapun Contoh:
  makeinfo foo.texi                      tulis Info ke foo @setfilename
  makeinfo --html foo.texi               tulis HTML ke @setfilename
  makeinfo --xml foo.texi                tulis Texinfo XML ke @setfilename
  makeinfo --docbook foo.texi            tulis DocBook XML ke @setfilename
  makeinfo --no-headers foo.texi         tulis plain teks ke standar keluaran

  makeinfo --html --no-headers foo.texi  tulis html tanpa baris titik, menu
  makeinfo --numer-sections foo.texi     tulis Info dengan daerah bernomor
  makeinfo --no-split foo.texi            tulis satu berkas Info walaupun besar
 Diduga @%s on atau off, bukan `%s' Catatan kaki didefinisikan tanpa titik orang tua Opsi umum:
      --error-limit=NUM       berhenti setelah NUM errors (baku %d).
      --document-language=STR locale yang digunakan dalam menerjemahkan kata
                              kunci untuk dokumen keluaran (baku C).
      --force                 jaga keluaran walaupun terjadi errors.
      --help                  tampilkan bantuan ini dan keluar.
      --no-validate           tekan validasi titik referensi silang.
      --no-warn               tekan peringatan (tetapi tidak untuk error).
  -v, --verbose               jelaskan apa yang sedang dilakukan.
      --version               tampilkan informasi versi dan keluar.
 Opsi umum keluaran:
  -E, --macro-expand=BERKAS   keluarkan macro-expanded sumber ke BERKAS,
                                mengabaikan @setfilename apapun.
      --no-headers            tekan pemisah titik, Titik: baris, dan menus
                                dari keluaran Info (sehingga menghasilkan plain teks)
                              atau dari HTML (sehingga menghasilkan keluaran lebih pendek);
                              juga, tulis ke standar keluaran secara baku.
      --no-split              tekan pemisahan dari keluaran Info atau HTML,
                              hanya hasilkan sebuah berkas keluaran.
      --number-sections       keluarkan chapter dan jumlah daerah.
  -o, --output=BERKAS         keluarkan ke BERKAS (atau direktori jika split HTML).
 Opsi berkas masukan:
      --commands-in-node-names  ijinkan @ perintah dalam nama titik.
  -D VAR                        definisikan variabel VAR, sama dengan @set.
  -I DIR                        tambahkan DIR ke jalur pencarian @include.
  -P DIR                        prepend DIR ke jalur pencarian @include.
  -U VAR                        tidak definisikan variabel VAR, sama dengan @clear.
 Salah tempat %c Harus berada dalam lingkungan `@%s' untuk menggunakan `@%s' Tidak cocok `%cend %s' Titik `%s' kurang item menu untuk `%s' dariapda target Up nya Hanya @%s 10 atau 11 yang didukung, bukan `%s' Opsi untuk HTML:
      --css-include=BERKAS    masukan BERKAS dalam HTML <style> keluaran;
                              baca stdin jika BERKAS adalah -.
      --css-ref=URL           hasilkan referensi ke sebuah berkas CSS.
      --internal-links=BERKAS hasilkan daftar dari links internal dalam BERKAS.
      --transliterate-file-names
                              hasilkan nama berkas dalam transliterasi ASCII.
 Opsi untuk Info dan plain teks:
      --disable-encoding      jangan keluarkan accented dan karakter spesial
                              dalam keluaran Info berdasar dari @documentencoding.
      --enable-encoding       override --disable-encoding (baku).
      --fill-column=NUM       break baris Info di karakter NUM (baku %d).
      --footnote-style=GAYA   keluarkan catatan kaki dalam Info menurut GAYA:
                              `separate' untuk menempatkan nya menurut titiknya;
                              `end' untuk menempatkannya di akhir dari titik, dalam
                               definisinya (ini adalah baku).
      --paragraph-indent=VAL   indent Info paragraph denga VAL spaces (baku %d).
                               Jika VAL adalah `none', jangan indent; jika VAL adalah
                               `asis', jaga indentasi yang sudah ada.
      --split-size=NUM         pisah berkas Info di ukuran NUM (baku %d).
 Pemilihan format keluaran (baku adalah untuk menghasilkan Info):
      --docbook               keluarkan Docbook XML daripada Info.
      --html                  keluarkan HTML daripada Info.
      --xml                   keluarkan Texinfo XML daripada Info.
      --plaintext             keluarkan plain teks daripada Info.
 Mencapai eof sebelum cocok @end %s Tipe float `%s' yang diminta belum digunakan sebelumnya Terlalu banyak kolom dalam multitable item (maksimal %d) Terlalu banyak errors! Menyerah.
 Terjemahkan sumber dokumentasi texinfo ke berbagai format lain, secara baku
Berkas info yang sesuai untuk pembacaan online dengan Emacs atau standalone GNU Info.
 Coba `%s --help' untuk informasi lebih lanjut.
 Perintah `%s' tidak diketahui Indeks `%s' tidak diketahui Indeks `%s' tidak diketahui dalam @printindex Tidak cocok `%c%s' Penggunaan: %s [OPSI]... BERKAS-TEXINFO...
 Gunakan kurung untuk memberi sebuah perintah sebagai sebuah argumen ke @%s `@end' diduga `%s', tetapi terlihat `%s' disini adalah definisi sebelumnya dari `%s' mengabaikan @tab diluar dari multitabel mengabaikan stray teks `%s' setelah @multitable makro `%s' telah didefinisikan sebelumnya tidak cocok @end %s dengan @%s mungkin titik @top anda seharusnya wrapped dalam @ifnottex daripada @ifinfo? opsi tidak terdefinisi: %s nama pengkodean `%s' tidak diketahui titik `%s' tidak tereferensi 