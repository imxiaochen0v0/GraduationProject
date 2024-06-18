const express = require('express')
const app = express()

// 引入cors中间件，解决跨域问题。
const cors = require('cors')
app.use(cors())

app.use(express.urlencoded({ extended: false }))
app.use(express.json())

// 解析token的中间件
const expressJWT = require('express-jwt')
const config = require('./config')
app.use(expressJWT.expressjwt({ secret: config.jwtSecretKey, algorithms: ["HS256"] }).unless({ path: [/^\/api\//, /^\/uploads\//] }))

// 托管静态资源文件
app.use('/uploads', express.static('./uploads'))

const userRouter = require('./router/user')
app.use('/api', userRouter)
const userinfoRouter = require('./router/userInfo')
app.use('/my', userinfoRouter)
const hotelRouter = require('./router/hotel')
app.use('/hotel', hotelRouter)
const walletRouter = require('./router/wallet')
app.use('/wallet', walletRouter)

// 错误级别中间件
app.use((err, req, res, next) => {
  if (err.name === 'ValidationError')
    return res.send({
      code: 1,
      message: err.message
    })
  // 捕获并处理 token 解析失败错误
  if (err.name === 'UnauthorizedError')
    return res.send({
      code: 401,
      message: err.message
    })
})

app.listen(8080, () => {
  console.log('Server is running on http://127.0.0.1:8080')
})