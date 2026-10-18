package com.rawchen.blog.service;

import com.rawchen.blog.entity.Article;
import com.rawchen.blog.entity.Comment;
import com.rawchen.blog.entity.FriendLink;

/**
 * 邮件服务接口
 *
 * @author RawChen
 */
public interface MailService {

    /**
     * 发送新评论通知给文章作者
     *
     * @param comment   新评论
     * @param article   文章
     * @param blogUrl   博客地址
     * @param blogName  博客名称
     */
    void sendNewCommentMail(Comment comment, Article article, String blogUrl, String blogName);

    /**
     * 发送回复通知给被回复者
     *
     * @param comment       回复评论
     * @param parentComment 被回复的父评论
     * @param article       文章
     * @param blogUrl       博客地址
     * @param blogName      博客名称
     */
    void sendReplyMail(Comment comment, Comment parentComment, Article article, String blogUrl, String blogName);

    /**
     * 发送友链审核通过通知给申请人
     *
     * @param friendLink 已通过审核的友链
     * @param blogUrl    博客地址
     * @param blogName   博客名称
     */
    void sendFriendApprovedMail(FriendLink friendLink, String blogUrl, String blogName);

    /**
     * 发送友链申请待审核通知给网站作者
     *
     * @param friendLink 待审核的友链申请
     * @param adminEmail 网站作者邮箱
     * @param blogUrl    博客地址
     * @param blogName   博客名称
     */
    void sendFriendPendingMail(FriendLink friendLink, String adminEmail, String blogUrl, String blogName);
}