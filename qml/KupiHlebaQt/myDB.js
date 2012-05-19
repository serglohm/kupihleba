//.pragma library

var _db;

function openDB(){
    _db = openDatabaseSync("KupiHlebaDB", "1.0", "the Todo related Database",1000000);
    createTables();
}

function getAllTaskCount(){
    return getOneResultSQL("SELECT count(*) FROM tasks");
}


function taskExists(nid){
    return getOneResultParamsSQL("SELECT * FROM tasks WHERE nid=?", [nid]);
}


function getOneResultParamsSQL(sql, params){
    var result = 0;
    _db.readTransaction(
        function(tx){
            var rs = tx.executeSql(sql, params);
            if(rs.rows.length > 0) {
                result = rs.rows.item(0);
            }
        }
    );
    return result;
}

function getOneResultSQL(sql){
    var result = 0;
    _db.readTransaction(
        function(tx){
            var rs = tx.executeSql(sql);
            if(rs.rows.length > 0) {
                result = rs.rows.item(0);
            }
        }
    );
    return result;
}


/*

CREATE TABLE IF NOT EXISTS todo
                                (
                                     id INTEGER PRIMARY KEY AUTOINCREMENT,
                                     nid INTEGER, // id таска на сервере
                                     puid INTEGER,  // uid создателя задачи
                                     uid INTEGER, // uid исполнителя задачи
                                     message text, // название / текст задачи
                                     comment text, // описание задачи

                                     performed INTEGER, // выполнена
                                     perform_time NUMERIC,
                                     create_time NUMERIC,

                                     modify_time NUMERIC,
                                     n_modify_time NUMERIC,


                                     catid INTEGER, // id категории задачи

                                     start_time NUMERIC,
                                     end_time NUMERIC,
                                     no_time INTEGER, // 1 - бессрочная задача

                                     priority INTEGER, // приоритет задачи

                                     is_deleted INTEGER, // удалили задачу на девайсе но не удалили на
                                     delete_time NUMERIC,

                                     list_nid INTEGER, // nid родительского таска
                                     list_id INTEGER, // id родительского таска
                                     list_idx INTEGER, // порядковый номер в списке подзадач
                                     is_list INTEGER,  // это главный таск для списка задач

                                     on_home_screen INTEGER //  отображать в виджете

                                )"
*/

function createTables(){
    _db.transaction(
        function(tx){
            tx.executeSql("CREATE TABLE IF NOT EXISTS tasks (id INTEGER PRIMARY KEY AUTOINCREMENT, nid INTEGER, puid INTEGER, uid INTEGER, message text, comment text, performed INTEGER, perform_time NUMERIC, create_time NUMERIC, modify_time NUMERIC, n_modify_time NUMERIC,  catid INTEGER, start_time NUMERIC, end_time NUMERIC, no_time INTEGER, priority INTEGER, is_deleted INTEGER, delete_time NUMERIC, list_nid INTEGER, list_id INTEGER, list_idx INTEGER, is_list INTEGER,  on_home_screen INTEGER )");
        }
    );
}

function dropTable()
{
    _db.transaction(
            function(tx){
                tx.executeSql("DROP TABLE IF EXISTS tasks");
            }
    );
}

function readAllTasks(){
    var data = [];
    _db.readTransaction(
        function(tx){
            var rs = tx.executeSql("SELECT * FROM tasks ");
            for (var i = 0; i < rs.rows.length; i++) {
                data[i] = rs.rows.item(i);
            }
        }
    );
    return data;
}

function updateTask(taskItem){
    _db.transaction(
        function(tx){
            tx.executeSql("UPDATE tasks SET BOX = ? , done = ?, \
                          title = ?, note = ?, modified = ?  \
                          WHERE id = ?", [todoItem.box, todoItem.done, todoItem.title, todoItem.note, todoItem.modified, todoItem.id]);
        }
    );
}

function deleteTasks(id){
    _db.transaction(
        function(tx){
            tx.executeSql("DELETE FROM tasks WHERE id = ?", [id]);
        }
    );
}

function deleteAllTasks(){
    _db.transaction(
        function(tx){
            tx.executeSql("DELETE FROM tasks");
        }
    );
}

function insertTask(taskItem){
    _db.transaction(
        function(tx){
            tx.executeSql("insert into tasks ( nid, puid, uid, message, comment, performed, perform_time, create_time, modify_time, n_modify_time, catid, start_time, end_time, no_time, priority, is_deleted, delete_time, list_nid, list_id, list_idx, is_list, on_home_screen ) values (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)",
                          [taskItem.nid,
                           taskItem.puid, taskItem.uid, taskItem.message, taskItem.comment, taskItem.performed, taskItem.perform_time, taskItem.create_time, 0, taskItem.modify_time, taskItem.catid, taskItem.start_time, taskItem.end_time, taskItem.no_time, taskItem.priority, taskItem.is_deleted, taskItem.delete_time, taskItem.list_nid, taskItem.list_id, taskItem.list_idx, taskItem.is_list, taskItem.on_home_screen]);
        }
    );
}
