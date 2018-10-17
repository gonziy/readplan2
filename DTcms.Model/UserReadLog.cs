using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace DTcms.Model
{
    /// <summary>
    /// 读书计划
    /// </summary>
    public class UserReadLog
    {
        public int? id { get; set; }
        /// <summary>
        /// 0整本 1分章 
        /// </summary>
        public int? read_type { get; set; }
        public int? category_id { get; set; }
        public int? article_id { get; set; }
        public int? user_id { get; set; }
        public int? read_date{ get; set; }
        /// <summary>
        /// 已读次数
        /// </summary>
        public int? read_count { get; set; }
        /// <summary>
        /// 计划次数
        /// </summary>
        public int? plan_read_count { get; set; }
        /// <summary>
        /// 合成的次数
        /// </summary>
        public int? compose_count { get; set; }
        public DateTime? add_time { get; set; }
    }
}
