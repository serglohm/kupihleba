var URLSTART = 'http://www.kupihleba.ru';
var SID = 0;
var IMEI = '12345678';
var VERSION = 1.522;


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

function engineLogin(uname, password, code, user_code){
    try{
        var login_url = URLSTART + '/cgi-bin/mf_widget.cgi?imei=' + IMEI + '&uname=' + uname + '&pass=' + password + '&cmd=login&version=' + VERSION + '&rnd=' + Math.random(1);
        if(user_code != ''){
            login_url += '&code=' + code + '&user_code=' + user_code;
        }

        console.log(login_url);

        mainPage.tasksList.indicator.visible = true;
        mainPage.tasksList.indicator.running = true;
        mainPage.flickPages.moveTo(2);


        Code.getJSON(login_url, function(data){
            engineAfterLogin(data);
        });
    } catch(e){
        console.log(Code.obj2json(e));
    }
}

function engineAfterLogin(data){
    SID = data.sid;
    parseLoadAll(data);

}

function parseLoadAll(data){
    var subtasks = new Array();
    var tempArray = new Array();
    for(var i = 0; i < data.notime_tasks.length; i++){
        var task = data.notime_tasks[i];
        task.qmlState = 'off';
        if(task.comment != ''){
            task.comment = task.comment.split('\r').join('<br>');
        }

        if(parseInt(task.list_nid) == 0){
            task.subtasks = new Array();
            tempArray[task.nid] = task;
        } else {
            subtasks.push(task);
        }
    }

    for(var i = 0; i < subtasks.length; i++){
        tempArray[subtasks[i].list_nid].subtasks.push(subtasks[i]);
    }
    //noTimeTasks = tempArray;
    for(var i in tempArray){
        mainPage.tasksList.model.append(tempArray[i]);
        console.log(Code.obj2json(tempArray[i]));
    }
    mainPage.tasksList.indicator.visible = false;
    mainPage.tasksList.indicator.running = false;
    mainPage.tasksList.list.visible = true;

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

