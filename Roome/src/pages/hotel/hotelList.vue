<script setup>
import { ref } from "vue"
import { http, baseUrl } from "@/utils/http"

const city = defineProps()
const hotelList = ref([])
const getHotelList = async () => {
    const res = await http('/hotel/list', {
        method: 'POST',
        data: {
            city: city.name
        }
    })
    hotelList.value = res.data
}
getHotelList()
</script>

<template>
    <div>
        <view class="hotelList">
            <u-navbar :title="city.name" :autoBack="true" safeAreaInsetTop placeholder fixed>
            </u-navbar>
            <u-empty mode="order" v-if="hotelList === undefined" style="margin-top: 100rpx;"></u-empty>
            <uni-card padding="0" margin="10" v-for="(item, index) in hotelList" :key="item.id">
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
                                <u-text :text="`距离${item.distance}km`" color="#aaa" size="12" margin="10rpx"></u-text>
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
    </div>
</template>

<style lang="scss" scoped>
.hotelList {
    padding: 25rpx;

    :deep(.uni-card) {
        height: 240rpx;
        padding-left: 0px !important;
        padding-right: 0px !important;
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
</style>