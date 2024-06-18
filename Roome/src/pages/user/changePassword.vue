<script setup>
import { ref } from "vue";
import { http } from "../../utils/http"

const pwd = ref({
  oldPwd: '',
  newPwd: ''
})
const uToastRef = ref(null)
const changePassword = async () => {
  await http('/my/updatePassword', {
    method: 'POST',
    data: pwd.value
  })
  uni.clearStorageSync('token')
  uToastRef.value.show({
    message: '修改成功',
    type: 'success',
    duration: 1000,
    complete() {
      uni.switchTab({
        url: '/pages/user/user'
      })
    }
  })
}
</script>

<template>
  <view class=''>
    <up-toast ref="uToastRef"></up-toast>

    <u-navbar placeholder safeAreaInsetTop title="修改密码" :autoBack="true"> </u-navbar>

    <view style="padding: 50rpx;">
      <uni-forms label-position="top">
        <uni-forms-item label="旧密码" name="">
          <uni-easyinput type="text" v-model="pwd.oldPwd" />
        </uni-forms-item>
        <uni-forms-item label="新密码" name="">
          <uni-easyinput type="text" v-model="pwd.newPwd" />
        </uni-forms-item>
      </uni-forms>

      <view style="padding: 0 150rpx;">
        <u-button color="#36CFC9" @click="changePassword">保存</u-button>
      </view>
    </view>

  </view>
</template>

<style lang='scss' scoped></style>