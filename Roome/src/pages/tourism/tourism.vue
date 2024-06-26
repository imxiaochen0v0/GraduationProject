<script setup>
import { ref } from 'vue'
import { http, baseUrl } from "@/utils/http"

const tabsList = ref([{
  name: '最近预定'
},
{
  name: '已完成'
},
{
  name: '收藏'
}])

const loading = ref(false) // 加载状态
const uToastRef = ref(null) // toast 组件实例
// 获取酒店列表信息 
const hotelList = ref([])
const getHotelList = async (url, data) => {
  const res = await http(url, {
    method: 'POST',
    data
  })
  hotelList.value = res.data
}
getHotelList('/hotel/orders', { status: 0 })

const activeIndex = ref(0)
const change = async ({ index }) => {
  activeIndex.value = index
  loading.value = true
  hotelList.value = []
  if (index === 0)
    await getHotelList('/hotel/orders', { status: 0 })
  if (index === 1)
    await getHotelList('/hotel/orders', { status: 1 })
  if (index === 2)
    await getHotelList('/hotel/list', { isLike: 0 })
  loading.value = false
}

// 修改酒店收藏状态
const likeHotel = async (e, index) => {
  hotelList.value[index].isLike = e.isLike === 0 ? 1 : 0
  await http('/hotel/like', {
    method: 'POST',
    data: {
      id: e.id,
      isLike: e.isLike
    }
  })
}

// 打开 ActionSheet 弹层
const show = ref(false)
const open = (e) => {
  orderInfo.value = e
  show.value = true
}

// 支付订单
const orderInfo = ref({})
const payOrder = async () => {
  await http('/wallet/pay', {
    method: 'POST',
    data: {
      amount: orderInfo.value.price,
      order_id: orderInfo.value.id
    }
  })
  show.value = false
  uToastRef.value.show({
    type: 'success',
    message: '支付成功',
    duration: 1000,
    complete() {
      getHotelList('/hotel/orders', { status: 0 })
    }
  })
}

const to = (e)=>{
  uni.navigateTo({
    url: `/pages/index/hotelDetail?id=${e.hotel_id || e.id}&name=${e.name}`,
  })
}
</script>

<template>
  <view class=''>
    <up-toast ref="uToastRef" />

    <u-navbar left-icon="" placeholder height="20px"></u-navbar>
    <view class="navbarTitle">我的旅行</view>

    <up-tabs :list="tabsList" @change="change" lineColor="#36CFC9" item-style="padding: 0; width: 33%; height: 75rpx"
      :active-style="{
      color: '#36CFC9',
      fontWeight: '600',
      transform: 'scale(1.1)'
    }"></up-tabs>

    <u-loading-icon mode="circle" :show="loading" size="40"></u-loading-icon>

    <!-- 酒店列表 -->
    <view class="hotelList" v-if="!loading">
      <u-empty mode="order" v-if="hotelList === undefined" style="margin-top: 100rpx;">
      </u-empty>

      <view v-for="(item, index) in hotelList" :key="item.id">
        <uni-card padding="0" margin="10" @tap="to(item)">
          <!-- 喜欢酒店按钮 -->
          <view v-if="activeIndex === 2" class="likeBtn">
            <u-button :type="item.isLike === 0?'error':'info'" shape="circle" :plain="item.isLike === 1" icon="star"
              @tap.stop="likeHotel(item, index)"></u-button>
          </view>

          <!-- 订单状态 -->
          <view v-else class="orderStatus">
            <u-text :text="activeIndex === 0 ? '预定中' : '已完成'" :color="activeIndex === 1 ? '#bbb' : '#36CFC9'"
              size="12"></u-text>
          </view>

          <image :src="baseUrl + item.img" mode="widthFix" />

          <!-- 酒店信息 -->
          <view class="hotelContent">
            <!-- 顶部酒店信息 -->
            <view>
              <u-text :text="item.name" bold color="#000"></u-text>
              <u-text v-if="activeIndex === 2" :text="item.address" color="#aaa" size="12"></u-text>
              <u-text v-else :text="'订单号：' + item.id" color="#aaa" size="12"></u-text>
            </view>

            <!-- 底部酒店信息 -->
            <view class="hotelContentBottom">
              <view>
                <view style="display: flex;">
                  <u-icon :name="activeIndex === 2 ? 'map' : 'tags'" color="#36CFC9"></u-icon>
                  <u-text v-if="activeIndex === 2" :text="`距离${item.distance}km`" color="#aaa" size="12"
                    margin="10rpx"></u-text>
                  <u-text v-else :text="item.type" color="#aaa" size="12" margin="10rpx"></u-text>
                </view>
                <u-rate readonly v-model="item.rate" :count="5" active-color="#36CFC9"></u-rate>
              </view>

              <view v-if="activeIndex === 2">
                <u-text :text="`￥${item.price}`" bold color="#000"></u-text>
                <u-text text="/每晚" color="#000" size="12" align="center"></u-text>
              </view>

              <view v-else class="btn">
                <u-text align="center" :text="`￥${item.price}`" bold color="#000"></u-text>
                <up-button v-if="activeIndex === 0" text="支付" color="#36CFC9" size="mini"
                  @tap.stop="open(item)"></up-button>
                <u-text v-if="activeIndex === 1" align="center" text="支付成功" type="error" size="12" bold></u-text>
              </view>
            </view>
          </view>
        </uni-card>

        <!-- 支付弹层 -->
        <u-action-sheet title="支付" :show="show" @close="show = false" round="10">
          <view style="display: flex;width: 200rpx;margin: 25rpx auto;">
            <u-text align="center" text="￥" size="25" bold></u-text>
            <u-text align="center" :text="`${orderInfo.price}`" size="35" bold></u-text>
          </view>

          <up-cell style="padding:0 25rpx;" value="电子钱包" :border="false">
            <template #icon>付款方式</template>
          </up-cell>

          <view style="padding:0 200rpx;">
            <up-button text="支付" color="#36CFC9" @click="payOrder()"></up-button>
          </view>
        </u-action-sheet>
      </view>
    </view>
  </view>
</template>

<style lang='scss' scoped>
:deep(.u-loading-icon) {
  margin-top: 100rpx;
}

.navbarTitle {
  padding: 0 25rpx;
  font-size: 40rpx;
  font-weight: bold;
  margin-bottom: 25rpx;
}

.hotelList {
  padding: 25rpx;

  :deep(.uni-card) {
    height: 240rpx;
    padding-left: 0px !important;
    padding-right: 0px !important;
    border-radius: 10px;

    .likeBtn {
      z-index: 99;
      position: absolute;
      left: 90%;
      top: 5%;
      width: 50rpx;
      height: 50rpx;

      .u-button {
        width: 50rpx;
        height: 50rpx;
        transition: all .3s ease-out;

        text {
          margin-right: .3px !important;
        }
      }
    }

    .orderStatus {
      z-index: 99;
      position: absolute;
      left: 87%;
      top: 5%;
    }

    .uni-card__content {
      display: flex;

      image {
        width: 40%;
      }

      .hotelContent {
        padding: 10rpx 25rpx;
        display: flex;
        flex-direction: column;
        justify-content: space-between;
        width: 60%;

        .hotelContentBottom {
          display: flex;
          align-items: center;
          justify-content: space-between;
        }
      }
    }

  }
}
</style>