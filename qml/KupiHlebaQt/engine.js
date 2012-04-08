var URLSTART = 'http://www.kupihleba.ru';
var SID = 0;

var imageModels = new Object();

function func() {

}


function login(){
    var VERSION = 1;
    var IMEI = '0123456789012345';
    var uname = 'user1';
    var password = '1';
    var url = URLSTART + '/cgi-bin/widget.cgi?imei=' + IMEI + '&uname=' + uname + '&pass=' + password + '&cmd=login&version=' + VERSION + '&rnd=' + Math.random(1);

    Code.getJSON(url, loginCallback);
}

function engineRegisterUser(login, password, des_user_name, email, user_code, code){
    try{
        var url = URLSTART + '/cgi-bin/mf_widget.cgi?cmd=register_user&rnd=' + Math.random(1);
        url += '&login=' + login;
        url += '&password=' + password;
        url += '&des_user_name=' + des_user_name;
        url += '&email=' + email;
        url += '&user_code=' + user_code;
        url += '&imei=' + IMEI;
        url += '&code=' + code;

        Code.getJSON(url, function(data){
            try{
                if(data['result'] != '1'){
                    if(data['error'] == -11){

                    } else if(data['error'] == -5){

                    }
                    console.log(obj2json(data));
                } else {
                    console.log(obj2json(data));
                }
            } catch(e){

            }
        });
    } catch(e){

    }
}


function engineGetRegisterCode(id){
    try{
        var login_url = URLSTART + '/cgi-bin/mf_widget.cgi?cmd=start_register&rnd=' + Math.random(1);
        Code.getJSON(login_url, function(data){
            try{
                updateUI(REGISTER_NEW_USER, data);

            } catch(e){

            }
        });
    } catch(e){

    }
}

function updateUI(param_name, data){

}
