

var URLSTART = 'http://www.kupihleba.ru';
var SID = 0;
var IMEI = '12345678';
var VERSION = 1.522;


var allTasks = new Array();

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
    //noTimeTasks = tempArray;

    var tempArray = parseTasks(data.notime_tasks);
    var taskArray = parseTasks(data.tasks);
    for(var i in taskArray){
        allTasks.push(taskArray[i]);
    }

    for(var i in tempArray){
        allTasks.push(tempArray[i]);


    }

    Mdb.openDB();
    console.log("getAllTaskCount = " + Code.obj2json(Mdb.getAllTaskCount()));
    Mdb.deleteAllTasks();

    for(var i in allTasks){
        mainPage.tasksList.model.append(allTasks[i]);
        Mdb.insertTask({
               "nid":              allTasks[i].nid,
               "puid":             allTasks[i].puid,
               "uid":              allTasks[i].uid,
               "message":          allTasks[i].message,
               "comment":          allTasks[i].comment,
               "performed": 		allTasks[i].performed,
               "perform_time": 	allTasks[i].perform_time,
               "create_time": 		allTasks[i].create_time,
               "n_modify_time":	allTasks[i].n_modify_time,
               "modify_time": 		allTasks[i].modify_time,
               "catid":            allTasks[i].catid,
               "start_time": 		allTasks[i].start_time,
               "end_time": 		allTasks[i].end_time,
               "no_time":          allTasks[i].no_time,
               "priority": 		allTasks[i].priority,
               "is_deleted": 		allTasks[i].is_deleted,
               "delete_time": 		allTasks[i].delete_time,
               "list_nid": 		allTasks[i].list_nid,
               "list_id":          allTasks[i].list_id,
               "list_idx": 		allTasks[i].list_idx,
               "is_list": 		    allTasks[i].is_list,
               "on_home_screen":	allTasks[i].on_home_screen
        });
    }
    console.log("readAllTasks: " + Code.obj2json(Mdb.readAllTasks()));


    mainPage.tasksList.indicator.visible = false;
    mainPage.tasksList.indicator.running = false;
    mainPage.tasksList.list.visible = true;

}

function parseTasks(data){
    var subtasks = new Array();
    var tempArray = new Array();

    for(var i = 0; i < data.length; i++){
        var task = data[i];
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

    return tempArray;

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

