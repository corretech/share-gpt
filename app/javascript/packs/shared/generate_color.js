(function(){
generate_color = function(string){
    // 文字列 -> 配列 -> 文字コードの配列 -> 全部足す
    var n = Array.from(string).map(ch => ch.charCodeAt(0)).reduce((a, b) => a+b);
    // hsl 用に 0 ~ 360 に収める
    var colorAngle = (n*n) % 360;
    return `hsl(${colorAngle}, 80%, 64%)`
}
})();