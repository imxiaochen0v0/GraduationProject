<script setup>
const login = () => {
	uni.navigateTo({
		url: '/pages/login/login'
	})
}

const enroll = () => {
	uni.navigateTo({
		url: '/pages/login/enroll'
	})
}
</script>

<template>
	<view class='steer'>
		<image src="../../static/img/login_logo.png" mode="widthFix" />

		<view>
			<view class="title">你的旅行计划</view>
			<view class="subtitle">预订一间我们独一无二的酒店来逃离平凡</view>
		</view>

		<view class="btn">
			<up-button @click="login" size="large" color="#36CFC9" shape="circle">登录</up-button>
			<up-button @click="enroll" size="large" color="#F5F5F5" shape="circle"><text
					style="color: black;">注册</text></up-button>
		</view>
	</view>
</template>

<style lang='scss' scoped>
.steer {
	height: 85vh;
	display: flex;
	flex-direction: column;
	justify-content: space-evenly;

	image {
		width: 100%;
	}

	.title {
		width: 100%;
		text-align: center;
		font-size: 48rpx;
		color: #333;
		margin-bottom: 10rpx;
	}

	.subtitle {
		width: 100%;
		text-align: center;
		font-size: 25rpx;
		color: #ccc;
	}

	.btn {
		padding: 0 30rpx;
		height: 220rpx;
		display: flex;
		flex-direction: column;
		justify-content: space-evenly;
	}
}
</style>