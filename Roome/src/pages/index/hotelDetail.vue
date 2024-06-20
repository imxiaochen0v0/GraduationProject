<script setup>
import { onLoad } from "@dcloudio/uni-app"
import { ref } from "vue"
import { http, baseUrl } from "@/utils/http"

const hotel = ref({})
const hotelDetail = ref({})
// 获取酒店信息
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

// 打开确定预订弹层
const show = ref(false)
const open = (e) => {
  hotelDetail.value.price = e.price
  hotelDetail.value.type = e.type
  show.value = true
}

// 确定预订
const uToastRef = ref(null) // toast 组件实例
const confirm = async () => {
  await http('/hotel/updateOrder', {
    method: 'POST',
    data: {
      hotel_id: hotelDetail.value.id,
      price: hotelDetail.value.price,
      type: hotelDetail.value.type
    }
  })
  show.value = false
  uToastRef.value.show({
    type: 'success',
    message: '预订成功',
    duration: 1000,
  })
}

// 修改酒店收藏状态
const likeHotel = async () => {
  await http('/hotel/like', {
    method: 'POST',
    data: {
      id: hotelDetail.value.id,
      isLike: hotelDetail.value.isLike === 0 ? 1 : 0
    }
  })
  hotelDetail.value.isLike = hotelDetail.value.isLike === 0 ? 1 : 0
}
</script>

<template>
  <view class='container'>

    <up-toast ref="uToastRef" />

    <u-navbar :title="hotel.name" :autoBack="true" safeAreaInsetTop placeholder :fixed="false"></u-navbar>

    <!-- 酒店图片 -->
    <view class="swiper">
      <u-swiper previous-margin="15" next-margin="15" height="200" bg-color="#fff"
        :list="[baseUrl + hotelDetail.img]"></u-swiper>
    </view>

    <!-- 房间列表 -->
    <view class="card">
      <uni-card :cover="baseUrl + `/uploads/room/room${index + 1}.png`" margin="25px" v-for="(item, index) in  roomList"
        :key="index" :title="item.type" :extra="'￥' + item.price">
        <u-button color="#36CFC9" text="预订" @click="open(item)"></u-button>
      </uni-card>
    </view>

    <!-- 预订弹层 -->
    <u-modal :show="show" title="预订" content='您确定要预订吗？' @close="show = false" closeOnClickOverlay @confirm="confirm()">
    </u-modal>

    <!-- 收藏按钮 -->
    <view class="btn">
      <u-button size="large" :type="hotelDetail.isLike === 0 ? 'error' : 'info'" :plain="hotelDetail.isLike === 1" icon="star" shape="circle"
        @click="likeHotel()"></u-button>
    </view>

  </view>
</template>

<style lang='scss' scoped>
.container {
  padding-bottom: env(safe-area-inset-bottom);

  .btn {
    position: fixed;
    top: 90%;
    right: 5%;
    width: 75rpx;
    height: 75rpx;
    
    :deep(.u-button) {
      width: 75rpx;
      height: 75rpx;
      transition: all .5s ease-out;

      text {
        top: -1rpx !important;
        margin-right: 0 !important;
      }
    }
  }

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