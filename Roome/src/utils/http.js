export const baseUrl = 'http://192.168.137.1:8080'

export const http = (url, options) => {
	return new Promise((resolve, reject) => {
		uni.request({
			url: baseUrl + url,
			header: {
				Authorization: uni.getStorageSync('token')
			},
			...options,
			success(res) {
				if (res.data.code === 401) {
					uni.reLaunch({
						url: '/pages/login/steer'
					})
					return uni.showToast({
						title: '请登录',
						icon: 'error'
					})
				}
				if (res.data.code === 1) {
					return uni.showToast({
						title: res.data.message,
						icon: 'none'
					})
				}
				resolve(res.data)
			},
			fail(err) {
				reject(err)
				uni.showToast({
					title: '请求失败',
					icon: 'none'
				})
			}
		})
	})
}
