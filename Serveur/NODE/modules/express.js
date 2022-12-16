/*######################################################
Import
######################################################*/
const express = require('express');
const bodyParser = require("body-parser");
require('dotenv').config();



const Perso =require("./routes/perso.js");
const Histoire =require("./routes/histoire.js");
const State =require("./routes/state.js");
const RPerso =require("./routes/Rperso.js");
const RHistoire =require("./routes/Rhistoire.js");
const RState =require("./routes/Rstate.js");
/*######################################################
Constante
######################################################*/
const app = express();
//app.use(bodyParser.json());

const pathHTML = "/www/";
const pathMODULE = "./modules";
let PORT = -1;

//BDD
let BDD = null;

/*######################################################
Variable Global
######################################################*/


/*######################################################
Fonction
######################################################*/

function addRoute(path,callback,appli = app) {

	appli.get(path, (req,res) => {
        res.setHeader('Access-Control-Allow-Origin', '*');
        res.setHeader('Access-Control-Allow-Headers', 'Origin, X-Requested-With, Content, Accept, Content-Type, Authorization');
        res.setHeader('Access-Control-Allow-Methods', 'GET, POST, PUT, DELETE, PATCH, OPTIONS');
		callback(req,res);
	});
}

function addPost(path,callback,appli = app) {
	appli.post(path, (req,res) => {
        res.setHeader('Access-Control-Allow-Origin', '*');
        res.setHeader('Access-Control-Allow-Headers', 'Origin, X-Requested-With, Content, Accept, Content-Type, Authorization');
        res.setHeader('Access-Control-Allow-Methods', 'GET, POST, PUT, DELETE, PATCH, OPTIONS');
		callback(req,res);
	});
}
//fonction de reponse :
function repErr(err) {
    return {"status":0,"err":err,"data":{"id":0}}
}
function repData(data) {
    return {"status":1,"err":[],"data":data}

}
function repOK() {
    return {"status":1,"err":[],"data":{"id":0}}

}
//ajout des routes :
function setupRoute(){

    Perso.add(BDD,addRoute,addPost,repErr,repData,repOK,pathHTML);
    Histoire.add(BDD,addRoute,addPost,repErr,repData,repOK,pathHTML);
    State.add(BDD,addRoute,addPost,repErr,repData,repOK,pathHTML);

    RPerso.add(BDD,addRoute,addPost,repErr,repData,repOK,pathHTML);
    RHistoire.add(BDD,addRoute,addPost,repErr,repData,repOK,pathHTML);
    RState.add(BDD,addRoute,addPost,repErr,repData,repOK,pathHTML);
	

	addRoute('/', function(request, response) {
		response.sendFile(__dirname + "/routes" + pathHTML +'index.html');
	});
	addRoute('/style.css', function(request, response) {
		response.sendFile(__dirname + "/routes" + pathHTML +'style.css');
	});

}

/*######################################################
Main
######################################################*/



function main(){
	app.use(bodyParser.urlencoded({ extended: true }));
	
	//ajout des routes :
	setupRoute();

	//lancement du serveur :
	app.listen(PORT, () => {
		console.log("Serveur listen on : "+PORT)
	});
}
/*######################################################
export
######################################################*/

module.exports = {
	init: function (port,bdd) {
		PORT = port;
		BDD = bdd;
		main();
	}
}

