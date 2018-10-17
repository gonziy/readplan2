using System;
using System.Collections;
using System.Collections.Specialized;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;
using System.Data.Common;
using System.Collections.Generic;
using DTcms.Common;
using DTcms.Common.Generic;
using System.Reflection;

namespace DTcms.DBUtility
{
    public abstract class DbHelperSQL
    {	
        public static string connectionString = null;

        public DbHelperSQL()
        {
        }

        static DbHelperSQL()
        {
            string en = ConfigurationManager.AppSettings["Encrypt"]==null?"": ConfigurationManager.AppSettings["Encrypt"].ToString();
            connectionString = ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString;
            if (string.Equals(en, "true"))
            {
                connectionString = DESEncrypt.Decrypt(connectionString);
            }
        }

        #region 公用方法
        /// <summary>
        /// 判断是否存在某表的某个字段
        /// </summary>
        /// <param name="tableName">表名称</param>
        /// <param name="columnName">列名称</param>
        /// <returns>是否存在</returns>
        public static bool ColumnExists(string tableName, string columnName)
        {
            string sql = "select count(1) from syscolumns where [id]=object_id('" + tableName + "') and [name]='" + columnName + "'";
            object res = GetSingle(sql);
            if (res == null)
            {
                return false;
            }
            return Convert.ToInt32(res) > 0;
        }
        public static int GetMinID(string FieldName, string TableName)
        {
            string strsql = "select min(" + FieldName + ") from " + TableName;
            object obj = DbHelperSQL.GetSingle(strsql);
            if (obj == null)
            {
                return 0;
            }
            else
            {
                return int.Parse(obj.ToString());
            }
        }
        public static int GetMaxID(string FieldName, string TableName)
        {
            string strsql = "select max(" + FieldName + ")+1 from " + TableName;
            object obj = DbHelperSQL.GetSingle(strsql);
            if (obj == null)
            {
                return 1;
            }
            else
            {
                return int.Parse(obj.ToString());
            }
        }
        public static bool Exists(string strSql)
        {
            object obj = DbHelperSQL.GetSingle(strSql);
            int cmdresult;
            if ((Object.Equals(obj, null)) || (Object.Equals(obj, System.DBNull.Value)))
            {
                cmdresult = 0;
            }
            else
            {
                cmdresult = int.Parse(obj.ToString());
            }
            if (cmdresult == 0)
            {
                return false;
            }
            else
            {
                return true;
            }
        }
        /// <summary>
        /// 表是否存在
        /// </summary>
        /// <param name="TableName"></param>
        /// <returns></returns>
        public static bool TabExists(string TableName)
        {
            string strsql = "select count(*) from sysobjects where id = object_id(N'[" + TableName + "]') and OBJECTPROPERTY(id, N'IsUserTable') = 1";
            //string strsql = "SELECT count(*) FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[" + TableName + "]') AND type in (N'U')";
            object obj = DbHelperSQL.GetSingle(strsql);
            int cmdresult;
            if ((Object.Equals(obj, null)) || (Object.Equals(obj, System.DBNull.Value)))
            {
                cmdresult = 0;
            }
            else
            {
                cmdresult = int.Parse(obj.ToString());
            }
            if (cmdresult == 0)
            {
                return false;
            }
            else
            {
                return true;
            }
        }
        public static bool Exists(string strSql, params SqlParameter[] cmdParms)
        {
            object obj = DbHelperSQL.GetSingle(strSql, cmdParms);
            int cmdresult;
            if ((Object.Equals(obj, null)) || (Object.Equals(obj, System.DBNull.Value)))
            {
                cmdresult = 0;
            }
            else
            {
                cmdresult = int.Parse(obj.ToString());
            }
            if (cmdresult == 0)
            {
                return false;
            }
            else
            {
                return true;
            }
        }
        #endregion

        #region  执行简单SQL语句

        /// <summary>
        /// 执行SQL语句，返回影响的记录数
        /// </summary>
        /// <param name="SQLString">SQL语句</param>
        /// <returns>影响的记录数</returns>
        public static int ExecuteSql(string SQLString)
        {
            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                using (SqlCommand cmd = new SqlCommand(SQLString, connection))
                {
                    try
                    {
                        connection.Open();
                        int rows = cmd.ExecuteNonQuery();
                        LogHelper.WriteDebugLog("[result:" + rows + "]" + SQLString);
                        return rows;
                    }
                    catch (System.Data.SqlClient.SqlException e)
                    {
                        connection.Close();
                        throw e;
                    }
                    finally
                    {
                        cmd.Dispose();
                        connection.Close();
                    }
                }
            }
        }

        /// <summary>
        /// 2012-2-21新增重载，执行SQL语句，返回影响的记录数
        /// </summary>
        /// <param name="connection">SqlConnection对象</param>
        /// <param name="trans">SqlTransaction事件</param>
        /// <param name="SQLString">SQL语句</param>
        /// <returns>影响的记录数</returns>
        public static int ExecuteSql(SqlConnection connection, SqlTransaction trans, string SQLString)
        {
            using (SqlCommand cmd = new SqlCommand(SQLString, connection))
            {
                try
                {
                    cmd.Connection = connection;
                    cmd.Transaction = trans;
                    int rows = cmd.ExecuteNonQuery();
                    LogHelper.WriteDebugLog("[result:" + rows + "]" + SQLString);
                    return rows;
                }
                catch (System.Data.SqlClient.SqlException e)
                {
                    //trans.Rollback();
                    throw e;
                }
                finally
                {
                    cmd.Dispose();
                }
            }
        }

        public static int ExecuteSqlByTime(string SQLString, int Times)
        {
            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                using (SqlCommand cmd = new SqlCommand(SQLString, connection))
                {
                    try
                    {
                        connection.Open();
                        cmd.CommandTimeout = Times;
                        int rows = cmd.ExecuteNonQuery();
                        LogHelper.WriteDebugLog("[result:" + rows + "]" + SQLString);
                        return rows;
                    }
                    catch (System.Data.SqlClient.SqlException e)
                    {
                        connection.Close();
                        throw e;
                    }
                    finally
                    {
                        cmd.Dispose();
                        connection.Close();
                    }
                }
            }
        }

        /// <summary>
        /// 执行Sql和Oracle滴混合事务
        /// </summary>
        /// <param name="list">SQL命令行列表</param>
        /// <param name="oracleCmdSqlList">Oracle命令行列表</param>
        /// <returns>执行结果 0-由于SQL造成事务失败 -1 由于Oracle造成事务失败 1-整体事务执行成功</returns>
        public static int ExecuteSqlTran(List<CommandInfo> list, List<CommandInfo> oracleCmdSqlList)
        {
            using (SqlConnection conn = new SqlConnection(connectionString))
            {
                conn.Open();
                SqlCommand cmd = new SqlCommand();
                cmd.Connection = conn;
                SqlTransaction tx = conn.BeginTransaction();
                cmd.Transaction = tx;
                try
                {
                    foreach (CommandInfo myDE in list)
                    {
                        string cmdText = myDE.CommandText;
                        SqlParameter[] cmdParms = (SqlParameter[])myDE.Parameters;
                        PrepareCommand(cmd, conn, tx, cmdText, cmdParms);
                        if (myDE.EffentNextType == EffentNextType.SolicitationEvent)
                        {
                            if (myDE.CommandText.ToLower().IndexOf("count(") == -1)
                            {
                                tx.Rollback();
                                throw new Exception("违背要求" + myDE.CommandText + "必须符合select count(..的格式");
                                //return 0;
                            }

                            object obj = cmd.ExecuteScalar();
                            bool isHave = false;
                            if (obj == null && obj == DBNull.Value)
                            {
                                isHave = false;
                            }
                            isHave = Convert.ToInt32(obj) > 0;
                            if (isHave)
                            {
                                //引发事件
                                myDE.OnSolicitationEvent();
                            }
                        }
                        if (myDE.EffentNextType == EffentNextType.WhenHaveContine || myDE.EffentNextType == EffentNextType.WhenNoHaveContine)
                        {
                            if (myDE.CommandText.ToLower().IndexOf("count(") == -1)
                            {
                                tx.Rollback();
                                throw new Exception("SQL:违背要求" + myDE.CommandText + "必须符合select count(..的格式");
                                //return 0;
                            }

                            object obj = cmd.ExecuteScalar();
                            bool isHave = false;
                            if (obj == null && obj == DBNull.Value)
                            {
                                isHave = false;
                            }
                            isHave = Convert.ToInt32(obj) > 0;

                            if (myDE.EffentNextType == EffentNextType.WhenHaveContine && !isHave)
                            {
                                tx.Rollback();
                                throw new Exception("SQL:违背要求" + myDE.CommandText + "返回值必须大于0");
                                //return 0;
                            }
                            if (myDE.EffentNextType == EffentNextType.WhenNoHaveContine && isHave)
                            {
                                tx.Rollback();
                                throw new Exception("SQL:违背要求" + myDE.CommandText + "返回值必须等于0");
                                //return 0;
                            }
                            continue;
                        }
                        int val = cmd.ExecuteNonQuery();
                        if (myDE.EffentNextType == EffentNextType.ExcuteEffectRows && val == 0)
                        {
                            tx.Rollback();
                            throw new Exception("SQL:违背要求" + myDE.CommandText + "必须有影响行");
                            //return 0;
                        }
                        cmd.Parameters.Clear();
                    }
                    //string oraConnectionString = PubConstant.GetConnectionString("ConnectionStringPPC");
                    //bool res = OracleHelper.ExecuteSqlTran(oraConnectionString, oracleCmdSqlList);
                    //if (!res)
                    //{
                    //    tx.Rollback();
                    //    throw new Exception("Oracle执行失败");
                    // return -1;
                    //}
                    tx.Commit();
                    return 1;
                }
                catch (System.Data.SqlClient.SqlException e)
                {
                    tx.Rollback();
                    throw e;
                }
                catch (Exception e)
                {
                    tx.Rollback();
                    throw e;
                }
                finally
                {
                    cmd.Dispose();
                    conn.Close();
                }
            }
        }
        /// <summary>
        /// 执行多条SQL语句，实现数据库事务。
        /// </summary>
        /// <param name="SQLStringList">多条SQL语句</param>		
        public static int ExecuteSqlTran(List<String> SQLStringList)
        {
            using (SqlConnection conn = new SqlConnection(connectionString))
            {
                conn.Open();
                SqlCommand cmd = new SqlCommand();
                cmd.Connection = conn;
                SqlTransaction tx = conn.BeginTransaction();
                cmd.Transaction = tx;
                try
                {
                    int count = 0;
                    for (int n = 0; n < SQLStringList.Count; n++)
                    {
                        string strsql = SQLStringList[n];
                        if (strsql.Trim().Length > 1)
                        {
                            cmd.CommandText = strsql;
                            count += cmd.ExecuteNonQuery();

                            LogHelper.WriteDebugLog("[result:" + count + "]" + strsql);
                        }
                    }
                    tx.Commit();

                    LogHelper.WriteDebugLog("[result:" + count + "]sqllist commit");
                    return count;
                }
                catch
                {
                    tx.Rollback();
                    return 0;
                }
                finally
                {
                    cmd.Dispose();
                    conn.Close();
                }
            }
        }
        /// <summary>
        /// 执行带一个存储过程参数的的SQL语句。
        /// </summary>
        /// <param name="SQLString">SQL语句</param>
        /// <param name="content">参数内容,比如一个字段是格式复杂的文章，有特殊符号，可以通过这个方式添加</param>
        /// <returns>影响的记录数</returns>
        public static int ExecuteSql(string SQLString, string content)
        {
            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                SqlCommand cmd = new SqlCommand(SQLString, connection);
                System.Data.SqlClient.SqlParameter myParameter = new System.Data.SqlClient.SqlParameter("@content", SqlDbType.NText);
                myParameter.Value = content;
                cmd.Parameters.Add(myParameter);
                try
                {
                    connection.Open();
                    int rows = cmd.ExecuteNonQuery();
                    LogHelper.WriteDebugLog("[result:" + rows + "]" + SQLString + "(" + content + ")");
                    return rows;
                }
                catch (System.Data.SqlClient.SqlException e)
                {
                    throw e;
                }
                finally
                {
                    cmd.Dispose();
                    connection.Close();
                }
            }
        }
        /// <summary>
        /// 执行带一个存储过程参数的的SQL语句。
        /// </summary>
        /// <param name="SQLString">SQL语句</param>
        /// <param name="content">参数内容,比如一个字段是格式复杂的文章，有特殊符号，可以通过这个方式添加</param>
        /// <returns>影响的记录数</returns>
        public static object ExecuteSqlGet(string SQLString, string content)
        {
            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                SqlCommand cmd = new SqlCommand(SQLString, connection);
                System.Data.SqlClient.SqlParameter myParameter = new System.Data.SqlClient.SqlParameter("@content", SqlDbType.NText);
                myParameter.Value = content;
                cmd.Parameters.Add(myParameter);
                try
                {
                    connection.Open();
                    object obj = cmd.ExecuteScalar();
                    if ((Object.Equals(obj, null)) || (Object.Equals(obj, System.DBNull.Value)))
                    {
                        return null;
                    }
                    else
                    {
                        return obj;
                    }
                }
                catch (System.Data.SqlClient.SqlException e)
                {
                    throw e;
                }
                finally
                {
                    cmd.Dispose();
                    connection.Close();
                }
            }
        }
        /// <summary>
        /// 向数据库里插入图像格式的字段(和上面情况类似的另一种实例)
        /// </summary>
        /// <param name="strSQL">SQL语句</param>
        /// <param name="fs">图像字节,数据库的字段类型为image的情况</param>
        /// <returns>影响的记录数</returns>
        public static int ExecuteSqlInsertImg(string strSQL, byte[] fs)
        {
            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                SqlCommand cmd = new SqlCommand(strSQL, connection);
                System.Data.SqlClient.SqlParameter myParameter = new System.Data.SqlClient.SqlParameter("@fs", SqlDbType.Image);
                myParameter.Value = fs;
                cmd.Parameters.Add(myParameter);
                try
                {
                    connection.Open();
                    int rows = cmd.ExecuteNonQuery();
                    return rows;
                }
                catch (System.Data.SqlClient.SqlException e)
                {
                    throw e;
                }
                finally
                {
                    cmd.Dispose();
                    connection.Close();
                }
            }
        }

        /// <summary>
        /// 执行一条计算查询结果语句，返回查询结果（object）。
        /// </summary>
        /// <param name="SQLString">计算查询结果语句</param>
        /// <returns>查询结果（object）</returns>
        public static object GetSingle(string SQLString)
        {
            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                using (SqlCommand cmd = new SqlCommand(SQLString, connection))
                {
                    try
                    {
                        connection.Open();
                        object obj = cmd.ExecuteScalar();
                        if ((Object.Equals(obj, null)) || (Object.Equals(obj, System.DBNull.Value)))
                        {
                            LogHelper.WriteDebugLog("[result:null]" + SQLString);
                            return null;
                        }
                        else
                        {
                            LogHelper.WriteDebugLog("[result:" + obj.ToString() + "]" + SQLString);
                            return obj;
                        }
                    }
                    catch (System.Data.SqlClient.SqlException e)
                    {
                        connection.Close();
                        throw e;
                    }
                    finally
                    {
                        cmd.Dispose();
                        connection.Close();
                    }
                }
            }
        }
        public static object GetSingle(string SQLString, int Times)
        {
            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                using (SqlCommand cmd = new SqlCommand(SQLString, connection))
                {
                    try
                    {
                        connection.Open();
                        cmd.CommandTimeout = Times;
                        object obj = cmd.ExecuteScalar();
                        if ((Object.Equals(obj, null)) || (Object.Equals(obj, System.DBNull.Value)))
                        {
                            LogHelper.WriteDebugLog("[result:null]" + SQLString);
                            return null;
                        }
                        else
                        {
                            LogHelper.WriteDebugLog("[result:" + obj.ToString() + "]" + SQLString);
                            return obj;
                        }
                    }
                    catch (System.Data.SqlClient.SqlException e)
                    {
                        connection.Close();
                        throw e;
                    }
                    finally
                    {
                        cmd.Dispose();
                        connection.Close();
                    }
                }
            }
        }
        /// <summary>
        /// 执行查询语句，返回SqlDataReader ( 注意：调用该方法后，一定要对SqlDataReader进行Close )
        /// </summary>
        /// <param name="strSQL">查询语句</param>
        /// <returns>SqlDataReader</returns>
        public static SqlDataReader ExecuteReader(string strSQL)
        {
            SqlConnection connection = new SqlConnection(connectionString);
            SqlCommand cmd = new SqlCommand(strSQL, connection);
            try
            {
                connection.Open();
                SqlDataReader myReader = cmd.ExecuteReader(CommandBehavior.CloseConnection);
                return myReader;
            }
            catch (System.Data.SqlClient.SqlException e)
            {
                throw e;
            }

        }
        /// <summary>
        /// 执行查询语句，返回DataSet
        /// </summary>
        /// <param name="SQLString">查询语句</param>
        /// <returns>DataSet</returns>
        public static DataSet Query(string SQLString)
        {

            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                DataSet ds = new DataSet();
                try
                {
                    connection.Open();
                    SqlDataAdapter command = new SqlDataAdapter(SQLString, connection);
                    command.Fill(ds, "ds");
                    command.Dispose();
                }
                catch (System.Data.SqlClient.SqlException ex)
                {
                    throw new Exception(ex.Message);
                }
                finally
                {
                    connection.Close();
                }
                return ds;
            }

        }
        public static DataSet Query(string SQLString, int Times)
        {
            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                DataSet ds = new DataSet();
                try
                {
                    connection.Open();
                    SqlDataAdapter command = new SqlDataAdapter(SQLString, connection);
                    command.SelectCommand.CommandTimeout = Times;
                    command.Fill(ds, "ds");
                    command.Dispose();
                }
                catch (System.Data.SqlClient.SqlException ex)
                {
                    throw new Exception(ex.Message);
                }
                finally
                {
                    connection.Close();
                }
                return ds;
            }
        }

        /// <summary>
        /// 2012-2-21新增重载，执行查询语句，返回DataSet
        /// </summary>
        /// <param name="connection">SqlConnection对象</param>
        /// <param name="trans">SqlTransaction事务</param>
        /// <param name="SQLString">SQL语句</param>
        /// <returns>DataSet</returns>
        public static DataSet Query(SqlConnection connection, SqlTransaction trans, string SQLString)
        {
            DataSet ds = new DataSet();
            try
            {
                SqlDataAdapter command = new SqlDataAdapter(SQLString, connection);
                command.SelectCommand.Transaction = trans;
                command.Fill(ds, "ds");
                command.Dispose();  //2016-07-11
            }
            catch (System.Data.SqlClient.SqlException ex)
            {
                throw new Exception(ex.Message);
            }
            return ds;

        }
        #endregion

        #region 执行带参数的SQL语句

        /// <summary>
        /// 执行SQL语句，返回影响的记录数
        /// </summary>
        /// <param name="SQLString">SQL语句</param>
        /// <returns>影响的记录数</returns>
        public static int ExecuteSql(string SQLString, params SqlParameter[] cmdParms)
        {
            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                using (SqlCommand cmd = new SqlCommand())
                {
                    try
                    {
                        PrepareCommand(cmd, connection, null, SQLString, cmdParms);
                        int rows = cmd.ExecuteNonQuery();
                        cmd.Parameters.Clear();
                        LogHelper.WriteDebugLog("[result:" + rows + "]" + SQLString + "(" + ParamsToString(cmdParms) + ")");
                        return rows;
                    }
                    catch (System.Data.SqlClient.SqlException e)
                    {
                        throw e;
                    }
                    finally  //2016-07-11
                    {
                        cmd.Dispose();
                        connection.Close();
                    }
                }
            }
        }

        public static int ExecuteSql(string SQLString, List<SqlParameter> cmdParms)
        {
            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                using (SqlCommand cmd = new SqlCommand())
                {
                    try
                    {
                        PrepareCommand(cmd, connection, null, SQLString, cmdParms);
                        int rows = cmd.ExecuteNonQuery();
                        LogHelper.WriteDebugLog("[result:" + rows + "]" + SQLString + "(" + ParamsToString(cmdParms) + ")");
                        cmd.Parameters.Clear();
                        return rows;
                    }
                    catch (System.Data.SqlClient.SqlException e)
                    {
                        throw e;
                    }
                    finally  //2016-07-11
                    {
                        cmd.Dispose();
                        connection.Close();
                    }
                }
            }
        }

        /// <summary>
        /// 2012-2-29新增重载，执行SQL语句，返回影响的记录数
        /// </summary>
        /// <param name="connection">SqlConnection对象</param>
        /// <param name="trans">SqlTransaction对象</param>
        /// <param name="SQLString">SQL语句</param>
        /// <returns>影响的记录数</returns>
        public static int ExecuteSql(SqlConnection connection, SqlTransaction trans, string SQLString, params SqlParameter[] cmdParms)
        {
            using (SqlCommand cmd = new SqlCommand())
            {
                try
                {
                    PrepareCommand(cmd, connection, trans, SQLString, cmdParms);
                    int rows = cmd.ExecuteNonQuery();
                    cmd.Parameters.Clear();
                    LogHelper.WriteDebugLog("[result:" + rows + "]" + SQLString + "(" + ParamsToString(cmdParms) + ")");
                    return rows;
                }
                catch (System.Data.SqlClient.SqlException e)
                {
                    //trans.Rollback();
                    throw e;
                }
                finally  //2016-07-11
                {
                    cmd.Dispose();
                }
            }
        }
        public static int ExecuteSql(SqlConnection connection, SqlTransaction trans, string SQLString, List<SqlParameter> cmdParms)
        {
            using (SqlCommand cmd = new SqlCommand())
            {
                try
                {
                    PrepareCommand(cmd, connection, trans, SQLString, cmdParms);
                    int rows = cmd.ExecuteNonQuery();
                    LogHelper.WriteDebugLog("[result:" + rows + "]" + SQLString + "(" + ParamsToString(cmdParms) + ")");
                    cmd.Parameters.Clear();
                    return rows;
                }
                catch (System.Data.SqlClient.SqlException e)
                {
                    //trans.Rollback();
                    throw e;
                }
                finally  //2016-07-11
                {
                    cmd.Dispose();
                }
            }
        }

        /// <summary>
        /// 执行多条SQL语句，实现数据库事务。
        /// </summary>
        /// <param name="SQLStringList">SQL语句的哈希表（key为sql语句，value是该语句的SqlParameter[]）</param>
        public static void ExecuteSqlTran(Hashtable SQLStringList)
        {
            using (SqlConnection conn = new SqlConnection(connectionString))
            {
                conn.Open();
                using (SqlTransaction trans = conn.BeginTransaction())
                {
                    SqlCommand cmd = new SqlCommand();
                    try
                    {
                        //循环
                        foreach (DictionaryEntry myDE in SQLStringList)
                        {
                            string cmdText = myDE.Key.ToString();
                            SqlParameter[] cmdParms = (SqlParameter[])myDE.Value;
                            PrepareCommand(cmd, conn, trans, cmdText, cmdParms);
                            int val = cmd.ExecuteNonQuery();
                            cmd.Parameters.Clear();
                        }
                        trans.Commit();
                    }
                    catch
                    {
                        trans.Rollback();
                        throw;
                    }
                    finally  //2016-07-11
                    {
                        cmd.Dispose();
                        conn.Close();
                    }
                }
            }
        }
        /// <summary>
        /// 执行多条SQL语句，实现数据库事务。
        /// </summary>
        /// <param name="SQLStringList">SQL语句的哈希表（key为sql语句，value是该语句的SqlParameter[]）</param>
        public static int ExecuteSqlTran(System.Collections.Generic.List<CommandInfo> cmdList)
        {
            using (SqlConnection conn = new SqlConnection(connectionString))
            {
                conn.Open();
                using (SqlTransaction trans = conn.BeginTransaction())
                {
                    SqlCommand cmd = new SqlCommand();
                    try
                    {
                        int count = 0;
                        //循环
                        foreach (CommandInfo myDE in cmdList)
                        {
                            string cmdText = myDE.CommandText;
                            SqlParameter[] cmdParms = (SqlParameter[])myDE.Parameters;
                            PrepareCommand(cmd, conn, trans, cmdText, cmdParms);

                            LogHelper.WriteDebugLog(cmdText + "(" + ParamsToString(cmdParms) + ")");
                            if (myDE.EffentNextType == EffentNextType.WhenHaveContine || myDE.EffentNextType == EffentNextType.WhenNoHaveContine)
                            {
                                if (myDE.CommandText.ToLower().IndexOf("count(") == -1)
                                {
                                    trans.Rollback();
                                    return 0;
                                }

                                object obj = cmd.ExecuteScalar();
                                bool isHave = false;
                                if (obj == null && obj == DBNull.Value)
                                {
                                    isHave = false;
                                }
                                isHave = Convert.ToInt32(obj) > 0;

                                if (myDE.EffentNextType == EffentNextType.WhenHaveContine && !isHave)
                                {
                                    trans.Rollback();
                                    return 0;
                                }
                                if (myDE.EffentNextType == EffentNextType.WhenNoHaveContine && isHave)
                                {
                                    trans.Rollback();
                                    return 0;
                                }
                                continue;
                            }
                            int val = cmd.ExecuteNonQuery();
                            count += val;
                            if (myDE.EffentNextType == EffentNextType.ExcuteEffectRows && val == 0)
                            {
                                trans.Rollback();
                                return 0;
                            }
                            cmd.Parameters.Clear();
                        }
                        trans.Commit();
                        return count;
                    }
                    catch
                    {
                        trans.Rollback();
                        throw;
                    }
                    finally  //2016-07-11
                    {
                        cmd.Dispose();
                        conn.Close();
                    }
                }
            }
        }
        /// <summary>
        /// 执行多条SQL语句，实现数据库事务。
        /// </summary>
        /// <param name="SQLStringList">SQL语句的哈希表（key为sql语句，value是该语句的SqlParameter[]）</param>
        public static void ExecuteSqlTranWithIndentity(System.Collections.Generic.List<CommandInfo> SQLStringList)
        {
            using (SqlConnection conn = new SqlConnection(connectionString))
            {
                conn.Open();
                using (SqlTransaction trans = conn.BeginTransaction())
                {
                    SqlCommand cmd = new SqlCommand();
                    try
                    {
                        int indentity = 0;
                        //循环
                        foreach (CommandInfo myDE in SQLStringList)
                        {
                            string cmdText = myDE.CommandText;
                            SqlParameter[] cmdParms = (SqlParameter[])myDE.Parameters;
                            foreach (SqlParameter q in cmdParms)
                            {
                                if (q.Direction == ParameterDirection.InputOutput)
                                {
                                    q.Value = indentity;
                                }
                            }
                            PrepareCommand(cmd, conn, trans, cmdText, cmdParms);
                            int val = cmd.ExecuteNonQuery();
                            foreach (SqlParameter q in cmdParms)
                            {
                                if (q.Direction == ParameterDirection.Output)
                                {
                                    indentity = Convert.ToInt32(q.Value);
                                }
                            }

                            LogHelper.WriteDebugLog("[result:" + val.ToString() + "]" + cmdText + "(" + ParamsToString(cmdParms) + ")");
                            cmd.Parameters.Clear();
                        }
                        trans.Commit();
                    }
                    catch
                    {
                        trans.Rollback();
                        throw;
                    }
                    finally  //2016-07-11
                    {
                        cmd.Dispose();
                        conn.Close();
                    }
                }
            }
        }
        /// <summary>
        /// 执行多条SQL语句，实现数据库事务。
        /// </summary>
        /// <param name="SQLStringList">SQL语句的哈希表（key为sql语句，value是该语句的SqlParameter[]）</param>
        public static void ExecuteSqlTranWithIndentity(Hashtable SQLStringList)
        {
            using (SqlConnection conn = new SqlConnection(connectionString))
            {
                conn.Open();
                using (SqlTransaction trans = conn.BeginTransaction())
                {
                    SqlCommand cmd = new SqlCommand();
                    try
                    {
                        int indentity = 0;
                        //循环
                        foreach (DictionaryEntry myDE in SQLStringList)
                        {
                            string cmdText = myDE.Key.ToString();
                            SqlParameter[] cmdParms = (SqlParameter[])myDE.Value;
                            foreach (SqlParameter q in cmdParms)
                            {
                                if (q.Direction == ParameterDirection.InputOutput)
                                {
                                    q.Value = indentity;
                                }
                            }
                            PrepareCommand(cmd, conn, trans, cmdText, cmdParms);
                            int val = cmd.ExecuteNonQuery();
                            foreach (SqlParameter q in cmdParms)
                            {
                                if (q.Direction == ParameterDirection.Output)
                                {
                                    indentity = Convert.ToInt32(q.Value);
                                }
                            }
                            cmd.Parameters.Clear();
                        }
                        trans.Commit();
                    }
                    catch
                    {
                        trans.Rollback();
                        throw;
                    }
                    finally  //2016-07-11
                    {
                        cmd.Dispose();
                        conn.Close();
                    }
                }
            }
        }
        /// <summary>
        /// 执行一条计算查询结果语句，返回查询结果（object）。
        /// </summary>
        /// <param name="SQLString">计算查询结果语句</param>
        /// <returns>查询结果（object）</returns>
        public static object GetSingle(string SQLString, params SqlParameter[] cmdParms)
        {
            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                using (SqlCommand cmd = new SqlCommand())
                {
                    try
                    {
                        PrepareCommand(cmd, connection, null, SQLString, cmdParms);
                        object obj = cmd.ExecuteScalar();

                        cmd.Parameters.Clear();
                        if ((Object.Equals(obj, null)) || (Object.Equals(obj, System.DBNull.Value)))
                        {
                            LogHelper.WriteDebugLog("[result:null]" + SQLString + "(" + ParamsToString(cmdParms) + ")");
                            return null;
                        }
                        else
                        {
                            LogHelper.WriteDebugLog("[result:" + obj.ToString() + "]" + SQLString + "(" + ParamsToString(cmdParms) + ")");
                            return obj;
                        }
                    }
                    catch (System.Data.SqlClient.SqlException e)
                    {
                        throw e;
                    }
                    finally  //2016-07-11
                    {
                        cmd.Dispose();
                        connection.Close();
                    }
                }
            }
        }
        public static object GetSingle(string SQLString, List<SqlParameter> cmdParms)
        {
            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                using (SqlCommand cmd = new SqlCommand())
                {
                    try
                    {
                        PrepareCommand(cmd, connection, null, SQLString, cmdParms);
                        object obj = cmd.ExecuteScalar();

                        cmd.Parameters.Clear();
                        if ((Object.Equals(obj, null)) || (Object.Equals(obj, System.DBNull.Value)))
                        {
                            LogHelper.WriteDebugLog("[result:null]" + SQLString + "(" + ParamsToString(cmdParms) + ")");
                            return null;
                        }
                        else
                        {
                            LogHelper.WriteDebugLog("[result:" + obj.ToString() + "]" + SQLString + "(" + ParamsToString(cmdParms) + ")");
                            return obj;
                        }
                    }
                    catch (System.Data.SqlClient.SqlException e)
                    {
                        throw e;
                    }
                    finally  //2016-07-11
                    {
                        cmd.Dispose();
                        connection.Close();
                    }
                }
            }
        }

        /// <summary>
        /// 2012-2-21新增重载，执行一条计算查询结果语句，返回查询结果（object）。
        /// </summary>
        /// <param name="connection">SqlConnection对象</param>
        /// <param name="trans">SqlTransaction事务</param>
        /// <param name="SQLString">计算查询结果语句</param>
        /// <returns>查询结果（object）</returns>
        public static object GetSingle(SqlConnection connection, SqlTransaction trans, string SQLString, params SqlParameter[] cmdParms)
        {
            using (SqlCommand cmd = new SqlCommand())
            {
                try
                {
                    PrepareCommand(cmd, connection, trans, SQLString, cmdParms);
                    object obj = cmd.ExecuteScalar();

                    cmd.Parameters.Clear();
                    if ((Object.Equals(obj, null)) || (Object.Equals(obj, System.DBNull.Value)))
                    {
                        LogHelper.WriteDebugLog("[result:null]" + SQLString + "(" + ParamsToString(cmdParms) + ")");
                        return null;
                    }
                    else
                    {
                        LogHelper.WriteDebugLog("[result:" + obj.ToString() + "]" + SQLString + "(" + ParamsToString(cmdParms) + ")");
                        return obj;
                    }
                }
                catch (System.Data.SqlClient.SqlException e)
                {
                    //trans.Rollback();
                    throw e;
                }
                finally  //2016-07-11
                {
                    cmd.Dispose();
                }
            }
        }
        public static object GetSingle(SqlConnection connection, SqlTransaction trans, string SQLString, List<SqlParameter> cmdParms)
        {
            using (SqlCommand cmd = new SqlCommand())
            {
                try
                {
                    PrepareCommand(cmd, connection, trans, SQLString, cmdParms);
                    object obj = cmd.ExecuteScalar();

                    cmd.Parameters.Clear();
                    if ((Object.Equals(obj, null)) || (Object.Equals(obj, System.DBNull.Value)))
                    {
                        LogHelper.WriteDebugLog("[result:null]" + SQLString + "(" + ParamsToString(cmdParms) + ")");
                        return null;
                    }
                    else
                    {
                        LogHelper.WriteDebugLog("[result:" + obj.ToString() + "]" + SQLString + "(" + ParamsToString(cmdParms) + ")");
                        return obj;
                    }
                }
                catch (System.Data.SqlClient.SqlException e)
                {
                    //trans.Rollback();
                    throw e;
                }
                finally  //2016-07-11
                {
                    cmd.Dispose();
                }
            }
        }

        /// <summary>
        /// 执行查询语句，返回SqlDataReader ( 注意：调用该方法后，一定要对SqlDataReader进行Close )
        /// </summary>
        /// <param name="strSQL">查询语句</param>
        /// <returns>SqlDataReader</returns>
        public static SqlDataReader ExecuteReader(string SQLString, params SqlParameter[] cmdParms)
        {
            SqlConnection connection = new SqlConnection(connectionString);
            SqlCommand cmd = new SqlCommand();
            try
            {
                PrepareCommand(cmd, connection, null, SQLString, cmdParms);
                SqlDataReader myReader = cmd.ExecuteReader(CommandBehavior.CloseConnection);
                cmd.Parameters.Clear();
                return myReader;
            }
            catch (System.Data.SqlClient.SqlException e)
            {
                throw e;
            }
        }
        public static SqlDataReader ExecuteReader(string SQLString, List<SqlParameter> cmdParms)
        {
            SqlConnection connection = new SqlConnection(connectionString);
            SqlCommand cmd = new SqlCommand();
            try
            {
                PrepareCommand(cmd, connection, null, SQLString, cmdParms);
                SqlDataReader myReader = cmd.ExecuteReader(CommandBehavior.CloseConnection);
                cmd.Parameters.Clear();
                return myReader;
            }
            catch (System.Data.SqlClient.SqlException e)
            {
                throw e;
            }
        }

        /// <summary>
        /// 执行查询语句，返回DataSet
        /// </summary>
        /// <param name="SQLString">查询语句</param>
        /// <returns>DataSet</returns>
        public static DataSet Query(string SQLString, params SqlParameter[] cmdParms)
        {
            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                SqlCommand cmd = new SqlCommand();
                PrepareCommand(cmd, connection, null, SQLString, cmdParms);
                using (SqlDataAdapter da = new SqlDataAdapter(cmd))
                {
                    DataSet ds = new DataSet();
                    try
                    {
                        da.Fill(ds, "ds");
                        cmd.Parameters.Clear();
                    }
                    catch (System.Data.SqlClient.SqlException ex)
                    {
                        throw new Exception(ex.Message);
                    }
                    finally  //2016-07-11
                    {
                        da.Dispose();
                        cmd.Dispose();
                        connection.Close();
                    }
                    return ds;
                }
            }
        }

        public static DataSet Query(string SQLString, List<SqlParameter> cmdParms)
        {
            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                SqlCommand cmd = new SqlCommand();
                PrepareCommand(cmd, connection, null, SQLString, cmdParms);
                using (SqlDataAdapter da = new SqlDataAdapter(cmd))
                {
                    DataSet ds = new DataSet();
                    try
                    {
                        da.Fill(ds, "ds");
                        cmd.Parameters.Clear();
                    }
                    catch (System.Data.SqlClient.SqlException ex)
                    {
                        throw new Exception(ex.Message);
                    }
                    finally  //2016-07-11
                    {
                        da.Dispose();
                        cmd.Dispose();
                        connection.Close();
                    }
                    return ds;
                }
            }
        }

        /// <summary>
        /// 2012-2-21新增重载，执行查询语句，返回DataSet
        /// </summary>
        /// <param name="connection">SqlConnection对象</param>
        /// <param name="trans">SqlTransaction事务</param>
        /// <param name="SQLString">查询语句</param>
        /// <returns>DataSet</returns>
        public static DataSet Query(SqlConnection connection, SqlTransaction trans, string SQLString, params SqlParameter[] cmdParms)
        {
            SqlCommand cmd = new SqlCommand();
            PrepareCommand(cmd, connection, trans, SQLString, cmdParms);
            using (SqlDataAdapter da = new SqlDataAdapter(cmd))
            {
                DataSet ds = new DataSet();
                try
                {
                    da.Fill(ds, "ds");
                    cmd.Parameters.Clear();
                }
                catch (System.Data.SqlClient.SqlException ex)
                {
                    //trans.Rollback();
                    throw new Exception(ex.Message);
                }
                finally  //2016-07-11
                {
                    da.Dispose();
                    cmd.Dispose();
                }
                return ds;
            }
        }
        public static DataSet Query(SqlConnection connection, SqlTransaction trans, string SQLString, List<SqlParameter> cmdParms)
        {
            SqlCommand cmd = new SqlCommand();
            PrepareCommand(cmd, connection, trans, SQLString, cmdParms);
            using (SqlDataAdapter da = new SqlDataAdapter(cmd))
            {
                DataSet ds = new DataSet();
                try
                {
                    da.Fill(ds, "ds");
                    cmd.Parameters.Clear();
                }
                catch (System.Data.SqlClient.SqlException ex)
                {
                    //trans.Rollback();
                    throw new Exception(ex.Message);
                }
                finally  //2016-07-11
                {
                    da.Dispose();
                    cmd.Dispose();
                }
                return ds;
            }
        }


        private static void PrepareCommand(SqlCommand cmd, SqlConnection conn, SqlTransaction trans, string cmdText, SqlParameter[] cmdParms)
        {
            if (conn.State != ConnectionState.Open)
                conn.Open();
            cmd.Connection = conn;
            cmd.CommandText = cmdText;
            if (trans != null)
                cmd.Transaction = trans;
            cmd.CommandType = CommandType.Text;//cmdType;
            if (cmdParms != null)
            {
                foreach (SqlParameter parameter in cmdParms)
                {
                    if ((parameter.Direction == ParameterDirection.InputOutput || parameter.Direction == ParameterDirection.Input) &&
                        (parameter.Value == null))
                    {
                        parameter.Value = DBNull.Value;
                    }
                    cmd.Parameters.Add(parameter);
                }
            }
        }
        private static void PrepareCommand(SqlCommand cmd, SqlConnection conn, SqlTransaction trans, string cmdText, List<SqlParameter> cmdParms)
        {
            if (conn.State != ConnectionState.Open)
                conn.Open();
            cmd.Connection = conn;
            cmd.CommandText = cmdText;
            if (trans != null)
                cmd.Transaction = trans;
            cmd.CommandType = CommandType.Text;//cmdType;
            if (cmdParms != null)
            {
                foreach (SqlParameter parameter in cmdParms)
                {
                    if ((parameter.Direction == ParameterDirection.InputOutput || parameter.Direction == ParameterDirection.Input) &&
                        (parameter.Value == null))
                    {
                        parameter.Value = DBNull.Value;
                    }
                    cmd.Parameters.Add(parameter);
                }
            }
        }

        #endregion

        #region 存储过程操作

        /// <summary>
        /// 执行存储过程，返回SqlDataReader ( 注意：调用该方法后，一定要对SqlDataReader进行Close )
        /// </summary>
        /// <param name="storedProcName">存储过程名</param>
        /// <param name="parameters">存储过程参数</param>
        /// <returns>SqlDataReader</returns>
        public static SqlDataReader RunProcedure(string storedProcName, IDataParameter[] parameters)
        {
            SqlConnection connection = new SqlConnection(connectionString);
            SqlDataReader returnReader;
            connection.Open();
            SqlCommand command = BuildQueryCommand(connection, storedProcName, parameters);
            command.CommandType = CommandType.StoredProcedure;
            returnReader = command.ExecuteReader(CommandBehavior.CloseConnection);
            return returnReader;

        }


        /// <summary>
        /// 执行存储过程
        /// </summary>
        /// <param name="storedProcName">存储过程名</param>
        /// <param name="parameters">存储过程参数</param>
        /// <param name="tableName">DataSet结果中的表名</param>
        /// <returns>DataSet</returns>
        public static DataSet RunProcedure(string storedProcName, IDataParameter[] parameters, string tableName)
        {
            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                DataSet dataSet = new DataSet();
                connection.Open();
                SqlDataAdapter sqlDA = new SqlDataAdapter();
                sqlDA.SelectCommand = BuildQueryCommand(connection, storedProcName, parameters);
                sqlDA.Fill(dataSet, tableName);
                sqlDA.Dispose();
                connection.Close();
                return dataSet;
            }
        }
        public static DataSet RunProcedure(string storedProcName, IDataParameter[] parameters, string tableName, int Times)
        {
            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                DataSet dataSet = new DataSet();
                connection.Open();
                SqlDataAdapter sqlDA = new SqlDataAdapter();
                sqlDA.SelectCommand = BuildQueryCommand(connection, storedProcName, parameters);
                sqlDA.SelectCommand.CommandTimeout = Times;
                sqlDA.Fill(dataSet, tableName);
                sqlDA.Dispose();
                connection.Close();
                return dataSet;
            }
        }


        /// <summary>
        /// 构建 SqlCommand 对象(用来返回一个结果集，而不是一个整数值)
        /// </summary>
        /// <param name="connection">数据库连接</param>
        /// <param name="storedProcName">存储过程名</param>
        /// <param name="parameters">存储过程参数</param>
        /// <returns>SqlCommand</returns>
        private static SqlCommand BuildQueryCommand(SqlConnection connection, string storedProcName, IDataParameter[] parameters)
        {
            SqlCommand command = new SqlCommand(storedProcName, connection);
            command.CommandType = CommandType.StoredProcedure;
            foreach (SqlParameter parameter in parameters)
            {
                if (parameter != null)
                {
                    // 检查未分配值的输出参数,将其分配以DBNull.Value.
                    if ((parameter.Direction == ParameterDirection.InputOutput || parameter.Direction == ParameterDirection.Input) &&
                        (parameter.Value == null))
                    {
                        parameter.Value = DBNull.Value;
                    }
                    command.Parameters.Add(parameter);
                }
            }

            return command;
        }

        /// <summary>
        /// 执行存储过程，返回影响的行数		
        /// </summary>
        /// <param name="storedProcName">存储过程名</param>
        /// <param name="parameters">存储过程参数</param>
        /// <param name="rowsAffected">影响的行数</param>
        /// <returns></returns>
        public static int RunProcedure(string storedProcName, IDataParameter[] parameters, out int rowsAffected)
        {
            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                int result;
                connection.Open();
                SqlCommand command = BuildIntCommand(connection, storedProcName, parameters);
                rowsAffected = command.ExecuteNonQuery();
                result = (int)command.Parameters["ReturnValue"].Value;
                //Connection.Close();
                return result;
            }
        }

        /// <summary>
        /// 创建 SqlCommand 对象实例(用来返回一个整数值)	
        /// </summary>
        /// <param name="storedProcName">存储过程名</param>
        /// <param name="parameters">存储过程参数</param>
        /// <returns>SqlCommand 对象实例</returns>
        private static SqlCommand BuildIntCommand(SqlConnection connection, string storedProcName, IDataParameter[] parameters)
        {
            SqlCommand command = BuildQueryCommand(connection, storedProcName, parameters);
            command.Parameters.Add(new SqlParameter("ReturnValue",
                SqlDbType.Int, 4, ParameterDirection.ReturnValue,
                false, 0, 0, string.Empty, DataRowVersion.Default, null));
            return command;
        }
        #endregion

        
        #region  泛型
        /// <summary>
        /// 获取实List
        /// </summary>
        /// <typeparam name="T"></typeparam>
        /// <param name="sql"></param>
        /// <returns></returns>
        public static iList<T> ListEntity<T>(string sql)
        {
            return ListEntity<T>(sql, null);
        }
        /// <summary>
        /// 获取List
        /// </summary>
        /// <typeparam name="T"></typeparam>
        /// <param name="sql"></param>
        /// <param name="parms"></param>
        /// <returns></returns>
        public static iList<T> ListEntity<T>(string sql, SqlParameter[] parms)
        {
            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                SqlCommand cmd = new SqlCommand();
                PrepareCommand(cmd, connection, null, sql, parms);
                using (SqlDataAdapter da = new SqlDataAdapter(cmd))
                {
                    DataSet ds = new DataSet();
                    iList<T> list = new iList<T>();
                    try
                    {
                        da.Fill(ds, "ds");
                        cmd.Parameters.Clear();
                        if (ds != null && ds.Tables.Count > 0)
                        {
                            DataTable dt = ds.Tables[0];
                            if (dt != null)
                            {
                                for (int i = 0; i < dt.Rows.Count; i++)
                                {
                                    DataRow dr = null;
                                    dr = dt.Rows[i];
                                    list.Add(DataReaderToEnity<T>(dr));
                                }
                            }
                            else
                            {
                                return null;
                            }
                        }
                        return list;
                    }
                    catch (System.Data.SqlClient.SqlException ex)
                    {
                        throw new Exception(ex.Message);
                    }
                    finally  //2016-07-11
                    {
                        da.Dispose();
                        cmd.Dispose();
                        connection.Close();
                    }
                }
            }
        }

        /// <summary>
        /// 获取一个实体的obj
        /// </summary>
        /// <typeparam name="T"></typeparam>
        /// <param name="sql"></param>
        /// <returns></returns>
        public static T Entity<T>(string sql)
        {
            return Entity<T>(sql, null);
        }
        /// <summary>
        /// 获取一个实体的obj
        /// </summary>
        /// <typeparam name="T"></typeparam>
        /// <param name="sql"></param>
        /// <param name="parms"></param>
        /// <returns></returns>
        public static T Entity<T>(string sql, SqlParameter[] parms)
        {
            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                SqlCommand cmd = new SqlCommand();
                PrepareCommand(cmd, connection, null, sql, parms);
                using (SqlDataAdapter da = new SqlDataAdapter(cmd))
                {
                    DataSet ds = new DataSet();
                    T t = default(T);
                    try
                    {
                        da.Fill(ds, "ds");
                        cmd.Parameters.Clear();
                        if (ds != null && ds.Tables.Count > 0)
                        {
                            DataTable dt = ds.Tables[0];
                            if (dt != null && dt.Rows.Count>0)
                            {
                                DataRow dr = dt.Rows[0];
                                t = (T)DataReaderToEnity<T>(dr);
                            }
                        }
                        return t;
                    }
                    catch (System.Data.SqlClient.SqlException ex)
                    {
                        throw new Exception(ex.Message);
                    }
                    finally  //2016-07-11
                    {
                        da.Dispose();
                        cmd.Dispose();
                        connection.Close();
                    }
                }
            }
        }


        /// <summary>
        /// 新增到数据库
        /// </summary>
        /// <typeparam name="T"></typeparam>
        /// <param name="t"></param>
        /// <returns></returns>
        public static int Insert<T>(T t)
        {
            int id = 0;
            Insert<T>(t, out id);
            return id > 0 ? 1 : 0;
        }

        /// <summary>
        /// 新增到数据库
        /// </summary>
        /// <typeparam name="T"></typeparam>
        /// <param name="t"></param>
        /// <param name="id"></param>
        /// <returns></returns>
        public static int Insert<T>(T t, out int id)
        {
            Type type = typeof(T);
            return Insert<T>(type.Name, t, out id);
        }
        
        /// <summary>
        /// 新增到数据库
        /// </summary>
        /// <typeparam name="T"></typeparam>
        /// <param name="table"></param>
        /// <param name="t"></param>
        /// <param name="id"></param>
        /// <returns></returns>
        public static int Insert<T>(string table,T t, out int id)
        {
            try
            {
                Type type = typeof(T);
                string sql = string.Empty;
                string column = string.Empty;
                string columnvalue = string.Empty;
                List<SqlParameter> parameters = new List<SqlParameter>();
                //object dynObj = Activator.CreateInstance(type);
                PropertyInfo[] properties = type.GetProperties();
                if (properties.Length > 0)
                {
                    //sql += "INSERT INTO [" + type.Name + "] ";
                    sql += "INSERT INTO [" + table + "] ";
                    int i = 0;
                    foreach (PropertyInfo p in properties)
                    {
                        if (p != null)
                        {
                            object objv = p.GetValue(t);
                            if (objv != null && !string.IsNullOrEmpty(objv.ToString()))
                            {
                                if (p.PropertyType.FullName == "System.String")
                                {
                                    string value = p.GetValue(t).ToString();
                                    column += "[" + p.Name + "]" + ",";
                                    columnvalue += "@" + p.Name + ",";
                                    SqlParameter param = new SqlParameter("@" + p.Name, SqlDbType.VarChar);
                                    param.Value = value;
                                    parameters.Add(param);
                                }
                                else if (Common.Utils.SplitString(p.PropertyType.FullName, "System.Nullable`1[[System.Int32").Length > 1 || p.PropertyType.FullName == "System.Int32")
                                {
                                    if (p.GetValue(t) != null)
                                    {
                                        int value = int.Parse(p.GetValue(t).ToString());
                                        column += "[" + p.Name + "]" + ",";
                                        columnvalue += "@" + p.Name + ",";
                                        SqlParameter param = new SqlParameter("@" + p.Name, SqlDbType.Int);
                                        param.Value = value;
                                        parameters.Add(param);
                                    }
                                }
                                else if (Common.Utils.SplitString(p.PropertyType.FullName, "System.Nullable`1[[System.Boolean").Length > 1 || p.PropertyType.FullName == "System.Boolean")
                                {
                                    if (p.GetValue(t) != null)
                                    {
                                        Boolean value = Boolean.Parse(p.GetValue(t).ToString());
                                        column += "[" + p.Name + "]" + ",";
                                        columnvalue += "@" + p.Name + ",";
                                        SqlParameter param = new SqlParameter("@" + p.Name, SqlDbType.Bit);
                                        param.Value = value;
                                        parameters.Add(param);
                                    }
                                }
                                else if (Common.Utils.SplitString(p.PropertyType.FullName, "System.Nullable`1[[System.Decimal").Length > 1 || p.PropertyType.FullName == "System.Decimal")
                                {
                                    if (p.GetValue(t) != null)
                                    {
                                        Decimal value = Decimal.Parse(p.GetValue(t).ToString());
                                        column += "[" + p.Name + "]" + ",";
                                        columnvalue += "@" + p.Name + ",";
                                        SqlParameter param = new SqlParameter("@" + p.Name, SqlDbType.Decimal);
                                        param.Value = value;
                                        parameters.Add(param);
                                    }
                                }
                                else if (Common.Utils.SplitString(p.PropertyType.FullName, "System.Nullable`1[[System.DateTime").Length > 1 || p.PropertyType.FullName == "System.DateTime")
                                {
                                    if (p.GetValue(t) != null)
                                    {
                                        DateTime value = DateTime.Parse(p.GetValue(t).ToString());
                                        column += "[" + p.Name + "]" + ",";
                                        columnvalue += "@" + p.Name + ",";
                                        SqlParameter param;
                                        if (value.ToString("yyyy/MM/dd HH:mm:ss.fff").EndsWith("00:00:00.000"))
                                        {
                                            param = new SqlParameter("@" + p.Name, SqlDbType.Date);
                                        }
                                        else
                                        {
                                            param = new SqlParameter("@" + p.Name, SqlDbType.DateTime);
                                        }
                                        param.Value = value;
                                        parameters.Add(param);
                                    }
                                }
                                else if (Common.Utils.SplitString(p.PropertyType.FullName, "System.Nullable`1[[System.Double").Length > 1 || p.PropertyType.FullName == "System.Double")
                                {
                                    if (p.GetValue(t) != null)
                                    {
                                        Double value = Double.Parse(p.GetValue(t).ToString());
                                        column += "[" + p.Name + "]" + ",";
                                        columnvalue += "@" + p.Name + ",";
                                        SqlParameter param = new SqlParameter("@" + p.Name, SqlDbType.Float);
                                        param.Value = value;
                                        parameters.Add(param);
                                    }
                                }
                                else if (Common.Utils.SplitString(p.PropertyType.FullName, "System.Nullable`1[[System.Single").Length > 1 || p.PropertyType.FullName == "System.Single")
                                {
                                    if (p.GetValue(t) != null)
                                    {
                                        float value = float.Parse(p.GetValue(t).ToString());
                                        column += "[" + p.Name + "]" + ",";
                                        columnvalue += "@" + p.Name + ",";
                                        SqlParameter param = new SqlParameter("@" + p.Name, SqlDbType.Real);
                                        param.Value = value;
                                        parameters.Add(param);
                                    }
                                }
                            }
                        }
                    }
                }
                else
                {
                    id = 0;
                    return 0;
                }
                if (column.EndsWith(","))
                {
                    column = column.Substring(0, column.Length - 1);
                }
                if (columnvalue.EndsWith(","))
                {
                    columnvalue = columnvalue.Substring(0, columnvalue.Length - 1);
                }
                sql += "(" + column + ") VALUES (" + columnvalue + ")";
                sql += ";select @@IDENTITY;";
                object result = GetSingle(sql, parameters);
                if (Utils.IsNumeric(result))
                    id = Convert.ToInt32(result);
                else
                    id = 1;
                LogHelper.WriteDebugLog("[result:" + id + "]" + sql + "(" + ParamsToString(parameters) + ")");
                return id;
            }
            catch (Exception ex)
            {
                id = 0;
                return 0;
            }
        }

        /// <summary>
        /// 修改数据库
        /// </summary>
        /// <typeparam name="T"></typeparam>
        /// <param name="t"></param>
        /// <param name="primaryKey">主键名称</param>
        /// <returns></returns>
        public static int Update<T>(T t, string primaryKey)
        {
            return Update<T>(t, primaryKey, "");
        }
        /// <summary>
        /// 修改数据库
        /// </summary>
        /// <typeparam name="T"></typeparam>
        /// <param name="t"></param>
        /// <param name="primaryKey">主键名称</param>
        /// <param name="strWhere"></param>
        /// <returns></returns>
        public static int Update<T>(T t, string primaryKey, string strWhere)
        {
            Type type = typeof(T);
            return Update<T>(type.Name, t, primaryKey, strWhere);
        }
        /// <summary>
        /// 修改数据库
        /// </summary>
        /// <typeparam name="T"></typeparam>
        /// <param name="table">表名</param>
        /// <param name="t"></param>
        /// <param name="primaryKey">主键名称,不设置主键为根据where修改全部</param>
        /// <param name="strWhere"></param>
        /// <returns></returns>
        public static int Update<T>(string table, T t, string primaryKey, string strWhere)
        {

            try
            {
                Type type = typeof(T);
                string sql = string.Empty;
                string column = string.Empty;
                object primaryKeyValue = string.Empty;
                SqlParameter keyParam = new SqlParameter();
                List<SqlParameter> parameters = new List<SqlParameter>();
                PropertyInfo[] properties = type.GetProperties();
                if (properties.Length > 0)
                {
                    sql += "UPDATE [" + table + "] SET ";
                    int i = 0;
                    foreach (PropertyInfo p in properties)
                    {
                        if (p != null)
                        {
                            object objv = p.GetValue(t);
                            if (objv != null && !string.IsNullOrEmpty(objv.ToString()))
                            {
                                if (p.PropertyType.FullName == "System.String")
                                {
                                    string value = p.GetValue(t).ToString();
                                    if (p.Name != primaryKey)
                                    {
                                        column += "[" + p.Name + "]=@" + p.Name + ",";
                                        SqlParameter param = new SqlParameter("@" + p.Name, SqlDbType.VarChar);
                                        param.Value = value;
                                        parameters.Add(param);
                                    }
                                    else
                                    {
                                        primaryKeyValue = value;
                                        keyParam.ParameterName = "@" + p.Name;
                                        keyParam.SqlDbType = SqlDbType.VarChar;
                                        keyParam.SqlValue = value;
                                    }
                                }
                                else if (Common.Utils.SplitString(p.PropertyType.FullName, "System.Nullable`1[[System.Int32").Length > 1 || p.PropertyType.FullName == "System.Int32")
                                {
                                    if (p.GetValue(t) != null)
                                    {
                                        int value = int.Parse(p.GetValue(t).ToString());
                                        if (p.Name != primaryKey)
                                        {
                                            column += "[" + p.Name + "]=@" + p.Name + ",";
                                            SqlParameter param = new SqlParameter("@" + p.Name, SqlDbType.Int);
                                            param.Value = value;
                                            parameters.Add(param);
                                        }
                                        else
                                        {
                                            primaryKeyValue = value;
                                            keyParam.ParameterName = "@" + p.Name;
                                            keyParam.SqlDbType = SqlDbType.Int;
                                            keyParam.SqlValue = value;
                                        }
                                    }
                                }
                                else if (Common.Utils.SplitString(p.PropertyType.FullName, "System.Nullable`1[[System.Boolean").Length > 1 || p.PropertyType.FullName == "System.Boolean")
                                {
                                    if (p.GetValue(t) != null)
                                    {
                                        Boolean value = Boolean.Parse(p.GetValue(t).ToString());
                                        if (p.Name != primaryKey)
                                        {
                                            column += "[" + p.Name + "]=@" + p.Name + ",";
                                            SqlParameter param = new SqlParameter("@" + p.Name, SqlDbType.Bit);
                                            param.Value = value;
                                            parameters.Add(param);
                                        }
                                    }
                                }
                                else if (Common.Utils.SplitString(p.PropertyType.FullName, "System.Nullable`1[[System.Decimal").Length > 1 || p.PropertyType.FullName == "System.Decimal")
                                {
                                    if (p.GetValue(t) != null)
                                    {

                                        Decimal value = Decimal.Parse(p.GetValue(t).ToString());
                                        if (p.Name != primaryKey)
                                        {
                                            column += "[" + p.Name + "]=@" + p.Name + ",";
                                            SqlParameter param = new SqlParameter("@" + p.Name, SqlDbType.Decimal);
                                            param.Value = value;
                                            parameters.Add(param);
                                        }
                                    }
                                }
                                else if (Common.Utils.SplitString(p.PropertyType.FullName, "System.Nullable`1[[System.DateTime").Length > 1 || p.PropertyType.FullName == "System.DateTime")
                                {
                                    if (p.GetValue(t) != null)
                                    {
                                        DateTime value = DateTime.Parse(p.GetValue(t).ToString());
                                        if (p.Name != primaryKey)
                                        {
                                            column += "[" + p.Name + "]=@" + p.Name + ",";
                                            SqlParameter param = new SqlParameter("@" + p.Name, SqlDbType.DateTime);
                                            param.Value = value;
                                            parameters.Add(param);
                                        }
                                    }
                                }
                                else if (Common.Utils.SplitString(p.PropertyType.FullName, "System.Nullable`1[[System.Double").Length > 1 || p.PropertyType.FullName == "System.Double")
                                {
                                    if (p.GetValue(t) != null)
                                    {
                                        Double value = Double.Parse(p.GetValue(t).ToString());
                                        if (p.Name != primaryKey)
                                        {
                                            column += "[" + p.Name + "]=@" + p.Name + ",";
                                            SqlParameter param = new SqlParameter("@" + p.Name, SqlDbType.Float);
                                            param.Value = value;
                                            parameters.Add(param);
                                        }
                                    }
                                }
                                else if (Common.Utils.SplitString(p.PropertyType.FullName, "System.Nullable`1[[System.Single").Length > 1 || p.PropertyType.FullName == "System.Single")
                                {
                                    if (p.GetValue(t) != null)
                                    {
                                        float value = float.Parse(p.GetValue(t).ToString());
                                        if (p.Name != primaryKey)
                                        {
                                            column += "[" + p.Name + "]=@" + p.Name + ",";
                                            SqlParameter param = new SqlParameter("@" + p.Name, SqlDbType.Real);
                                            param.Value = value;
                                            parameters.Add(param);
                                        }
                                    }
                                }
                            }
                        }
                    }
                }
                else
                {
                    return 0;
                }
                string newWhere = string.Empty;
                if (!string.IsNullOrEmpty(primaryKey))
                {
                    newWhere += " where " + primaryKey + "=@" + primaryKey;
                    parameters.Add(keyParam);
                    newWhere += (!string.IsNullOrEmpty(strWhere) ? " and " + strWhere : "");
                }
                else
                {
                    newWhere += (!string.IsNullOrEmpty(strWhere) ? " where " + strWhere : "");
                }
                if (column.EndsWith(","))
                {
                    column = column.Substring(0, column.Length - 1);
                }
                sql += column + newWhere;
                int result = ExecuteSql(sql, parameters);

                LogHelper.WriteDebugLog("[result:" + result.ToString() + "]" + sql + "(" + ParamsToString(parameters) + ")");
                return result;
            }
            catch
            {
                return 0;
            }
        }



        /// <summary>
        /// DataRow转换为实体
        /// </summary>
        /// <typeparam name="T"></typeparam>
        /// <param name="dr"></param>
        /// <returns></returns>
        private static T DataReaderToEnity<T>(DataRow dr)
        {
            Type type = typeof(T);
            object dynObj = Activator.CreateInstance(type);

            for (int i = 0; i < dr.Table.Columns.Count; i++)
            {
                PropertyInfo p = type.GetProperty(dr.Table.Columns[i].ToString());

                if (p != null)
                {
                    if (p.PropertyType.FullName == "System.String")
                    {
                        p.SetValue(dynObj, dr[dr.Table.Columns[i].ToString()].ToString().Trim(), null);
                    }
                    else if (Common.Utils.SplitString(p.PropertyType.FullName, "System.Nullable`1[[System.Int32").Length > 1 || p.PropertyType.FullName == "System.Int32")
                    {
                        if (dr.Table.Columns[i]!=null && dr[dr.Table.Columns[i].ToString()] != null && dr[dr.Table.Columns[i].ToString()] != null && !string.IsNullOrEmpty(dr[dr.Table.Columns[i].ToString()].ToString()))
                            p.SetValue(dynObj, TypeConverter.StrToInt(dr[dr.Table.Columns[i].ToString()].ToString()), null);
                    }
                    else if (Common.Utils.SplitString(p.PropertyType.FullName, "System.Nullable`1[[System.DateTime").Length > 1 || p.PropertyType.FullName == "System.DateTime")
                    {
                        if (dr.Table.Columns[i] != null && dr[dr.Table.Columns[i].ToString()] != null && dr[dr.Table.Columns[i].ToString()] != null && !string.IsNullOrEmpty(dr[dr.Table.Columns[i].ToString()].ToString()))
                            p.SetValue(dynObj, TypeConverter.ObjectToDateTime(dr[dr.Table.Columns[i]]), null);
                    }
                    else if (Common.Utils.SplitString(p.PropertyType.FullName, "System.Nullable`1[[System.Boolean").Length > 1 || p.PropertyType.FullName == "System.Boolean")
                    {
                        if (dr.Table.Columns[i] != null && dr[dr.Table.Columns[i].ToString()] != null && dr[dr.Table.Columns[i].ToString()] != null && !string.IsNullOrEmpty(dr[dr.Table.Columns[i].ToString()].ToString()))
                            p.SetValue(dynObj, TypeConverter.StrToBool(dr[dr.Table.Columns[i]].ToString(), false), null);
                    }
                    else if (Common.Utils.SplitString(p.PropertyType.FullName, "System.Nullable`1[[System.Single").Length > 1 || p.PropertyType.FullName == "System.Single")
                    {
                        if (dr.Table.Columns[i] != null && dr[dr.Table.Columns[i].ToString()] != null && dr[dr.Table.Columns[i].ToString()] != null && !string.IsNullOrEmpty(dr[dr.Table.Columns[i].ToString()].ToString()))
                            p.SetValue(dynObj, TypeConverter.ObjectToFloat(dr[dr.Table.Columns[i]]), null);
                    }
                    else if (Common.Utils.SplitString(p.PropertyType.FullName, "System.Nullable`1[[System.Double").Length > 1 || p.PropertyType.FullName == "System.Double")
                    {
                        if (dr.Table.Columns[i] != null && dr[dr.Table.Columns[i].ToString()] != null && dr[dr.Table.Columns[i].ToString()] != null && !string.IsNullOrEmpty(dr[dr.Table.Columns[i].ToString()].ToString()))
                            p.SetValue(dynObj, Convert.ToDouble(dr[dr.Table.Columns[i]]), null);
                    }
                    
                    else if (Common.Utils.SplitString(p.PropertyType.FullName, "System.Nullable`1[[System.Decimal").Length > 1 || p.PropertyType.FullName == "System.Decimal")
                    {
                        if (dr.Table.Columns[i] != null && dr[dr.Table.Columns[i].ToString()] != null && dr[dr.Table.Columns[i].ToString()] != null && !string.IsNullOrEmpty(dr[dr.Table.Columns[i].ToString()].ToString()))
                            p.SetValue(dynObj, Convert.ToDecimal(dr[dr.Table.Columns[i]]), null);
                    }
                }
            }

            return (T)dynObj;
        }

        #endregion
        private static string ParamsToString(SqlParameter[] parms)
        {
            string strParam = string.Empty;
            foreach (SqlParameter p in parms)
            {
                strParam += p.ParameterName + "=" + p.Value;
            }
            return strParam;
        }
        private static string ParamsToString(List<SqlParameter> parms)
        {
            string strParam = string.Empty;
            foreach (SqlParameter p in parms)
            {
                strParam += p.ParameterName + "=" + p.Value;
            }
            return strParam;
        }
    }
}
