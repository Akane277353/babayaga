/*######################################################
Import
######################################################*/


const express = require('express');
const bodyParser = require("body-parser");
require('dotenv').config();

let preRoute = "";
/*######################################################
Setup
######################################################*/
let BDD = null;

let addRoute = null;
let addPost = null;

let repErr = null;
let repData = null;
let repOK = null;

let pathHTML = null;

function estVide(txt) {
	txt = txt.split(" ").join("");
	txt = txt.split("\n").join("");
	txt = txt.split("\r").join("");
	txt = txt.split("\t").join("");
	return txt == "";
}

function estScript(txt) {
	let bool = true;
	bool = bool && txt.split("<").length==1;
	bool = bool && txt.split(">").length==1;
	bool = bool && txt.split("`").length==1;
	bool = bool && txt.split("'").length==1;	
	bool = bool && txt.split("CREATE TABLE").length==1;
	return !bool;
}

function errorPage(err) {
	let res = '<!DOCTYPE html><html><head><meta charset="utf-8"><meta name="viewport" content="width=device-width, initial-scale=1"><title>Page Erreur</title></head><body><div><a href="'+preRoute+'/histoire"><button>Histoire</button></a><a href="'+preRoute+'/perso"><button>Personnage</button></a></div><div>';
	res = res +"<ol><li>"+ err.join("</li><li>")+"</li></ol>";
	res = res +"</div></body></html>";
	return res
}

/*######################################################
Main
######################################################*/

function main() {
	addPost(preRoute+"/histoire/add/",(req,res)=>{
		let err = [];
		const description = (req.body.description);
		if (estVide(description) || estScript(description)) { err.push("La description est Invalide !")}
		const chaos = (req.body.chaos);
		const combat = (req.body.combat);

		const ch1Name = (req.body.ch1Name);
		const ch1Suite = (req.body.ch1Suite);
		if ((estVide(ch1Name) && ch1Suite != 0) || estScript(ch1Name)) { err.push("Le nom du choix 1 est Invalide !")}
		

		const ch2Name = (req.body.ch2Name);
		const ch2Suite = (req.body.ch2Suite);
		if ((estVide(ch2Name) && ch2Suite != 0) || estScript(ch2Name)) { err.push("Le nom du choix 2 est Invalide !")}
		

		const ch3Name = (req.body.ch3Name);
		const ch3Suite = (req.body.ch3Suite);
		if ((estVide(ch3Name) && ch3Suite != 0) || estScript(ch3Name)) { err.push("Le nom du choix 3 est Invalide !")}
		
		const img = (req.body.img);
		if (estVide(img) || estScript(img)) { err.push("L'image est Invalide !")}

		const fond = (req.body.fond);
		if (estVide(fond) || estScript(fond)) { err.push("L'image de fond est Invalide !")}

		let choix = [
			[ch1Name,ch1Suite],
			[ch2Name,ch2Suite],
			[ch3Name,ch3Suite]
		]

		let choixs = [];
		for (let i = 0; i < choix.length; i++) {
			if(choix[i][1] != 0){
				choixs.push(choix[i]);
			}
		}
		if (err.length != 0) {
			res.send(errorPage(err))
		}else{
			BDD.Rhistoire.add(description,chaos,combat,img,fond,choixs,function (data) {
				res.redirect(preRoute+"/histoire");
			})
		}
		

		
	});
	addRoute(preRoute+"/histoire/ls",(req,res)=>{
		BDD.Rhistoire.ls(function (data) {
			res.status(200).json(data);
		})
        
    });

    addRoute(preRoute+"/histoire/get/:id",(req,res)=>{
    	const id = (req.params.id);
        BDD.Rhistoire.get(id,function (data) {
			res.status(200).json(data);
		})
    });

    addPost(preRoute+"/histoire/del/",(req,res)=>{
    	const id = (req.body.id);
        BDD.Rhistoire.del(id,function (data) {
			res.redirect(preRoute+"/histoire");
		})
    });

    addPost(preRoute+"/histoire/mod/",(req,res)=>{
    	let id = req.body.id; 

    	let err = [];
		const description = (req.body.description);
		if (estVide(description) || estScript(description)) { err.push("La description est Invalide !")}
		const chaos = (req.body.chaos);
		const combat = (req.body.combat);

		const ch1Name = (req.body.ch1Name);
		const ch1Suite = (req.body.ch1Suite);
		if ((estVide(ch1Name) && ch1Suite != 0) || estScript(ch1Name)) { err.push("Le nom du choix 1 est Invalide !")}
		

		const ch2Name = (req.body.ch2Name);
		const ch2Suite = (req.body.ch2Suite);
		if ((estVide(ch2Name) && ch2Suite != 0) || estScript(ch2Name)) { err.push("Le nom du choix 2 est Invalide !")}
		

		const ch3Name = (req.body.ch3Name);
		const ch3Suite = (req.body.ch3Suite);
		if ((estVide(ch3Name) && ch3Suite != 0) || estScript(ch3Name)) { err.push("Le nom du choix 3 est Invalide !")}
		
		const img = (req.body.img);
		if (estVide(img) || estScript(img)) { err.push("L'image est Invalide !")}

		const fond = (req.body.fond);
		if (estVide(fond) || estScript(fond)) { err.push("L'image de fond est Invalide !")}

		let choix = [
			[ch1Name,ch1Suite],
			[ch2Name,ch2Suite],
			[ch3Name,ch3Suite]
		]

		let choixs = [];
		for (var i = choix.length - 1; i >= 0; i--) {
			if(choix[i][1] != 0){
				choixs.push(choix[i]);
			}
		}
		if (err.length != 0) {
			res.send(errorPage(err))
		}else{
			BDD.Rhistoire.mod(id,description,chaos,combat,img,fond,choixs,function (data) {
				res.redirect(preRoute+"/histoire");
			})
		}
		
	});


    addRoute(preRoute+'/histoire', function(request, response) {
        response.sendFile(__dirname + pathHTML +'/Rhistoire.html');
    });
	addRoute(preRoute+'/Rstat', function(request, response) {
        response.sendFile(__dirname + pathHTML +'/Rstat.html');
    });}


/*######################################################
Export
######################################################*/
module.exports = {
	add:function (PBDD,PaddRoute,PaddPost,PrepErr,PrepData,PrepOK,PpathHTML) {
		BDD = PBDD;

		addRoute = PaddRoute;
		addPost = PaddPost;

		repErr = PrepErr;
		repData = PrepData;
		repOK = PrepOK;

		pathHTML = PpathHTML;

		main();
	}
}