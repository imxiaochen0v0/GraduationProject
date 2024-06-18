<script setup>
import { ref } from "vue"
import { http, baseUrl } from "../../utils/http"

const userInfo = ref({})
const getUserInfo = async () => {
  const res = await http('/my/getUserInfo')
  userInfo.value = res.data
}
getUserInfo()

const disabled = ref(true)
const uToastRef = ref(null)
// 修改用户信息
const changeUserInfo = async () => {
  disabled.value = !disabled.value
  if (disabled.value === true) {
    // 修改用户信息接口
    const res = await http('/my/updateUserInfo', {
      method: 'POST',
      data: userInfo.value
    })
    uToastRef.value.show({
      message: res.message,
      type: 'success',
      duration: 1000,
      complete() {
        getUserInfo()
      }
    })
  }
}

// 修改头像
const changePic = async () => {
  if (disabled.value === true) {
    return
  }
  uni.chooseImage({
    count: 1,
    success: async (e) => {
      const filePath = e.tempFilePaths[0]
      const res = await uni.uploadFile({
        url: baseUrl + '/my/updateAvatar',
        filePath,
        name: 'avatar',
        formData: {
          'user_id': userInfo.value.user_id
        },
        header: {
          'Authorization': uni.getStorageSync('token')
        }
      })
      uni.showToast({
        title: JSON.parse(res.data).message,
        icon: 'success',
      })
      await getUserInfo()
    }
  })
}


</script>

<template>
  <view class=''>
    <up-toast ref="uToastRef"></up-toast>

    <u-navbar placeholder safeAreaInsetTop :autoBack="true"></u-navbar>

    <view class="title">编辑个人信息</view>

    <!-- 头像 -->
    <view class="img">
      <image :src="baseUrl + userInfo.user_pic" mode="scaleToFill" @click="changePic" />
      <view v-if="disabled === false" style="font-size: 25rpx; color: #ccc; text-align: center">点击修改头像</view>
    </view>

    <!-- 个人信息 -->
    <u-cell-group :border="false">
      <u-cell title="用户名">
        <template #value><input v-model="userInfo.username" disabled></template>
      </u-cell>
      <u-cell title="用户昵称">
        <template #value><input :class="{ input: disabled === false }" v-model="userInfo.nickname"
            :disabled="disabled"></template>
      </u-cell>
      <u-cell title="邮箱">
        <template #value><input :class="{ input: disabled === false }" v-model="userInfo.email"
            :disabled="disabled"></template>
      </u-cell>
      <u-cell title="手机号">
        <template #value><input :class="{ input: disabled === false }" v-model="userInfo.phone"
            :disabled="disabled"></template>
      </u-cell>
    </u-cell-group>

    <!-- 修改按钮 -->
    <view style="padding: 50rpx 150rpx;">
      <u-button :color="disabled === false ? '#fa3534' : '#36CFC9'" @click="changeUserInfo">{{ disabled ===
      false ? '保存' : '编辑' }}</u-button>
    </view>
  </view>
</template>

<style lang='scss' scoped>
.title {
  margin-top: 50rpx;
  padding: 25rpx;
  font-size: 40rpx;
  font-weight: bold
}

.img {
  display: flex;
  flex-direction: column;
  justify-content: center;
  align-items: center;
  width: 35vw;
  height: 35vw;
  margin: 0 auto;

  image {
    width: 30vw;
    height: 30vw;
    border: 1px solid #eee;
    border-radius: 50%;
  }
}

input {
  border-radius: 5px;
  padding: 5px;
}

.input {
  border: 1px solid #ccc;
}
</style>