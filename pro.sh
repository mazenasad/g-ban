#!/bin/bash
# ==========================================
# TOOL: TIKTOK INSTANT CHANGER (NO HUNTING)
# OWNER: MAZEN (MAZENASAD)
# ==========================================

# تعريف الألوان
G='\033[1;32m' # أخضر
R='\033[1;31m' # أحمر
Y='\033[1;33m' # أصفر
C='\033[1;36m' # سماوي
W='\033[1;37m' # أبيض

clear
echo -e "${C}============================================${W}"
echo -e "${G}     WELCOME TO g-ban INSTANT CHANGER       ${W}"
echo -e "${C}============================================${W}"

# إدخال البيانات
echo -e "${Y}[!] أدخل بيانات الحساب:${W}"
read -p "  > SessionID: " SID
read -p "  > New Username: " NEW_USER

echo -e "\n${G}[*] جاري إرسال طلب التغيير الآن...${W}"

# طلب التغيير المباشر (مرة واحدة فقط)
res=$(curl -s -X POST "https://www.tiktok.com/api/v1/user/profile/update/" \
    -H "Cookie: sessionid=$SID" \
    -H "Content-Type: application/x-www-form-urlencoded" \
    -d "unique_id=$NEW_USER")

# فحص النتيجة والرد بالسبب لو رفض
if [[ $res == *"success"* ]]; then
    echo -e "\n${G}[✔] مبروك يا مازن! تم تغيير اليوزر بنجاح لـ @$NEW_USER${W}"
else
    echo -e "\n${R}[!] تيك توك رفض الطلب!${W}"
    echo -e "${Y}السبب المكتوب من السيرفر:${W} $res"
fi

echo -e "\n${C}============================================${W}"
echo -e "${G}تم الانتهاء. الأداة ستغلق الآن.${W}"
