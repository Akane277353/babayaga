module.exports = {
	class:function () {
		return class {
			constructor(db){
				this.db = db;
					
			}
			add(token,pos,chunk,choix){
				let sql = "INSERT INTO `statEl`(`id`, `token`,`pos`,`chunk`,`choix`) VALUES (null,'"+token+"','"+pos+"','"+chunk+"','"+choix+"');";
				this.db.query(sql, function (err, result) {
					if (err) throw err;
					
				});
			}


			getToken(token,callback){
				let sql = "SELECT * FROM `statEl` WHERE token='"+token+"' ORDER BY `pos` ASC;";
				this.db.query(sql, function (err, result) {
					if (err) throw err;
					callback(result);
				});

			}

			getChunk(chunk,choix,callback){
				let sql = "SELECT * FROM `statEl` WHERE chunk='"+chunk+"' AND choix='"+choix+"' ORDER BY `pos` ASC;";
				this.db.query(sql, function (err, result) {
					if (err) throw err;
					callback(result);
				});

			}


			
		}
	}
}