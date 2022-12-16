/*######################################################
Table
######################################################*/
let tables = [];

let perso = "CREATE TABLE IF NOT EXISTS perso ";
perso = perso + "( id INT PRIMARY KEY AUTO_INCREMENT NOT NULL, ";
perso = perso + "nom VARCHAR(100),";
perso = perso + "pv INT,";
perso = perso + "playable TINYINT,";
perso = perso + "img VARCHAR(100));";
tables.push(["perso",perso]);

let attack = "CREATE TABLE IF NOT EXISTS attack ";
attack = attack + "( id INT PRIMARY KEY AUTO_INCREMENT NOT NULL, ";
attack = attack + "perso INT,";
attack = attack + "degat INT,";
attack = attack + "nomATK VARCHAR(100));";
tables.push(["attack",attack]);


let histoire = "CREATE TABLE IF NOT EXISTS histoire ";
histoire = histoire + "( id INT PRIMARY KEY AUTO_INCREMENT NOT NULL ,";
histoire = histoire + "description VARCHAR(500),";
histoire = histoire + "combat TINYINT,";
histoire = histoire + "img VARCHAR(100),";
histoire = histoire + "fond VARCHAR(100),";
histoire = histoire + "chaos INT,";
histoire = histoire + "choix1 INT,";
histoire = histoire + "choix2 INT,";
histoire = histoire + "choix3 INT);";
tables.push(["histoire",histoire]);


let choix = "CREATE TABLE IF NOT EXISTS choix ";
choix = choix + "( id INT PRIMARY KEY AUTO_INCREMENT NOT NULL, ";
choix = choix + "suivant INT,";
choix = choix + "txt VARCHAR(500));";
tables.push(["choix",choix]);


let statEl = "CREATE TABLE IF NOT EXISTS statEl ";
statEl = statEl + "( id INT PRIMARY KEY AUTO_INCREMENT NOT NULL, ";
statEl = statEl + "token VARCHAR(100),";
statEl = statEl + "pos INT,";
statEl = statEl + "chunk INT,";
statEl = statEl + "choix INT);";
tables.push(["statEl",statEl]);


let Rperso = "CREATE TABLE IF NOT EXISTS Rperso ";
Rperso = Rperso + "( id INT PRIMARY KEY AUTO_INCREMENT NOT NULL, ";
Rperso = Rperso + "nom VARCHAR(100),";
Rperso = Rperso + "pv INT,";
Rperso = Rperso + "playable TINYINT,";
Rperso = Rperso + "img VARCHAR(100));";
tables.push(["Rperso",Rperso]);

let Rattack = "CREATE TABLE IF NOT EXISTS Rattack ";
Rattack = Rattack + "( id INT PRIMARY KEY AUTO_INCREMENT NOT NULL, ";
Rattack = Rattack + "perso INT,";
Rattack = Rattack + "degat INT,";
Rattack = Rattack + "nomATK VARCHAR(100));";
tables.push(["Rattack",Rattack]);


let Rhistoire = "CREATE TABLE IF NOT EXISTS Rhistoire ";
Rhistoire = Rhistoire + "( id INT PRIMARY KEY AUTO_INCREMENT NOT NULL ,";
Rhistoire = Rhistoire + "description VARCHAR(500),";
Rhistoire = Rhistoire + "combat TINYINT,";
Rhistoire = Rhistoire + "img VARCHAR(100),";
Rhistoire = Rhistoire + "fond VARCHAR(100),";
Rhistoire = Rhistoire + "chaos INT,";
Rhistoire = Rhistoire + "choix1 INT,";
Rhistoire = Rhistoire + "choix2 INT,";
Rhistoire = Rhistoire + "choix3 INT);";
tables.push(["Rhistoire",Rhistoire]);


let Rchoix = "CREATE TABLE IF NOT EXISTS Rchoix ";
Rchoix = Rchoix + "( id INT PRIMARY KEY AUTO_INCREMENT NOT NULL, ";
Rchoix = Rchoix + "suivant INT,";
Rchoix = Rchoix + "txt VARCHAR(500));";
tables.push(["Rchoix",Rchoix]);


let RstatEl = "CREATE TABLE IF NOT EXISTS RstatEl ";
RstatEl = RstatEl + "( id INT PRIMARY KEY AUTO_INCREMENT NOT NULL, ";
RstatEl = RstatEl + "token VARCHAR(100),";
RstatEl = RstatEl + "pos INT,";
RstatEl = RstatEl + "chunk INT,";
RstatEl = RstatEl + "choix INT);";
tables.push(["RstatEl",RstatEl]);



let TempTab = "";
TempTab = TempTab + "";
//tables.push(["Temp",TempTab]);

/*######################################################
Main
######################################################*/
function addTable(db,table) {
	let newbdd = table[1];
	db.query(newbdd, function (err, result) {
		if (err) throw err;
		console.log("TABLE created : "+table[0]);
	});
}
function main(db){
	for (var i = 0; i < tables.length; i++) {
		addTable(db,tables[i])
	}
}

/*######################################################
export
######################################################*/

module.exports = {
	init : (db) => {
		main(db);
	}
}