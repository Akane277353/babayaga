RChoix = class{
	constructor(db){
		this.db = db;
	}

	add(txt,suite,callback){
		let sql = "INSERT INTO `Rchoix`(`id`, `suivant`,`txt`) VALUES ";
		sql = sql + "(null,'"+suite+"','"+txt+"');";
		let DB = this.db
		this.db.query(sql, function (err, result){
			if (err) throw err;
			let sql = "SELECT MAX(id) AS 'id' FROM Rchoix;";
			DB.query(sql,function (err2,res2){
				if (err) throw err;
				callback(res2[0])
			})
			
		});
	}
	get(id,callback){
		let sql = "SELECT Rchoix.* ,Rhistoire.chaos FROM Rchoix JOIN Rhistoire ON Rhistoire.id=Rchoix.suivant WHERE Rchoix.id="+id+" ORDER BY Rchoix.id DESC;" ;
		this.db.query(sql, function (err, result) {
			if (err) throw err;
			callback(result)
		});
	}
	del(id,callback){
		let sql = "DELETE FROM `Rchoix` WHERE `id`="+id+";" ;
		this.db.query(sql, function (err, result) {
			if (err) throw err;
			callback(result)
		});

	}
	purge(id,UPThis,callback){
		let sql = "SELECT * FROM Rchoix WHERE suivant="+id+";";
		const This = this;
		this.db.query(sql, function (err, result){
			if (err) throw err;
			let sql = "DELETE FROM Rchoix WHERE suivant="+id+";";
			This.db.query(sql, function (err, result){if (err) throw err;});

			for (var i = 0; i < result.length; i++) {
				UPThis.clearChoix(result[i].id);
			}
		})
		callback(1);
	}
}

function format(ls,callback,choix,indice=0,res=[]) {
	const CHOIX = choix;
	if (ls.length<=indice) {
		callback(res);
	}else{
		let el = {
			"id":ls[indice]["id"],
			"description":ls[indice]["description"],
			"img":ls[indice]["img"],
			"fond":ls[indice]["fond"],
			"chaos":ls[indice]["chaos"],
			"combat":ls[indice]["combat"],
			"choix1":ls[indice]["choix1"],
			"choix2":ls[indice]["choix2"],
			"choix3":ls[indice]["choix3"],

		}
		CHOIX.get(el.choix1 ,function (res1) {
			let json = {
				"id":-1,
				"txt":"",
				"chaosRequis":0,
				"numeroChoix":-1,
				"choixRequis":[]
			};

			if (el.choix1 != "-1") {
				if (res1.length == 0) {
					console.log("	=>	Rhistoire id : "+ls[indice]["id"]+" choix1 : "+el.choix1)
				}
				json.txt=res1[0].txt;
				json.id=res1[0].id;
				json.numeroChoix=res1[0].suivant;
				json.chaosRequis = res1[0].chaos
			}
			el.choix1 = json;
			
			CHOIX.get(el.choix2 ,function (res2) {
				
				let json = {
					"id":-1,
					"txt":"",
					"chaosRequis":0,
					"numeroChoix":-1,
					"choixRequis":[]
				};
				if (el.choix2 != "-1") {
					if (res2.length == 0) {
						console.log("	=>	Rhistoire id : "+ls[indice]["id"]+" choix2 : "+el.choix2)
					}
					json.txt=res2[0].txt;
					json.id=res2[0].id;
					json.numeroChoix=res2[0].suivant;
					json.chaosRequis = res2[0].chaos
				}
				el.choix2 = json;
				CHOIX.get(el.choix3 ,function (res3) {
					
					let json = {
						"id":-1,
						"txt":"",
						"chaosRequis":0,
						"numeroChoix":-1,
						"choixRequis":[]
					};
					if (el.choix3 != "-1") {
						if (res3.length == 0) {
							console.log("	=>	Rhistoire id : "+ls[indice]["id"]+" choix3 : "+el.choix3)
						}
						json.txt=res3[0].txt;
						json.id=res3[0].id;
						json.numeroChoix=res3[0].suivant;
						json.chaosRequis = res3[0].chaos
					}
					el.choix3 = json;
					res.push(el);
					format(ls,callback,CHOIX,indice+1,res)
				})
			})
		})
	}

	
}

module.exports = {
	class:function () {
		return class {
			constructor(db){
				this.db = db;
				this.choix = new RChoix(this.db);
					
			}
			add(description,chaos,combat,img,fond,choix,callback,id=null){
				let BDD = this.db;
				let CHOIX = this.choix;

				let indice  = 0;
				let ids = [];
				if (choix.length == 0) {
					let sql = "INSERT INTO `Rhistoire`(`id`, `description`,`combat`,`chaos`,`img`,`fond`,`choix1`,`choix2`,`choix3`) VALUES " ;
					sql = sql + "("+id+",'"+description+"','"+combat+"','"+chaos+"','"+img+"','"+fond+"',-1,-1,-1);";
					this.db.query(sql, function (err, result) {
						if (err) throw err;
						callback(result);
						
					});

				}else{
					CHOIX.add(choix[0][0],choix[0][1],traitement);
					function traitement(res) {
						ids.push(res.id);
						indice = indice+1;
						if (indice>=choix.length) {

							let sql = "INSERT INTO `Rhistoire`(`id`, `description`,`combat`,`chaos`,`img`,`fond`,`choix1`,`choix2`,`choix3`) VALUES " ;
							if (indice == 1) {
								sql = sql + "("+id+",'"+description+"','"+combat+"','"+chaos+"','"+img+"','"+fond+"',"+ids[0]+",-1,-1);";	
							}
							if (indice == 2) {
								sql = sql + "("+id+",'"+description+"','"+combat+"','"+chaos+"','"+img+"','"+fond+"',"+ids[0]+","+ids[1]+",-1);";	
							}
							if (indice == 3) {
								sql = sql + "("+id+",'"+description+"','"+combat+"','"+chaos+"','"+img+"','"+fond+"',"+ids[0]+","+ids[1]+","+ids[2]+");";	
							}
							BDD.query(sql, function (err, result) {
								if (err) throw err;
								callback(result);
								
							});

						}else{
							CHOIX.add(choix[indice][0],choix[indice][1],traitement);
						}
					}
				}


			}
			ls(callback){
				
				let sql = "SELECT * FROM Rhistoire;" ;
				const CHOIX = this.choix;
				this.db.query(sql, function (err, result) {
					if (err) throw err;
					format(result,function (res) {
						callback(res);
					},CHOIX);
				});

			}
			get(id,callback){
				let sql = "SELECT * FROM Rhistoire WHERE id="+id+" ;" ;
				const CHOIX = this.choix;
				this.db.query(sql, function (err, result) {
					if (err) throw err;
					format(result,function (res) {
						callback(res);
					},CHOIX);
				});

			}
			clearChoix(id){
				let sql = "UPDATE `Rhistoire` SET choix1=-1 WHERE `choix1`="+id+";" ;
				this.db.query(sql, function (err, result) {
					if (err) throw err;
				});
				sql = "UPDATE `Rhistoire` SET choix2=-1 WHERE `choix2`="+id+";" ;
				this.db.query(sql, function (err, result) {
					if (err) throw err;
				});
				sql = "UPDATE `Rhistoire` SET choix3=-1 WHERE `choix3`="+id+";" ;
				this.db.query(sql, function (err, result) {
					if (err) throw err;
				});
			}

			del(id,callback){
				const This = this;
				This.get(id,function (rawel) {
					let el = rawel[0];
					if (el.choix1.id != -1) {This.choix.del(el.choix1.id,function (choix1res) {});}
					if (el.choix2.id != -1) {This.choix.del(el.choix2.id,function (choix2res) {});}
					if (el.choix3.id != -1) {This.choix.del(el.choix3.id,function (choix3res) {});}
					This.choix.purge(id,This,function (choixPurge) {});
					let sql = "DELETE FROM `Rhistoire` WHERE `id`="+id+";" ;
					This.db.query(sql, function (err, result) {
						if (err) throw err;
						callback(result)
					});
				});
			}

			mod(id,description,chaos,combat,img,fond,choix,callback){
				const This = this;
				let BDD = this.db;
				let CHOIX = this.choix;
				This.get(id,function (rawel) {
					let el = rawel[0];
					if (el.choix1.id != -1) {This.choix.del(el.choix1.id,function (choix1res) {});}
					if (el.choix2.id != -1) {This.choix.del(el.choix2.id,function (choix2res) {});}
					if (el.choix3.id != -1) {This.choix.del(el.choix3.id,function (choix3res) {});}



					let indice  = 0;
					let ids = [];
					if (choix.length == 0) {
						
						let sql = "UPDATE `Rhistoire` SET " ;
						sql = sql + "`description`='"+description+"',`combat`='"+combat+"',`chaos`='"+chaos+"',`img`='"+img+"',`fond`='"+fond+"',`choix1`='-1',`choix2`='-1',`choix3`='-1'";
						sql = sql + " WHERE id="+id+";";
						This.db.query(sql, function (err, result) {
							if (err) throw err;
							callback(result);
							
						});

					}else{
						CHOIX.add(choix[0][0],choix[0][1],traitement);
						function traitement(res) {
							ids.push(res.id);
							indice = indice+1;
							if (indice>=choix.length) {

								let sql = "UPDATE `Rhistoire` SET " ;
								if (indice == 1) {
									sql = sql + "`description`='"+description+"',`combat`='"+combat+"',`chaos`='"+chaos+"',`img`='"+img+"',`fond`='"+fond+"',`choix1`='"+ids[0]+"',`choix2`='-1',`choix3`='-1'";

								}
								if (indice == 2) {
									sql = sql + "`description`='"+description+"',`combat`='"+combat+"',`chaos`='"+chaos+"',`img`='"+img+"',`fond`='"+fond+"',`choix1`='"+ids[0]+"',`choix2`='"+ids[1]+"',`choix3`='-1'";

								}
								if (indice == 3) {
									sql = sql + "`description`='"+description+"',`combat`='"+combat+"',`chaos`='"+chaos+"',`img`='"+img+"',`fond`='"+fond+"',`choix1`='"+ids[0]+"',`choix2`='"+ids[1]+"',`choix3`='"+ids[2]+"'";

								}
								sql = sql + " WHERE id="+id+";";
								BDD.query(sql, function (err, result) {
									if (err) throw err;
									callback(result);
									
								});

							}else{
								CHOIX.add(choix[indice][0],choix[indice][1],traitement);
							}
						}
					}
					
				});
			}
		}
	}
}