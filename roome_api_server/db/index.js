const mysql = require('mysql')

const db = mysql.createPool({
  host: '127.0.0.1', // 数据库地址
  user: 'root', // 数据库用户名
  password: 'root', // 数据库密码
  database: 'roome' // 数据库名称
})

module.exports = db