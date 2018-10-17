using DTcms.Common;
using DTcms.Web.UI;
using Senparc.Weixin.MP.AdvancedAPIs;
using Senparc.Weixin.MP.AdvancedAPIs.OAuth;
using System;
using System.Collections.Generic;
using System.Drawing;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace DTcms.Web
{
    public partial class wx_share_init : WXBasePage
    {
        Model.siteconfig siteConfig = new BLL.siteconfig().loadConfig();
        Model.userconfig userConfig = new BLL.userconfig().loadConfig();
        protected void Page_Load(object sender, EventArgs e)
        {

            if (!IsPostBack)
            {
                string code = Common.DTRequest.GetString("code");
                if (!string.IsNullOrEmpty(code))
                {
                    string openid = Utils.GetCookie("wx_openid");
                    string unionid = Utils.GetCookie("wx_unionid");
                    if (string.IsNullOrEmpty(openid) || string.IsNullOrEmpty(unionid))
                    {
                        OAuthAccessTokenResult oauthResult = OAuthApi.GetAccessToken(appId, appSecret, code);
                        Utils.WriteCookie("wx_openid", oauthResult.openid);
                        Utils.WriteCookie("wx_unionid", oauthResult.unionid);
                        openid = oauthResult.openid;
                        unionid = oauthResult.unionid;
                    }

                    //if (string.IsNullOrEmpty(accessToken) || tokenTime > DateTime.Now.AddMinutes(-30))
                    //{
                    //    accessToken = AccessTokenContainer.GetAccessToken(appId);
                    //    tokenTime = DateTime.Now;
                    //}
                    //UserInfoJson userInfo = UserApi.Info(accessToken, oauthResult.openid);

                    BLL.users bll = new BLL.users();
                    if (bll.ExistsWxOpenID(openid))
                    {
                        LogHelper.WriteDebugLog("[wx_init] login,wx_open_id:" + openid);
                        LogHelper.WriteDebugLog("[wx_init] login,UnionID:" + unionid);
                        List<Model.users> list = bll.GetModelByWx(openid);

                        Session[DTKeys.SESSION_USER_INFO] = list;
                        Session.Timeout = 45;

                        foreach (Model.users model in list)
                        {
                            //检查用户二维码
                            if (!Common.Utils.FileExists("/upload/InviterQRCode/" + model.id + ".png"))
                            {
                                string url = (siteConfig.weburl.StartsWith("http://") ? siteConfig.weburl : "http://" + siteConfig.weburl) + "/inviter.aspx?from=" + model.id;
                                Bitmap img = Common.QRCode.Create_ImgCode(url, 4);
                                Common.QRCode.SaveImg(Server.MapPath("~/upload/InviterQRCode/"), model.id + ".png", img);
                            }
                        }

                        Response.Write("inviter:" + Common.Utils.GetCookie("inviter"));
                        Response.Write("<br />turl:" + Common.Utils.GetCookie(Common.DTKeys.COOKIE_URL_REFERRER));

                        //Utils.WriteCookie(DTKeys.COOKIE_WEIXIN_FOCUS_ON, userInfo.subscribe.ToString());
                        Response.Redirect("login.aspx?wxopenid=" + openid + "&turl=" + Server.UrlEncode(Utils.GetCookie(DTKeys.COOKIE_URL_REFERRER)));
                    }
                    else
                    {
                        Response.Write("inviter:" + Common.Utils.GetCookie("inviter"));
                        Response.Write("<br />turl:" + Common.Utils.GetCookie(Common.DTKeys.COOKIE_URL_REFERRER));
                        LogHelper.WriteDebugLog("[wx_init] register,wx_open_id:" + openid);
                        try
                        {


                            #region 用户注册

                            Model.user_groups modelGroup = new BLL.user_groups().GetDefault();

                            #region 保存用户注册信息
                            Model.users model = new Model.users();
                            model.group_id = modelGroup.id;
                            model.user_name = openid;
                            model.salt = Utils.GetCheckCode(6); //获得6位的salt加密字符串
                            model.password = "012345";
                            model.email = openid + "@yuedujing.com";
                            model.mobile = string.Empty;
                            model.reg_ip = DTRequest.GetIP();
                            model.reg_time = DateTime.Now;
                            model.nick_name = "新用户";


                            //设置用户状态
                            if (userConfig.regstatus == 3)
                            {
                                model.status = 1; //待验证
                            }
                            else if (userConfig.regverify == 1)
                            {
                                model.status = 2; //待审核
                            }
                            else
                            {
                                model.status = 0; //正常
                            }
                            //开始写入数据库
                            model.id = bll.Add(model);
                            if (model.id < 1)
                            {
                                return;
                            }

                            //检查用户二维码
                            if (!Common.Utils.FileExists("/upload/InviterQRCode/" + model.id + ".png"))
                            {
                                string url = (siteConfig.weburl.StartsWith("http://") ? siteConfig.weburl : "http://" + siteConfig.weburl) + "/inviter.aspx?from=" + model.id;
                                Bitmap img = Common.QRCode.Create_ImgCode(url, 4);
                                Common.QRCode.SaveImg(Server.MapPath("~/upload/InviterQRCode/"), model.id + ".png", img);
                            }
                            //检查用户组是否需要赠送积分
                            if (modelGroup.point > 0)
                            {
                                new BLL.user_point_log().Add(model.id, model.user_name, modelGroup.point, "注册赠送积分", false);
                            }
                            //检查用户组是否需要赠送金额
                            if (modelGroup.amount > 0)
                            {
                                new BLL.user_amount_log().Add(model.id, model.user_name, modelGroup.amount, "注册赠送金额");
                            }
                            #endregion

                            #region 登录
                            if (bll.ExistsWxOpenID(openid))
                            {
                                LogHelper.WriteDebugLog("[wx_init] login,wx_open_id:" + openid);
                                LogHelper.WriteDebugLog("[wx_init] login,UnionID:" + unionid);
                                model = new Model.users();
                                model = bll.GetModelByWx(openid).First();
                                Session[DTKeys.SESSION_USER_INFO] = model;
                                Session.Timeout = 45;

                                //检查用户二维码
                                if (!Common.Utils.FileExists("/upload/InviterQRCode/" + model.id + ".png"))
                                {
                                    string url = (siteConfig.weburl.StartsWith("http://") ? siteConfig.weburl : "http://" + siteConfig.weburl) + "/inviter.aspx?from=" + model.id;
                                    Bitmap img = Common.QRCode.Create_ImgCode(url, 4);
                                    Common.QRCode.SaveImg(Server.MapPath("~/upload/InviterQRCode/"), model.id + ".png", img);
                                }

                                Response.Write("inviter:" + Common.Utils.GetCookie("inviter"));
                                Response.Write("<br />turl:" + Common.Utils.GetCookie(Common.DTKeys.COOKIE_URL_REFERRER));
                                //Utils.WriteCookie(DTKeys.COOKIE_WEIXIN_FOCUS_ON, userInfo.subscribe.ToString());
                                Response.Redirect("login.aspx?wxopenid=" + openid + "&turl=" + Utils.GetCookie(DTKeys.COOKIE_URL_REFERRER));
                            }
                            #endregion

                            #endregion
                        }
                        catch
                        {
                            //Utils.WriteCookie(DTKeys.COOKIE_WEIXIN_FOCUS_ON, userInfo.subscribe.ToString());
                            Response.Redirect("register.aspx?wxopenid=" + openid + "&turl=" + Utils.GetCookie(DTKeys.COOKIE_URL_REFERRER));
                        }


                    }
                }
                else
                {
                    Response.Redirect("login.aspx");
                }
            }
        }
    }
}