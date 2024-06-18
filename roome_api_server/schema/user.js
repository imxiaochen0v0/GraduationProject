// 导入定义验证规则的包
const joi = require('joi')

// 定义规则
const username = joi.string().alphanum().min(4).max(12).required().messages({
  'string.alphanum': '用户名必须为字母和数字',
  'string.min': '用户名长度至少为4个字符',
  'string.max': '用户名长度最多为12个字符',
  'string.empty': '用户名不能为空'
})
const password = joi.string().pattern(/^[a-zA-Z0-9]{6,12}$/).required().messages({
  'string.pattern.base': '密码必须为字母和数字，长度为6到12个字符',
  'string.empty': '密码不能为空'
})

const nickname = joi.string().required()
const email = joi.string().email().required().messages({
  'string.email': '邮箱格式不正确',
  'string.empty': '邮箱不能为空'
})
const phone = joi.string().pattern(/^1[3-9]\d{9}$/).required().messages({
  'string.pattern.base': '手机号格式不正确',
})

const avatar = joi.string().dataUri().required()

// 用户登录和注册的规则
exports.reg_login_schema = {
  body: {
    username,
    password,
  }
}

// 修改用户信息的规则
exports.update_userinfo_schema = {
  body: {
    nickname,
    email,
    phone
  }
}

// 修改用户头像的规则
exports.update_avatar_schema = {
  body: {
    // avatar,
  }
}

// 修改用户密码的规则
exports.update_password_schema = {
  body: {
    oldPwd: password,
    newPwd: password
  },
}