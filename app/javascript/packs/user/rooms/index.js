var insert_elements = function(response, scroll_element){
    scroll_element.insertAdjacentHTML('beforeend', response);
    raplace_code_signs();
  }
var loaded_pages  = []
$(window).on('scroll', function(){
    var chats_list_area = document.getElementById("chats_list_area");
    let token = document.getElementsByName("csrf-token")[0].content;
    var docHeight = $(document).innerHeight(), //ドキュメントの高さ
        windowHeight = $(window).innerHeight(), //ウィンドウの高さ
        pageBottom = docHeight - windowHeight - 0.5; //ドキュメントの高さ - ウィンドウの高さ

        total_units = document.getElementsByClassName("chat_unit").length;
        page = Math.ceil(total_units/gon.chat_pages)+1;
        //ウィンドウの一番下までスクロールした時 && スクロール位置が変化した
    if(check_scroll() && !loaded_pages.includes(page)) {
        loaded_pages.unshift(page);
        scrollTo(0, pageBottom + 10);
        xml_request(`rooms/page`, page, chats_list_area,  insert_units, location.search.replace("?",""));
    }
});
