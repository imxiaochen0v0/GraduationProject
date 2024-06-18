const express = require('express')
const router = express.Router()

const { pay, recharge } = require('../router_handler/wallet')

router.post('/pay', pay)
router.post('/recharge', recharge)

module.exports = router