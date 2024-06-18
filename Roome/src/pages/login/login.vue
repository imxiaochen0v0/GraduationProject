<script setup>
import { ref } from 'vue'
import { http } from "../../utils/http"

const enroll = () => {
  uni.navigateTo({
    url: '/pages/login/enroll'
  })
}

const userInfo = ref({
  username: 'admin',
  password: '000000'
})
const uToastRef = ref(null)
const login = async () => {
  const res = await http('/api/login', {
    method: 'POST',
    data: userInfo.value
  })
  if (res.code === 0) {
    uni.setStorageSync('token', res.token)
    uToastRef.value.show({
      message: '登录成功',
      type: 'success',
      duration: 1000,
      complete() {
        uni.switchTab({
          url: '/pages/index/index'
        })
      }
    })
  }
}
</script>

<template>
  <view class='login'>
    <up-toast ref="uToastRef"></up-toast>
    <view class="form">
      <view style="font-size: 50rpx;text-align: center;font-weight: bolder;margin-bottom: 100rpx;">登录</view>

      <input v-model="userInfo.username" placeholder="username" type="text" name="text" class="input">
      <input v-model="userInfo.password" placeholder="password" type="password" name="text" class="input">
    </view>
    <view class="btn">
      <up-button @click="login" size="large" color="#36CFC9" shape="circle" style="margin-bottom: 10rpx;">登录</up-button>
    </view>


    <view class="enroll">
      <text style="color: #909399; font-size: 25rpx;">还没有账号？</text>
      <text style="color: #36CFC9; font-size: 25rpx;" @click="enroll">注册</text>
    </view>
  </view>
</template>

<style lang='scss' scoped>
.login {
  height: 85vh;
  display: flex;
  flex-direction: column;
  justify-content: center;

  .form {
    display: flex;
    flex-direction: column;
    align-items: center;
    margin-bottom: 50rpx;
  }

  .btn {
    padding: 0 50rpx;
  }

  .enroll {
    text-align: center;
    margin-top: 200rpx;
  }
}


.input {
  width: 100%;
  max-width: 300px;
  height: 20px;
  padding: 12px;
  border-radius: 12px;
  border: 1.5px solid lightgrey;
  outline: none;
  transition: all 0.3s cubic-bezier(0.19, 1, 0.22, 1);
  box-shadow: 0px 0px 20px -18px;
  margin-bottom: 10px;
}
</style>