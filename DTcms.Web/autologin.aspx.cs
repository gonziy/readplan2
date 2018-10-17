using DTcms.Common;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace DTcms.Web
{
    public partial class autologin : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            string username = Common.DTRequest.GetQueryString("username");
            BLL.users bll = new BLL.users();
            if (bll.Exists(username))
            {
                Model.users model = bll.GetModel(username);
                HttpContext.Current.Session[DTKeys.SESSION_USER_INFO] = model;
                Session.Timeout = 45;
                Response.Redirect("usercenter.aspx?action=index");
            }
        }
    }
}