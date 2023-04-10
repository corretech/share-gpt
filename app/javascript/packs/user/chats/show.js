var insert_elements = function(response, scroll_element){
    scroll_element.insertAdjacentHTML('beforeend', response);
    ();
  }
  console.log(gon.id)
if(get_param("bottom") == "comment"){
    console.log("comment");
    action = "comments";
    pages = gon.comment_pages;
}else{
    console.log("chat");
    action = "sequels";
    pages = gon.chat_pages;
}

var loaded_pages  = []

check_elements = function(){
    var scroll_area = document.getElementById("scroll_area")
    //console.log(scroll_area)
    let token = document.getElementsByName("csrf-token")[0].content;
    var docHeight = $(document).innerHeight(), //ドキュメントの高さ
        windowHeight = $(window).innerHeight(), //ウィンドウの高さ
        pageBottom = docHeight - windowHeight - 0.5; //ドキュメントの高さ - ウィンドウの高さ

        total_units = scroll_area.getElementsByClassName("unit").length;
        page = Math.ceil(total_units/pages)+1;

        //ウィンドウの一番下までスクロールした時 && スクロール位置が変化した
    if(check_scroll() && !loaded_pages.includes(page)) {
        loaded_pages.unshift(page);
        scrollTo(0, pageBottom + 10);
        xml_request(`${action}/${gon.id}`, page, scroll_area,  insert_units, null);
        //window.removeEventListener('scroll',check_elements)
        //window.addEventListener('scroll', check_elements);
    }
}
window.addEventListener('scroll', check_elements);
//$(".link").on("click",function(){
//    console.log("クリック")
//    window.removeEventListener('scroll',check_elements)
//})

//スクロール単体はできるがロード後にスクロールはできない
function scrollToTop() {
    console.log("aa")
    var
    $target = $('#main_unit'),
    offset = $target.offset() || {top: 0, left: 0},
    outerHeight = $target.outerHeight();
    $(window).scrollTop(offset.top - window.innerHeight + outerHeight);
 }
$(window).on('load',function() {
 scrollToTop()
});