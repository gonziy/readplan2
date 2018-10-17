using DTcms.Web.UI;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace DTcms.Web
{
    public partial class wx_share_login : WXBasePage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            string turl = DTcms.Common.DTRequest.GetString("turl");
            int inviter_id = DTcms.Common.DTRequest.GetQueryInt("inviterfrom");

            if (!string.IsNullOrEmpty(turl))
            {
                Common.Utils.WriteCookie(Common.DTKeys.COOKIE_URL_REFERRER, turl);
            }
            if (inviter_id > 0)
            {
                BLL.users userBll = new BLL.users();
                if (userBll.Exists(inviter_id))
                {
                    Model.users userModel = userBll.GetModel(inviter_id);
                    if (userModel.inviter_id>0)
                    {
                        Common.Utils.WriteCookie("inviter", inviter_id.ToString());
                    }
                }
            }
            Response.Write("inviter:" + Common.Utils.GetCookie("inviter"));
            Response.Write("<br />turl:" + Common.Utils.GetCookie(Common.DTKeys.COOKIE_URL_REFERRER));

            Response.Redirect(GetCodeUrl(appId, Server.UrlEncode("http://www.yuedujing.com/wx_share_init.aspx")));
        }
        public string GetCodeUrl(string Appid, string redirect_uri)
        {
            return string.Format("https://open.weixin.qq.com/connect/oauth2/authorize?appid={0}&redirect_uri={1}&response_type=code&scope=snsapi_userinfo&state=STATE#wechat_redirect", Appid, redirect_uri);
        }
    }

}