using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Senparc.Weixin;
using Senparc.Weixin.MP;
using Senparc.Weixin.MP.AdvancedAPIs.OAuth;
using Senparc.Weixin.MP.AdvancedAPIs;
using Senparc.Weixin.MP.Containers;
using Senparc.Weixin.MP.Entities;
using DTcms.Common;
using System.Drawing;
using Senparc.Weixin.MP.AdvancedAPIs.User;
using DTcms.Web.UI;

namespace DTcms.Web
{
    public partial class wx_init : WXBasePage
    {

        Model.siteconfig siteConfig = new BLL.siteconfig().loadConfig();
        Model.userconfig userConfig = new BLL.userconfig().loadConfig();

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                string code = Common.DTRequest.GetQueryString("code");
                if (!string.IsNullOrEmpty(code))
                {
                    string openid = "";// Utils.GetCookie("wx_openid");
                    //if (string.IsNullOrEmpty(openid) || string.IsNullOrEmpty(unionid))
                    //{OAuthAccessTokenResult result = OAuthApi.GetAccessToken(appId, secret, code);  
                    OAuthAccessTokenResult oauthResult = OAuthApi.GetAccessToken(appId, appSecret, code);
                    //Utils.WriteCookie("wx_openid", oauthResult.openid);
                    //Utils.WriteCookie("wx_unionid", oauthResult.unionid);
                    openid = oauthResult.openid;
                    //}


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
                        Model.users model = bll.GetModelByWx(openid).First();
                        //if (string.IsNullOrEmpty(model.wx_unionid))
                        //{
                        //    bll.UpdateWxUnionID(model.id, unionid);
                        //}
                        Session[DTKeys.SESSION_USER_INFO] = model;
                        Session.Timeout = 45;

                        //检查用户二维码
                        if (!Common.Utils.FileExists("/upload/InviterQRCode/" + model.id + ".png"))
                        {
                            string url = (siteConfig.weburl.StartsWith("http://") ? siteConfig.weburl : "http://" + siteConfig.weburl) + "/inviter.aspx?from=" + model.id;
                            Bitmap img = Common.QRCode.Create_ImgCode(url, 4);
                            Common.QRCode.SaveImg(Server.MapPath("~/upload/InviterQRCode/"), model.id + ".png", img);
                        }

                        //#region 云端记录 邀请记录
                        //Model.inviter_history inviter = new Model.inviter_history();
                        //inviter.add_time = DateTime.Now;
                        //inviter.channel = "qrcode";
                        //inviter.inviter_id = TypeConverter.ObjectToInt(Common.Utils.GetCookie("inviter"), 0);
                        //inviter.remark = "通过扫码邀请";
                        //inviter.url = "";
                        //inviter.user_id = model.id;
                        //new BLL.inviter_history().Add(inviter);
                        //#endregion

                        //Response.Redirect("login.aspx?wxopenid=" + oauthResult.openid + "&subscribe=" + userInfo.subscribe);
                        Common.Utils.WriteCookie("openid", openid);
                        Response.Redirect("index.aspx?openid=" + openid);
                    }
                    else
                    {
                        //    Model.user_groups modelGroup = new BLL.user_groups().GetDefault();
                        //    Model.users u1 = new Model.users();
                        //    u1.group_id = modelGroup.id;
                        //    u1.user_name = openid + "-1";
                        //    u1.salt = Utils.GetCheckCode(6); //获得6位的salt加密字符串
                        //    u1.password = DESEncrypt.Encrypt("123456", u1.salt);
                        //    u1.email = u1.user_name + "@a.com";
                        //    u1.mobile = "";
                        //    u1.reg_ip = "";
                        //    u1.reg_time = DateTime.Now;
                        //    u1.status = 0; //正常
                        //    u1.id = bll.Add(u1);

                        //    Model.users u2 = new Model.users();
                        //    u2.group_id = modelGroup.id;
                        //    u2.user_name = openid + "-2";
                        //    u2.salt = Utils.GetCheckCode(6); //获得6位的salt加密字符串
                        //    u2.password = DESEncrypt.Encrypt("123456", u2.salt);
                        //    u2.email = u2.user_name + "@a.com";
                        //    u2.mobile = "";
                        //    u2.reg_ip = "";
                        //    u2.reg_time = DateTime.Now;
                        //    u2.status = 0; //正常

                        //    //开始写入数据库
                        //    u2.id = bll.Add(u2);

                        //    Model.users u3 = new Model.users();
                        //    u3.group_id = modelGroup.id;
                        //    u3.user_name = openid + "-3";
                        //    u3.salt = Utils.GetCheckCode(6); //获得6位的salt加密字符串
                        //    u3.password = DESEncrypt.Encrypt("123456", u3.salt);
                        //    u3.email = u3.user_name + "@a.com";
                        //    u3.mobile = "";
                        //    u3.reg_ip = "";
                        //    u3.reg_time = DateTime.Now;
                        //    u3.status = 0; //正常

                        //    //开始写入数据库
                        //    u3.id = bll.Add(u3);


                        Common.Utils.WriteCookie("openid", openid);
                        Response.Redirect("index.aspx?openid=" + openid);
                    }
                }
            }
        }
    }
}