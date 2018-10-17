using System;
using System.Collections.Generic;
using System.Drawing;
using System.IO;
using System.Linq;
using System.Text;
using ThoughtWorks.QRCode.Codec;

namespace DTcms.Common
{
    public class QRCode
    {
        /// <summary>  
        /// 保存图片  
        /// </summary>  
        /// <param name="strDic">保存路径</param>  
        /// <param name="filename">png文件名</param>  
        /// <param name="img">图片</param>  
        public static void SaveImg(string strDic, string filename, Bitmap img)
        {
            //保存图片到目录  
            if (Directory.Exists(strDic))
            {
                img.Save(strDic + "/" + filename, System.Drawing.Imaging.ImageFormat.Png);
            }
            else
            {
                //当前目录不存在，则创建  
                Directory.CreateDirectory(strDic);
                img.Save(strDic + "/" + filename, System.Drawing.Imaging.ImageFormat.Png);
            }
        }
        /// <summary>  
        /// 生成二维码图片  
        /// </summary>  
        /// <param name="codeNumber">要生成二维码的字符串</param>       
        /// <param name="size">大小尺寸</param>  
        /// <returns>二维码图片</returns>  
        public static Bitmap Create_ImgCode(string codeNumber, int size)
        {
            //创建二维码生成类  
            QRCodeEncoder qrCodeEncoder = new QRCodeEncoder();
            //设置编码模式  
            qrCodeEncoder.QRCodeEncodeMode = QRCodeEncoder.ENCODE_MODE.BYTE;
            //设置编码测量度  
            qrCodeEncoder.QRCodeScale = size;
            //设置编码版本  
            qrCodeEncoder.QRCodeVersion = 0;
            //设置编码错误纠正  
            qrCodeEncoder.QRCodeErrorCorrect = QRCodeEncoder.ERROR_CORRECTION.M;
            //生成二维码图片  
            System.Drawing.Bitmap image = qrCodeEncoder.Encode(codeNumber);
            return image;
        }
    }
}
