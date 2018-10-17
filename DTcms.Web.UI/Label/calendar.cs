using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace DTcms.Web.UI
{
    public partial class BasePage : System.Web.UI.Page
    {
        protected string GetArticleTitle(int? article_id)
        {
            Model.article article = new BLL.article().GetModel(DTcms.Common.TypeConverter.ObjectToInt(article_id));
            Model.article_category category = new BLL.article_category().GetModel(article.category_id);
            return "《" + category.title + "》" + article.title;
        }
        protected string GetCategoryTitle(int? category_id)
        {
            Model.article_category category = new BLL.article_category().GetModel(DTcms.Common.TypeConverter.ObjectToInt(category_id));
            return "《" + category.title + "》";
        }

        protected bool CompletePlan(string user_id, string day)
        {
            
            BLL.UserReadLog userReadLog = new BLL.UserReadLog();
            List<Model.UserReadLog> list = userReadLog.List("[user_id]='" + user_id + "' and [read_date]='" + day + "' and [read_count] < [plan_read_count]");
            if (list == null)
            {
                return true;
            }
            if (list.Count == 0)
            {
                return true;
            }
            return false;
        }
    }
}
