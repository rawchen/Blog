<template>
	<header ref="header">
		<div class="view">
			<!-- <img ref="imgbg1" src="https://cdn.jsdelivr.net/gh/Naccl/blog-resource/img/bg1.jpg" style="display: none;"> -->
			<div style="background-image: url('https://cdn.jsdelivr.net/gh/yoyling/JsDelivr/bg/bg-04.png');"></div>
			<!-- <div class="bg2" style="background-image: url('https://cdn.jsdelivr.net/gh/yoyling/JsDelivr/bg/bg-02.jpg');"></div> -->
			<!-- <div class="bg3" style="background-image: url('https://cdn.jsdelivr.net/gh/yoyling/JsDelivr/bg/bg-03.jpg');" v-show="loaded"></div> -->
		</div>
		<div class="text-malfunction">{{blogName}}<span class="caret"></span>
		</div>
		<div class="wrapper">
			<i class="ali-iconfont icon-down" @click="scrollToMain"></i>
		</div>
		<div class="wave1"></div>
		<div class="wave2"></div>
	</header>
</template>

<script>
	import {mapState} from 'vuex'

	export default {
		name: "Header",
		props:{
			blogName:{
				type: String,
				default: 'yoyling'
			}
		},
		data() {
			return {
				loaded: false
			}
		},
		computed: {
			...mapState(['clientSize'])
		},
		watch: {
			'clientSize.clientHeight'() {
				this.setHeaderHeight()
			}
		},
		mounted() {
			/**
			 * 因为bg3.jpg比较小，通常会比bg1.jpg先加载，显示出来会有一瞬间bg1显示一半，bg3显示一半，为了解决这个问题，增加这个判断，让bg1加载完毕后再显示bg3
			 * HTML中使用img标签的原因：我个人想用div作为图片的载体，而只有img标签有图片加载完毕的onload回调，所以用一个display: none的img人柱力来加载图片
			 * 当img中的src加载完毕后，会把图片缓存到浏览器，后续在div中用background url的形式将直接从浏览器中取出图片，不会下载两次图片
			 */
		
		this.setHeaderHeight()
		// 	let startingPoint
		// 	const header = this.$refs.header
		// 	header.addEventListener('mouseenter', (e) => {
		// 		startingPoint = e.clientX
		// 	})
		// 	header.addEventListener('mouseout', (e) => {
		// 		header.classList.remove('moving')
		// 		header.style.setProperty('--percentage', 0.5)
		// 	})
		// 	header.addEventListener('mousemove', (e) => {
		// 		let percentage = (e.clientX - startingPoint) / window.outerWidth + 0.5
		// 		header.style.setProperty('--percentage', percentage)
		// 		header.classList.add('moving')
		// 	})
		// }
		},
		methods: {
			//根据可视窗口高度，动态改变首图大小
			setHeaderHeight() {
				this.$refs.header.style.height = this.clientSize.clientHeight + 'px'
			},
			//平滑滚动至正文部分
			scrollToMain() {
				window.scrollTo({top: this.clientSize.clientHeight, behavior: 'smooth'})
			}
		},
	}
</script>

<style scoped>
	header {
		--percentage: 0.5;
		user-select: none;
	}

	.view {
		position: absolute;
		top: 0;
		right: 0;
		bottom: 0;
		left: 0;
		display: flex;
		justify-content: center;
		transform: translatex(calc(var(--percentage) * 100px));
	}

	.view div {
		background-position: center center;
		background-size: cover;
		position: absolute;
		width: 110%;
		height: 100%;
	}

	.view .bg1 {
		z-index: 10;
		opacity: calc(1 - (var(--percentage) - 0.5) / 0.5);
	}

	.view .bg2 {
		z-index: 20;
		opacity: calc(1 - (var(--percentage) - 0.25) / 0.25);
	}

	.view .bg3 {
		left: -10%;
	}

	header .view,
	header .bg1,
	header .bg2 {
		transition: .2s all ease-in;
	}

	header.moving .view,
	header.moving .bg1,
	header.moving .bg2 {
		transition: none;
	}

	.text-malfunction {
		line-height: 37px;
		position: absolute;
		top: 45%;
		left: 50%;
		transform: translate(-50%, -50%) scale(2.5);
		max-width: 800px;
		font-size: 50px;
		text-align: center;
		font-family: sans-serif;
		color: white;
	}

	.caret {
		animation-name: flash;
		width: 4px;
		height: 37px;
		background-color: #fff;
		margin-left: 5px;
		margin-bottom: -2px;
		animation-duration: 2s;
		animation-fill-mode: both;
		animation-iteration-count: infinite;
		display: inline-block;
		vertical-align: bottom;
	}

	@keyframes flash {
		from, 50%, to {
			opacity: 1;
		}

		25%, 75% {
			opacity: 0;
		}
	}

	.wrapper {
		position: absolute;
		width: 100px;
		bottom: 150px;
		left: 0;
		right: 0;
		margin: auto;
		font-size: 26px;
		z-index: 100;
	}

	.wrapper i {
		font-size: 60px;
		opacity: 0.5;
		cursor: pointer;
		position: absolute;
		top: 55px;
		left: 20px;
		animation: opener .5s ease-in-out alternate infinite;
		transition: opacity .2s ease-in-out, transform .5s ease-in-out .2s;
	}

	.wrapper i:hover {
		opacity: 1;
	}

	@keyframes opener {
		100% {
			top: 65px
		}
	}

	.wave1, .wave2 {
		position: absolute;
		bottom: 0;
		transition-duration: .4s, .4s;
		z-index: 80;
	}

	.wave1 {
		background: url('https://cdn.jsdelivr.net/gh/yoyling/JsDelivr/bg/wave1.png') repeat-x;
		height: 75px;
		width: 100%;
	}

	.wave2 {
		background: url('https://cdn.jsdelivr.net/gh/yoyling/JsDelivr/bg/wave2.png') repeat-x;
		height: 90px;
		width: calc(100% + 100px);
		left: -100px;
	}
</style>