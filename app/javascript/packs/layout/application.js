if( gon.is_loaded){
    console.log("gonをロードした")
    gon.is_loaded = false
  }else{
    console.log("gonをロードしてない")
    window.location.reload();
  }
