/*######################################################
Import
######################################################*/


const express = require('express');
const bodyParser = require("body-parser");
require('dotenv').config();

let preRoute = "/admin";

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

function newToken() {
	let alpha = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789!@".split("");
	let token = "";
	for (var i = 0; i < 5; i++) {
		token = token + alpha[Math.floor(Math.random()*alpha.length)];
	}
	return token
}

/*######################################################
Main
######################################################*/

function main() {
	addPost(preRoute+"/state/add",(req,res)=>{
		const raw = (req.body.choix);
		if (typeof raw != undefined) {
			let token = newToken();
			let choix = raw.split("!")
			for (var i = 0; i < choix.length-1; i++) {
				BDD.state.add(token,i,choix[i],choix[i+1])
			}

			res.send(token);

		}else{
			console.log(req.body);
			res.send("-1");
		}
		
	});


    addRoute(preRoute+"/state/get/:token",(req,res)=>{
    	const token = (req.params.token);
        BDD.state.getToken(token,function (data) {
			res.status(200).json(data);
		})
    });

    addRoute(preRoute+"/state/get/:chunk/:choix",(req,res)=>{
    	const chunk = (req.params.chunk);
    	const choix = (req.params.choix);

        BDD.state.getChunk(chunk,choix,function (data) {
			res.status(200).json(data);
		})
    });

}


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