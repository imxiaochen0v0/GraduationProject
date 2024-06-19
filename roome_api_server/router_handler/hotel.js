const db = require('../db/index')

// 获取酒店列表
exports.getHotels = (req, res) => {
  let sql = 'select * from hotel where isLike = ? or cheap = ? or city = ? or id = ?'
  if (Object.keys(req.body).length === 0) {
    sql = 'select * from hotel'
  }
  db.query(sql, [req.body.isLike, req.body.cheap, req.body.city, req.body.id], (err, result) => {
    if (err)
      return res.send({ code: 1, message: err.message })
    if (result.length === 0)
      return res.send({ code: 0, message: '暂无数据' })
    res.send({
      code: 0,
      message: '获取成功',
      data: result
    })
  })
}

// 喜欢 / 取消喜欢酒店
exports.likeHotel = (req, res) => {
  let isLike = parseInt(req.body.isLike)
  if (isLike !== 0 && isLike !== 1)
    return res.send({ code: 1, message: '参数错误' })
  let sql = 'update hotel set isLike = ? where id = ?'
  db.query(sql, [req.body.isLike, req.body.id], (err, result) => {
    if (err)
      return res.send({ code: 1, message: err.message })
    if (result.affectedRows !== 1)
      return res.send({ code: 0, message: '酒店不存在' })
    res.send({ code: 0, message: '操作成功' })
  })
}

// 获取订单
exports.getOrders = (req, res) => {
  let sql = 'select * from hotelOrder where status = ?'
  db.query(sql, [req.body.status], (err, result) => {
    let data = []
    if (err)
      return res.send({ code: 1, message: err.message })
    if (result.length === 0)
      return res.send({ code: 0, message: '暂无数据' })
    sql = 'select id, name, img, rate, address, distance from hotel where id = ?'
    result.forEach(item => {
      db.query(sql, [item.hotel_id, item.status], (err, hotelResult) => {
        if (err)
          return res.send({ code: 1, message: err.message })
        if (hotelResult.length === 0)
          return res.send({ code: 0, message: '酒店不存在' })
        data.push({ ...hotelResult[0], ...item })
        if (data.length === result.length)
          res.send({ code: 0, message: '获取成功', data })
      })
    })
  })
}