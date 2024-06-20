<script setup>
import { ref } from 'vue'
import { http, baseUrl } from "../../utils/http"

// 获取实惠酒店列表
const hotelList = ref([])
const getHotelList = async () => {
	const res = await http('/hotel/list', {
		method: 'POST',
		data: {
			cheap: 0
		}
	})
	hotelList.value = res.data
}
getHotelList()

// 获取城市列表 API
const getCityList = async (data) => {
	return await http('/hotel/city', {
		method: 'POST',
		data
	})
}

// 获取推荐城市
const recommendCityList = ref([])
const getRecommendCityList = async () => {
	const res = await getCityList({ recommend: 0 })
	recommendCityList.value = res.data
}
getRecommendCityList()

// 获取热门城市	
const hotCityList = ref([])
const getHotCityList = async () => {
	const res = await getCityList({ isHot: 0 })
	hotCityList.value = res.data
}
getHotCityList()

const to = (e) => {
	uni.navigateTo({
		url: `/pages/index/hotelList?name=${e.name}`
	})
}


// 搜索 
const uToast = ref(null)
const keyword = ref('')
const search = async () => {
	if (!keyword.value)
		return uToast.value.show({
			type: 'error',
			message: '请输入搜索内容',
		})
	uni.navigateTo({
		url: `/pages/index/hotelList?name=${keyword.value.trim()}`
	})
}
</script>

<template>
	<view class='index'>
		<up-toast ref="uToast"></up-toast>

		<image style="width: 100%;" :src="baseUrl + '/uploads/index/index_bg.png'" mode="widthFix" />
		<view class='content'>
			<view class="title">下一次你想去哪？</view>

			<!-- 搜索框 -->
			<view class="input">
				<u-input v-model="keyword" @confirm="search()" placeholder="伦敦， 开普敦" prefixIcon="search"
					prefixIconStyle="font-size: 20px;color: #909399" fontSize="25rpx"></u-input>
			</view>

			<!-- 日期、房间选择 -->
			<view class="date">
				<view class="dateCard">
					<view class="dateTitle">选择日期</view>
					<view class="dateText">2024 - 10 - 10</view>
				</view>
				<view style="height: 100%; width: 1px; background-color: #eee;"></view>
				<view class="dateCard">
					<view class="dateTitle">房间数</view>
					<view class="dateText">1间 - 2人</view>
				</view>
			</view>

			<!-- 搜索按钮 -->
			<view class="btn">
				<up-button @click="search()" color="#36CFC9" shape="circle" style="margin-bottom: 10rpx;">搜索酒店</up-button>
			</view>

			<!-- 推荐 -->
			<view class="recommend">
				<view class="recommendTitle">推荐</view>

				<scroll-view scroll-x="true" class="scroll-view_H">
					<uni-card class="scroll-view-item_H" v-for="(item, index) in recommendCityList" :key="item.id" margin="10rpx"
						padding="0" @click="to(item)">
						<image :src="baseUrl + item.img" mode="widthFix" />
						<text>{{ item.name }}</text>
					</uni-card>
				</scroll-view>
			</view>

			<!-- 最受欢迎的旅游圣地 -->
			<view class="hot">
				<view class="hotTitle">最受欢迎的旅游圣地</view>

				<scroll-view scroll-x="true" class="scroll-view_H">
					<uni-card class="scroll-view-item_H" v-for="(item, index) in hotCityList" :key="item.id" margin="10rpx"
						padding="0" @click="to(item)">
						<image :src="baseUrl + item.img" mode="widthFix" />
						<text>{{ item.name }}</text>
					</uni-card>
				</scroll-view>
			</view>

			<!-- 最实惠的价格 -->
			<view class="cheap">
				<view class="cheapTitle">最实惠的价格</view>

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
		</view>
	</view>
</template>

<style lang='scss' scoped>
.scroll-view_H {
	white-space: nowrap;
}

.scroll-view-item_H {
	display: inline-block;
}

.index {
	.content {
		.title {
			font-size: 40rpx;
			color: #fff;
			margin-top: -260rpx;
			padding: 25rpx;
		}

		.input {
			padding: 50rpx 75rpx;

			:deep(.u-input) {
				border-radius: 50px;
				box-shadow: 1px 1px 5px #ccc;
			}
		}

		.date {
			height: 75rpx;
			display: flex;
			padding: 0 70rpx;

			.dateCard {
				width: 50vw;
				margin: 0 10rpx;

				.dateTitle {
					font-size: 25rpx;
					color: #ccc;
					text-align: center;
				}

				.dateText {
					font-size: 25rpx;
					text-align: center;
					margin-top: 10rpx;
					font-weight: 600;
				}
			}
		}

		.btn {
			padding: 50rpx 75rpx;
		}

		.recommend {
			padding: 25rpx;

			.recommendTitle {
				font-size: 30rpx;
				font-weight: 600;
			}

			:deep(.uni-card) {
				width: 35vw;
				height: 190rpx;
				padding-left: 0px !important;
				padding-right: 0px !important;
				border-radius: 10px;

				image {
					width: 100%;
				}

				text {
					position: absolute;
					top: 70%;
					left: 10%;
					z-index: 10;
					color: #fff;
				}
			}
		}

		.hot {
			padding: 25rpx;

			.hotTitle {
				font-size: 30rpx;
				font-weight: 600;
			}

			:deep(.uni-card) {
				width: 50vw;
				height: 200rpx;
				padding-left: 0px !important;
				padding-right: 0px !important;
				border-radius: 10px;

				image {
					width: 100%;
				}

				text {
					position: absolute;
					top: 70%;
					left: 10%;
					z-index: 10;
					color: #fff;
				}
			}
		}

		.cheap {
			padding: 25rpx;

			.cheapTitle {
				font-size: 30rpx;
				font-weight: 600;
			}

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
	}
}
</style>