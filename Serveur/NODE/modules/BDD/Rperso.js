Rattack = class{
	constructor(db){
		this.db = db;
	}

	add(id,degat,nom,callback){
		let sql = "INSERT INTO `Rattack`(`id`, `perso`,`degat`,`nomATK`) VALUES ";
		sql = sql + "(null,'"+id+"','"+degat+"','"+nom+"');";
		this.db.query(sql, function (err, result){
			if (err) throw err;
			callback(result)
		});
	}

	get(id,callback){
		let sql = "SELECT * FROM `Rattack` WHERE `perso`="+id+";" ;
		this.db.query(sql, function (err, result) {
			if (err) throw err;

			callback(result)
		});
	}
	del(id,callback){
		let sql = "DELETE FROM `Rattack` WHERE `perso`="+id+";" ;
		this.db.query(sql, function (err, result) {
			if (err) throw err;
			callback(result)
		});

	}
}

function format(ls) {

	let perso = {};
	for (var i = 0; i < ls.length; i++) {

		if (perso[ls[i].id] == undefined) {
			perso[ls[i].id] = {
				"id":ls[i].id,
				"nom":ls[i].nom,
				"pv":ls[i].pv,
				"playable":ls[i].playable,
				"img":ls[i].img,
				"attack":[{"nom":ls[i].nomATK,"degat":ls[i].degat}]
			}
		}else{
			perso[ls[i].id]["attack"].push({"nom":ls[i].nomATK,"degat":ls[i].degat});
		}

		

	}
	let tab = [];
	for(var key in perso) {
		let el = perso[key];
		/*for (var i = 0; i < el.attack.length; i++) {
			
			el["attack"+(i+1)] = el.attack[i];
		}*/
		tab.push(el);
	}
	return tab;
}

module.exports = {
	class:function () {
		return class {
			constructor(db){
				this.db = db;
				this.atk = new Rattack(this.db);
					
			}
			add(nom,pv,play,img,atks,callback,id=null){

				let sql = "INSERT INTO `Rperso`(`id`, `nom`,`pv`,`playable`,`img`) VALUES " ;
				sql = sql + "("+id+",'"+nom+"','"+pv+"','"+play+"','"+img+"');";
				this.db.query(sql, function (err, result) {
					if (err) throw err;
					etape2(result);
					
				});
				let BDD = this.db;
				let ATK = this.atk;
				function etape2(result) {
					let sqlls = "SELECT * FROM Rperso ORDER BY id DESC;" ;
					BDD.query(sqlls, function (err2, result2) {
						if (id == null) {
							id = result2[0].id;
						}

						for (var i = 0; i < atks.length; i++) {
							let atk = atks[i];
							if (atk[0]!="") {
								ATK.add(id,atk[1],atk[0],function (atkRes) {});
							}
							
							
						}
						callback(result)
					});
				}

			}
			ls(callback){
				
				let sql = "SELECT Rperso.*,Rattack.degat,Rattack.nomATK FROM Rperso JOIN Rattack ON Rperso.id=Rattack.perso ORDER BY Rperso.id DESC;" ;
				this.db.query(sql, function (err, result) {
					if (err) throw err;
					callback(format(result));
				});

			}
			get(id,callback){
				let sql = "SELECT Rperso.*,Rattack.degat,Rattack.nomATK FROM Rperso JOIN Rattack ON Rperso.id=Rattack.perso WHERE Rperso.id="+id+" ;" ;
				this.db.query(sql, function (err, result) {
					if (err) throw err;
					callback(format(result));
				});

			}

			del(id,callback){
				const This = this;
				let sql = "DELETE FROM `Rperso` WHERE `id`="+id+";" ;
				this.db.query(sql, function (err, result) {
					if (err) throw err;
					This.atk.del(id,function (atkRes) {
						callback(result)
					});
				});

			}
		}
	}
}