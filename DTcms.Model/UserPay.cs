using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace DTcms.Model
{
    public class UserPay
    {
        public string id { get; set; }

        public string openid { get; set; }
        public decimal? amount { get; set; }

        public DateTime? add_time { get; set; }

        /// <summary>
        /// 0未付款  1已支付
        /// </summary>
        public int? status { get; set; }
        /// <summary>
        /// 邀请人
        /// </summary>
        public int? inviter_id { get; set; }
    }
}
