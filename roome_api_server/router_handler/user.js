const db = require('../db/index')
// 导入 bcryptjs 模块, 用于加密密码
const bcrypt = require('bcryptjs')
// 导入生成 token 的包
const jwt = require('jsonwebtoken')
const config = require('../config')

// 注册函数, 用于处理用户注册请求
exports.regUser = (req, res) => {
  // TODO: 查询用户名是否被占用
  const userInfo = req.body
  const sql = 'select * from users where username = ?'
  db.query(sql, [userInfo.username], (err, results) => {
    if (err)
      return res.send({ message: err.message, code: 1 })
    if (results.length > 0)
      return res.send({ message: '用户名已存在', code: 1 })
    userInfo.password = bcrypt.hashSync(userInfo.password, 10) // 加密密码
    // TODO: 插入新用户到数据库
    const sql = 'insert into users set ?'
    db.query(sql, { username: userInfo.username, password: userInfo.password },
      (err, results) => {
        if (err)
          return res.send({ message: err.message, code: 1 })
        if (results.affectedRows !== 1)
          return res.send({ message: '注册失败', code: 1 })
        res.send({ message: '注册成功', code: 0 })
      })
  })
}

// 登录函数,用于处理用户登录请求
exports.login = (req, res) => {
  const userInfo = req.body
  // TODO: 查询用户名是否存在
  const sql = 'select * from users where username = ?'
  db.query(sql, [userInfo.username], (err, results) => {
    if (err)
      return res.send({ message: err.message, code: 1 })
    if (results.length !== 1)
      return res.send({ message: '用户名不存在', code: 1 })
    // TODO: 判断用户密码是否正确，使用 bcrypt.compareSync() 方法进行密码比对
    const compareResult = bcrypt.compareSync(userInfo.password, results[0].password)
    if (!compareResult)
      return res.send({ message: '密码错误', code: 1 })
    // TODO: 生成 token 字符串，并返回给客户端
    const user = { ...results[0], password: '', user_pic: '' } // 去除密码字段，避免泄露
    const token = jwt.sign(user, config.jwtSecretKey, { expiresIn: config.expiresIn })
    res.send({ message: '登录成功', code: 0, token: 'Bearer ' + token })
  })
}