/*######################################################
Import
######################################################*/
const express = require('express');
const mysql = require('mysql');
require('dotenv').config();


const dbTable = require('./bdd-Table.js');

const Perso = require('./BDD/perso.js');
const Histoire = require('./BDD/histoire.js');
const State = require('./BDD/state.js');

const RPerso = require('./BDD/Rperso.js');
const RHistoire = require('./BDD/Rhistoire.js');
const RState = require('./BDD/Rstate.js');

/*######################################################
fonction
######################################################*/

/*######################################################
module
######################################################*/

let INIT = class{
	constructor(db){
		this.db = db;
	}
	Table(){
		dbTable.init(this.db);
	}
	Values(){
		/*for (var i = 0; i < 1; i++) {
			this.msg.add("root","msg n°"+i);
		}*/
	}
}



let PERSO = Perso.class();
let HISTOIRE = Histoire.class();
let STATE = State.class();

let RPERSO = RPerso.class();
let RHISTOIRE = RHistoire.class();
let RSTATE = RState.class();

/*######################################################
BDD
######################################################*/
let BDD = class{
	constructor(host,user,mdp){
		//constantes
		this.host = host;
		this.user = user;
		this.mdp = mdp;


		//connexion
		const db = mysql.createConnection({   
			host: this.host,   
			user: this.user,   
			password: this.mdp,
			port:process.env.MYSQL_PORT,
			database: process.env.MYSQL_DATABASE
		});

		db.connect(function(err) {   
			if (err) throw err;
			console.log("Connecté à la base de données MySQL!"); 
		});

		//modules
		this.init = new INIT(db);

		this.perso = new PERSO(db);
		this.histoire = new HISTOIRE(db);
		this.state = new STATE(db);

		this.Rperso = new RPERSO(db);
		this.Rhistoire = new RHISTOIRE(db);
		this.Rstate = new RSTATE(db);

		//initialisation
		this.init.Table();
		this.init.Values();
	}
}










/*######################################################
export
######################################################*/
module.exports = {
	new : function (host,user,mdp) {
		return new BDD(host,user,mdp);
	}
}
