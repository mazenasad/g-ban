#!/bin/bash
clear
G='\033[1;32m'
R='\033[1;31m'
Y='\033[1;33m'
C='\033[1;36m'
W='\033[1;37m'

echo -e "${C}============================================${W}"
echo -e "${G}     MAZEN INSTANT CHANGER V7.0 (FINAL)     ${W}"
echo -e "${C}============================================${W}"

read -p "  > SessionID: " SID
read -p "  > New Username: " NEW_USER

echo -e "\n${Y}[*] جاري الاتصال بالسيرفر العالمي...${W}"

# الرابط الجديد كلياً لتخطي خطأ URL doesn't match
res=$(curl -s -X POST "https://api16-normal-c-useast1a.tiktokv.com/passport/user/update_profile/?aid=1233&device_id=7123456789012345678" \
    -H "Cookie: sessionid=$SID" \
    -H "User-Agent: TikTok 26.1.3 (iPhone; iOS 15.4.1; en_US)" \
    -H "Content-Type: application/x-www-form-urlencoded" \
    -d "unique_id=$NEW_USER")

# فحص الرد
if [[ $res == *"success"* ]]; then
    echo -e "\n${G}[✔] مبروك يا مازن! تم التغيير بنجاح لـ @$NEW_USER${W}"
elif [[ $res == *'"status_code":0'* ]]; then
    echo -e "\n${G}[✔] تم إرسال الطلب بنجاح! راجع حسابك الآن.${W}"
else
    echo -e "\n${R}[!] تيك توك رفض الطلب!${W}"
    # استخراج رسالة الخطأ الحقيقية
    reason=$(echo $res | grep -o '"message":"[^Internal]*"' | cut -d'"' -f4)
    echo -e "${Y}السبب الحقيقي:${W} ${reason:-$res}"
fi
echo -e "\n${C}============================================${W}"
