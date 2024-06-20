<script setup>
import { ref } from 'vue'
import { http } from "@/utils/http"

const list = [5, 10, 20, 50, 100, 200]

// 获取用户信息
const userInfo = ref(uni.getStorageSync('userInfo'))

const show = ref(false)
const amount = ref(0)
const amountTemp = ref()
const uToast = ref(null)
const open = (item) => {
  if (item)
    amount.value = item
  else {
    if (!amountTemp.value) {
      return uToast.value.show({
        type: 'error',
        message: '请输入充值金额',
        duration: 1000,
      })
    }
    amount.value = amountTemp.value
  }
  show.value = true
}

// 充值
const recharge = async () => {
  await http('/wallet/recharge', {
    method: 'POST',
    data: {
      amount: amount.value
    }
  })
  show.value = false
  userInfo.value.amount += amount.value
  uni.setStorageSync('userInfo', userInfo.value)
  uToast.value.show({
    type: 'success',
    message: '充值成功',
    duration: 1000,
  })
}
</script>

<template>
  <div class='container'>
    <u-navbar title="充值" placeholder auto-back safe-area-inset-top></u-navbar>

    <up-toast ref="uToast"></up-toast>

    <view>
      <uni-card title="余额" margin="0 10">
        <u-text :text="`CNY ${userInfo.amount}`" bold size="35"></u-text>
      </uni-card>
    </view>

    <view>
      <uni-card margin="0 10">
        <u-grid :border="false">
          <u-grid-item v-for="(item, index) in list" :key="index">
            <u-button color="#36CFC9" plain :text="item" @click="open(item)"></u-button>
          </u-grid-item>
        </u-grid>

        <view style="margin: 25rpx;">
          <uni-easyinput v-model="amountTemp" placeholder="自定义充值金额" type="number" />
        </view>
        <view style="margin: 25rpx;">
          <u-button color="#36CFC9" text="充值" @click="open()"></u-button>
        </view>
      </uni-card>
    </view>

    <u-action-sheet title="充值" :show="show" @close="show = false" round="10">
      <view style="margin: 25rpx 0;">
        <u-text :text="`￥ ${amount}`" bold size="35" align="center"></u-text>
      </view>
      <view style="padding:0 200rpx;">
        <up-button text="充值" color="#36CFC9" @click="recharge()"></up-button>
      </view>
    </u-action-sheet>

  </div>
</template>

<style lang='scss' scoped>
.container {
  :deep(.u-grid-item) {
    padding: 10rpx;
  }

  :deep(.uni-card__content) {
    .u-text {
      padding: 25rpx;
    }
  }
}
</style>