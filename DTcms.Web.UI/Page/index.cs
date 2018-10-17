using System;
using System.Collections.Generic;
using System.Text;

namespace DTcms.Web.UI.Page
{
    public partial class index : Web.UI.BasePage
    {
        public string InviterName = "";
        protected void Page_Load(object sender, EventArgs e)
        {
            DTcms.Model.UserPay userPay = new DTcms.Model.UserPay();
            userPay.add_time = DateTime.Now;
            userPay.amount = 9.28M;
            userPay.id = DateTime.Now.ToString("yyyyMMddHHmmssfff");
            userPay.openid = "";
            userPay.status = 0;
            new DTcms.BLL.UserPay().Add(userPay);

            if (!string.IsNullOrEmpty(DTcms.Common.Utils.GetCookie("inviter")))
            {
                Model.users user = new BLL.users().GetModel(int.Parse(DTcms.Common.Utils.GetCookie("inviter")));
                if (user != null)
                {

                    InviterName = user.nick_name;
                }
            }
        }
    }

}
