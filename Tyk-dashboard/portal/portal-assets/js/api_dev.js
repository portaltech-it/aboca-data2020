
const Url = 'http://192.168.136.19:3000/api/apis';

window.launch = function(){
    $.getJSON(Url, function(result)
    {
        alert(result)
    });
}