using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace DTcms.Model
{
    /// <summary>
    /// 合成
    /// </summary>
    public class ComposeList
    {
        /// <summary>
        /// 书ID
        /// </summary>
        public int category_id { get; set; }

        public string category_title { get; set; }

        /// <summary>
        /// 可合成遍数
        /// </summary>
        public int count { get; set; }
    }
    public class ReadArticleList
    {
        /// <summary>
        /// 书ID
        /// </summary>
        public int article_id { get; set; }

        /// <summary>
        /// 可合成遍数
        /// </summary>
        public int count { get; set; }
    }
    public class ArticleCategory
    {
        public int category_id { get; set; }
        
    }
}
