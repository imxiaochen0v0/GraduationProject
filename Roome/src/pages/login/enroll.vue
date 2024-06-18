<script setup>
import { ref } from 'vue'
import { http } from "../../utils/http";

const login = () => {
  uni.navigateTo({
    url: '/pages/login/login'
  })
}

const userInfo = ref({
  username: '',
  password: ''
})
const uToastRef = ref(null)
const enroll = async () => {
  const res = await http('/api/register', {
    method: 'POST',
    data: userInfo.value
  })
  if (res.code === 0) {
    uToastRef.value.show({
      message: '注册成功',
      type: 'success',
      duration: 1000,
      complete() {
        uni.navigateTo({
          url: '/pages/login/login'
        })
      }
    })
  }
}
</script>

<template>
  <view class='enroll'>
    <up-toast ref="uToastRef"></up-toast>
    <view class="form">
      <view style="font-size: 50rpx;text-align: center;font-weight: bolder;margin-bottom: 100rpx;">注册</view>

      <input v-model="userInfo.username" placeholder="username" type="text" name="text" class="input">
      <input v-model="userInfo.password" placeholder="password" type="password" name="text" class="input">
    </view>
    <view class="btn">
      <up-button @click="enroll" size="large" color="#36CFC9" shape="circle"
        style="margin-bottom: 10rpx;">注册</up-button>
    </view>


    <view class="login">
      <text style="color: #909399; font-size: 25rpx;">已有账号？</text>
      <text style="color: #36CFC9; font-size: 25rpx;" @click="login">登录</text>
    </view>
  </view>
</template>

<style lang='scss' scoped>
.enroll {
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

  .login {
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