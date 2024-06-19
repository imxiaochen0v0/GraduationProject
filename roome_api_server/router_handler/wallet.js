const db = require('../db/index')

// 支付接口
exports.pay = (req, res) => {
  let sql = 'select amount from users where id = ?'
  if (req.body.amount <= 0 && !req.body.order_id && Object.keys(req.body).length === 0) {
    return res.send({ code: 1, message: '参数错误' })
  }
  db.query(sql, [req.auth.id], (err, results) => {
    if (err)
      return res.send({ code: 1, message: err.message })
    if (results.length === 0)
      return res.send({ code: 1, message: '用户不存在' })
    if (results[0].amount < req.body.amount) {
      return res.send({ code: 1, message: '余额不足' })
    }
    const amount = results[0].amount - req.body.amount
    sql = 'update users set amount = ? where id = ?'
    db.query(sql, [amount, req.auth.id], (err, results) => {
      if (err)
        return res.send({ code: 1, message: err.message })
      if (results.affectedRows !== 1)
        return res.send({ code: 1, message: '支付失败' })
      sql = 'update hotelOrder set status = 1 where id = ?'
      db.query(sql, [req.body.order_id], (err, results) => {
        if (err)
          return res.send({ code: 1, message: err.message })
        if (results.affectedRows !== 1)
          return res.send({ code: 1, message: '支付失败' })
        res.send({ code: 0, message: '支付成功', amount })
      })
    })
  })
}

// 充值接口
exports.recharge = (req, res) => {
  const sql = 'select amount from users where id = ?'
  if (req.body.amount <= 0 || Object.keys(req.body).length === 0) {
    return res.send({ code: 1, message: '请输入正确的金额' })
  }
  db.query(sql, [req.auth.id], (err, results) => {
    if (err)
      return res.send({ code: 1, message: err.message })
    if (results.length === 0)
      return res.send({ code: 1, message: '用户不存在' })
    const amount = results[0].amount + parseInt(req.body.amount)
    const sql = 'update users set amount = ? where id = ?'
    db.query(sql, [amount, req.auth.id], (err, results) => {
      if (err)
        return res.send({ code: 1, message: err.message })
      if (results.affectedRows !== 1)
        return res.send({ code: 1, message: '充值失败' })
      res.send({ code: 0, message: '充值成功', amount })
    })
  })
}