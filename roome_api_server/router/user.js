const express = require('express')
const router = express.Router()
// 导入用户处理函数模块
const { regUser, login } = require('../router_handler/user')
// 导入验证数据的中间件
const expressJoi = require('@escook/express-joi')
// 导入需要的验证规则对象
const { reg_login_schema } = require('../schema/user')

// 用户注册接口
router.post('/register', expressJoi(reg_login_schema), regUser)

// 用户登录接口
router.post('/login', expressJoi(reg_login_schema), login)

module.exports = router