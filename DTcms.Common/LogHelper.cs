using System;
using NLog;

namespace DTcms.Common
{
    public class LogHelper
    {
        private static readonly NLog.Logger logger;

        static LogHelper()
        {
            logger = NLog.LogManager.GetCurrentClassLogger();
        }

        /// <summary>
        /// 输出日志
        /// </summary>
        /// <param name="info"></param>
        public static void WriteLog(string message)
        {
            logger.Info(message);
        }

        public static void WriteDebugLog(string message)
        {
            logger.Error(message);
        }

        /// <summary>
        /// 输出错误日志
        /// </summary>
        /// <param name="info"></param>
        public static void WriteLog(string message, Exception ex)
        {
            logger.Error(message, ex.Message);
        }

        /// <summary>
        /// 输出错误日志 true全部、false详情
        /// </summary>
        /// <param name="info"></param>
        public static void WriteLog(string message, Exception ex, bool status)
        {
            if (status)
            {
                logger.Error(message, ex.ToString());
            }
            else
            {
                logger.Error(message, ex.Message);
            }
        }
    }
}
