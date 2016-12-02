require "csv"
require "cgi"
require "/home/seiyo/public_html/darts/html.rb"

class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

def cgi_error()
	html_header( "CGI ERROR" )
	puts "#{CGI.escapeHTML( $!.inspect ) }<BR />\n"
	$@.each { |ex| puts CGI.escapeHTML(e), "<BR />\n"}
end

def todofuken_read()
	hash = {}
	CSV.foreach( "./todofuken.csv" , encoding: "utf-8" ) do |row|
		hash[ row[1] ] = [ row[2] ]
	end
	return hash
end

def area_select( )
	puts "<DIV ID=\"areaDiv\">\n"
	puts "<INPUT TYPE=\"checkbox\" NAME=\"area_hokkaido\" VALUE=\"hokaido\" onclick=\"changePref(this.checked , 'hokkaido' );\" >北海道"
	puts "<INPUT TYPE=\"checkbox\" NAME=\"area_tohoku\" VALUE=\"tohoku\" onclick=\"changePref(this.checked , 'aomori' , 'iwate' , 'akita' , 'miyagi' , 'yamagata' , 'fukushima' );\" >東北"
	puts "<INPUT TYPE=\"checkbox\" NAME=\"area_kanto\" VALUE=\"kanto\" onclick=\"changePref(this.checked , 'ibaraki' , 'tochigi' , 'gumma' , 'saitama' , 'chiba' , 'tokyo' , 'kanagawa' );\" >関東"
	puts "<INPUT TYPE=\"checkbox\" NAME=\"area_tyubu\" VALUE=\"tyubu\" onclick=\"changePref(this.checked , 'yamanashi' , 'nagano' , 'niigata' , 'toyama' , 'ishikawa' , 'fukui' , 'shizuoka' , 'aichi' , 'gifu' );\" >中部"
	puts "<INPUT TYPE=\"checkbox\" NAME=\"area_kinki\" VALUE=\"kinki\" onclick=\"changePref(this.checked , 'mie' , 'shiga' , 'kyoto' , 'oosaka' , 'hyogo' , 'nara' , 'wakayama' );\" >近畿"
	puts "<INPUT TYPE=\"checkbox\" NAME=\"area_tyugoku\" VALUE=\"tyugoku\" onclick=\"changePref(this.checked , 'tottori' , 'shimane' , 'okayama' , 'hiroshima' , 'yamaguchi' );\" >中国"
	puts "<INPUT TYPE=\"checkbox\" NAME=\"area_sikoku\" VALUE=\"sikoku\" onclick=\"changePref(this.checked , 'kagawa' , 'ehime' , 'tokushima' , 'kouchi' );\" >四国"
	puts "<INPUT TYPE=\"checkbox\" NAME=\"area_kyusyu\" VALUE=\"kyusyu\" onclick=\"changePref(this.checked , 'fukuoka' , 'saga' , 'nagasaki' , 'kumamoto' , 'ooita' , 'miyazaki' , 'kagoshima' );\" >九州（沖縄除く）"
	puts "<HR />\n"
	puts "<INPUT TYPE=\"checkbox\" NAME=\"area_okinawa\" VALUE=\"okinawa\" onclick=\"changePref(this.checked , 'okinawa' );\" >沖縄"
	puts "<BR />\n"
	puts "<INPUT TYPE=\"checkbox\" NAME=\"area_kitatohoku\" VALUE=\"kitatohoku\" onclick=\"changePref(this.checked , 'aomori' , 'iwate' , 'akita' );\" >北東北"
	puts "<INPUT TYPE=\"checkbox\" NAME=\"area_minamitohoku\" VALUE=\"minamitohoku\" onclick=\"changePref(this.checked , 'miyagi' , 'yamagata' , 'fukushima' );\" >南東北"
	puts "<INPUT TYPE=\"checkbox\" NAME=\"area_kitakanto\" VALUE=\"kitakanto\" onclick=\"changePref(this.checked , 'ibaraki' , 'tochigi' , 'gumma' );\" >北関東"
	puts "<INPUT TYPE=\"checkbox\" NAME=\"area_minamikanto\" VALUE=\"minamikanto\" onclick=\"changePref(this.checked , 'saitama' , 'chiba' , 'tokyo' , 'kanagawa' );\" >南関東"
	puts "<INPUT TYPE=\"checkbox\" NAME=\"area_koushinetu\" VALUE=\"koushinetu\" onclick=\"changePref(this.checked , 'yamanashi' , 'nagano' , 'niigata' );\" >甲信越"
	puts "<INPUT TYPE=\"checkbox\" NAME=\"area_hokuriku\" VALUE=\"hokuriku\" onclick=\"changePref(this.checked , 'toyama' , 'ishikawa' , 'fukui' );\" >北陸"
	puts "<INPUT TYPE=\"checkbox\" NAME=\"area_tokai\" VALUE=\"tokai\" onclick=\"changePref(this.checked , 'shizuoka' , 'aichi' , 'gifu' , 'mie' );\" >東海"
	puts "<INPUT TYPE=\"checkbox\" NAME=\"area_kansai\" VALUE=\"kansai\" onclick=\"changePref(this.checked , 'shiga' , 'kyoto' , 'oosaka' , 'hyogo' , 'nara' , 'wakayama' );\" >関西"
	puts "<INPUT TYPE=\"checkbox\" NAME=\"area_sannin\" VALUE=\"sannin\" onclick=\"changePref(this.checked , 'tottori' , 'shimane' );\" >山陰"
	puts "<INPUT TYPE=\"checkbox\" NAME=\"area_sanyo\" VALUE=\"sanyo\" onclick=\"changePref(this.checked , 'okayama' , 'hiroshima' , 'yamaguchi' );\" >山陽"
	puts "<INPUT TYPE=\"checkbox\" NAME=\"area_setouchi\" VALUE=\"setouchi\" onclick=\"changePref(this.checked , 'okayama' , 'hiroshima' , 'yamaguchi' , 'kagawa' , 'ehime' );\" >瀬戸内"
	puts "<INPUT TYPE=\"checkbox\" NAME=\"area_hokubukyusyu\" VALUE=\"hokubukyusyu\" onclick=\"changePref(this.checked , 'fukuoka' , 'saga' , 'nagasaki' , 'kumamoto' , 'ooita' );\" >北部九州"
	puts "<INPUT TYPE=\"checkbox\" NAME=\"area_minamikyusyu\" VALUE=\"minamikyusyu\" onclick=\"changePref(this.checked , 'miyazaki' , 'kagoshima' );\" >南九州"
	puts "</DIV>\n"
	puts "<HR />\n"
end

def mode_form()
	puts "<B>ダーツの精度</B>"
	puts "<DIV ID=\"mode\">\n"
	puts "</DIV>\n"
	puts "<DIV ID=\"modeoptions1\">\n"
	puts "</DIV>\n"
	puts "<DIV ID=\"modeoptions2\" >\n"
	puts "<SELECT NAME=\"seireitarget\" ID=\"seireitarget\" STYLE=\"display: none;\" >\n"
	CSV.foreach( "./seireisiteitoshi.csv" , encoding: "utf-8" ) do |row|
		puts "<OPTION VALUE=\"" + row[2] + "\">" + row[2] + "</OPTION>\n"
	end
	puts "</SELECT>\n"
	puts "</DIV>\n"
	puts "<BR />\n<BR />\n"
end


def pref_form( items )
	s = "<DIV ID=\"prefDiv\">\n";
	bri = 0
	items.each do |pref,v|
		s = s + "<INPUT TYPE=\"checkbox\" ID=\"#{v[0]}\" NAME=\"pref_#{pref}\" VALUE=\"#{pref}\">#{pref}"
		if bri == 2
			s = s + "<BR />\n"
			bri = 0
		else
			bri = bri + 1
		end
			
	end
	s = s + "<BR />\n"
	s = s + "<BR />\n"
	s = s + "</DIV>\n";
	s += "<INPUT TYPE=\"submit\" VALUE=\"ダーツを投げる\" />"
	return s
end



begin
	cgi = CGI.new("html5")
	
	All_pref = todofuken_read()

	html_header_begin( "ダーツの旅 Darts Trip" , "index" )
	html_header_end( "index" )

	puts "<H1>ダーツの旅？</H1>\n"
	puts "<DIV>\n"
	puts "基本的な使い方。<BR/>\n"
	puts "０．safari、chromeなどのブラウザで開く。（Twitter、FaceBook、LINEなどではないもの）<BR/>\n"
	puts "１．地域または都道府県を選択（チェックする）<BR/>\n"
	puts "２．「都道府県」または「市区町村」を選択<BR/>\n"
	puts "３．「ダーツを投げる」ボタンを押す<BR/>\n"
	puts "</DIV>\n"
	puts "<H1>地域別</H1>\n"
	area_select()
	puts "<DIV ID=\"underDiv\">\n"
	puts "<H1>都道府県</H1>\n"
	puts "<FORM METHOD=\"GET\" NAME=\"prefs\" ACTION=\"launch.rb\" >\n"
	puts mode_form()
	puts pref_form( All_pref )
	puts "</FORM>\n"
	puts "</DIV>\n"

	puts <<AD
<script async src="//pagead2.googlesyndication.com/pagead/js/adsbygoogle.js"></script>
<!-- Darts -->
<ins class="adsbygoogle"
     style="display:inline-block;width:320px;height:100px"
     data-ad-client="ca-pub-9311529224490656"
     data-ad-slot="2662170256"></ins>
<script>
(adsbygoogle = window.adsbygoogle || []).push({});
</script>
AD
	html_footer()
rescue
	cgi_error()
end

end
# vim:set ts=4:
