using System;
using System.Data;
using System.Collections.Generic;
using DTcms.Common;

namespace DTcms.BLL
{
    public partial class UserReadBook
    {
        private readonly Model.siteconfig siteConfig = new BLL.siteconfig().loadConfig(); //获得站点配置信息
        private readonly DAL.UserReadBook dal;
        public UserReadBook()
        {
            dal = new DAL.UserReadBook(siteConfig.sysdatabaseprefix);
        }
        public int Add(Model.UserReadBook model)
        {
            return dal.Add(model);
        }
        public int Update(Model.UserReadBook model, string where)
        {
            return dal.Update(model, where);
        }
        public Model.UserReadBook Get(string where)
        {
            return dal.Get(where);
        }

        public List<Model.UserReadBook> List(string where)
        {
            return dal.List(where);
        }
        public int UpdateField(int id, string strValue)
        {
            return dal.UpdateField(id, strValue);
        }

    }
}