<script setup>
import { onLoad } from "@dcloudio/uni-app"
import { ref } from "vue"
import { http, baseUrl } from "@/utils/http"

const hotel = ref({})
const hotelDetail = ref({})
onLoad(async (options) => {
  hotel.value = options
  const res = await http('/hotel/list', {
    method: 'POST',
    data: {
      id: options.id
    }
  })
  hotelDetail.value = res.data[0]
  for (let i = 0; i < roomList.value.length; i++) {
    roomList.value[i].price = res.data[0].price * (3 - i)
  }
})

const roomList = ref([{
  type: '总统套房',
  price: 0
}, {
  type: '豪华套房',
  price: 0
}, {
  type: '普通套房',
  price: 0
},])

const show = ref(false)
const uToastRef = ref(null) // toast 组件实例
const open = (e) => {
  hotelDetail.value.price = e.price
  show.value = true
}

const confirm = async () => {
  await http('/hotel/updateOrder', {
    method: 'POST',
    data: {
      hotel_id: hotelDetail.value.id,
      price: hotelDetail.value.price
    }
  })
  show.value = false
  uToastRef.value.show({
    type: 'success',
    message: '预订成功',
    duration: 1000,
  })
}
</script>

<template>
  <view class='container'>

    <up-toast ref="uToastRef" />

    <u-navbar :title="hotel.name" :autoBack="true" safeAreaInsetTop placeholder></u-navbar>
    <view class="swiper">
      <u-swiper previous-margin="15" next-margin="15" height="200" bg-color="#fff"
        :list="[baseUrl + hotelDetail.img]"></u-swiper>
    </view>

    <view class="card">
      <uni-card :cover="baseUrl + `/uploads/room/room${index + 1}.png`" margin="25px" v-for="(item, index) in  roomList"
        :key="index" :title="item.type" :extra="'￥' + item.price">
        <u-button color="#36CFC9" text="预订" @click="open(item)"></u-button>
      </uni-card>
    </view>

    <u-modal :show="show" title="预订" content='您确定要预订吗？' @close="show = false" closeOnClickOverlay
      @confirm="confirm()"></u-modal>
  </view>
</template>

<style lang='scss' scoped>
.container {
  padding-bottom: env(safe-area-inset-bottom);

  .swiper {
    margin: 25rpx 0;
  }

  :deep(.uni-card) {
    .uni-card__cover {
      image {
        width: 100%;
      }
    }
  }
}
</style>