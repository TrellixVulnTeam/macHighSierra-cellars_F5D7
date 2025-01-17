��    ?        Y         p  E  q     �  6   �               1  1   G  @   y  D   �  <   �  F   <     �  "   �  %   �  /   �  E   	     ^	  2   ~	  R   �	  &   
     +
     C
  l  c
  �   �  �   �  (   d  ^  �      �  $     d  2  �  �  w  �     �  )        /  >   F  (   �  �  �  �  /  :  �  #      -   7   ,   e      �   �   �   &   E!     l!     �!  !   �!     �!  &   �!  2   �!  "   !"  '   D"  #   l"  *   �"     �"     �"  J   �"     @#     S#     s#  �  �#  �  4%  &   �&  P   '  /   T'     �'  #   �'  B   �'  �   (  �   �(  ~   >)  }   �)  #   ;*  @   _*  1   �*  E   �*  W   +  1   p+  U   �+  j   �+  ;   c,     �,  *   �,    �,  U  �0  �   J2  A   3  �  R3  7   �5  6   (6  �  _6  u  �9  �  ]=     D?  @   X?  '   �?  i   �?  6   +@  �  b@     _B  F  `G  <   �H  K   �H  =   0I     nI  �   �I  J   PJ     �J     �J  +   �J     �J  H   K  N   ]K  4   �K  4   �K  *   L  =   AL  2   L     �L  h   �L     8M  )   UM  )   M     -           8                 =   +             3      2   !                       $   )             9          5   6       &   0   >   ;                 '             <   .   4   "                ?            7   %       #      	       :           /   *                               
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
PO-Revision-Date: 2009-09-23 21:25+0930
Last-Translator: Clytie Siddall <clytie@riverland.net.au>
Language-Team: Vietnamese <vi-VN@googlegroups.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Plural-Forms: nplurals=1; plural=0;
X-Generator: LocFactoryEditor 1.8
   Giá trị mặc định cho các điều kiện @if... thì phụ thuộc vào định dạng xuất:
  tạo ra HTML thì bật « --ifhtml » và các điều khác bị tắt;
  tạo ra Info thì bật « --ifinfo » và các điều khác bị tắt;
  tạo ra nhập thô thì bật « --ifplaintext » và các điều khác bị tắt;
  tạo ra XML thì bật « --ifxml » và các điều khác bị tắt;
 %c%s mong đợi dấu ngoặc móc {} %c%s mong đợi một ký tự riêng lẻ « i » hay « j » làm đối số %c%s: thiếu dấu ngoặc móc đóng « } » %c%s cần đến tên Không tìm thấy vĩ lệnh %cend %s cần thiết một đối số: bộ định dạng cho %citem %s: đối số « --footnote-style » (kiểu dáng cước chú) phải là:
 • separate	riêng
 • end		cuốinkhông phải « %s ».
 %s: đối số « --paragraph-indent » (thụt lề đoạn văn) phải là:
 • numeric	kiểu số
 • none		không có
 • asis		như thế
không phải « %s ».
 %s: đang bỏ qua giá trị không được nhận ra « TEXINFO_OUTPUT_FORMAT » (định dạng xuất Texinfo) « %s ».
 %s: đang gỡ bỏ tập tin xuất « %s » do lỗi; hãy dùng tùy chọn « --force » (buộc) để bảo tồn nó.
 %s: thiếu đối số tập tin.
 %s:%d: tập tin CSS « --css-file » kết thúc với ghi chú @%s không có nghĩa bên trong khối « @%s » @%s không có nghĩa bên ngoài môi trường « @float » (nổi) @%s không có nghĩa bên ngoài môi trường  « @titlepage » và « @quotation » Không thể đọc tập tin @image « %s »: %s « @sp » cần đến một đối số dương thuộc số, không phải « %s » « @strong{Note...} » tạo một tham chiếu chéo giả trong Info; hãy sửa đổi để tránh nó Đối số sai « %s » tới « %s » nên dùng « %s » Đối số sai tới @%s: %s Không thể tạo thư mục « %s »: %s Xử lý điều kiện trong kết nhập:
  --ifdocbook       	xử lý @ifdocbook và @docbook thậm chí nếu
		không tạo ra Docbook.
  --ifhtml          	xử lý @ifhtml và @html thậm chí nếu không tạo ra HTML.
  --ifinfo          	xử lý @ifinfo thậm chí nếu không tạo ra Info.
  --ifplaintext     	xử lý @ifplaintext thậm chí nếu không tạo ra nhập thô.
  --iftex           	xử lý @iftex và @tex; ngụ ý « --no-split ».
  --ifxml           	xử lý @ifxml và @xml.
  --no-ifdocbook	đừng xử lý văn bản @ifdocbook và @docbook.
  --no-ifhtml       	đừng xử lý văn bản @ifhtml và @html.
  --no-ifinfo       	đừng xử lý văn bản @ifinfo.
  --no-ifplaintext	đừng xử lý văn bản @ifplaintext.
  --no-iftex       	đừng xử lý văn bản @iftex và @tex.
  --no-ifxml        	đừng xử lý văn bản @ifxml và @xml.

  Hơn nữa, đối với các tùy chọn « --no-ifĐỊNH_DẠNG », có phải xử lý văn bản @ifnotĐỊNH_DẠNG.
 Tác quyền © %s Tổ chức Phần mềm Tự do.
Giấy phép GPL pb3+: Giấy phép Công cộng GNU phiên bản 3 và sau:
<http://gnu.org/licenses/gpl.html>
Đây là phần mềm tự do : bạn có quyền thay đổi và phát hành lại nó.
KHÔNG CÓ BẢO HÀNH GÌ CẢ, với điều kiện được pháp luật cho phép
 Hãy thông báo lỗi cho địa chỉ « bug-texinfo@gnu.org »,
và gửi câu hỏi chung, thảo luận v.v. cho help-texinfo@gnu.org.
Trang chủ texinfo: http://www.gnu.org/software/texinfo/ Mục nhập cho chỉ mục « %s » nằm ở ngoại nút nào Mẫu thí dụ :
  makeinfo phu.texi                      ghi Info vào @setfilename của phu
  makeinfo --html phu.texi               ghi HTML vào @setfilename
  makeinfo --xml phu.texi                ghi Texinfo XML vào @setfilename  makeinfo --docbook phu.texi            ghi DocBook XML vào @setfilename  makeinfo --no-headers phu.texi         ghi nhập thô vào thiết bị xuất chuẩn

  makeinfo --html --no-headers phu.texi
 		ghi HTML không có dòng nút hay trình đơn
  makeinfo --number-sections phu.texi
		ghi Info có các phần đã đánh số
  makeinfo --no-split phu.texi
		ghi một tập tin Info, bất chấp kích cỡ tối đa
 Mong đợi @%s bật hay tắt, không phải « %s » Cước chú đã xác định mà không có nút cha Tùy chọn chung:
      --error-limit=SỐ      thoát sau khi gặp số lỗi này (mặc định là %d).
		(_sự hạn chế lỗi_)
      --document-language=CHUỖI	 miền địa phương cần dùng
		để dịch các từ khoá Texinfo cho tài liệu xuất (mặc định là C).
		(_ngôn ngữ tài liệu_)
      --force                 bảo tồn kết xuất thậm chí nếu có lỗi (_ép buộc_).
      --help                  hiển thị trợ giúp này rồi thoát (_trợ giúp_)
      --no-validate           thu hồi khả năng thầm tra tham chiếu chéo.
		(_không thẩm tra_)
      --no-warn               thu hồi các cảnh báo (không phải lỗi).
		(_không cảnh báo_)
 -v, --verbose               diễn tả việc đang được làm (_chi tiết_)
      --version              hiển thị thông tin phiên bản rồi thoát (_phiên bản_)
 Tùy chọn xuất chung:
  -E, --macro-expand TẬP_TIN     xuất vào tập tin này nguồn đã mở rộng
		bằng vĩ lệnh, cũng bỏ qua @setfilename nào.
		(_vĩ lệnh mở rộng_)
      --no-headers           thu hồi các bộ phân cách nút, dòng Node:
		và trình đơn từ kết xuất Info (thì xuất văn bản thô),
		hoặc từ HTML (thì tạo kết xuất ngắn hơn);
		cũng ghi vào đầu ra tiêu chuẩn theo mặc định.		(_không có dòng đầu_)
      --no-split              thu hồi khả năng chia tách kết xuất kiểu Info hoặc HTML,
		tạo ra chỉ một tập tin xuất (_không chia tách_).
      --number-sections       xuất các số thứ tự chương và phần.
		(_đánh số các phần_)
  -o, --output=TẬP_TIN	xuất ra tập tin này (vào thư mục nếu
		HTML đã chia tách) (_kết xuất_).
 Tùy chọn tập tin nhập vào :
      --commands-in-node-names  cho phép lệnh kiểu @ trong tên nút.
		(_các lệnh trong tên nút_)
  -D BIẾN             	xác định biến này, như bằng @set.
  -I THƯ_MỤC      	phụ thêm thư mục này vào đường dẫn tìm kiếm @include.
  -P THƯ_MỤC       	thêm thư mục này vào đầu của đường dẫn tìm kiếm @include.
  -U BIẾN              	hủy xác định biến này, như bằng @clear.
 Định vị sai %c Phải bên trong môi trường « @%s » để dùng « @%s » Không có « %cend %s » tương ứng Nút « %s » không có mục trình đơn cho « %s », không kể nút này là đích Lên của nó Chỉ hỗ trợ @%s 10 hay 11, không phải « %s » Tùy chọn HTML:
      --css-include=TẬP_TIN      tập tin bao gồm (include)
		xuất theo kiểu dáng <style> HTML;
		TẬP_TIN là « - » thì đọc thiết bị nhập chuẩn.
      --css-ref=URL           tạo ra tham chiếu đến tập tin CSS.
      --internal-links=TẬP_TIN     cung cấp danh sách các liên kết nội bộ
                                                   trong tập tin này
      --transliterate-file-names	tạo các tên tập tin đã chuyển chữ ASCII.
 Tùy chọn đối với Info và nhập thô :
      --disable-encoding      đừng xuất các ký tự có dấu phụ và các ký tự
		đặc biệt trong kết xuất Info dựa vào bảng mã tài liệu @documentencoding.
      --enable-encoding       xuất các ký tự có dấu phụ và ký tự đặc biệt
		trong kết xuất Info dựa vào @documentencoding.
		(_bật bảng mã_)
      --fill-column=SỐ       ngắt các dòng Info ở số ký tự này (mặc định là %d).
		(_tô đầy cột_)
      --footnote-style=KIỂU_DÁNG	xuất các cước chú trong Info
		tùy theo kiểu dáng này:
			« separate » (riêng) để đặt cước chú trong cùng nút;
			« end » (cuối) để đặt cước chú ở cuối nút trong đó
			nó được xác định (đây là mặc định) (_kiểu dáng cước chú_)
      --paragraph-indent=GIÁ_TRỊ		thụt lề các đoạn văn Info
		theo số dấu cách này (mặc định là %d).
			GIÁ TRỊ là « none » (không có) thì đừng thụt lề;
			GIÁ TRỊ là « asis » (như thế) thì bảo tồn sự thụt lề đã có.		(_đoạn văn thụt lề_)
      --split-size=SỐ        chia tách các tập tin Info ở kích cỡ SỐ (mặc định là %d).
 Chọn định dạng xuất (mặc định là tạo Info):
      --docbook             	xuất XML Docbook thay cho Info.
      --html                	xuất HTML thay cho Info.
      --xml                 	xuất XML Texinfo thay cho Info.
      --plaintext           	xuất văn bản thô thay cho Info (_nhập thô_).
 Đã tới kết thúc tập tin trước khi khớp @end %s Kiểu nổi đã yêu cầu « %s » không phải được dùng trước Quá nhiều cột trong mục đa bảng (tối đà là %d) Quá nhiều lỗi nên thôi.
 Dịch tài liệu nguồn Texinfo sang nhiều định dạng khác nhau, mặc định là tập tin Info thích hợp để đọc trực tuyến bằng Emacs hoặc Info GNU độc nhất.
 Hãy thử lệnh trợ giúp « %s --help » để xem thông tin thêm.
 Lệnh không rõ « %s » Chỉ mục lạ « %s » Chỉ mục lạ « %s » trong @printindex Chưa khớp « %c%s » Cách sử dụng: %s [TÙY_CHỌN]... TTT...

[TTT		Tập Tin Texinfo]
 Dùng dấu ngoặc móc {} để đưa ra lệnh dạng đối số tới @%s « @end » mong đợi « %s », còn gặp « %s » đây là lời xác định trước của « %s » đang bỏ qua @tab bên ngoài đa bảng Đang bỏ qua văn bản rải rác « %s » sau @multitable vĩ lệnh « %s » được xác định trước khớp sai @end %s với @%s có lẽ nút « @top » (trên) của bạn nên được bao bọc bằng @ifnottex thay cho @ifinfo ? chưa xác định cờ : %s không nhận ra tên bảng mã « %s » nút chưa được tham chiếu « %s » 