const express = require('express')
const router = express.Router()

const { getHotels, likeHotel, getOrders, getCityList, updateOrder } = require('../router_handler/hotel')

router.post('/list', getHotels)
router.post('/like', likeHotel)
router.post('/orders', getOrders)
router.post('/city', getCityList)
router.post('/updateOrder', updateOrder)

module.exports = router