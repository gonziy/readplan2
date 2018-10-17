using System;
using System.Data;
using System.Collections.Generic;
using DTcms.Common;
using DTcms.Model;

namespace DTcms.BLL
{
    public partial class UserReadLog
    {
        private readonly Model.siteconfig siteConfig = new BLL.siteconfig().loadConfig(); //获得站点配置信息
        private readonly DAL.UserReadLog dal;
        public UserReadLog()
        {
            dal = new DAL.UserReadLog(siteConfig.sysdatabaseprefix);
        }
        public int Add(Model.UserReadLog model)
        {
            return dal.Add(model);
        }
        public int Update(Model.UserReadLog model, string where)
        {
            return dal.Update(model, where);
        }
        public Model.UserReadLog Get(string where)
        {
            return dal.Get(where);
        }
        public List<Model.UserReadLog> List(string where)
        {
            return dal.List(where);
        }

        public int Count(string where)
        {
            return dal.Count(where);
        }
        public List<Model.UserReadLog> List(int pageSize, int pageIndex, string where, string filedOrder, out int recordCount)
        {
            return dal.List(pageSize, pageIndex, where, filedOrder, out recordCount);
        }
        public int UpdateField(int id, string strValue)
        {
            return dal.UpdateField(id, strValue);
        }
        public List<ArticleCategory> ReadCategory(int user_id)
        {
            return dal.ReadCategory(user_id);
        }
        public int CategoryComposeCount(int user_id, int category_id)
        {
            return dal.CategoryComposeCount(user_id, category_id);
        }
        public int ArticleCompose(int user_id, int article)
        {
            return dal.ArticleCompose(user_id, article);
        }

    }
}