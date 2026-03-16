#!/bin/bash

# ألوان للتنسيق
GREEN='\033[0;32m'
RED='\033[0;31m'
CYAN='\033[0;36m'
NC='\033[0m'

clear
echo -e "${CYAN}=======================================${NC}"
echo -e "${GREEN}    TikTok User Hunter Pro (By Mazen)  ${NC}"
echo -e "${CYAN}=======================================${NC}"

# طلب البيانات من المستخدم
read -p "Enter your Session ID: " SID
read -p "Enter the Username you want: " TARGET_USER

echo -e "\n${YELLOW}Searching for: ${TARGET_USER}...${NC}"

while true; do
    # فحص اليوزر هل هو متاح أم لا
    check=$(curl -s -o /dev/null -w "%{http_code}" "https://www.tiktok.com/@${TARGET_USER}")

    if [ "$check" == "404" ]; then
        echo -e "${GREEN}[+] User @${TARGET_USER} is AVAILABLE! Attempting to claim...${NC}"
        
        # محاولة تغيير اليوزر باستخدام السيزون آيدي
        claim=$(curl -s -X POST "https://www.tiktok.com/api/v1/user/profile/update/" \
            -H "Cookie: sessionid=${SID}" \
            -d "unique_id=${TARGET_USER}")

        if [[ $claim == *"success"* ]]; then
            echo -e "${GREEN}[!!!] CONGRATULATIONS! @${TARGET_USER} is now YOURS!${NC}"
            exit 1
        else
            echo -e "${RED}[!] Failed to claim. Maybe SessionID expired?${NC}"
        fi
        break
    else
        echo -e "${RED}[-] @${TARGET_USER} is still taken... Retrying in 1s${NC}"
        sleep 1
    fi
done
