using System;
using System.Data;
using System.Text;
using System.Collections.Generic;
using System.Data.SqlClient;
using DTcms.DBUtility;
using DTcms.Common;

namespace DTcms.DAL
{
    public partial class UserPay
    {
        private string databaseprefix; //数据库表名前缀
        public UserPay(string _databaseprefix)
        {
            databaseprefix = _databaseprefix;
        }

        public int Add(Model.UserPay model)
        {
            int id = 0;
            return DbHelperSQL.Insert(databaseprefix + "user_pay", model, out id);
        }
        public int Update(Model.UserPay model,string where)
        {
            return DbHelperSQL.Update<Model.UserPay>(databaseprefix + "user_pay", model, "id", where);
        }
        public Model.UserPay Get(string where)
        {
            return DbHelperSQL.Entity<Model.UserPay>("select * from " + databaseprefix + "user_pay where id > '0' " + (string.IsNullOrEmpty(where) ? "" : " and " + where));
        }
        public int UpdateField(int id, string strValue)
        {
            StringBuilder strSql = new StringBuilder();
            strSql.Append("update " + databaseprefix + "user_pay set " + strValue);
            strSql.Append(" where id=" + id);
            return DbHelperSQL.ExecuteSql(strSql.ToString());
        }

    }
}