using DTcms.Web.UI;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace DTcms.Web
{
    public partial class wx_login : WXBasePage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            Response.Redirect(GetCodeUrl(appId, Server.UrlEncode("http://www.yuedujing.com/wx_init.aspx")));
        }
        public string GetCodeUrl(string Appid, string redirect_uri)
        {
            return string.Format("https://open.weixin.qq.com/connect/oauth2/authorize?appid={0}&redirect_uri={1}&response_type=code&scope=snsapi_base&state=STATE#wechat_redirect", Appid, redirect_uri);
        }
    }
}