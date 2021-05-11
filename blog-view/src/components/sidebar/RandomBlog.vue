<template>
	<!--随机文章-->
	<div class="ui segments m-box">
		<div class="ui secondary segment"><i class="bookmark icon"></i>随机文章</div>
		<div class="ui yellow segment">
			<div class="ui divided items">
				<!-- <div class="item" v-for="blog in randomBlogList" :key="blog.id">
					<div class="content">
						<a href="javascript:;" @click.prevent="toBlog(blog)" class="header m-text-500">{{ blog.title }}</a>
						<div class="meta">
							<router-link :to="`/category/${blog.category.name}`">
								<i class="folder open icon"></i>{{ blog.category.name }}
							</router-link>
						</div>
						<div class="extra">
							<router-link :to="`/tag/${tag.name}`" class="ui label m-text-500" :class="tag.color" v-for="(tag,index) in blog.tags" :key="index">{{ tag.name }}</router-link>
							<a href="javascript:;" @click.prevent="toBlog(blog)" class="ui right floated">
								阅读全文<i class="angle double right icon"></i>
							</a>
						</div> -->

				<div class="m-item" v-for="blog in randomBlogList" :key="blog.id" @click.prevent="toBlog(blog)">
					<div class="img" :style="{'background-image':'url(' + blog.firstPicture + ')'}"></div>
					<div class="info">
						<div class="date">{{ blog.createTime | dateFormat('YYYY-MM-DD') }}</div>
						<div class="title">{{ blog.title }}</div>
					</div>
				</div>
			</div>
		</div>
	</div>
</template>

<script>
	export default {
		name: "RandomBlog",
		props: {
			randomBlogList: {
				type: Array,
				required: true
			},
		},
		methods: {
			toBlog(blog) {
				this.$store.dispatch('goBlogPage', blog)
			}
		}
	}
</script>

<style scoped>
	.secondary.segment {
		padding: 10px;
	}

	.ui.divided.items .m-item:first-child {
		margin-top: 0;
	}

	.ui.divided.items .m-item {
		margin-top: 1rem;
		height: 7rem;
		position: relative;
		overflow: hidden;
		border-radius: 5px;
		cursor: pointer;
		user-select: none;
	}

	.ui.divided.items .m-item .img {
		position: absolute;
		top: 0;
		left: 0;
		right: 0;
		bottom: 0;
		object-fit: cover;
		background-position-x: center;
		background-position-y: center;
		background-size: cover;
	}

	.ui.divided.items .date {
		padding-top:50px;
	}


	.ui.divided.items .m-item .info {
		z-index: 1;
		background: linear-gradient(to bottom, rgba(0, 0, 0, 0), rgba(0, 0, 0, 0.2));
		position: absolute;
		left: 0;
		right: 0;
		bottom: 0;
		padding: .5rem !important;
		font-size: 12px;
		color: white;
	}
	.ui.divided.items .m-item .info .title {
		overflow: hidden;
		text-overflow: ellipsis;
		display: -webkit-box;
		-webkit-box-orient: vertical;
		-webkit-line-clamp: 1;
		word-break: break-word;
	}
</style>