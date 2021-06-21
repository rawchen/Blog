/*
 Navicat Premium Data Transfer

 Source Server         : MySQL
 Source Server Type    : MySQL
 Source Server Version : 50561
 Source Host           : localhost:3306
 Source Schema         : blog

 Target Server Type    : MySQL
 Target Server Version : 50561
 File Encoding         : 65001

 Date: 22/05/2021 23:33:21
*/

SET NAMES utf8;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for about
-- ----------------------------
DROP TABLE IF EXISTS `about`;
CREATE TABLE `about`  (
  `id` bigint(20) NOT NULL,
  `name_en` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `name_zh` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `value` longtext CHARACTER SET utf8 COLLATE utf8_general_ci NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of about
-- ----------------------------
INSERT INTO `about` VALUES (1, 'title', '标题', 'RawChen');
INSERT INTO `about` VALUES (2, 'musicId', '网易云歌曲ID', '346089');
INSERT INTO `about` VALUES (3, 'content', '正文Markdown', '');
INSERT INTO `about` VALUES (4, 'commentEnabled', '评论开关', 'true');

-- ----------------------------
-- Table structure for blog
-- ----------------------------
DROP TABLE IF EXISTS `blog`;
CREATE TABLE `blog`  (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `title` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '文章标题',
  `content` longtext CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '文章正文',
  `description` longtext CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '描述',
  `is_published` bit(1) NOT NULL COMMENT '公开或私密',
  `is_recommend` bit(1) NOT NULL COMMENT '推荐开关',
  `is_appreciation` bit(1) NOT NULL COMMENT '赞赏开关',
  `is_comment_enabled` bit(1) NOT NULL COMMENT '评论开关',
  `create_time` datetime NOT NULL COMMENT '创建时间',
  `update_time` datetime NOT NULL COMMENT '更新时间',
  `views` int(11) NOT NULL COMMENT '浏览次数',
  `category_id` bigint(20) NOT NULL COMMENT '文章分类',
  `user_id` bigint(20) NULL DEFAULT NULL COMMENT '文章作者',
  `is_top` bit(1) NOT NULL COMMENT '是否置顶',
  `password` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '密码保护',
  `first_picture` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '文章首图，用于随机文章展示',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `type_id`(`category_id`) USING BTREE,
  INDEX `user_id`(`user_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 3 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of blog
-- ----------------------------
INSERT INTO `blog` VALUES (1, '对IOC控制反转的理解?', '# 是什么\n\nIOC全称是 `Inversion of Control`控制反转。按照字面意思理解，将控制反转过来，这里的控制指的是什么？为什么要进行反转，ioc可以解决什么问题？要回答这些问题，我们需要先了解一下IOC为什么会产生。\n\n# 怎么来的？\n\nJava是一门面向对象的语言，我们的应用程序通过一个个对象之间的**相互关联**和作用来完成功能，就像手表里的机械结构。每一个齿轮代表一个对象，对象之间彼此紧密咬合形成一个系统，这样的系统对象之间的**耦合度**非常高，所谓的耦合度就是关系的依赖程度，高耦合度带来的问题显而易见，只要有一个齿轮发生故障，其它齿轮也无法工作，进而整个系统都无法正常工作，这种牵一发而动全身情况如何才能改善呢？\n\n![](https://cdn.jsdelivr.net/gh/rawchen/JsDelivr/static/default-post-image.jpg)\n\n再来一个Service层实际的例子：\n\n```Java\npublic class UserServiceImpl {\n    private UserDao userDao = new UserDaoImpl();\n    private UserDao userDao = (UserDao)BeanFactory.getBean(\"userDao\");\n\n    public List<User> getAllUser(){\n        return userDao.getAllUser();\n    }\n}\n```\n\n一个是**独立控制**通过**new**一个UserDao实现类来完成，一个是**Bean工厂**通过全限定类名找到Bean对象并创建多例对象，**无法自主控制**。第二者把控制权交给了Bean工厂来创建对象，带来的好处就是降低程序间的依赖关系，也叫削减计算机的耦合。\n\n# 改善方法？\n\n上面机械齿轮的例子可以通过一个中间齿轮的方式来解决，也就是后面的**中间IOC容器**。所有的齿轮都交由中间这个齿轮管理，试着把中间这个齿轮拿掉我们可以看到这两个齿轮之间彼此毫无关系，即使一个齿轮出了故障，也不会影响到其它齿轮。\n中间这个齿轮就好比ioc容器，其它齿轮就是对象，可以看出引入了ioc容器，对象之间的耦合度降低了。当我们修改一个对象的时候不需要去考虑其它对象，因为它不会对其它对象造成影响。\n\n# ioc的原理？\n\n这里说到的ioc容器到底是个什么东东，又是什么让它具有如此神奇的力量？\n\n先来看一下没有ioc容器的时候，对象A依赖对象B，A在运行到某一时刻的时候会去创建B的对象，在这里A具有主动权，它控制了对象B的创建。\n\n引入ioc以后对象A和对象B之间没有了直接联系，当A运行的时候由ioc容器创建B对象在适当的时候注入到A中，在这里，控制权由A对象转移到了ioc容器。这也就是控制反转名称的由来。\n\n基于上述UserDao的例子我们可以通过**反射**来**解耦**，反射可以根据类的全限定名在程序运行时创建对象，可以这样做，将类的全限定名配置在xml文件中，在程序运行时通过反射读取该类的全限定名，动态的创建对象，赋值给userDao接口userDaoImpl。这样做后UserServiceImpl和UserDaoImpl之间没有了直接的关系，当我们需要替换UserDaoImpl对象的时候只需要在配置文件中去修改类的全限定名就可以了，非常的灵活方便，ioc容器的实现就是这个原理。\n\nIOC容器可以自动的帮我们完成以上一系列操作，我们需要做的就是通过配置文件告诉ioc需要创建哪个类以及类和类之间的关系。\n\n# 控制反转和依赖注入\n\n在这里需要提到一个概念**依赖注入**，很多初学者搞不清楚控制反转和依赖注入之间的关系，其实他们是对同一事物的不同角度的描述。\n**控制反转是一种设计思想**而**依赖注入是这种思想的具体实现**\n\n具体说控制反转就是将创建userDaoImpl对象的控制权反转过来由UserServiceImpl交给了ioc容器，强调的是一种能力和思想，ioc容器具有了控制权。\n\n依赖注入就是ioc容器将UserServiceImpl所依赖的对象userDaoImpl，注入给UserServiceImpl，强调的是一个**过程和实现**。\n\nIOC很好的体现了面向对象设计法则之一—— 好莱坞法则：“别找我们，我们找你”。\n\n# 优缺点\n\n1. 软件系统中由于引入了第三方IOC容器，生成对象的步骤变得有些复杂，本来是两者之间的事情，又凭空多出一道手续，所以，我们在刚开始使用IOC框架的时候，会感觉系统变得不太直观。所以，引入了一个全新的框架，就会增加团队成员学习和认识的培训成本，并且在以后的运行维护中，还得让新加入者具备同样的知识体系。\n2. 由于IOC容器生成对象是通过反射方式，在运行效率上有一定的损耗。如果你要追求运行效率的话，就必须对此进行权衡。\n3. 具体到IOC框架产品(比如：Spring)来讲，需要进行大量的配制工作，比较繁琐，对于一些小的项目而言，客观上也可能加大一些工作成本。\n4. IOC框架产品本身的成熟度需要进行评估，如果引入一个不成熟的IOC框架产品，那么会影响到整个项目，所以这也是一个隐性的风险。\n\n我们大体可以得出这样的结论：一些工作量不大的项目或者产品，不太适合使用IOC框架产品。另外，如果团队成员的知识能力欠缺，对于IOC框架产品缺乏深入的理解，也不要贸然引入。最后，特别强调运行效率的项目或者产品，也不太适合引入IOC框架产品，像WEB2.0网站就是这种情况。\n\n> Spring框架文档：\n> [https://rawchen.com/spring5][2]\n\n[1]: https://cdn.jsdelivr.net/gh/rawchen/JsDelivr/static/default-post-image.jpg\n[2]: https://rawchen.com/spring5\n\n', 'IOC全称是 `Inversion of Control`控制反转。按照字面意思理解，将控制反转过来，这里的控制指的是什么？为什么要进行反转，ioc可以解决什么问题？要回答这些问题，我们需要先了解一下IOC为什么会产生。\n![](https://cdn.jsdelivr.net/gh/rawchen/JsDelivr/static/default-post-image.jpg)\n\n', b'1', b'1', b'1', b'1', '2021-03-17 14:07:25', '2021-05-22 23:30:05', 137, 1, 1, b'1', '', 'https://cdn.jsdelivr.net/gh/rawchen/JsDelivr/ContentThumb/9.jpg');
INSERT INTO `blog` VALUES (2, 'test2', 'test2\n\n', 'test2\n\n', b'1', b'1', b'0', b'1', '2021-03-18 08:59:54', '2021-03-18 16:00:55', 7, 2, 1, b'0', '', 'https://cdn.jsdelivr.net/gh/rawchen/JsDelivr/ContentThumb/2.jpg');

-- ----------------------------
-- Table structure for blog_tag
-- ----------------------------
DROP TABLE IF EXISTS `blog_tag`;
CREATE TABLE `blog_tag`  (
  `blog_id` bigint(20) NOT NULL,
  `tag_id` bigint(20) NOT NULL
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of blog_tag
-- ----------------------------
INSERT INTO `blog_tag` VALUES (2, 2);
INSERT INTO `blog_tag` VALUES (2, 1);
INSERT INTO `blog_tag` VALUES (1, 1);
INSERT INTO `blog_tag` VALUES (1, 2);

-- ----------------------------
-- Table structure for category
-- ----------------------------
DROP TABLE IF EXISTS `category`;
CREATE TABLE `category`  (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `category_name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 3 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of category
-- ----------------------------
INSERT INTO `category` VALUES (1, 'test');
INSERT INTO `category` VALUES (2, 'default');

-- ----------------------------
-- Table structure for city_visitor
-- ----------------------------
DROP TABLE IF EXISTS `city_visitor`;
CREATE TABLE `city_visitor`  (
  `city` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '城市名称',
  `uv` int(11) NOT NULL COMMENT '独立访客数量',
  PRIMARY KEY (`city`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of city_visitor
-- ----------------------------

-- ----------------------------
-- Table structure for comment
-- ----------------------------
DROP TABLE IF EXISTS `comment`;
CREATE TABLE `comment`  (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `nickname` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '昵称',
  `email` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '邮箱',
  `content` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '评论内容',
  `avatar` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '头像(图片路径)',
  `create_time` datetime NULL DEFAULT NULL COMMENT '评论时间',
  `ip` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '评论者ip地址',
  `is_published` bit(1) NOT NULL COMMENT '公开或回收站',
  `is_admin_comment` bit(1) NOT NULL COMMENT '博主回复',
  `page` int(11) NOT NULL COMMENT '0普通文章，1关于我页面，2友链页面',
  `is_notice` bit(1) NOT NULL COMMENT '接收邮件提醒',
  `blog_id` bigint(20) NULL DEFAULT NULL COMMENT '所属的文章',
  `parent_comment_id` bigint(20) NOT NULL COMMENT '父评论id，-1为根评论',
  `website` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '个人网站',
  `qq` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '如果评论昵称为QQ号，则将昵称和头像置为QQ昵称和QQ头像，并将此字段置为QQ号备份',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 12 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of comment
-- ----------------------------
INSERT INTO `comment` VALUES (1, 'RawChen', '2221999792@qq.com', '测试下哈', 'http://q.qlogo.cn/g?b=qq&nk=2221999792&s=100', '2021-03-18 21:34:24', '192.168.136.1', b'1', b'0', 0, b'1', 1, -1, 'https://rawchen.com', '2221999792');
INSERT INTO `comment` VALUES (2, 'RawChen', '2221999792@qq.com', '测试回复', 'http://q.qlogo.cn/g?b=qq&nk=2221999792&s=100', '2021-03-18 22:02:57', '192.168.136.1', b'1', b'0', 0, b'1', 1, 1, 'https://rawchen.com', '2221999792');
INSERT INTO `comment` VALUES (3, 'RawChen', '2221999792@qq.com', '测试t', 'http://q.qlogo.cn/g?b=qq&nk=2221999792&s=100', '2021-03-22 08:20:40', '192.168.136.1', b'1', b'0', 0, b'1', 1, 2, 'https://rawchen.com', '2221999792');
INSERT INTO `comment` VALUES (4, 'RawChen', '2221999792@qq.com', '测试回复', 'http://q.qlogo.cn/g?b=qq&nk=2221999792&s=100', '2021-03-22 08:30:35', '192.168.136.1', b'1', b'0', 0, b'1', 1, 3, 'https://rawchen.com', '2221999792');
INSERT INTO `comment` VALUES (5, 'RawChen', '2221999792@qq.com', '回复1', 'http://q.qlogo.cn/g?b=qq&nk=2221999792&s=100', '2021-03-22 08:32:17', '192.168.136.1', b'1', b'0', 0, b'1', 1, -1, 'https://rawchen.com', '2221999792');
INSERT INTO `comment` VALUES (6, '棒棒糖堂主', '2221999792@qq.com', '回', 'http://q.qlogo.cn/g?b=qq&nk=362774405&s=100', '2021-04-26 10:28:04', '192.168.136.1', b'1', b'0', 0, b'1', 1, 1, 'https://rawchen.com', '362774405');
INSERT INTO `comment` VALUES (7, '棒棒糖堂主', '2221999792@qq.com', '测试啊啊啊啊啊啊啊啊', 'http://q.qlogo.cn/g?b=qq&nk=362774405&s=100', '2021-04-26 10:32:10', '192.168.136.1', b'1', b'0', 0, b'1', 1, 5, 'https://rawchen.com', '362774405');
INSERT INTO `comment` VALUES (8, 'RawChen', '2221999792@qq.com', 'aaa', 'http://q.qlogo.cn/g?b=qq&nk=2221999792&s=100', '2021-05-10 11:08:45', '192.168.136.1', b'1', b'0', 0, b'1', 1, -1, 'https://rawchen.com', '2221999792');
INSERT INTO `comment` VALUES (9, 'RawChen', '2221999792@qq.com', '@[tv_白眼]', 'http://q.qlogo.cn/g?b=qq&nk=2221999792&s=100', '2021-05-11 13:46:31', '192.168.136.1', b'1', b'0', 0, b'1', 1, -1, 'https://rawchen.com', '2221999792');
INSERT INTO `comment` VALUES (10, 'RawChen', 'rawchen@qq.com', '啊', 'https://q.qlogo.cn/g?b=qq&nk=2221999792&s=100', '2021-05-19 00:24:13', '192.168.136.1', b'1', b'0', 0, b'1', 1, -1, 'https://rawchen.com', '2221999792');
INSERT INTO `comment` VALUES (11, 'Admin', '2221999792@qq.com', '我的回复', '/img/avatar.jpg', '2021-05-19 00:29:20', '192.168.136.1', b'1', b'1', 0, b'0', 1, 10, '/', NULL);

-- ----------------------------
-- Table structure for exception_log
-- ----------------------------
DROP TABLE IF EXISTS `exception_log`;
CREATE TABLE `exception_log`  (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `uri` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '请求接口',
  `method` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '请求方式',
  `param` varchar(2000) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '请求参数',
  `description` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '操作描述',
  `error` text CHARACTER SET utf8 COLLATE utf8_general_ci NULL COMMENT '异常信息',
  `ip` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT 'ip',
  `ip_source` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT 'ip来源',
  `os` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '操作系统',
  `browser` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '浏览器',
  `create_time` datetime NOT NULL COMMENT '操作时间',
  `user_agent` varchar(2000) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT 'user-agent用户代理',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 9 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of exception_log
-- ----------------------------
INSERT INTO `exception_log` VALUES (4, '/admin/job/run', 'POST', '{\"jobId\":2}', '立即执行定时任务', 'java.lang.RuntimeException: 立即执行定时任务失败\r\n	at com.rawchen.util.quartz.ScheduleUtils.run(ScheduleUtils.java:102)\r\n	at com.rawchen.service.impl.ScheduleJobServiceImpl.runJobById(ScheduleJobServiceImpl.java:84)\r\n	at com.rawchen.service.impl.ScheduleJobServiceImpl$$FastClassBySpringCGLIB$$176b3d96.invoke(<generated>)\r\n	at org.springframework.cglib.proxy.MethodProxy.invoke(MethodProxy.java:218)\r\n	at org.springframework.aop.framework.CglibAopProxy$DynamicAdvisedInterceptor.intercept(CglibAopProxy.java:687)\r\n	at com.rawchen.service.impl.ScheduleJobServiceImpl$$EnhancerBySpringCGLIB$$926990c7.runJobById(<generated>)\r\n	at com.rawchen.controller.admin.ScheduleJobController.runJob(ScheduleJobController.java:103)\r\n	at com.rawchen.controller.admin.ScheduleJobController$$FastClassBySpringCGLIB$$e84a871f.invoke(<generated>)\r\n	at org.springframework.cglib.proxy.MethodProxy.invoke(MethodProxy.java:218)\r\n	at org.springframework.aop.framework.CglibAopProxy$CglibMethodInvocation.invokeJoinpoint(CglibAopProxy.java:771)\r\n	at org.springframework.aop.framework.ReflectiveMethodInvocation.proceed(ReflectiveMethodInvocation.java:163)\r\n	at org.springframework.aop.framework.CglibAopProxy$CglibMethodInvocation.proceed(CglibAopProxy.java:749)\r\n	at org.springframework.aop.aspectj.MethodInvocationProceedingJoinPoint.proceed(MethodInvocationProceedingJoinPoint.java:88)\r\n	at com.rawchen.aspect.OperationLogAspect.logAround(OperationLogAspect.java:53)\r\n	at sun.reflect.NativeMethodAccessorImpl.invoke0(Native Method)\r\n	at sun.reflect.NativeMethodAccessorImpl.invoke(NativeMethodAccessorImpl.java:62)\r\n	at sun.reflect.DelegatingMethodAccessorImpl.invoke(DelegatingMethodAccessorImpl.java:43)\r\n	at java.lang.reflect.Method.invoke(Method.java:498)\r\n	at org.springframework.aop.aspectj.AbstractAspectJAdvice.invokeAdviceMethodWithGivenArgs(AbstractAspectJAdvice.java:644)\r\n	at org.springframework.aop.aspectj.AbstractAspectJAdvice.invokeAdviceMethod(AbstractAspectJAdvice.java:633)\r\n	at org.springframework.aop.aspectj.AspectJAroundAdvice.invoke(AspectJAroundAdvice.java:70)\r\n	at org.springframework.aop.framework.ReflectiveMethodInvocation.proceed(ReflectiveMethodInvocation.java:175)\r\n	at org.springframework.aop.framework.CglibAopProxy$CglibMethodInvocation.proceed(CglibAopProxy.java:749)\r\n	at org.springframework.aop.aspectj.AspectJAfterThrowingAdvice.invoke(AspectJAfterThrowingAdvice.java:62)\r\n	at org.springframework.aop.framework.ReflectiveMethodInvocation.proceed(ReflectiveMethodInvocation.java:186)\r\n	at org.springframework.aop.framework.CglibAopProxy$CglibMethodInvocation.proceed(CglibAopProxy.java:749)\r\n	at org.springframework.aop.interceptor.ExposeInvocationInterceptor.invoke(ExposeInvocationInterceptor.java:95)\r\n	at org.springframework.aop.framework.ReflectiveMethodInvocation.proceed(ReflectiveMethodInvocation.java:186)\r\n	at org.springframework.aop.framework.CglibAopProxy$CglibMethodInvocation.proceed(CglibAopProxy.java:749)\r\n	at org.springframework.aop.framework.CglibAopProxy$DynamicAdvisedInterceptor.intercept(CglibAopProxy.java:691)\r\n	at com.rawchen.controller.admin.ScheduleJobController$$EnhancerBySpringCGLIB$$1c704dcc.runJob(<generated>)\r\n	at sun.reflect.NativeMethodAccessorImpl.invoke0(Native Method)\r\n	at sun.reflect.NativeMethodAccessorImpl.invoke(NativeMethodAccessorImpl.java:62)\r\n	at sun.reflect.DelegatingMethodAccessorImpl.invoke(DelegatingMethodAccessorImpl.java:43)\r\n	at java.lang.reflect.Method.invoke(Method.java:498)\r\n	at org.springframework.web.method.support.InvocableHandlerMethod.doInvoke(InvocableHandlerMethod.java:190)\r\n	at org.springframework.web.method.support.InvocableHandlerMethod.invokeForRequest(InvocableHandlerMethod.java:138)\r\n	at org.springframework.web.servlet.mvc.method.annotation.ServletInvocableHandlerMethod.invokeAndHandle(ServletInvocableHandlerMethod.java:105)\r\n	at org.springframework.web.servlet.mvc.method.annotation.RequestMappingHandlerAdapter.invokeHandlerMethod(RequestMappingHandlerAdapter.java:879)\r\n	at org.springframework.web.servlet.mvc.method.annotation.RequestMappingHandlerAdapter.handleInternal(RequestMappingHandlerAdapter.java:793)\r\n	at org.springframework.web.servlet.mvc.method.AbstractHandlerMethodAdapter.handle(AbstractHandlerMethodAdapter.java:87)\r\n	at org.springframework.web.servlet.DispatcherServlet.doDispatch(DispatcherServlet.java:1040)\r\n	at org.springframework.web.servlet.DispatcherServlet.doService(DispatcherServlet.java:943)\r\n	at org.springframework.web.servlet.FrameworkServlet.processRequest(FrameworkServlet.java:1006)\r\n	at org.springframework.web.servlet.FrameworkServlet.doPost(FrameworkServlet.java:909)\r\n	at javax.servlet.http.HttpServlet.service(HttpServlet.java:660)\r\n	at org.springframework.web.servlet.FrameworkServlet.service(FrameworkServlet.java:883)\r\n	at javax.servlet.http.HttpServlet.service(HttpServlet.java:741)\r\n	at org.apache.catalina.core.ApplicationFilterChain.internalDoFilter(ApplicationFilterChain.java:231)\r\n	at org.apache.catalina.core.ApplicationFilterChain.doFilter(ApplicationFilterChain.java:166)\r\n	at org.apache.tomcat.websocket.server.WsFilter.doFilter(WsFilter.java:53)\r\n	at org.apache.catalina.core.ApplicationFilterChain.internalDoFilter(ApplicationFilterChain.java:193)\r\n	at org.apache.catalina.core.ApplicationFilterChain.doFilter(ApplicationFilterChain.java:166)\r\n	at org.springframework.security.web.FilterChainProxy$VirtualFilterChain.doFilter(FilterChainProxy.java:320)\r\n	at org.springframework.security.web.access.intercept.FilterSecurityInterceptor.invoke(FilterSecurityInterceptor.java:126)\r\n	at org.springframework.security.web.access.intercept.FilterSecurityInterceptor.doFilter(FilterSecurityInterceptor.java:90)\r\n	at org.springframework.security.web.FilterChainProxy$VirtualFilterChain.doFilter(FilterChainProxy.java:334)\r\n	at org.springframework.security.web.access.ExceptionTranslationFilter.doFilter(ExceptionTranslationFilter.java:118)\r\n	at org.springframework.security.web.FilterChainProxy$VirtualFilterChain.doFilter(FilterChainProxy.java:334)\r\n	at org.springframework.security.web.session.SessionManagementFilter.doFilter(SessionManagementFilter.java:137)\r\n	at org.springframework.security.web.FilterChainProxy$VirtualFilterChain.doFilter(FilterChainProxy.java:334)\r\n	at org.springframework.security.web.authentication.AnonymousAuthenticationFilter.doFilter(AnonymousAuthenticationFilter.java:111)\r\n	at org.springframework.security.web.FilterChainProxy$VirtualFilterChain.doFilter(FilterChainProxy.java:334)\r\n	at org.springframework.security.web.servletapi.SecurityContextHolderAwareRequestFilter.doFilter(SecurityContextHolderAwareRequestFilter.java:158)\r\n	at org.springframework.security.web.FilterChainProxy$VirtualFilterChain.doFilter(FilterChainProxy.java:334)\r\n	at org.springframework.security.web.savedrequest.RequestCacheAwareFilter.doFilter(RequestCacheAwareFilter.java:63)\r\n	at org.springframework.security.web.FilterChainProxy$VirtualFilterChain.doFilter(FilterChainProxy.java:334)\r\n	at com.rawchen.config.JwtFilter.doFilter(JwtFilter.java:57)\r\n	at org.springframework.security.web.FilterChainProxy$VirtualFilterChain.doFilter(FilterChainProxy.java:334)\r\n	at org.springframework.security.web.authentication.AbstractAuthenticationProcessingFilter.doFilter(AbstractAuthenticationProcessingFilter.java:200)\r\n	at org.springframework.security.web.FilterChainProxy$VirtualFilterChain.doFilter(FilterChainProxy.java:334)\r\n	at org.springframework.security.web.authentication.logout.LogoutFilter.doFilter(LogoutFilter.java:116)\r\n	at org.springframework.security.web.FilterChainProxy$VirtualFilterChain.doFilter(FilterChainProxy.java:334)\r\n	at org.springframework.web.filter.CorsFilter.doFilterInternal(CorsFilter.java:92)\r\n	at org.springframework.web.filter.OncePerRequestFilter.doFilter(OncePerRequestFilter.java:119)\r\n	at org.springframework.security.web.FilterChainProxy$VirtualFilterChain.doFilter(FilterChainProxy.java:334)\r\n	at org.springframework.security.web.header.HeaderWriterFilter.doHeadersAfter(HeaderWriterFilter.java:92)\r\n	at org.springframework.security.web.header.HeaderWriterFilter.doFilterInternal(HeaderWriterFilter.java:77)\r\n	at org.springframework.web.filter.OncePerRequestFilter.doFilter(OncePerRequestFilter.java:119)\r\n	at org.springframework.security.web.FilterChainProxy$VirtualFilterChain.doFilter(FilterChainProxy.java:334)\r\n	at org.springframework.security.web.context.SecurityContextPersistenceFilter.doFilter(SecurityContextPersistenceFilter.java:105)\r\n	at org.springframework.security.web.FilterChainProxy$VirtualFilterChain.doFilter(FilterChainProxy.java:334)\r\n	at org.springframework.security.web.context.request.async.WebAsyncManagerIntegrationFilter.doFilterInternal(WebAsyncManagerIntegrationFilter.java:56)\r\n	at org.springframework.web.filter.OncePerRequestFilter.doFilter(OncePerRequestFilter.java:119)\r\n	at org.springframework.security.web.FilterChainProxy$VirtualFilterChain.doFilter(FilterChainProxy.java:334)\r\n	at org.springframework.security.web.FilterChainProxy.doFilterInternal(FilterChainProxy.java:215)\r\n	at org.springframework.security.web.FilterChainProxy.doFilter(FilterChainProxy.java:178)\r\n	at org.springframework.web.filter.DelegatingFilterProxy.invokeDelegate(DelegatingFilterProxy.java:358)\r\n	at org.springframework.web.filter.DelegatingFilterProxy.doFilter(DelegatingFilterProxy.java:271)\r\n	at org.apache.catalina.core.ApplicationFilterChain.internalDoFilter(ApplicationFilterChain.java:193)\r\n	at org.apache.catalina.core.ApplicationFilterChain.doFilter(ApplicationFilterChain.java:166)\r\n	at org.springframework.web.filter.RequestContextFilter.doFilterInternal(RequestContextFilter.java:100)\r\n	at org.springframework.web.filter.OncePerRequestFilter.doFilter(OncePerRequestFilter.java:119)\r\n	at org.apache.catalina.core.ApplicationFilterChain.internalDoFilter(ApplicationFilterChain.java:193)\r\n	at org.apache.catalina.core.ApplicationFilterChain.doFilter(ApplicationFilterChain.java:166)\r\n	at org.springframework.web.filter.FormContentFilter.doFilterInternal(FormContentFilter.java:93)\r\n	at org.springframework.web.filter.OncePerRequestFilter.doFilter(OncePerRequestFilter.java:119)\r\n	at org.apache.catalina.core.ApplicationFilterChain.internalDoFilter(ApplicationFilterChain.java:193)\r\n	at org.apache.catalina.core.ApplicationFilterChain.doFilter(ApplicationFilterChain.java:166)\r\n	at org.springframework.web.filter.CharacterEncodingFilter.doFilterInternal(CharacterEncodingFilter.java:201)\r\n	at org.springframework.web.filter.OncePerRequestFilter.doFilter(OncePerRequestFilter.java:119)\r\n	at org.apache.catalina.core.ApplicationFilterChain.internalDoFilter(ApplicationFilterChain.java:193)\r\n	at org.apache.catalina.core.ApplicationFilterChain.doFilter(ApplicationFilterChain.java:166)\r\n	at org.apache.catalina.core.StandardWrapperValve.invoke(StandardWrapperValve.java:202)\r\n	at org.apache.catalina.core.StandardContextValve.invoke(StandardContextValve.java:96)\r\n	at org.apache.catalina.authenticator.AuthenticatorBase.invoke(AuthenticatorBase.java:541)\r\n	at org.apache.catalina.core.StandardHostValve.invoke(StandardHostValve.java:139)\r\n	at org.apache.catalina.valves.ErrorReportValve.invoke(ErrorReportValve.java:92)\r\n	at org.apache.catalina.core.StandardEngineValve.invoke(StandardEngineValve.java:74)\r\n	at org.apache.catalina.connector.CoyoteAdapter.service(CoyoteAdapter.java:343)\r\n	at org.apache.coyote.http11.Http11Processor.service(Http11Processor.java:373)\r\n	at org.apache.coyote.AbstractProcessorLight.process(AbstractProcessorLight.java:65)\r\n	at org.apache.coyote.AbstractProtocol$ConnectionHandler.process(AbstractProtocol.java:868)\r\n	at org.apache.tomcat.util.net.NioEndpoint$SocketProcessor.doRun(NioEndpoint.java:1590)\r\n	at org.apache.tomcat.util.net.SocketProcessorBase.run(SocketProcessorBase.java:49)\r\n	at java.util.concurrent.ThreadPoolExecutor.runWorker(ThreadPoolExecutor.java:1149)\r\n	at java.util.concurrent.ThreadPoolExecutor$Worker.run(ThreadPoolExecutor.java:624)\r\n	at org.apache.tomcat.util.threads.TaskThread$WrappingRunnable.run(TaskThread.java:61)\r\n	at java.lang.Thread.run(Thread.java:748)\r\nCaused by: org.quartz.JobPersistenceException: The job (DEFAULT.TASK_2) referenced by the trigger does not exist.\r\n	at org.quartz.simpl.RAMJobStore.storeTrigger(RAMJobStore.java:422)\r\n	at org.quartz.core.QuartzScheduler.triggerJob(QuartzScheduler.java:1162)\r\n	at org.quartz.impl.StdScheduler.triggerJob(StdScheduler.java:341)\r\n	at com.rawchen.util.quartz.ScheduleUtils.run(ScheduleUtils.java:100)\r\n	... 118 more\r\n', '192.168.136.1', '内网IP|内网IP', 'Windows 10', 'Chrome 87.0.4280.141', '2021-03-18 09:53:13', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/87.0.4280.141 Safari/537.36');
INSERT INTO `exception_log` VALUES (5, '/admin/job/run', 'POST', '{\"jobId\":2}', '立即执行定时任务', 'java.lang.RuntimeException: 立即执行定时任务失败\r\n	at com.rawchen.util.quartz.ScheduleUtils.run(ScheduleUtils.java:102)\r\n	at com.rawchen.service.impl.ScheduleJobServiceImpl.runJobById(ScheduleJobServiceImpl.java:84)\r\n	at com.rawchen.service.impl.ScheduleJobServiceImpl$$FastClassBySpringCGLIB$$176b3d96.invoke(<generated>)\r\n	at org.springframework.cglib.proxy.MethodProxy.invoke(MethodProxy.java:218)\r\n	at org.springframework.aop.framework.CglibAopProxy$DynamicAdvisedInterceptor.intercept(CglibAopProxy.java:687)\r\n	at com.rawchen.service.impl.ScheduleJobServiceImpl$$EnhancerBySpringCGLIB$$926990c7.runJobById(<generated>)\r\n	at com.rawchen.controller.admin.ScheduleJobController.runJob(ScheduleJobController.java:103)\r\n	at com.rawchen.controller.admin.ScheduleJobController$$FastClassBySpringCGLIB$$e84a871f.invoke(<generated>)\r\n	at org.springframework.cglib.proxy.MethodProxy.invoke(MethodProxy.java:218)\r\n	at org.springframework.aop.framework.CglibAopProxy$CglibMethodInvocation.invokeJoinpoint(CglibAopProxy.java:771)\r\n	at org.springframework.aop.framework.ReflectiveMethodInvocation.proceed(ReflectiveMethodInvocation.java:163)\r\n	at org.springframework.aop.framework.CglibAopProxy$CglibMethodInvocation.proceed(CglibAopProxy.java:749)\r\n	at org.springframework.aop.aspectj.MethodInvocationProceedingJoinPoint.proceed(MethodInvocationProceedingJoinPoint.java:88)\r\n	at com.rawchen.aspect.OperationLogAspect.logAround(OperationLogAspect.java:53)\r\n	at sun.reflect.NativeMethodAccessorImpl.invoke0(Native Method)\r\n	at sun.reflect.NativeMethodAccessorImpl.invoke(NativeMethodAccessorImpl.java:62)\r\n	at sun.reflect.DelegatingMethodAccessorImpl.invoke(DelegatingMethodAccessorImpl.java:43)\r\n	at java.lang.reflect.Method.invoke(Method.java:498)\r\n	at org.springframework.aop.aspectj.AbstractAspectJAdvice.invokeAdviceMethodWithGivenArgs(AbstractAspectJAdvice.java:644)\r\n	at org.springframework.aop.aspectj.AbstractAspectJAdvice.invokeAdviceMethod(AbstractAspectJAdvice.java:633)\r\n	at org.springframework.aop.aspectj.AspectJAroundAdvice.invoke(AspectJAroundAdvice.java:70)\r\n	at org.springframework.aop.framework.ReflectiveMethodInvocation.proceed(ReflectiveMethodInvocation.java:175)\r\n	at org.springframework.aop.framework.CglibAopProxy$CglibMethodInvocation.proceed(CglibAopProxy.java:749)\r\n	at org.springframework.aop.aspectj.AspectJAfterThrowingAdvice.invoke(AspectJAfterThrowingAdvice.java:62)\r\n	at org.springframework.aop.framework.ReflectiveMethodInvocation.proceed(ReflectiveMethodInvocation.java:186)\r\n	at org.springframework.aop.framework.CglibAopProxy$CglibMethodInvocation.proceed(CglibAopProxy.java:749)\r\n	at org.springframework.aop.interceptor.ExposeInvocationInterceptor.invoke(ExposeInvocationInterceptor.java:95)\r\n	at org.springframework.aop.framework.ReflectiveMethodInvocation.proceed(ReflectiveMethodInvocation.java:186)\r\n	at org.springframework.aop.framework.CglibAopProxy$CglibMethodInvocation.proceed(CglibAopProxy.java:749)\r\n	at org.springframework.aop.framework.CglibAopProxy$DynamicAdvisedInterceptor.intercept(CglibAopProxy.java:691)\r\n	at com.rawchen.controller.admin.ScheduleJobController$$EnhancerBySpringCGLIB$$1c704dcc.runJob(<generated>)\r\n	at sun.reflect.NativeMethodAccessorImpl.invoke0(Native Method)\r\n	at sun.reflect.NativeMethodAccessorImpl.invoke(NativeMethodAccessorImpl.java:62)\r\n	at sun.reflect.DelegatingMethodAccessorImpl.invoke(DelegatingMethodAccessorImpl.java:43)\r\n	at java.lang.reflect.Method.invoke(Method.java:498)\r\n	at org.springframework.web.method.support.InvocableHandlerMethod.doInvoke(InvocableHandlerMethod.java:190)\r\n	at org.springframework.web.method.support.InvocableHandlerMethod.invokeForRequest(InvocableHandlerMethod.java:138)\r\n	at org.springframework.web.servlet.mvc.method.annotation.ServletInvocableHandlerMethod.invokeAndHandle(ServletInvocableHandlerMethod.java:105)\r\n	at org.springframework.web.servlet.mvc.method.annotation.RequestMappingHandlerAdapter.invokeHandlerMethod(RequestMappingHandlerAdapter.java:879)\r\n	at org.springframework.web.servlet.mvc.method.annotation.RequestMappingHandlerAdapter.handleInternal(RequestMappingHandlerAdapter.java:793)\r\n	at org.springframework.web.servlet.mvc.method.AbstractHandlerMethodAdapter.handle(AbstractHandlerMethodAdapter.java:87)\r\n	at org.springframework.web.servlet.DispatcherServlet.doDispatch(DispatcherServlet.java:1040)\r\n	at org.springframework.web.servlet.DispatcherServlet.doService(DispatcherServlet.java:943)\r\n	at org.springframework.web.servlet.FrameworkServlet.processRequest(FrameworkServlet.java:1006)\r\n	at org.springframework.web.servlet.FrameworkServlet.doPost(FrameworkServlet.java:909)\r\n	at javax.servlet.http.HttpServlet.service(HttpServlet.java:660)\r\n	at org.springframework.web.servlet.FrameworkServlet.service(FrameworkServlet.java:883)\r\n	at javax.servlet.http.HttpServlet.service(HttpServlet.java:741)\r\n	at org.apache.catalina.core.ApplicationFilterChain.internalDoFilter(ApplicationFilterChain.java:231)\r\n	at org.apache.catalina.core.ApplicationFilterChain.doFilter(ApplicationFilterChain.java:166)\r\n	at org.apache.tomcat.websocket.server.WsFilter.doFilter(WsFilter.java:53)\r\n	at org.apache.catalina.core.ApplicationFilterChain.internalDoFilter(ApplicationFilterChain.java:193)\r\n	at org.apache.catalina.core.ApplicationFilterChain.doFilter(ApplicationFilterChain.java:166)\r\n	at org.springframework.security.web.FilterChainProxy$VirtualFilterChain.doFilter(FilterChainProxy.java:320)\r\n	at org.springframework.security.web.access.intercept.FilterSecurityInterceptor.invoke(FilterSecurityInterceptor.java:126)\r\n	at org.springframework.security.web.access.intercept.FilterSecurityInterceptor.doFilter(FilterSecurityInterceptor.java:90)\r\n	at org.springframework.security.web.FilterChainProxy$VirtualFilterChain.doFilter(FilterChainProxy.java:334)\r\n	at org.springframework.security.web.access.ExceptionTranslationFilter.doFilter(ExceptionTranslationFilter.java:118)\r\n	at org.springframework.security.web.FilterChainProxy$VirtualFilterChain.doFilter(FilterChainProxy.java:334)\r\n	at org.springframework.security.web.session.SessionManagementFilter.doFilter(SessionManagementFilter.java:137)\r\n	at org.springframework.security.web.FilterChainProxy$VirtualFilterChain.doFilter(FilterChainProxy.java:334)\r\n	at org.springframework.security.web.authentication.AnonymousAuthenticationFilter.doFilter(AnonymousAuthenticationFilter.java:111)\r\n	at org.springframework.security.web.FilterChainProxy$VirtualFilterChain.doFilter(FilterChainProxy.java:334)\r\n	at org.springframework.security.web.servletapi.SecurityContextHolderAwareRequestFilter.doFilter(SecurityContextHolderAwareRequestFilter.java:158)\r\n	at org.springframework.security.web.FilterChainProxy$VirtualFilterChain.doFilter(FilterChainProxy.java:334)\r\n	at org.springframework.security.web.savedrequest.RequestCacheAwareFilter.doFilter(RequestCacheAwareFilter.java:63)\r\n	at org.springframework.security.web.FilterChainProxy$VirtualFilterChain.doFilter(FilterChainProxy.java:334)\r\n	at com.rawchen.config.JwtFilter.doFilter(JwtFilter.java:57)\r\n	at org.springframework.security.web.FilterChainProxy$VirtualFilterChain.doFilter(FilterChainProxy.java:334)\r\n	at org.springframework.security.web.authentication.AbstractAuthenticationProcessingFilter.doFilter(AbstractAuthenticationProcessingFilter.java:200)\r\n	at org.springframework.security.web.FilterChainProxy$VirtualFilterChain.doFilter(FilterChainProxy.java:334)\r\n	at org.springframework.security.web.authentication.logout.LogoutFilter.doFilter(LogoutFilter.java:116)\r\n	at org.springframework.security.web.FilterChainProxy$VirtualFilterChain.doFilter(FilterChainProxy.java:334)\r\n	at org.springframework.web.filter.CorsFilter.doFilterInternal(CorsFilter.java:92)\r\n	at org.springframework.web.filter.OncePerRequestFilter.doFilter(OncePerRequestFilter.java:119)\r\n	at org.springframework.security.web.FilterChainProxy$VirtualFilterChain.doFilter(FilterChainProxy.java:334)\r\n	at org.springframework.security.web.header.HeaderWriterFilter.doHeadersAfter(HeaderWriterFilter.java:92)\r\n	at org.springframework.security.web.header.HeaderWriterFilter.doFilterInternal(HeaderWriterFilter.java:77)\r\n	at org.springframework.web.filter.OncePerRequestFilter.doFilter(OncePerRequestFilter.java:119)\r\n	at org.springframework.security.web.FilterChainProxy$VirtualFilterChain.doFilter(FilterChainProxy.java:334)\r\n	at org.springframework.security.web.context.SecurityContextPersistenceFilter.doFilter(SecurityContextPersistenceFilter.java:105)\r\n	at org.springframework.security.web.FilterChainProxy$VirtualFilterChain.doFilter(FilterChainProxy.java:334)\r\n	at org.springframework.security.web.context.request.async.WebAsyncManagerIntegrationFilter.doFilterInternal(WebAsyncManagerIntegrationFilter.java:56)\r\n	at org.springframework.web.filter.OncePerRequestFilter.doFilter(OncePerRequestFilter.java:119)\r\n	at org.springframework.security.web.FilterChainProxy$VirtualFilterChain.doFilter(FilterChainProxy.java:334)\r\n	at org.springframework.security.web.FilterChainProxy.doFilterInternal(FilterChainProxy.java:215)\r\n	at org.springframework.security.web.FilterChainProxy.doFilter(FilterChainProxy.java:178)\r\n	at org.springframework.web.filter.DelegatingFilterProxy.invokeDelegate(DelegatingFilterProxy.java:358)\r\n	at org.springframework.web.filter.DelegatingFilterProxy.doFilter(DelegatingFilterProxy.java:271)\r\n	at org.apache.catalina.core.ApplicationFilterChain.internalDoFilter(ApplicationFilterChain.java:193)\r\n	at org.apache.catalina.core.ApplicationFilterChain.doFilter(ApplicationFilterChain.java:166)\r\n	at org.springframework.web.filter.RequestContextFilter.doFilterInternal(RequestContextFilter.java:100)\r\n	at org.springframework.web.filter.OncePerRequestFilter.doFilter(OncePerRequestFilter.java:119)\r\n	at org.apache.catalina.core.ApplicationFilterChain.internalDoFilter(ApplicationFilterChain.java:193)\r\n	at org.apache.catalina.core.ApplicationFilterChain.doFilter(ApplicationFilterChain.java:166)\r\n	at org.springframework.web.filter.FormContentFilter.doFilterInternal(FormContentFilter.java:93)\r\n	at org.springframework.web.filter.OncePerRequestFilter.doFilter(OncePerRequestFilter.java:119)\r\n	at org.apache.catalina.core.ApplicationFilterChain.internalDoFilter(ApplicationFilterChain.java:193)\r\n	at org.apache.catalina.core.ApplicationFilterChain.doFilter(ApplicationFilterChain.java:166)\r\n	at org.springframework.web.filter.CharacterEncodingFilter.doFilterInternal(CharacterEncodingFilter.java:201)\r\n	at org.springframework.web.filter.OncePerRequestFilter.doFilter(OncePerRequestFilter.java:119)\r\n	at org.apache.catalina.core.ApplicationFilterChain.internalDoFilter(ApplicationFilterChain.java:193)\r\n	at org.apache.catalina.core.ApplicationFilterChain.doFilter(ApplicationFilterChain.java:166)\r\n	at org.apache.catalina.core.StandardWrapperValve.invoke(StandardWrapperValve.java:202)\r\n	at org.apache.catalina.core.StandardContextValve.invoke(StandardContextValve.java:96)\r\n	at org.apache.catalina.authenticator.AuthenticatorBase.invoke(AuthenticatorBase.java:541)\r\n	at org.apache.catalina.core.StandardHostValve.invoke(StandardHostValve.java:139)\r\n	at org.apache.catalina.valves.ErrorReportValve.invoke(ErrorReportValve.java:92)\r\n	at org.apache.catalina.core.StandardEngineValve.invoke(StandardEngineValve.java:74)\r\n	at org.apache.catalina.connector.CoyoteAdapter.service(CoyoteAdapter.java:343)\r\n	at org.apache.coyote.http11.Http11Processor.service(Http11Processor.java:373)\r\n	at org.apache.coyote.AbstractProcessorLight.process(AbstractProcessorLight.java:65)\r\n	at org.apache.coyote.AbstractProtocol$ConnectionHandler.process(AbstractProtocol.java:868)\r\n	at org.apache.tomcat.util.net.NioEndpoint$SocketProcessor.doRun(NioEndpoint.java:1590)\r\n	at org.apache.tomcat.util.net.SocketProcessorBase.run(SocketProcessorBase.java:49)\r\n	at java.util.concurrent.ThreadPoolExecutor.runWorker(ThreadPoolExecutor.java:1149)\r\n	at java.util.concurrent.ThreadPoolExecutor$Worker.run(ThreadPoolExecutor.java:624)\r\n	at org.apache.tomcat.util.threads.TaskThread$WrappingRunnable.run(TaskThread.java:61)\r\n	at java.lang.Thread.run(Thread.java:748)\r\nCaused by: org.quartz.JobPersistenceException: The job (DEFAULT.TASK_2) referenced by the trigger does not exist.\r\n	at org.quartz.simpl.RAMJobStore.storeTrigger(RAMJobStore.java:422)\r\n	at org.quartz.core.QuartzScheduler.triggerJob(QuartzScheduler.java:1162)\r\n	at org.quartz.impl.StdScheduler.triggerJob(StdScheduler.java:341)\r\n	at com.rawchen.util.quartz.ScheduleUtils.run(ScheduleUtils.java:100)\r\n	... 118 more\r\n', '192.168.136.1', '内网IP|内网IP', 'Windows 10', 'Chrome 87.0.4280.141', '2021-03-18 09:53:54', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/87.0.4280.141 Safari/537.36');
INSERT INTO `exception_log` VALUES (6, '/admin/job/run', 'POST', '{\"jobId\":2}', '立即执行定时任务', 'java.lang.RuntimeException: 立即执行定时任务失败\r\n	at com.rawchen.util.quartz.ScheduleUtils.run(ScheduleUtils.java:102)\r\n	at com.rawchen.service.impl.ScheduleJobServiceImpl.runJobById(ScheduleJobServiceImpl.java:84)\r\n	at com.rawchen.service.impl.ScheduleJobServiceImpl$$FastClassBySpringCGLIB$$176b3d96.invoke(<generated>)\r\n	at org.springframework.cglib.proxy.MethodProxy.invoke(MethodProxy.java:218)\r\n	at org.springframework.aop.framework.CglibAopProxy$DynamicAdvisedInterceptor.intercept(CglibAopProxy.java:687)\r\n	at com.rawchen.service.impl.ScheduleJobServiceImpl$$EnhancerBySpringCGLIB$$926990c7.runJobById(<generated>)\r\n	at com.rawchen.controller.admin.ScheduleJobController.runJob(ScheduleJobController.java:103)\r\n	at com.rawchen.controller.admin.ScheduleJobController$$FastClassBySpringCGLIB$$e84a871f.invoke(<generated>)\r\n	at org.springframework.cglib.proxy.MethodProxy.invoke(MethodProxy.java:218)\r\n	at org.springframework.aop.framework.CglibAopProxy$CglibMethodInvocation.invokeJoinpoint(CglibAopProxy.java:771)\r\n	at org.springframework.aop.framework.ReflectiveMethodInvocation.proceed(ReflectiveMethodInvocation.java:163)\r\n	at org.springframework.aop.framework.CglibAopProxy$CglibMethodInvocation.proceed(CglibAopProxy.java:749)\r\n	at org.springframework.aop.aspectj.MethodInvocationProceedingJoinPoint.proceed(MethodInvocationProceedingJoinPoint.java:88)\r\n	at com.rawchen.aspect.OperationLogAspect.logAround(OperationLogAspect.java:53)\r\n	at sun.reflect.NativeMethodAccessorImpl.invoke0(Native Method)\r\n	at sun.reflect.NativeMethodAccessorImpl.invoke(NativeMethodAccessorImpl.java:62)\r\n	at sun.reflect.DelegatingMethodAccessorImpl.invoke(DelegatingMethodAccessorImpl.java:43)\r\n	at java.lang.reflect.Method.invoke(Method.java:498)\r\n	at org.springframework.aop.aspectj.AbstractAspectJAdvice.invokeAdviceMethodWithGivenArgs(AbstractAspectJAdvice.java:644)\r\n	at org.springframework.aop.aspectj.AbstractAspectJAdvice.invokeAdviceMethod(AbstractAspectJAdvice.java:633)\r\n	at org.springframework.aop.aspectj.AspectJAroundAdvice.invoke(AspectJAroundAdvice.java:70)\r\n	at org.springframework.aop.framework.ReflectiveMethodInvocation.proceed(ReflectiveMethodInvocation.java:175)\r\n	at org.springframework.aop.framework.CglibAopProxy$CglibMethodInvocation.proceed(CglibAopProxy.java:749)\r\n	at org.springframework.aop.aspectj.AspectJAfterThrowingAdvice.invoke(AspectJAfterThrowingAdvice.java:62)\r\n	at org.springframework.aop.framework.ReflectiveMethodInvocation.proceed(ReflectiveMethodInvocation.java:186)\r\n	at org.springframework.aop.framework.CglibAopProxy$CglibMethodInvocation.proceed(CglibAopProxy.java:749)\r\n	at org.springframework.aop.interceptor.ExposeInvocationInterceptor.invoke(ExposeInvocationInterceptor.java:95)\r\n	at org.springframework.aop.framework.ReflectiveMethodInvocation.proceed(ReflectiveMethodInvocation.java:186)\r\n	at org.springframework.aop.framework.CglibAopProxy$CglibMethodInvocation.proceed(CglibAopProxy.java:749)\r\n	at org.springframework.aop.framework.CglibAopProxy$DynamicAdvisedInterceptor.intercept(CglibAopProxy.java:691)\r\n	at com.rawchen.controller.admin.ScheduleJobController$$EnhancerBySpringCGLIB$$1c704dcc.runJob(<generated>)\r\n	at sun.reflect.NativeMethodAccessorImpl.invoke0(Native Method)\r\n	at sun.reflect.NativeMethodAccessorImpl.invoke(NativeMethodAccessorImpl.java:62)\r\n	at sun.reflect.DelegatingMethodAccessorImpl.invoke(DelegatingMethodAccessorImpl.java:43)\r\n	at java.lang.reflect.Method.invoke(Method.java:498)\r\n	at org.springframework.web.method.support.InvocableHandlerMethod.doInvoke(InvocableHandlerMethod.java:190)\r\n	at org.springframework.web.method.support.InvocableHandlerMethod.invokeForRequest(InvocableHandlerMethod.java:138)\r\n	at org.springframework.web.servlet.mvc.method.annotation.ServletInvocableHandlerMethod.invokeAndHandle(ServletInvocableHandlerMethod.java:105)\r\n	at org.springframework.web.servlet.mvc.method.annotation.RequestMappingHandlerAdapter.invokeHandlerMethod(RequestMappingHandlerAdapter.java:879)\r\n	at org.springframework.web.servlet.mvc.method.annotation.RequestMappingHandlerAdapter.handleInternal(RequestMappingHandlerAdapter.java:793)\r\n	at org.springframework.web.servlet.mvc.method.AbstractHandlerMethodAdapter.handle(AbstractHandlerMethodAdapter.java:87)\r\n	at org.springframework.web.servlet.DispatcherServlet.doDispatch(DispatcherServlet.java:1040)\r\n	at org.springframework.web.servlet.DispatcherServlet.doService(DispatcherServlet.java:943)\r\n	at org.springframework.web.servlet.FrameworkServlet.processRequest(FrameworkServlet.java:1006)\r\n	at org.springframework.web.servlet.FrameworkServlet.doPost(FrameworkServlet.java:909)\r\n	at javax.servlet.http.HttpServlet.service(HttpServlet.java:660)\r\n	at org.springframework.web.servlet.FrameworkServlet.service(FrameworkServlet.java:883)\r\n	at javax.servlet.http.HttpServlet.service(HttpServlet.java:741)\r\n	at org.apache.catalina.core.ApplicationFilterChain.internalDoFilter(ApplicationFilterChain.java:231)\r\n	at org.apache.catalina.core.ApplicationFilterChain.doFilter(ApplicationFilterChain.java:166)\r\n	at org.apache.tomcat.websocket.server.WsFilter.doFilter(WsFilter.java:53)\r\n	at org.apache.catalina.core.ApplicationFilterChain.internalDoFilter(ApplicationFilterChain.java:193)\r\n	at org.apache.catalina.core.ApplicationFilterChain.doFilter(ApplicationFilterChain.java:166)\r\n	at org.springframework.security.web.FilterChainProxy$VirtualFilterChain.doFilter(FilterChainProxy.java:320)\r\n	at org.springframework.security.web.access.intercept.FilterSecurityInterceptor.invoke(FilterSecurityInterceptor.java:126)\r\n	at org.springframework.security.web.access.intercept.FilterSecurityInterceptor.doFilter(FilterSecurityInterceptor.java:90)\r\n	at org.springframework.security.web.FilterChainProxy$VirtualFilterChain.doFilter(FilterChainProxy.java:334)\r\n	at org.springframework.security.web.access.ExceptionTranslationFilter.doFilter(ExceptionTranslationFilter.java:118)\r\n	at org.springframework.security.web.FilterChainProxy$VirtualFilterChain.doFilter(FilterChainProxy.java:334)\r\n	at org.springframework.security.web.session.SessionManagementFilter.doFilter(SessionManagementFilter.java:137)\r\n	at org.springframework.security.web.FilterChainProxy$VirtualFilterChain.doFilter(FilterChainProxy.java:334)\r\n	at org.springframework.security.web.authentication.AnonymousAuthenticationFilter.doFilter(AnonymousAuthenticationFilter.java:111)\r\n	at org.springframework.security.web.FilterChainProxy$VirtualFilterChain.doFilter(FilterChainProxy.java:334)\r\n	at org.springframework.security.web.servletapi.SecurityContextHolderAwareRequestFilter.doFilter(SecurityContextHolderAwareRequestFilter.java:158)\r\n	at org.springframework.security.web.FilterChainProxy$VirtualFilterChain.doFilter(FilterChainProxy.java:334)\r\n	at org.springframework.security.web.savedrequest.RequestCacheAwareFilter.doFilter(RequestCacheAwareFilter.java:63)\r\n	at org.springframework.security.web.FilterChainProxy$VirtualFilterChain.doFilter(FilterChainProxy.java:334)\r\n	at com.rawchen.config.JwtFilter.doFilter(JwtFilter.java:57)\r\n	at org.springframework.security.web.FilterChainProxy$VirtualFilterChain.doFilter(FilterChainProxy.java:334)\r\n	at org.springframework.security.web.authentication.AbstractAuthenticationProcessingFilter.doFilter(AbstractAuthenticationProcessingFilter.java:200)\r\n	at org.springframework.security.web.FilterChainProxy$VirtualFilterChain.doFilter(FilterChainProxy.java:334)\r\n	at org.springframework.security.web.authentication.logout.LogoutFilter.doFilter(LogoutFilter.java:116)\r\n	at org.springframework.security.web.FilterChainProxy$VirtualFilterChain.doFilter(FilterChainProxy.java:334)\r\n	at org.springframework.web.filter.CorsFilter.doFilterInternal(CorsFilter.java:92)\r\n	at org.springframework.web.filter.OncePerRequestFilter.doFilter(OncePerRequestFilter.java:119)\r\n	at org.springframework.security.web.FilterChainProxy$VirtualFilterChain.doFilter(FilterChainProxy.java:334)\r\n	at org.springframework.security.web.header.HeaderWriterFilter.doHeadersAfter(HeaderWriterFilter.java:92)\r\n	at org.springframework.security.web.header.HeaderWriterFilter.doFilterInternal(HeaderWriterFilter.java:77)\r\n	at org.springframework.web.filter.OncePerRequestFilter.doFilter(OncePerRequestFilter.java:119)\r\n	at org.springframework.security.web.FilterChainProxy$VirtualFilterChain.doFilter(FilterChainProxy.java:334)\r\n	at org.springframework.security.web.context.SecurityContextPersistenceFilter.doFilter(SecurityContextPersistenceFilter.java:105)\r\n	at org.springframework.security.web.FilterChainProxy$VirtualFilterChain.doFilter(FilterChainProxy.java:334)\r\n	at org.springframework.security.web.context.request.async.WebAsyncManagerIntegrationFilter.doFilterInternal(WebAsyncManagerIntegrationFilter.java:56)\r\n	at org.springframework.web.filter.OncePerRequestFilter.doFilter(OncePerRequestFilter.java:119)\r\n	at org.springframework.security.web.FilterChainProxy$VirtualFilterChain.doFilter(FilterChainProxy.java:334)\r\n	at org.springframework.security.web.FilterChainProxy.doFilterInternal(FilterChainProxy.java:215)\r\n	at org.springframework.security.web.FilterChainProxy.doFilter(FilterChainProxy.java:178)\r\n	at org.springframework.web.filter.DelegatingFilterProxy.invokeDelegate(DelegatingFilterProxy.java:358)\r\n	at org.springframework.web.filter.DelegatingFilterProxy.doFilter(DelegatingFilterProxy.java:271)\r\n	at org.apache.catalina.core.ApplicationFilterChain.internalDoFilter(ApplicationFilterChain.java:193)\r\n	at org.apache.catalina.core.ApplicationFilterChain.doFilter(ApplicationFilterChain.java:166)\r\n	at org.springframework.web.filter.RequestContextFilter.doFilterInternal(RequestContextFilter.java:100)\r\n	at org.springframework.web.filter.OncePerRequestFilter.doFilter(OncePerRequestFilter.java:119)\r\n	at org.apache.catalina.core.ApplicationFilterChain.internalDoFilter(ApplicationFilterChain.java:193)\r\n	at org.apache.catalina.core.ApplicationFilterChain.doFilter(ApplicationFilterChain.java:166)\r\n	at org.springframework.web.filter.FormContentFilter.doFilterInternal(FormContentFilter.java:93)\r\n	at org.springframework.web.filter.OncePerRequestFilter.doFilter(OncePerRequestFilter.java:119)\r\n	at org.apache.catalina.core.ApplicationFilterChain.internalDoFilter(ApplicationFilterChain.java:193)\r\n	at org.apache.catalina.core.ApplicationFilterChain.doFilter(ApplicationFilterChain.java:166)\r\n	at org.springframework.web.filter.CharacterEncodingFilter.doFilterInternal(CharacterEncodingFilter.java:201)\r\n	at org.springframework.web.filter.OncePerRequestFilter.doFilter(OncePerRequestFilter.java:119)\r\n	at org.apache.catalina.core.ApplicationFilterChain.internalDoFilter(ApplicationFilterChain.java:193)\r\n	at org.apache.catalina.core.ApplicationFilterChain.doFilter(ApplicationFilterChain.java:166)\r\n	at org.apache.catalina.core.StandardWrapperValve.invoke(StandardWrapperValve.java:202)\r\n	at org.apache.catalina.core.StandardContextValve.invoke(StandardContextValve.java:96)\r\n	at org.apache.catalina.authenticator.AuthenticatorBase.invoke(AuthenticatorBase.java:541)\r\n	at org.apache.catalina.core.StandardHostValve.invoke(StandardHostValve.java:139)\r\n	at org.apache.catalina.valves.ErrorReportValve.invoke(ErrorReportValve.java:92)\r\n	at org.apache.catalina.core.StandardEngineValve.invoke(StandardEngineValve.java:74)\r\n	at org.apache.catalina.connector.CoyoteAdapter.service(CoyoteAdapter.java:343)\r\n	at org.apache.coyote.http11.Http11Processor.service(Http11Processor.java:373)\r\n	at org.apache.coyote.AbstractProcessorLight.process(AbstractProcessorLight.java:65)\r\n	at org.apache.coyote.AbstractProtocol$ConnectionHandler.process(AbstractProtocol.java:868)\r\n	at org.apache.tomcat.util.net.NioEndpoint$SocketProcessor.doRun(NioEndpoint.java:1590)\r\n	at org.apache.tomcat.util.net.SocketProcessorBase.run(SocketProcessorBase.java:49)\r\n	at java.util.concurrent.ThreadPoolExecutor.runWorker(ThreadPoolExecutor.java:1149)\r\n	at java.util.concurrent.ThreadPoolExecutor$Worker.run(ThreadPoolExecutor.java:624)\r\n	at org.apache.tomcat.util.threads.TaskThread$WrappingRunnable.run(TaskThread.java:61)\r\n	at java.lang.Thread.run(Thread.java:748)\r\nCaused by: org.quartz.JobPersistenceException: The job (DEFAULT.TASK_2) referenced by the trigger does not exist.\r\n	at org.quartz.simpl.RAMJobStore.storeTrigger(RAMJobStore.java:422)\r\n	at org.quartz.core.QuartzScheduler.triggerJob(QuartzScheduler.java:1162)\r\n	at org.quartz.impl.StdScheduler.triggerJob(StdScheduler.java:341)\r\n	at com.rawchen.util.quartz.ScheduleUtils.run(ScheduleUtils.java:100)\r\n	... 118 more\r\n', '192.168.136.1', '内网IP|内网IP', 'Windows 10', 'Chrome 87.0.4280.141', '2021-03-18 09:55:24', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/87.0.4280.141 Safari/537.36');
INSERT INTO `exception_log` VALUES (7, '/admin/job/run', 'POST', '{\"jobId\":1}', '立即执行定时任务', 'java.lang.RuntimeException: 立即执行定时任务失败\r\n	at com.rawchen.util.quartz.ScheduleUtils.run(ScheduleUtils.java:102)\r\n	at com.rawchen.service.impl.ScheduleJobServiceImpl.runJobById(ScheduleJobServiceImpl.java:84)\r\n	at com.rawchen.service.impl.ScheduleJobServiceImpl$$FastClassBySpringCGLIB$$176b3d96.invoke(<generated>)\r\n	at org.springframework.cglib.proxy.MethodProxy.invoke(MethodProxy.java:218)\r\n	at org.springframework.aop.framework.CglibAopProxy$DynamicAdvisedInterceptor.intercept(CglibAopProxy.java:687)\r\n	at com.rawchen.service.impl.ScheduleJobServiceImpl$$EnhancerBySpringCGLIB$$926990c7.runJobById(<generated>)\r\n	at com.rawchen.controller.admin.ScheduleJobController.runJob(ScheduleJobController.java:103)\r\n	at com.rawchen.controller.admin.ScheduleJobController$$FastClassBySpringCGLIB$$e84a871f.invoke(<generated>)\r\n	at org.springframework.cglib.proxy.MethodProxy.invoke(MethodProxy.java:218)\r\n	at org.springframework.aop.framework.CglibAopProxy$CglibMethodInvocation.invokeJoinpoint(CglibAopProxy.java:771)\r\n	at org.springframework.aop.framework.ReflectiveMethodInvocation.proceed(ReflectiveMethodInvocation.java:163)\r\n	at org.springframework.aop.framework.CglibAopProxy$CglibMethodInvocation.proceed(CglibAopProxy.java:749)\r\n	at org.springframework.aop.aspectj.MethodInvocationProceedingJoinPoint.proceed(MethodInvocationProceedingJoinPoint.java:88)\r\n	at com.rawchen.aspect.OperationLogAspect.logAround(OperationLogAspect.java:53)\r\n	at sun.reflect.NativeMethodAccessorImpl.invoke0(Native Method)\r\n	at sun.reflect.NativeMethodAccessorImpl.invoke(NativeMethodAccessorImpl.java:62)\r\n	at sun.reflect.DelegatingMethodAccessorImpl.invoke(DelegatingMethodAccessorImpl.java:43)\r\n	at java.lang.reflect.Method.invoke(Method.java:498)\r\n	at org.springframework.aop.aspectj.AbstractAspectJAdvice.invokeAdviceMethodWithGivenArgs(AbstractAspectJAdvice.java:644)\r\n	at org.springframework.aop.aspectj.AbstractAspectJAdvice.invokeAdviceMethod(AbstractAspectJAdvice.java:633)\r\n	at org.springframework.aop.aspectj.AspectJAroundAdvice.invoke(AspectJAroundAdvice.java:70)\r\n	at org.springframework.aop.framework.ReflectiveMethodInvocation.proceed(ReflectiveMethodInvocation.java:175)\r\n	at org.springframework.aop.framework.CglibAopProxy$CglibMethodInvocation.proceed(CglibAopProxy.java:749)\r\n	at org.springframework.aop.aspectj.AspectJAfterThrowingAdvice.invoke(AspectJAfterThrowingAdvice.java:62)\r\n	at org.springframework.aop.framework.ReflectiveMethodInvocation.proceed(ReflectiveMethodInvocation.java:186)\r\n	at org.springframework.aop.framework.CglibAopProxy$CglibMethodInvocation.proceed(CglibAopProxy.java:749)\r\n	at org.springframework.aop.interceptor.ExposeInvocationInterceptor.invoke(ExposeInvocationInterceptor.java:95)\r\n	at org.springframework.aop.framework.ReflectiveMethodInvocation.proceed(ReflectiveMethodInvocation.java:186)\r\n	at org.springframework.aop.framework.CglibAopProxy$CglibMethodInvocation.proceed(CglibAopProxy.java:749)\r\n	at org.springframework.aop.framework.CglibAopProxy$DynamicAdvisedInterceptor.intercept(CglibAopProxy.java:691)\r\n	at com.rawchen.controller.admin.ScheduleJobController$$EnhancerBySpringCGLIB$$1c704dcc.runJob(<generated>)\r\n	at sun.reflect.NativeMethodAccessorImpl.invoke0(Native Method)\r\n	at sun.reflect.NativeMethodAccessorImpl.invoke(NativeMethodAccessorImpl.java:62)\r\n	at sun.reflect.DelegatingMethodAccessorImpl.invoke(DelegatingMethodAccessorImpl.java:43)\r\n	at java.lang.reflect.Method.invoke(Method.java:498)\r\n	at org.springframework.web.method.support.InvocableHandlerMethod.doInvoke(InvocableHandlerMethod.java:190)\r\n	at org.springframework.web.method.support.InvocableHandlerMethod.invokeForRequest(InvocableHandlerMethod.java:138)\r\n	at org.springframework.web.servlet.mvc.method.annotation.ServletInvocableHandlerMethod.invokeAndHandle(ServletInvocableHandlerMethod.java:105)\r\n	at org.springframework.web.servlet.mvc.method.annotation.RequestMappingHandlerAdapter.invokeHandlerMethod(RequestMappingHandlerAdapter.java:879)\r\n	at org.springframework.web.servlet.mvc.method.annotation.RequestMappingHandlerAdapter.handleInternal(RequestMappingHandlerAdapter.java:793)\r\n	at org.springframework.web.servlet.mvc.method.AbstractHandlerMethodAdapter.handle(AbstractHandlerMethodAdapter.java:87)\r\n	at org.springframework.web.servlet.DispatcherServlet.doDispatch(DispatcherServlet.java:1040)\r\n	at org.springframework.web.servlet.DispatcherServlet.doService(DispatcherServlet.java:943)\r\n	at org.springframework.web.servlet.FrameworkServlet.processRequest(FrameworkServlet.java:1006)\r\n	at org.springframework.web.servlet.FrameworkServlet.doPost(FrameworkServlet.java:909)\r\n	at javax.servlet.http.HttpServlet.service(HttpServlet.java:660)\r\n	at org.springframework.web.servlet.FrameworkServlet.service(FrameworkServlet.java:883)\r\n	at javax.servlet.http.HttpServlet.service(HttpServlet.java:741)\r\n	at org.apache.catalina.core.ApplicationFilterChain.internalDoFilter(ApplicationFilterChain.java:231)\r\n	at org.apache.catalina.core.ApplicationFilterChain.doFilter(ApplicationFilterChain.java:166)\r\n	at org.apache.tomcat.websocket.server.WsFilter.doFilter(WsFilter.java:53)\r\n	at org.apache.catalina.core.ApplicationFilterChain.internalDoFilter(ApplicationFilterChain.java:193)\r\n	at org.apache.catalina.core.ApplicationFilterChain.doFilter(ApplicationFilterChain.java:166)\r\n	at org.springframework.security.web.FilterChainProxy$VirtualFilterChain.doFilter(FilterChainProxy.java:320)\r\n	at org.springframework.security.web.access.intercept.FilterSecurityInterceptor.invoke(FilterSecurityInterceptor.java:126)\r\n	at org.springframework.security.web.access.intercept.FilterSecurityInterceptor.doFilter(FilterSecurityInterceptor.java:90)\r\n	at org.springframework.security.web.FilterChainProxy$VirtualFilterChain.doFilter(FilterChainProxy.java:334)\r\n	at org.springframework.security.web.access.ExceptionTranslationFilter.doFilter(ExceptionTranslationFilter.java:118)\r\n	at org.springframework.security.web.FilterChainProxy$VirtualFilterChain.doFilter(FilterChainProxy.java:334)\r\n	at org.springframework.security.web.session.SessionManagementFilter.doFilter(SessionManagementFilter.java:137)\r\n	at org.springframework.security.web.FilterChainProxy$VirtualFilterChain.doFilter(FilterChainProxy.java:334)\r\n	at org.springframework.security.web.authentication.AnonymousAuthenticationFilter.doFilter(AnonymousAuthenticationFilter.java:111)\r\n	at org.springframework.security.web.FilterChainProxy$VirtualFilterChain.doFilter(FilterChainProxy.java:334)\r\n	at org.springframework.security.web.servletapi.SecurityContextHolderAwareRequestFilter.doFilter(SecurityContextHolderAwareRequestFilter.java:158)\r\n	at org.springframework.security.web.FilterChainProxy$VirtualFilterChain.doFilter(FilterChainProxy.java:334)\r\n	at org.springframework.security.web.savedrequest.RequestCacheAwareFilter.doFilter(RequestCacheAwareFilter.java:63)\r\n	at org.springframework.security.web.FilterChainProxy$VirtualFilterChain.doFilter(FilterChainProxy.java:334)\r\n	at com.rawchen.config.JwtFilter.doFilter(JwtFilter.java:57)\r\n	at org.springframework.security.web.FilterChainProxy$VirtualFilterChain.doFilter(FilterChainProxy.java:334)\r\n	at org.springframework.security.web.authentication.AbstractAuthenticationProcessingFilter.doFilter(AbstractAuthenticationProcessingFilter.java:200)\r\n	at org.springframework.security.web.FilterChainProxy$VirtualFilterChain.doFilter(FilterChainProxy.java:334)\r\n	at org.springframework.security.web.authentication.logout.LogoutFilter.doFilter(LogoutFilter.java:116)\r\n	at org.springframework.security.web.FilterChainProxy$VirtualFilterChain.doFilter(FilterChainProxy.java:334)\r\n	at org.springframework.web.filter.CorsFilter.doFilterInternal(CorsFilter.java:92)\r\n	at org.springframework.web.filter.OncePerRequestFilter.doFilter(OncePerRequestFilter.java:119)\r\n	at org.springframework.security.web.FilterChainProxy$VirtualFilterChain.doFilter(FilterChainProxy.java:334)\r\n	at org.springframework.security.web.header.HeaderWriterFilter.doHeadersAfter(HeaderWriterFilter.java:92)\r\n	at org.springframework.security.web.header.HeaderWriterFilter.doFilterInternal(HeaderWriterFilter.java:77)\r\n	at org.springframework.web.filter.OncePerRequestFilter.doFilter(OncePerRequestFilter.java:119)\r\n	at org.springframework.security.web.FilterChainProxy$VirtualFilterChain.doFilter(FilterChainProxy.java:334)\r\n	at org.springframework.security.web.context.SecurityContextPersistenceFilter.doFilter(SecurityContextPersistenceFilter.java:105)\r\n	at org.springframework.security.web.FilterChainProxy$VirtualFilterChain.doFilter(FilterChainProxy.java:334)\r\n	at org.springframework.security.web.context.request.async.WebAsyncManagerIntegrationFilter.doFilterInternal(WebAsyncManagerIntegrationFilter.java:56)\r\n	at org.springframework.web.filter.OncePerRequestFilter.doFilter(OncePerRequestFilter.java:119)\r\n	at org.springframework.security.web.FilterChainProxy$VirtualFilterChain.doFilter(FilterChainProxy.java:334)\r\n	at org.springframework.security.web.FilterChainProxy.doFilterInternal(FilterChainProxy.java:215)\r\n	at org.springframework.security.web.FilterChainProxy.doFilter(FilterChainProxy.java:178)\r\n	at org.springframework.web.filter.DelegatingFilterProxy.invokeDelegate(DelegatingFilterProxy.java:358)\r\n	at org.springframework.web.filter.DelegatingFilterProxy.doFilter(DelegatingFilterProxy.java:271)\r\n	at org.apache.catalina.core.ApplicationFilterChain.internalDoFilter(ApplicationFilterChain.java:193)\r\n	at org.apache.catalina.core.ApplicationFilterChain.doFilter(ApplicationFilterChain.java:166)\r\n	at org.springframework.web.filter.RequestContextFilter.doFilterInternal(RequestContextFilter.java:100)\r\n	at org.springframework.web.filter.OncePerRequestFilter.doFilter(OncePerRequestFilter.java:119)\r\n	at org.apache.catalina.core.ApplicationFilterChain.internalDoFilter(ApplicationFilterChain.java:193)\r\n	at org.apache.catalina.core.ApplicationFilterChain.doFilter(ApplicationFilterChain.java:166)\r\n	at org.springframework.web.filter.FormContentFilter.doFilterInternal(FormContentFilter.java:93)\r\n	at org.springframework.web.filter.OncePerRequestFilter.doFilter(OncePerRequestFilter.java:119)\r\n	at org.apache.catalina.core.ApplicationFilterChain.internalDoFilter(ApplicationFilterChain.java:193)\r\n	at org.apache.catalina.core.ApplicationFilterChain.doFilter(ApplicationFilterChain.java:166)\r\n	at org.springframework.web.filter.CharacterEncodingFilter.doFilterInternal(CharacterEncodingFilter.java:201)\r\n	at org.springframework.web.filter.OncePerRequestFilter.doFilter(OncePerRequestFilter.java:119)\r\n	at org.apache.catalina.core.ApplicationFilterChain.internalDoFilter(ApplicationFilterChain.java:193)\r\n	at org.apache.catalina.core.ApplicationFilterChain.doFilter(ApplicationFilterChain.java:166)\r\n	at org.apache.catalina.core.StandardWrapperValve.invoke(StandardWrapperValve.java:202)\r\n	at org.apache.catalina.core.StandardContextValve.invoke(StandardContextValve.java:96)\r\n	at org.apache.catalina.authenticator.AuthenticatorBase.invoke(AuthenticatorBase.java:541)\r\n	at org.apache.catalina.core.StandardHostValve.invoke(StandardHostValve.java:139)\r\n	at org.apache.catalina.valves.ErrorReportValve.invoke(ErrorReportValve.java:92)\r\n	at org.apache.catalina.core.StandardEngineValve.invoke(StandardEngineValve.java:74)\r\n	at org.apache.catalina.connector.CoyoteAdapter.service(CoyoteAdapter.java:343)\r\n	at org.apache.coyote.http11.Http11Processor.service(Http11Processor.java:373)\r\n	at org.apache.coyote.AbstractProcessorLight.process(AbstractProcessorLight.java:65)\r\n	at org.apache.coyote.AbstractProtocol$ConnectionHandler.process(AbstractProtocol.java:868)\r\n	at org.apache.tomcat.util.net.NioEndpoint$SocketProcessor.doRun(NioEndpoint.java:1590)\r\n	at org.apache.tomcat.util.net.SocketProcessorBase.run(SocketProcessorBase.java:49)\r\n	at java.util.concurrent.ThreadPoolExecutor.runWorker(ThreadPoolExecutor.java:1149)\r\n	at java.util.concurrent.ThreadPoolExecutor$Worker.run(ThreadPoolExecutor.java:624)\r\n	at org.apache.tomcat.util.threads.TaskThread$WrappingRunnable.run(TaskThread.java:61)\r\n	at java.lang.Thread.run(Thread.java:748)\r\nCaused by: org.quartz.JobPersistenceException: The job (DEFAULT.TASK_1) referenced by the trigger does not exist.\r\n	at org.quartz.simpl.RAMJobStore.storeTrigger(RAMJobStore.java:422)\r\n	at org.quartz.core.QuartzScheduler.triggerJob(QuartzScheduler.java:1162)\r\n	at org.quartz.impl.StdScheduler.triggerJob(StdScheduler.java:341)\r\n	at com.rawchen.util.quartz.ScheduleUtils.run(ScheduleUtils.java:100)\r\n	... 118 more\r\n', '192.168.136.1', '内网IP|内网IP', 'Windows 10', 'Chrome 87.0.4280.141', '2021-03-18 09:55:27', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/87.0.4280.141 Safari/537.36');

-- ----------------------------
-- Table structure for friend
-- ----------------------------
DROP TABLE IF EXISTS `friend`;
CREATE TABLE `friend`  (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `nickname` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '昵称',
  `description` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '描述',
  `website` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '站点',
  `avatar` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '头像',
  `is_published` bit(1) NOT NULL COMMENT '公开或隐藏',
  `views` int(11) NOT NULL COMMENT '点击次数',
  `create_time` datetime NOT NULL COMMENT '创建时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of friend
-- ----------------------------

-- ----------------------------
-- Table structure for login_log
-- ----------------------------
DROP TABLE IF EXISTS `login_log`;
CREATE TABLE `login_log`  (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `username` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '用户名称',
  `ip` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT 'ip',
  `ip_source` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT 'ip来源',
  `os` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '操作系统',
  `browser` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '浏览器',
  `status` bit(1) NULL DEFAULT NULL COMMENT '登录状态',
  `description` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '操作描述',
  `create_time` datetime NOT NULL COMMENT '登录时间',
  `user_agent` varchar(2000) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT 'user-agent用户代理',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 31 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of login_log
-- ----------------------------
INSERT INTO `login_log` VALUES (1, 'Admin', '192.168.136.1', '内网IP|内网IP', 'Windows 10', 'Chrome 87.0.4280.141', b'0', '用户名或密码错误', '2021-03-17 17:53:13', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/87.0.4280.141 Safari/537.36');
INSERT INTO `login_log` VALUES (2, 'Admin', '192.168.136.1', '内网IP|内网IP', 'Windows 10', 'Chrome 87.0.4280.141', b'0', '用户名或密码错误', '2021-03-17 17:53:18', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/87.0.4280.141 Safari/537.36');
INSERT INTO `login_log` VALUES (3, 'admin', '192.168.136.1', '内网IP|内网IP', 'Windows 10', 'Chrome 87.0.4280.141', b'0', '用户名或密码错误', '2021-03-17 17:53:26', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/87.0.4280.141 Safari/537.36');
INSERT INTO `login_log` VALUES (4, 'admin', '192.168.136.1', '内网IP|内网IP', 'Windows 10', 'Chrome 87.0.4280.141', b'1', '登录成功', '2021-03-17 17:53:30', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/87.0.4280.141 Safari/537.36');
INSERT INTO `login_log` VALUES (5, 'admin', '192.168.136.1', '内网IP|内网IP', 'Windows 10', 'Chrome 87.0.4280.141', b'1', '登录成功', '2021-03-17 18:08:17', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/87.0.4280.141 Safari/537.36');
INSERT INTO `login_log` VALUES (6, 'admin', '192.168.136.1', '内网IP|内网IP', 'Windows 10', 'Chrome 87.0.4280.141', b'1', '登录成功', '2021-03-17 18:12:54', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/87.0.4280.141 Safari/537.36');
INSERT INTO `login_log` VALUES (7, 'admin', '192.168.136.1', '内网IP|内网IP', 'Windows 10', 'Edge 89.0.774.54', b'1', '登录成功', '2021-03-18 21:17:50', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/89.0.4389.90 Safari/537.36 Edg/89.0.774.54');
INSERT INTO `login_log` VALUES (8, 'admin', '192.168.136.1', '内网IP|内网IP', 'Windows 10', 'Chrome 87.0.4280.141', b'1', '登录成功', '2021-03-18 21:22:51', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/87.0.4280.141 Safari/537.36');
INSERT INTO `login_log` VALUES (9, 'admin', '192.168.136.1', '内网IP|内网IP', 'Windows 10', 'Chrome 87.0.4280.141', b'1', '登录成功', '2021-03-18 21:36:00', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/87.0.4280.141 Safari/537.36');

-- ----------------------------
-- Table structure for moment
-- ----------------------------
DROP TABLE IF EXISTS `moment`;
CREATE TABLE `moment`  (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `content` longtext CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '动态内容',
  `create_time` datetime NOT NULL COMMENT '创建时间',
  `likes` int(11) NULL DEFAULT NULL COMMENT '点赞数量',
  `is_published` bit(1) NOT NULL COMMENT '是否公开',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 2 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of moment
-- ----------------------------
INSERT INTO `moment` VALUES (1, '测试动态\n\n', '2021-03-18 21:42:32', 0, b'1');

-- ----------------------------
-- Table structure for operation_log
-- ----------------------------
DROP TABLE IF EXISTS `operation_log`;
CREATE TABLE `operation_log`  (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `username` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '操作者用户名',
  `uri` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '请求接口',
  `method` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '请求方式',
  `param` varchar(2000) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '请求参数',
  `description` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '操作描述',
  `ip` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT 'ip',
  `ip_source` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT 'ip来源',
  `os` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '操作系统',
  `browser` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '浏览器',
  `times` int(11) NOT NULL COMMENT '请求耗时（毫秒）',
  `create_time` datetime NOT NULL COMMENT '操作时间',
  `user_agent` varchar(2000) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT 'user-agent用户代理',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 72 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of operation_log
-- ----------------------------
INSERT INTO `operation_log` VALUES (19, 'Admin', '/admin/category', 'DELETE', '{\"id\":2}', '删除分类', '192.168.136.1', '内网IP|内网IP', 'Windows 10', 'Chrome 87.0.4280.141', 2, '2021-03-18 09:00:42', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/87.0.4280.141 Safari/537.36');
INSERT INTO `operation_log` VALUES (20, 'Admin', '/admin/category', 'DELETE', '{\"id\":2}', '删除分类', '192.168.136.1', '内网IP|内网IP', 'Windows 10', 'Chrome 87.0.4280.141', 3, '2021-03-18 09:00:47', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/87.0.4280.141 Safari/537.36');
INSERT INTO `operation_log` VALUES (21, 'Admin', '/admin/category', 'DELETE', '{\"id\":2}', '删除分类', '192.168.136.1', '内网IP|内网IP', 'Android 6', 'Chrome 87.0.4280.141', 3, '2021-03-18 09:02:55', 'Mozilla/5.0 (Linux; Android 6.0; Nexus 5 Build/MRA58N) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/87.0.4280.141 Mobile Safari/537.36');
INSERT INTO `operation_log` VALUES (22, 'Admin', '/admin/category', 'DELETE', '{\"id\":2}', '删除分类', '192.168.136.1', '内网IP|内网IP', 'Android 6', 'Chrome 87.0.4280.141', 3, '2021-03-18 09:28:31', 'Mozilla/5.0 (Linux; Android 6.0; Nexus 5 Build/MRA58N) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/87.0.4280.141 Mobile Safari/537.36');
INSERT INTO `operation_log` VALUES (23, 'Admin', '/admin/category', 'DELETE', '{\"id\":2}', '删除分类', '192.168.136.1', '内网IP|内网IP', 'Android 6', 'Chrome 87.0.4280.141', 3, '2021-03-18 09:28:41', 'Mozilla/5.0 (Linux; Android 6.0; Nexus 5 Build/MRA58N) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/87.0.4280.141 Mobile Safari/537.36');
INSERT INTO `operation_log` VALUES (24, 'Admin', '/admin/job/run', 'POST', '{\"jobId\":1}', '立即执行定时任务', '192.168.136.1', '内网IP|内网IP', 'Windows 10', 'Chrome 87.0.4280.141', 8, '2021-03-18 10:26:07', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/87.0.4280.141 Safari/537.36');
INSERT INTO `operation_log` VALUES (25, 'Admin', '/admin/job/run', 'POST', '{\"jobId\":2}', '立即执行定时任务', '192.168.136.1', '内网IP|内网IP', 'Windows 10', 'Chrome 87.0.4280.141', 3, '2021-03-18 10:27:25', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/87.0.4280.141 Safari/537.36');
INSERT INTO `operation_log` VALUES (26, 'Admin', '/admin/tag', 'PUT', '{\"tag\":{\"id\":1,\"name\":\"test\",\"color\":\"grey\",\"blogs\":[]}}', '修改标签', '192.168.136.1', '内网IP|内网IP', 'Windows 10', 'Chrome 87.0.4280.141', 39, '2021-03-18 15:58:45', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/87.0.4280.141 Safari/537.36');

-- ----------------------------
-- Table structure for schedule_job
-- ----------------------------
DROP TABLE IF EXISTS `schedule_job`;
CREATE TABLE `schedule_job`  (
  `job_id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '任务id',
  `bean_name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT 'spring bean名称',
  `method_name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '方法名',
  `params` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '参数',
  `cron` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT 'cron表达式',
  `status` tinyint(4) NULL DEFAULT NULL COMMENT '任务状态',
  `remark` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '备注',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  PRIMARY KEY (`job_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 3 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of schedule_job
-- ----------------------------
INSERT INTO `schedule_job` VALUES (1, 'redisSyncScheduleTask', 'syncBlogViewsToDatabase', '', '0 0 1 * * ?', 1, '每天凌晨一点，从Redis将博客浏览量同步到数据库', '2020-11-17 23:45:42');
INSERT INTO `schedule_job` VALUES (2, 'visitorSyncScheduleTask', 'syncVisitInfoToDatabase', '', '0 0 0 * * ? *', 1, '清空当天Redis访客标识，记录当天的PV和UV，更新当天所有访客的PV和最后访问时间，更新城市新增访客UV数', '2021-02-05 08:14:28');

-- ----------------------------
-- Table structure for schedule_job_log
-- ----------------------------
DROP TABLE IF EXISTS `schedule_job_log`;
CREATE TABLE `schedule_job_log`  (
  `log_id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '任务日志id',
  `job_id` bigint(20) NOT NULL COMMENT '任务id',
  `bean_name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT 'spring bean名称',
  `method_name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '方法名',
  `params` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '参数',
  `status` tinyint(4) NOT NULL COMMENT '任务执行结果',
  `error` text CHARACTER SET utf8 COLLATE utf8_general_ci NULL COMMENT '异常信息',
  `times` int(11) NOT NULL COMMENT '耗时（单位：毫秒）',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  PRIMARY KEY (`log_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 13 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of schedule_job_log
-- ----------------------------
INSERT INTO `schedule_job_log` VALUES (1, 1, 'redisSyncScheduleTask', 'syncBlogViewsToDatabase', '', 1, NULL, 16, '2021-03-18 10:26:07');
INSERT INTO `schedule_job_log` VALUES (2, 2, 'visitorSyncScheduleTask', 'syncVisitInfoToDatabase', '', 1, NULL, 45, '2021-03-18 10:27:25');
INSERT INTO `schedule_job_log` VALUES (3, 2, 'visitorSyncScheduleTask', 'syncVisitInfoToDatabase', '', 1, NULL, 32, '2021-03-18 17:57:45');
INSERT INTO `schedule_job_log` VALUES (4, 2, 'visitorSyncScheduleTask', 'syncVisitInfoToDatabase', '', 1, NULL, 24, '2021-03-18 18:12:35');
INSERT INTO `schedule_job_log` VALUES (5, 2, 'visitorSyncScheduleTask', 'syncVisitInfoToDatabase', '', 1, NULL, 33, '2021-03-22 08:37:30');
INSERT INTO `schedule_job_log` VALUES (6, 2, 'visitorSyncScheduleTask', 'syncVisitInfoToDatabase', '', 1, NULL, 25, '2021-04-05 23:55:26');
INSERT INTO `schedule_job_log` VALUES (7, 2, 'visitorSyncScheduleTask', 'syncVisitInfoToDatabase', '', 1, NULL, 37, '2021-04-12 11:34:47');
INSERT INTO `schedule_job_log` VALUES (8, 2, 'visitorSyncScheduleTask', 'syncVisitInfoToDatabase', '', 1, NULL, 15, '2021-04-12 11:37:14');
INSERT INTO `schedule_job_log` VALUES (9, 2, 'visitorSyncScheduleTask', 'syncVisitInfoToDatabase', '', 1, NULL, 202302, '2021-04-12 11:44:50');
INSERT INTO `schedule_job_log` VALUES (10, 2, 'visitorSyncScheduleTask', 'syncVisitInfoToDatabase', '', 1, NULL, 53, '2021-04-26 08:38:47');
INSERT INTO `schedule_job_log` VALUES (11, 2, 'visitorSyncScheduleTask', 'syncVisitInfoToDatabase', '', 1, NULL, 11, '2021-04-26 09:04:31');
INSERT INTO `schedule_job_log` VALUES (12, 2, 'visitorSyncScheduleTask', 'syncVisitInfoToDatabase', '', 1, NULL, 188, '2021-05-12 00:00:00');

-- ----------------------------
-- Table structure for site_setting
-- ----------------------------
DROP TABLE IF EXISTS `site_setting`;
CREATE TABLE `site_setting`  (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `name_en` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `name_zh` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `value` longtext CHARACTER SET utf8 COLLATE utf8_general_ci NULL,
  `type` int(11) NULL DEFAULT NULL COMMENT '1基础设置，2页脚徽标，3资料卡，4友链信息',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 29 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of site_setting
-- ----------------------------
INSERT INTO `site_setting` VALUES (1, 'webTitleSuffix', '网页标题后缀', ' - RawChen', 1);
INSERT INTO `site_setting` VALUES (2, 'blogName', '博客名称', 'RawChen', 1);
INSERT INTO `site_setting` VALUES (3, 'footerImgTitle', '页脚图片标题', '手机看本站', 1);
INSERT INTO `site_setting` VALUES (4, 'footerImgUrl', '页脚图片路径', '/img/qr.png', 1);
INSERT INTO `site_setting` VALUES (5, 'copyright', 'Copyright', '{\"title\":\"Copyright © 2019 - 2021\",\"siteName\":\"RawChen\"}', 1);
INSERT INTO `site_setting` VALUES (6, 'beian', 'ICP备案号', '闽ICP备18008354号-1', 1);
INSERT INTO `site_setting` VALUES (7, 'badge', '徽标', '{\"title\":\"由 Spring Boot 强力驱动\",\"url\":\"https://spring.io/projects/spring-boot/\",\"subject\":\"Powered\",\"value\":\"Spring Boot\",\"color\":\"blue\"}', 2);
INSERT INTO `site_setting` VALUES (8, 'badge', '徽标', '{\"title\":\"Vue.js 客户端渲染\",\"url\":\"https://cn.vuejs.org/\",\"subject\":\"SPA\",\"value\":\"Vue.js\",\"color\":\"brightgreen\"}', 2);
INSERT INTO `site_setting` VALUES (9, 'badge', '徽标', '{\"title\":\"UI 框架 Semantic-UI\",\"url\":\"https://semantic-ui.com/\",\"subject\":\"UI\",\"value\":\"Semantic-UI\",\"color\":\"semantic-ui\"}', 2);
INSERT INTO `site_setting` VALUES (10, 'badge', '徽标', '{\"title\":\"阿里云相关服务\",\"url\":\"https://www.aliyun.com/\",\"subject\":\"VPS\",\"value\":\"Aliyun\",\"color\":\"blueviolet\"}', 2);
INSERT INTO `site_setting` VALUES (11, 'badge', '徽标', '{\"title\":\"jsDelivr 提供 CDN 加速服务\",\"url\":\"https://www.jsdelivr.com/\",\"subject\":\"CDN\",\"value\":\"jsDelivr\",\"color\":\"orange\"}', 2);
INSERT INTO `site_setting` VALUES (12, 'badge', '徽标', '{\"title\":\"GitHub 提供图床\",\"url\":\"https://github.com/\",\"subject\":\"OSS\",\"value\":\"GitHub\",\"color\":\"github\"}', 2);
INSERT INTO `site_setting` VALUES (14, 'avatar', '图片路径', '/img/avatar.jpg', 3);
INSERT INTO `site_setting` VALUES (15, 'name', '昵称', 'RawChen', 3);
INSERT INTO `site_setting` VALUES (16, 'rollText', '滚动个签', '\"大道至简  大简至极\",\"越努力  越幸运\"', 3);
INSERT INTO `site_setting` VALUES (17, 'github', 'GitHub地址', 'https://github.com/rawchen', 3);
INSERT INTO `site_setting` VALUES (18, 'qq', 'QQ链接', 'http://wpa.qq.com/msgrd?v=3&uin=2221999792', 3);
INSERT INTO `site_setting` VALUES (19, 'bilibili', 'bilibili链接', 'https://space.bilibili.com/17612520', 3);
INSERT INTO `site_setting` VALUES (20, 'netease', '网易云音乐', 'https://music.163.com/#/user/home?id=337040899', 3);
INSERT INTO `site_setting` VALUES (21, 'email', 'email', 'http://mail.qq.com/cgi-bin/qm_share?t=qm_mailme&email=BnRncWVuY2hGd3coZWlr', 3);
INSERT INTO `site_setting` VALUES (22, 'favorite', '自定义', '{\"title\":\"感兴趣的事\",\"content\":\"写博客、极简化、后端开发、摄影、旅游\"}', 3);
INSERT INTO `site_setting` VALUES (23, 'favorite', '自定义', '{\"title\":\"最喜欢的人\",\"content\":\"马斯克、乔布斯\"}', 3);
INSERT INTO `site_setting` VALUES (24, 'favorite', '自定义', '{\"title\":\"最喜欢的电影\",\"content\":\"太多了\"}', 3);
INSERT INTO `site_setting` VALUES (25, 'reward', '赞赏码路径', '/img/reward.jpg', 1);
INSERT INTO `site_setting` VALUES (26, 'commentAdminFlag', '博主评论标识', '博主', 1);
INSERT INTO `site_setting` VALUES (27, 'friendContent', '友链页面信息', '随机排序，不分先后。欢迎交换友链~(￣▽￣)~*\n\n* 昵称：RawChen\n* 一句话：越努力，越幸运。\n* 网址：[https://rawchen.com](https://rawchen.com)\n* 头像：[https://rawchen.com/favicon.png](https://rawchen.com/favicon.png)\n\n仅凭个人喜好添加友链，请在收到我的回复邮件后再于贵站添加本站链接。原则上已添加的友链不会删除，如果你发现自己被移除了，恕不另行通知，只需和我一样做就好。\n\n', 4);
INSERT INTO `site_setting` VALUES (28, 'friendCommentEnabled', '友链页面评论开关', '1', 4);

-- ----------------------------
-- Table structure for tag
-- ----------------------------
DROP TABLE IF EXISTS `tag`;
CREATE TABLE `tag`  (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `tag_name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `color` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '标签颜色(可选)',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 3 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of tag
-- ----------------------------
INSERT INTO `tag` VALUES (1, 'test', '');
INSERT INTO `tag` VALUES (2, 'IOC', '');

-- ----------------------------
-- Table structure for user
-- ----------------------------
DROP TABLE IF EXISTS `user`;
CREATE TABLE `user`  (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `username` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '用户名',
  `password` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '密码',
  `nickname` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '昵称',
  `avatar` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '头像地址',
  `email` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '邮箱',
  `create_time` datetime NOT NULL COMMENT '创建时间',
  `update_time` datetime NOT NULL COMMENT '更新时间',
  `role` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '角色访问权限',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 2 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of user
-- ----------------------------
INSERT INTO `user` VALUES (1, 'admin', '$2a$10$V5.FLSNsCtJYarg2f2Xjc./s.qzp5Kxb744dz5Xf4dnMgEhhx56xu', 'Admin', '/img/avatar.jpg', '2221999792@qq.com', '2020-09-21 16:47:18', '2020-09-21 16:47:22', 'ROLE_admin');

-- ----------------------------
-- Table structure for visit_log
-- ----------------------------
DROP TABLE IF EXISTS `visit_log`;
CREATE TABLE `visit_log`  (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `uuid` varchar(36) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '访客标识码',
  `uri` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '请求接口',
  `method` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '请求方式',
  `param` varchar(2000) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '请求参数',
  `behavior` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '访问行为',
  `content` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '访问内容',
  `remark` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '备注',
  `ip` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT 'ip',
  `ip_source` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT 'ip来源',
  `os` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '操作系统',
  `browser` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '浏览器',
  `times` int(11) NOT NULL COMMENT '请求耗时（毫秒）',
  `create_time` datetime NOT NULL COMMENT '访问时间',
  `user_agent` varchar(2000) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT 'user-agent用户代理',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 707 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of visit_log
-- ----------------------------
INSERT INTO `visit_log` VALUES (1, '89513a0d-f835-4353-b80e-588cd1290ff9', '/blogs', 'GET', '{\"pageNum\":1}', '访问页面', '首页', '第1页', '192.168.136.1', '内网IP|内网IP', 'Windows 10', 'Chrome 87.0.4280.141', 117, '2021-03-17 14:05:38', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/87.0.4280.141 Safari/537.36');
INSERT INTO `visit_log` VALUES (2, '89513a0d-f835-4353-b80e-588cd1290ff9', '/blogs', 'GET', '{\"pageNum\":1}', '访问页面', '首页', '第1页', '192.168.136.1', '内网IP|内网IP', 'Windows 10', 'Chrome 87.0.4280.141', 24, '2021-03-17 14:05:56', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/87.0.4280.141 Safari/537.36');
INSERT INTO `visit_log` VALUES (3, '89513a0d-f835-4353-b80e-588cd1290ff9', '/blogs', 'GET', '{\"pageNum\":1}', '访问页面', '首页', '第1页', '192.168.136.1', '内网IP|内网IP', 'Windows 10', 'Chrome 87.0.4280.141', 13, '2021-03-17 14:06:23', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/87.0.4280.141 Safari/537.36');
INSERT INTO `visit_log` VALUES (4, '89513a0d-f835-4353-b80e-588cd1290ff9', '/blogs', 'GET', '{\"pageNum\":1}', '访问页面', '首页', '第1页', '192.168.136.1', '内网IP|内网IP', 'Windows 10', 'Chrome 87.0.4280.141', 7, '2021-03-17 14:06:36', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/87.0.4280.141 Safari/537.36');

-- ----------------------------
-- Table structure for visit_record
-- ----------------------------
DROP TABLE IF EXISTS `visit_record`;
CREATE TABLE `visit_record`  (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `pv` int(11) NOT NULL COMMENT '访问量',
  `uv` int(11) NOT NULL COMMENT '独立用户',
  `date` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '日期\"02-23\"',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 11 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of visit_record
-- ----------------------------
INSERT INTO `visit_record` VALUES (1, 151, 5, '03-17');
INSERT INTO `visit_record` VALUES (2, 220, 5, '03-18');
INSERT INTO `visit_record` VALUES (3, 0, 0, '03-21');
INSERT INTO `visit_record` VALUES (4, 0, 0, '04-04');
INSERT INTO `visit_record` VALUES (5, 0, 0, '04-11');
INSERT INTO `visit_record` VALUES (6, 0, 0, '04-11');
INSERT INTO `visit_record` VALUES (7, 0, 0, '04-11');
INSERT INTO `visit_record` VALUES (8, 0, 0, '04-25');
INSERT INTO `visit_record` VALUES (9, 0, 0, '04-25');
INSERT INTO `visit_record` VALUES (10, 101, 1, '05-11');

-- ----------------------------
-- Table structure for visitor
-- ----------------------------
DROP TABLE IF EXISTS `visitor`;
CREATE TABLE `visitor`  (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `uuid` varchar(36) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '访客标识码',
  `ip` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT 'ip',
  `ip_source` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT 'ip来源',
  `os` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '操作系统',
  `browser` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '浏览器',
  `create_time` datetime NOT NULL COMMENT '首次访问时间',
  `last_time` datetime NOT NULL COMMENT '最后访问时间',
  `pv` int(11) NULL DEFAULT NULL COMMENT '访问页数统计',
  `user_agent` varchar(2000) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT 'user-agent用户代理',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 9 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of visitor
-- ----------------------------
INSERT INTO `visitor` VALUES (1, '7cbd1d76-f7ae-4926-9c93-94ff0a3927f6', '192.168.136.1', '内网IP|内网IP', 'Windows 10', 'Edge 89.0.774.54', '2021-03-17 14:37:36', '2021-03-17 14:37:36', 3, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/89.0.4389.90 Safari/537.36 Edg/89.0.774.54');
INSERT INTO `visitor` VALUES (2, '86095574-34d0-4daa-a3d4-4a1284bd8b59', '192.168.136.1', '内网IP|内网IP', 'Windows 10', 'Chrome 87.0.4280.141', '2021-03-17 18:13:33', '2021-03-17 21:12:28', 153, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/87.0.4280.141 Safari/537.36');
INSERT INTO `visitor` VALUES (3, '7d1eec6f-384a-42f2-b4e5-6735021bce07', '192.168.136.1', '内网IP|内网IP', 'Windows 10', 'Edge 89.0.774.54', '2021-03-17 20:35:25', '2021-03-17 20:36:36', 9, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/89.0.4389.90 Safari/537.36 Edg/89.0.774.54');
INSERT INTO `visitor` VALUES (4, 'f6f4ccd9-3526-4b71-ae56-246e84861c42', '192.168.136.1', '内网IP|内网IP', 'Windows 10', 'Chrome 87.0.4280.141', '2021-03-17 21:40:27', '2021-03-17 23:49:12', 189, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/87.0.4280.141 Safari/537.36');
INSERT INTO `visitor` VALUES (5, 'f12fb23b-15d0-41e7-9c74-aa979df6ca3e', '192.168.136.1', '内网IP|内网IP', 'Windows 10', 'Chrome 87.0.4280.141', '2021-03-22 08:18:55', '2021-03-22 08:18:55', 0, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/87.0.4280.141 Safari/537.36');
INSERT INTO `visitor` VALUES (6, '3cfd4af5-74ae-48a6-9b60-5a224cdda761', '192.168.136.1', '内网IP|内网IP', 'Windows 10', 'Chrome 87.0.4280.141', '2021-03-24 14:38:36', '2021-03-24 14:38:36', 0, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/87.0.4280.141 Safari/537.36');
INSERT INTO `visitor` VALUES (7, 'be939895-1e38-4eff-a5a9-36eeab04cb1a', '192.168.136.1', '内网IP|内网IP', 'Windows 10', 'Chrome 89.0.4389.90', '2021-04-26 10:24:19', '2021-05-11 22:13:27', 101, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/89.0.4389.90 Safari/537.36');
INSERT INTO `visitor` VALUES (8, '691475fd-eebf-363b-8bc3-a43d3b4c0346', '192.168.136.1', '内网IP|内网IP', 'Windows 10', 'Chrome 89.0.4389.90', '2021-05-16 21:21:36', '2021-05-16 21:21:36', 0, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/89.0.4389.90 Safari/537.36');

SET FOREIGN_KEY_CHECKS = 1;
