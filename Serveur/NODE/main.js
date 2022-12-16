/*######################################################
Import
######################################################*/
const express = require('express');
const mysql = require('mysql');
require('dotenv').config();

const BDD = require('./modules/bdd.js');
const EXP = require('./modules/express.js');

/*######################################################
Constante
######################################################*/
const app = express();
const pathHTML = "./www/";
const pathMODULE = "./modules";
const PORT = 8081;

//DB
const host = process.env.HOST;
const user = process.env.MYSQL_USER;
const mdp = process.env.MYSQL_PASSWORD;

/*######################################################
BDD
######################################################*/


/*######################################################
Fonction
######################################################*/


/*######################################################
main
######################################################*/
function main(){
	let bdd = BDD.new(host,user,mdp);
	EXP.init(PORT,bdd);
}
main();
