<script setup>
import { ref } from "vue"
import { http, baseUrl } from "@/utils/http"
import { onLoad } from "@dcloudio/uni-app"

const hotelList = ref([])
const city = ref({}) // 城市信息，用于导航栏显示
// 获取城市名称，用于请求酒店列表数据
onLoad(async (options) => {
    city.value = options
    const res = await http('/hotel/list', {
        method: 'POST',
        data: {
            city: options.name
        }
    })
    hotelList.value = res.data
})

const to = async (e) => {
    uni.navigateTo({
        url: `/pages/index/hotelDetail?id=${e.id}&name=${e.name}`,

    })
}
</script>

<template>
    <view class="container">
        <view class="hotelList">
            <u-navbar :title="city.name" :autoBack="true" safeAreaInsetTop placeholder></u-navbar>

            <u-empty mode="favor" text="该城市暂无酒店" v-if="hotelList === undefined"></u-empty>
            <uni-card @click="to(item)" padding="0" margin="10" v-for="(item, index) in hotelList" :key="item.id">
                <image :src="baseUrl + item.img" mode="widthFix" />
                <view class="hotelContent">
                    <view>
                        <u-text :text="item.name" bold color="#000"></u-text>
                        <u-text :text="item.address" color="#aaa" size="12"></u-text>
                    </view>
                    <view class="hotelContentBottom">
                        <view>
                            <view style="display: flex;">
                                <u-icon name="map-fill" color="#36CFC9"></u-icon>
                                <u-text :text="`距离${item.distance}km`" color="#aaa" size="12"></u-text>
                            </view>
                            <u-rate readonly v-model="item.rate" :count="5" active-color="#36CFC9"></u-rate>
                        </view>
                        <view>
                            <u-text :text="`￥${item.price}`" bold color="#000"></u-text>
                            <u-text text="/每晚" color="#000" size="12" align="center"></u-text>
                        </view>
                    </view>
                </view>
            </uni-card>
        </view>
    </view>
</template>

<style lang="scss" scoped>
.container {
    padding-bottom: env(safe-area-inset-bottom);

    .hotelList {
        padding: 25rpx;

        :deep(.u-empty) {
            margin-top: 100rpx !important;
        }

        :deep(.uni-card) {
            height: 240rpx;
            padding: 0rpx !important;
            border-radius: 10px;

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
}
</style>