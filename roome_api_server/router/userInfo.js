const express = require('express')
const router = express.Router()

// 导入 multer 和 path
const multer = require('multer')
const path = require('path')

// 创建 multer 的实例
const uploads = multer({ dest: path.join(__dirname, '../uploads/avatar') })

// 导入验证数据的中间件
const expressJoi = require('@escook/express-joi')

// 导入需要的验证规则对象
const { update_userinfo_schema, update_avatar_schema, update_password_schema } = require('../schema/user')
// 导入用户信息的处理函数模块
const { getUserInfo, updateUserInfo, updateUserAvatar, updateUserPassword } = require('../router_handler/userInfo')

router.get('/getUserInfo', getUserInfo)
router.post('/updateUserInfo', expressJoi(update_userinfo_schema), updateUserInfo)
router.post('/updateAvatar', uploads.single('avatar'), expressJoi(update_avatar_schema), updateUserAvatar)
router.post('/updatePassword', expressJoi(update_password_schema), updateUserPassword)

module.exports = router