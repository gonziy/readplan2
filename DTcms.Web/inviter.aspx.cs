using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace DTcms.Web
{
    public partial class inviter : System.Web.UI.Page
    {
        protected int inviter_id = 0;
        protected void Page_Load(object sender, EventArgs e)
        {
            inviter_id = DTcms.Common.DTRequest.GetQueryInt("from");
            if (inviter_id > 0)
            {
                Common.Utils.WriteCookie("inviter", inviter_id.ToString());
                if (!string.IsNullOrEmpty(Common.Utils.GetCookie("inviter")))
                {
                    Response.Redirect("wx_login.aspx");
                }
            }
        }
    }
}