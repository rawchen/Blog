<p align="center">
	<a href="" target="_blank">
		<img src="https://cdn.jsdelivr.net/gh/rawchen/JsDelivr/static/blog/favicon-gif.gif" alt="Blog · Logo" style="width: 200px; height: 200px">
	</a>
</p>
<p align="center">
	<img src="https://img.shields.io/badge/JDK-1.8+-orange">
	<img src="https://img.shields.io/badge/SpringBoot-2.2.7.RELEASE-brightgreen">
	<img src="https://img.shields.io/badge/MyBatis-3.5.5-red">
	<img src="https://img.shields.io/badge/Vue-2.6.11-brightgreen">
    <img src="https://img.shields.io/badge/Redis-3.2.100-brightgreen">
	<img src="https://hits.seeyoufarm.com/api/count/incr/badge.svg?url=https%3A%2F%2Fgithub.com%2Frawchen%2FBlog&count_bg=%2379C83D&title_bg=%23555555&icon=&icon_color=%23E7E7E7&title=hits&edge_flat=false">
</p>





## 简介

前后端分离Blog系统，基于 Spring Boot + Vue 前后端分离博客系统

自用博客，长期维护，欢迎勘误。此项目本是学习过程中的产物，参考了许多优秀的教程和项目。


> [https://blog.rawchen.com](https://blog.rawchen.com)
>
> [https://admin.rawchen.com](https://admin.rawchen.com)

## 后端

1. 核心框架：[Spring Boot](https://github.com/spring-projects/spring-boot)
2. 安全框架：[Spring Security](https://github.com/spring-projects/spring-security)
3. Token 认证：[jjwt](https://github.com/jwtk/jjwt)
4. 持久层框架：[MyBatis](https://github.com/mybatis/spring-boot-starter)
5. 分页插件：[PageHelper](https://github.com/pagehelper/Mybatis-PageHelper)
6. NoSQL缓存：[Redis](https://github.com/redis/redis)
7. Markdown 转 HTML：[commonmark-java](https://github.com/commonmark/commonmark-java)
8. 离线 IP 地址库：[ip2region](https://github.com/lionsoul2014/ip2region)
9. 定时任务：[quartz](https://github.com/quartz-scheduler/quartz)
10. UserAgent 解析：[yauaa](https://github.com/nielsbasjes/yauaa)



邮件模板参考自[Typecho-CommentToMail-Template](https://github.com/MisakaTAT/Typecho-CommentToMail-Template)

基于 JDK8 开发，8以上要添加依赖：

```xml
<dependency>
    <groupId>javax.xml.bind</groupId>
    <artifactId>jaxb-api</artifactId>
    <version>2.3.0</version>
</dependency>
```



## 前端

核心框架：Vue2.x、Vue Router、Vuex

Vue 项目基于 @vue/cli4.x 构建

JS 依赖及参考的 css：[axios](https://github.com/axios/axios)、[moment](https://github.com/moment/moment)、[nprogress](https://github.com/rstacruz/nprogress)、[v-viewer](https://github.com/fengyuanchen/viewerjs)、[prismjs](https://github.com/PrismJS/prism)、[APlayer](https://github.com/DIYgod/APlayer)、[MetingJS](https://github.com/metowolf/MetingJS)、[lodash](https://github.com/lodash/lodash)、[mavonEditor](https://github.com/hinesboy/mavonEditor)、[echarts](https://github.com/apache/echarts)、[tocbot](https://github.com/tscanlin/tocbot)、[iCSS](https://github.com/chokcoco/iCSS)



### 后台 UI

[Element UI](https://github.com/ElemeFE/element)：后台 CMS 部分完全基于 Element UI 开发



### 前台 UI

[Semantic UI](https://semantic-ui.com/)：主要使用，页面布局样式，语义化的 css，该框架 Vue 版的开发完成度不高，见 [Semantic UI Vue](https://semantic-ui-vue.github.io/#/)

[Element UI](https://github.com/ElemeFE/element)：部分使用，一些小组件，弥补了 Semantic UI 的不足，便于快速实现效果

文章排版：基于 [typo.css](https://github.com/sofish/typo.css) 修改



## 快速开始

1. 创建 MySQL 数据库`blog`，并运行`blog.sql`初始化表数据
2. 修改配置信息`blog-api/src/main/resources/application-dev.properties`
3. 安装 Redis 并启动
4. 启动后端SpringBoot服务
5. 分别在`blog-cms`和`blog-view`目录下执行`npm install`安装依赖
6. 分别在`blog-cms`和`blog-view`目录下执行`npm run serve`启动前后台页面



## 注意事项

- 本人使用的 MySQL 版本为5.5.61
- 数据库中默认用户名密码为`admin`，`admin`，因为是个人博客，没打算做修改密码的页面，可在`util.HashUtils`下的`main`方法手动生成密码存入数据库
- 注意修改`application-dev.properties`的配置信息
  - Redis 若没有密码，留空即可
  - 注意修改`token.secretKey`，否则无法保证 token 安全性



## 隐藏功能

- 在前台访问`/login`路径登录后，可以以博主身份（带有博主标识）回复评论，且不需要填写昵称和邮箱即可提交
- 在 Markdown 中加入`<meting-js server="netease" type="song" id="歌曲id" theme="#25CCF7"></meting-js>` 可以在文章中添加 [APlayer](https://github.com/DIYgod/APlayer) 音乐播放器，`netease`为网易云音乐，其它配置及具体用法参考 [MetingJS](https://github.com/metowolf/MetingJS)
- 提供了两种隐藏文字效果：在 Markdown 中使用`@@`包住文字，文字会被渲染成“黑幕”效果，鼠标悬浮在上面时才会显示；使用`%%`包住文字，文字会被“蓝色覆盖层”遮盖，只有鼠标选中状态才会反色显示。例如：`@@隐藏文字@@`，`%%隐藏文字%%`
- 大部分个性化配置可以在后台“站点设置”中修改



## 项目截图

![](https://cdn.jsdelivr.net/gh/rawchen/JsDelivr/static/blog/screenshot/01.png)

![](https://cdn.jsdelivr.net/gh/rawchen/JsDelivr/static/blog/screenshot/02.png)

![](https://cdn.jsdelivr.net/gh/rawchen/JsDelivr/static/blog/screenshot/03.png)

![](https://cdn.jsdelivr.net/gh/rawchen/JsDelivr/static/blog/screenshot/04.png)

![](https://cdn.jsdelivr.net/gh/rawchen/JsDelivr/static/blog/screenshot/05.png)

![](https://cdn.jsdelivr.net/gh/rawchen/JsDelivr/static/blog/screenshot/06.png)

![](https://cdn.jsdelivr.net/gh/rawchen/JsDelivr/static/blog/screenshot/07.png)

![](https://cdn.jsdelivr.net/gh/rawchen/JsDelivr/static/blog/screenshot/08.png)

![](https://cdn.jsdelivr.net/gh/rawchen/JsDelivr/static/blog/screenshot/09.png)

![](https://cdn.jsdelivr.net/gh/rawchen/JsDelivr/static/blog/screenshot/10.png)

![](https://cdn.jsdelivr.net/gh/rawchen/JsDelivr/static/blog/screenshot/11.png)

![](https://cdn.jsdelivr.net/gh/rawchen/JsDelivr/static/blog/screenshot/12.png)



## Stargazers

[![](https://reporoster.com/stars/rawchen/blog)](https://github.com/rawchen/blog/stargazers)

## Forkers

[![](https://reporoster.com/forks/rawchen/blog)](https://github.com/rawchen/blog/network/members)


## 如何贡献

Fork 项目到你自己仓库，本地拉取你 fork 的项目并部署修改。
提交本地仓库更改，推送到你 fork 的项目仓库中。
在我的项目发起 Pull requests，我看到后将考虑合并到主分支。
