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
	addPost(preRoute+"/perso/add/",(req,res)=>{
		let err = [];
		const nom = (req.body.name);
		if (estVide(nom) || estScript(nom)) { err.push("Le nom est Invalide !")}
		const pv = (req.body.pv);
		if (pv < 1) {err.push("Les pv doivent etre supérieur à 0 !")}

		const play = (req.body.play);

		const atk1Name = (req.body.atk1Name);
		if ((estScript(atk1Name))) { err.push("Le nom de l'attaque 1 est Invalide !")}
		const atk1Degat = (req.body.atk1Degat);
		

		const atk2Name = (req.body.atk2Name);
		if ((estScript(atk2Name))) { err.push("Le nom de l'attaque 2 est Invalide !")}
		const atk2Degat = (req.body.atk2Degat);
		

		const atk3Name = (req.body.atk3Name);
		if ((estScript(atk3Name))) { err.push("Le nom de l'attaque 3 est Invalide !")}
		const atk3Degat = (req.body.atk3Degat);

		const img = (req.body.img);
		if (estVide(img) || estScript(img)) { err.push("L'image est Invalide !")}
		

		let atks = [
			[atk1Name,atk1Degat],
			[atk2Name,atk2Degat],
			[atk3Name,atk3Degat]
		]

		if (err.length != 0) {
			res.send(errorPage(err))
		}else{
			BDD.Rperso.add(nom,pv,play,img,atks,function (data) {
				res.redirect(preRoute+"/perso");
			})
		}

		
	});
	addRoute(preRoute+"/perso/ls",(req,res)=>{
		BDD.Rperso.ls(function (data) {
			res.status(200).json(data);
		})
        
    });

    addRoute(preRoute+"/perso/get/:id",(req,res)=>{
    	const id = (req.params.id);
        BDD.Rperso.get(id,function (data) {
			res.status(200).json(data);
		})
    });

    addPost(preRoute+"/perso/del/",(req,res)=>{
    	const id = (req.body.id);
        BDD.Rperso.del(id,function (data) {
			res.redirect(preRoute+"/perso");
		})
    });

    addPost(preRoute+"/perso/mod/",(req,res)=>{

		const id = (req.body.id);

		let err = [];
		const nom = (req.body.name);
		if (estVide(nom) || estScript(nom)) { err.push("Le nom est Invalide !")}
		const pv = (req.body.pv);
		if (pv < 1) {err.push("Les pv doivent etre supérieur à 0 !")}

		const atk1Name = (req.body.atk1Name);
		if ((estScript(atk1Name))) { err.push("Le nom de l'attaque 1 est Invalide !")}
		const atk1Degat = (req.body.atk1Degat);
		

		const atk2Name = (req.body.atk2Name);
		if ((estScript(atk2Name))) { err.push("Le nom de l'attaque 2 est Invalide !")}
		const atk2Degat = (req.body.atk2Degat);
		

		const atk3Name = (req.body.atk3Name);
		if ((estScript(atk3Name))) { err.push("Le nom de l'attaque 3 est Invalide !")}
		const atk3Degat = (req.body.atk3Degat);
		
		const img = (req.body.img);
		if (estVide(img) || estScript(img)) { err.push("L'image est Invalide !")}

		const play = (req.body.play);
		
		let atks = [
			[atk1Name,atk1Degat],
			[atk2Name,atk2Degat],
			[atk3Name,atk3Degat]
		]
		if (err.length != 0) {
			res.send(errorPage(err))
		}else{
			BDD.Rperso.del(id,function (data) {
				BDD.Rperso.add(nom,pv,play,img,atks,function (data) {
					res.redirect(preRoute+"/perso");
				},id)
			})
		}
		

		
	});


    addRoute(preRoute+'/perso', function(request, response) {
        response.sendFile(__dirname + pathHTML +'/Rperso.html');
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