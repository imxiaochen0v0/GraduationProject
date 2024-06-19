<script setup>
import { ref } from "vue"
import { http, baseUrl } from "../../utils/http"
import { onShow } from "@dcloudio/uni-app"

const userInfo = ref({})
const getUserInfo = async () => {
  const res = await http('/my/getUserInfo')
  userInfo.value = res.data
}
onShow(() => {
  getUserInfo()
})


const to = (link) => {
  uni.navigateTo({
    url: `/pages/user/${link}`
  })
}

const quit = () => {
  uni.removeStorageSync('token')
  uni.reLaunch({
    url: '/pages/login/login'
  })
}
</script>

<template>
  <view class='user'>
    <u-navbar left-icon="" placeholder safe-area-inset-top height="20px"></u-navbar>
    <uni-card shadow="0 0 0 0" :border="false" isFull @click="to('info')" :title="userInfo.nickname || '未设置昵称'"
      :sub-title="userInfo.username" :extra="'余额：' + userInfo.amount || 0" :thumbnail="baseUrl + userInfo.user_pic">
      <u-cell-group :border="false">
        <u-cell title="修改密码" @click="to('changePassword')">
          <template #value><u-icon name="lock" size="20"></u-icon></template>
        </u-cell>
        <u-cell title="帮助中心">
          <template #value><u-icon name="question-circle" size="20"></u-icon></template>
        </u-cell>
        <u-cell title="意见反馈">
          <template #value><u-icon name="info-circle" size="20"></u-icon></template>
        </u-cell>
        <u-cell title="设置">
          <template #value><u-icon name="setting" size="20"></u-icon></template>
        </u-cell>
        <br>
        <view style="display: flex; margin-top: 50rpx;">
          <button @click.stop="quit" type="warn" size="mini">退出登录</button>
        </view>
      </u-cell-group>
    </uni-card>
  </view>
</template>

<style lang='scss' scoped>
:deep(.uni-card__header) {
  height: 150rpx;
}
</style>