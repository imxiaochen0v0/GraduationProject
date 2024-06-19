const express = require('express')
const router = express.Router()

const { getHotels, likeHotel, getOrders, getCityList } = require('../router_handler/hotel')

router.post('/list', getHotels)
router.post('/like', likeHotel)
router.post('/orders', getOrders)
router.get('/city', getCityList)

module.exports = router