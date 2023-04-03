(function(){
    raplace_code_signs = function(){
        $('.text').each(function(){
            var txt = $(this).html();
            var count = ( txt.match( /```/g ) || [] ).length ;
            for(i = 0; i <count; i++){
              txt = txt.replace(/```/,'<pre><code>\n')
              txt = txt.replace(/```/,'\n</pre></code>')
            }
            $(this).html(txt);
            console.log(txt)
        });
        $('pre code').each(function(i, block) {
          hljs.highlightBlock(block);
        });
    }
})();