#!/bin/bash

# تنظيف الشاشة
clear
echo -e "\033[1;32m[ MAZEN V3.0 - AUTOMATIC USER CHANGER ]\033[0m"
echo "----------------------------------------------"

# طلب البيانات
read -p "أدخل السيزون آيدي (SessionID): " SID
read -p "أدخل اليوزر اللي بدك تصيده (الهدف): " TARGET

echo -e "\n\033[1;33m[*] جاري مراقبة اليوزر @$TARGET ...\033[0m"

while true; do
    # فحص إذا اليوزر أصبح متاحاً (404 يعني متاح)
    check=$(curl -s -o /dev/null -w "%{http_code}" "https://www.tiktok.com/@$TARGET")

    if [ "$check" == "404" ]; then
        echo -e "\n\033[1;32m[+] اليوزر متاح الآن! جاري محاولة السحب...\033[0m"
        
        # الكود المسؤول عن تغيير يوزر حسابك فوراً
        response=$(curl -s -X POST "https://www.tiktok.com/api/v1/user/profile/update/" \
            -H "Cookie: sessionid=$SID" \
            -H "Content-Type: application/x-www-form-urlencoded" \
            -H "User-Agent: Mozilla/5.0 (iPhone; CPU iPhone OS 14_8 like Mac OS X) AppleWebKit/605.1.15" \
            --data-urlencode "unique_id=$TARGET")

        if [[ $response == *"success"* ]]; then
            echo -e "\033[1;36m[✔] مبروك يا مازن! تم تغيير يوزر حسابك إلى: @$TARGET\033[0m"
            exit
        else
            echo -e "\033[1;31m[!] فشل السحب. تأكد من السيزون آيدي أو أن اليوزر مسموح به.\033[0m"
            echo "الرد من تيك توك: $response"
            exit
        fi
    else
        # طباعة نقطة عشان تعرف إنه شغال بيفحص
        echo -ne "\033[1;37m.\033[0m"
        sleep 0.4
    fi
done
