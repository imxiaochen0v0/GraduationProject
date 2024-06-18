const express = require('express')
const router = express.Router()

const { getHotels, likeHotel, getOrders } = require('../router_handler/hotel')

router.post('/list', getHotels)
router.post('/like', likeHotel)
router.post('/orders', getOrders)


module.exports = router