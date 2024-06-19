const db = require('../db/index')

// 导入 bcryptjs 模块，用于密码加密
const bcrypt = require('bcryptjs')

// 获取用户信息
exports.getUserInfo = (req, res) => {
  const sql = 'select id, username, nickname, email, user_pic, phone, amount  from users where id = ?'
  db.query(sql, [req.auth.id], (err, result) => {
    if (err)
      return res.send({ code: 1, message: err.message })
    if (result.length !== 1)
      return res.send({ code: 1, message: '获取用户信息失败' })
    res.send({
      code: 0,
      message: '获取用户信息成功',
      data: result[0] // 返回用户信息对象
    })
  })
}

// 修改用户信息
exports.updateUserInfo = (req, res) => {
  const sql = 'update users set ? where id = ?'
  db.query(sql, [req.body, req.auth.id], (err, result) => {
    if (err)
      return res.send({ code: 1, message: err.message })
    if (result.affectedRows !== 1)
      return res.send({ code: 1, message: '修改用户信息失败' })
    res.send({ code: 0, message: '修改用户信息成功' })
  })
}

// 修改用户头像
exports.updateUserAvatar = (req, res) => {
  const sql = 'update users set user_pic = ? where id = ?'
  // const user_pic = path.join('/uploads', req.file.filename) // 拼接头像图片的路径
  const user_pic = '/uploads/avatar/' + req.file.filename // 拼接头像图片的路径
  db.query(sql, [user_pic, req.auth.id], (err, result) => {
    if (err)
      return res.send({ code: 1, message: err.message })
    if (result.affectedRows !== 1)
      return res.send({ code: 1, message: '修改用户头像失败' })
    res.send({ code: 0, message: '修改用户头像成功' })
  })
}

// 修改用户密码
exports.updateUserPassword = (req, res) => {
  const sql = 'select password from users where id = ?'
  db.query(sql, [req.auth.id], (err, result) => {
    if (err)
      return res.send({ code: 1, message: err.message })
    if (result.length !== 1)
      return res.send({ code: 1, message: '修改用户密码失败' })
    // TODO: 判断用户输入的旧密码是否正确
    const compareResult = bcrypt.compareSync(req.body.oldPwd, result[0].password)
    if (!compareResult)
      return res.send({ code: 1, message: '旧密码错误' })
    const sql = 'update users set password = ? where id = ?'
    const newPwd = bcrypt.hashSync(req.body.newPwd, 10) // 加密新密码
    // TODO: 更新数据库对应的用户密码
    db.query(sql, [newPwd, req.auth.id], (err, result) => {
      if (err)
        return res.send({ code: 1, message: err.message })
      if (result.affectedRows !== 1)
        return res.send({ code: 1, message: '修改用户密码失败' })
      res.send({ code: 0, message: '修改用户密码成功' })
    })
  })
}