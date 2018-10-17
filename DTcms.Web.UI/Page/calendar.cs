using DTcms.Common;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace DTcms.Web.UI.Page
{
    public partial class calendar : Web.UI.UserPage
    {

        protected string day = "";
        protected string month = "";
        protected string date = "";
        protected string pre1_year_month = "";
        protected string pre2_year_month = "";
        protected string aft1_year_month = "";
        protected string aft2_year_month = "";
        protected int year = 0;
        protected List<Model.UserReadLog> list = new List<Model.UserReadLog>();
        protected List<string> daysInMonth = new List<string>();

        /// <summary>
        /// 重写虚方法,此方法将在Init事件前执行
        /// </summary>
        protected override void InitPage()
        {
            day = DTRequest.GetQueryString("day");
            if (string.IsNullOrEmpty(day))
            {
                day = DateTime.Now.ToString("yyyyMMdd");
            }
            pre1_year_month = TypeConverter.ObjectToDateTime(day.Substring(0,4) +"/" + day.Substring(4, 2) +"/"+ day.Substring(6, 2)).AddMonths(-1).ToString("yyyyMM");
            pre2_year_month = TypeConverter.ObjectToDateTime(day.Substring(0, 4) + "/" + day.Substring(4, 2) + "/" + day.Substring(6, 2)).AddMonths(-2).ToString("yyyyMM");
            aft1_year_month = TypeConverter.ObjectToDateTime(day.Substring(0, 4) + "/" + day.Substring(4, 2) + "/" + day.Substring(6, 2)).AddMonths(1).ToString("yyyyMM");
            aft2_year_month = TypeConverter.ObjectToDateTime(day.Substring(0, 4) + "/" + day.Substring(4, 2) + "/" + day.Substring(6, 2)).AddMonths(2).ToString("yyyyMM");
            BLL.UserReadLog userReadLog = new BLL.UserReadLog();
            list = new List<Model.UserReadLog>();
            list.AddRange(userReadLog.List("[user_id]='"+ GetUserInfo().id +"' and [read_date] ='" + day + "'"));
            year = int.Parse(day.ToString().Substring(0, 4));
            month = day.ToString().Substring(4, 2);
            date = day.ToString().Substring(6, 2);
            for (int d = 1; d <= DateTime.DaysInMonth(year, int.Parse(month)); d++)
            {
                daysInMonth.Add(d < 10 ? ("0" + d.ToString()) : d.ToString());
            }
            
        }
    }
}
