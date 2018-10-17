using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace DTcms.Web.UI
{
    public class WXBasePage : System.Web.UI.Page
    {
        public static string appId = "wx8d4e7949440b3187";
        public static string appSecret = "ff40ff5ebf56bd815c5842ec43fc1d06";

        public string accessToken = "";
        public DateTime tokenTime;
    }
}
