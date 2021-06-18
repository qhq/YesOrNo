#!/usr/bin/env bash

############################## DIY更新状态检查 ##############################
iCan=true
FileDiy=${ConfigDir}/diy.sh
if [ -f ${FileDiy} ]; then
    echo " "
else
    echo -e "当前系统时间：$(date "+%Y-%m-%d %H:%M")"
    grep -iq "const diy = true;" ${JD_DIR}/scripts/getJDCookie.js
    if [ $? -ne 0 ]; then
        echo "上次Pull执行DIY失败"
        #bash git_pull >> ${JD_DIR}/log/git_pull.log 2>&1
        #sleep 30
        ScriptsDir=${JD_DIR}/scripts
        iCan=false
        #exit
    else
        echo "DIY已成功执行"
        exit
    fi
fi

#添加hosts;如无法正常下载Github Raw文件，请注释掉
Host_IP=('151.101.88.133' '151.101.228.133' '185.199.108.133')
Host_Name=('raw.githubusercontent.com' 'raw.githubusercontent.com' 'raw.githubusercontent.com')
cat /etc/hosts | grep "raw.githubusercontent.com" -q
if [ $? -ne 0 ]; then
    for ((i = 0; i <= ${#Host_IP[@]}; i++)); do
        echo "${Host_IP[$i]} ${Host_Name[$i]}" >>/etc/hosts
    done
fi
PROXY_URL=https://ghproxy.com/

if [ ${iCan} = "true" ]; then

    ## 短期或长期活动：
    # jd_wsdlb.js                  柠檬我是大老板农场           （需要种水果）
    # jd_SplitRedPacket.js         天降红包                    （默认助力第一个账号）
    # jd_star_store.js             明星小店                    （最新修复版）
    # jd_ddnc_farmpark.js          东东乐园
    # jx_pasture.js                京喜牧场                    （最新修复版）
    # jx_cfdtx.js                  京喜财富岛提现
    # jx_mc_coin.js                京喜牧场收集金币
    # jx_mc_emptycabbage.js        京喜牧场清空白菜
    # adolf_oneplus.js             赢一加新品手机
    # ddo_pk.js                    京享值PK                     （新一期）
    # long_half_redrain.js         半点红包雨
    # long_super_redrain.js        整点红包雨
    # zooElecsport.js              东东电竞经理

    ############################## 作者昵称（必填）##############################
    # 使用空格隔开
    author_list="qhqcz Sunert NobyDa yangtingxiao longzhuzhu zooPanda ddo Ariszy moposmall panghu star261 jdShare MoPoQAQ Wenmoux"
    ############################## 作者脚本地址URL（必填）##############################
    # 例如：https://raw.githubusercontent.com/whyour/hundun/master/quanx/jx_nc.js
    # https://raw.sevencdn.com/
    # 1.从作者库中随意挑选一个脚本地址，每个作者的地址添加一个即可，无须重复添加
    # 2.将地址最后的 “脚本名称+后缀” 剪切到下一个变量里（my_scripts_list_xxx）
    scripts_base_url_1=${PROXY_URL}https://raw.githubusercontent.com/qhq/YesOrNo/main/Scripts/
    scripts_base_url_2=https://gitee.com/Sunert/Scripts/raw/master/Task/ #https://raw.sevencdn.com/Sunert/Scripts/master/Task/
    scripts_base_url_3=${PROXY_URL}https://raw.githubusercontent.com/NobyDa/Script/master/iQIYI-DailyBonus/
    scripts_base_url_4=${PROXY_URL}https://raw.githubusercontent.com/yangtingxiao/QuantumultX/master/scripts/jd/
    scripts_base_url_5=${PROXY_URL}https://raw.githubusercontent.com/longzhuzhu/nianyu/main/qx/
    scripts_base_url_6=${PROXY_URL}https://raw.githubusercontent.com/zooPanda/zoo/dev/ #https://raw.githubusercontent.com/sngxpro/AutoSyncScript/zooPanda/
    scripts_base_url_7=${PROXY_URL}https://raw.githubusercontent.com/hyzaw/scripts/main/
    scripts_base_url_8=${PROXY_URL}https://raw.githubusercontent.com/sngxpro/AutoSyncScript/ZhiYi-N/Scripts/
    scripts_base_url_9=${PROXY_URL}https://raw.githubusercontent.com/moposmall/Script/main/Me/
    scripts_base_url_10=${PROXY_URL}https://raw.githubusercontent.com/panghu999/panghu/master/
    scripts_base_url_11=${PROXY_URL}https://raw.githubusercontent.com/star261/jd/main/scripts/
    scripts_base_url_12=${PROXY_URL}https://raw.githubusercontent.com/JDHelloWorld/jd_scripts/main/
    scripts_base_url_13=${PROXY_URL}https://raw.githubusercontent.com/jiulan/platypus/main/scripts/
    scripts_base_url_14=${PROXY_URL}https://raw.githubusercontent.com/Wenmoux/scripts/wen/jd/

    ############################## 作者脚本名称（必填）##############################
    # 将相应作者的脚本填写到以下变量中
    my_scripts_list_1="91wii.js jd_live_lottery_social.js post_code.js jd_bean_change.js"
    my_scripts_list_2="baidu_speed.js youth.js Youth_Read.js jukan.js"
    my_scripts_list_3="iQIYI.js"
    my_scripts_list_4="jd_lotteryMachine.js"
    my_scripts_list_5="long_half_redrain.js long_super_redrain.js"
    my_scripts_list_6="zooElecsport.js"
    my_scripts_list_7="ddo_pk.js"
    my_scripts_list_8="zy_618jc.js"
    my_scripts_list_9="jx_mc_coin.js jx_mc_emptycabbage.js"
    my_scripts_list_10="jd_wsdlb.js"
    my_scripts_list_11="jd_star_shop.js jd_jxmc.js"
    my_scripts_list_12="jd_cfd.js jd_dreamFactory.js jd_fruit.js jd_health.js jd_pet.js jd_plantBean.js jd_carnivalcity.js jd_jdfactory.js jd_sgmh.js jd_api_test.js"
    my_scripts_list_13="jx_cfdtx.js jdJxncTokens.js"
    my_scripts_list_14="jd_SplitRedPacket.js jd_ddnc_farmpark.js"

    ############################## 随机函数 ##########################################
    rand() {
        min=$1
        max=$(($2 - $min + 1))
        num=$(cat /proc/sys/kernel/random/uuid | cksum | awk -F ' ' '{print $1}')
        echo $(($num % $max + $min))
    }
    cd $ScriptsDir # 在 git_pull.sh 中已经定义 ScriptsDir 此变量，diy.sh 由 git_pull.sh 调用，因此可以直接使用此变量
    index=1
    for author in $author_list; do
        echo -e "下载 $author 的脚本"
        # 下载my_scripts_list中的每个js文件，重命名增加前缀"作者昵称_"，增加后缀".new"
        eval scripts_list=\$my_scripts_list_${index}
        #echo $scripts_list
        eval url_list=\$scripts_base_url_${index}
        #echo $url_list
        for js in $scripts_list; do
            eval url=$url_list$js
            echo "地址 $url"
            eval name=$author"_"$js
            #echo $name
            wget -q --no-check-certificate $url -O $name.new

            # 如果上一步下载没问题，才去掉后缀".new"，如果上一步下载有问题，就保留之前正常下载的版本
            # 随机添加个cron到crontab.list
            if [ $? -eq 0 ]; then
                mv -f $name.new $name
                echo -e "更新 $name 完成...\n"
                croname=$(echo "$name" | awk -F\. '{print $1}')
                script_date=$(cat $name | grep "http" | awk '{if($1~/^[0-59]/) print $1,$2,$3,$4,$5}' | sort | uniq | head -n 1)
                if [ -z "${script_date}" ]; then
                    cron_min=$(rand 1 59)
                    cron_hour=$(rand 7 9)
                    [ $(grep -c "$croname" /jd/config/crontab.list) -eq 0 ] && sed -i "/hangup/a${cron_min} ${cron_hour} * * * bash jd $croname" /jd/config/crontab.list
                else
                    [ $(grep -c "$croname" /jd/config/crontab.list) -eq 0 ] && sed -i "/hangup/a${script_date} bash jd $croname" /jd/config/crontab.list
                fi
            else
                [ -f $name.new ] && rm -f $name.new
                echo -e "更新 $name 失败，使用上一次正常的版本...\n"
            fi
        done
        index=$(($index + 1))
    done
fi

############################## 同步 diy.sh ##########################################
#cd $ConfigDir
#echo -e "开始更新 diy.sh "
#wget -q --no-check-certificate https://raw.githubusercontent.com/qhq/YesOrNo/main/diy.sh -O diy.sh.new
#if [ $? -eq 0 ]; then
#  mv -f diy.sh.new diy.sh
#  echo -e "更新 diy.sh 完成"
#else
#  rm -rf diy.sh.new
#  echo -e "更新 diy.sh 失败，使用上一次正常的版本...\n"
#fi

############################## 文件处理 ##########################################
echo -e "============ 清理内置 ============"

exJS=(qhqcz_post_code.js) #需排除的脚本
for file in $(ls $ScriptsDir); do
    #[[ ${array[@]/${var}/} != ${array[@]} ]] && echo "Yes" || echo "No"
    if [ "${file##*.}" = "js" ] && [[ ${exJS[@]/"${file%.*}"/} == ${exJS[@]} ]] && [ $(grep -cEi "nickName" ${ScriptsDir}/${file}) -ne '0' ]; then
        perl -0777 -i -pe "s/(^|\s+)\\$.nickName = (''|\\$.*?);/\1\\$.nickName = \2;\1\\$.custName = (process.env.CUSTNAME ? process.env.CUSTNAME : '').split(',')[i];/ig" ${ScriptsDir}/${file} >/dev/null 2>&1
        perl -0777 -i -pe "s/\\$.nickName \|\|/\\$.custName \|\| \\$.nickName \|\|/ig" ${ScriptsDir}/${file} >/dev/null 2>&1
    fi
    if [ "${file##*.}" = "js" ] && [[ ${exJS[@]/"${file%.*}"/} == ${exJS[@]} ]] && [ $(grep -cEi "(let \w+Codes|const \w+Codes|let invite_pins|const shareID|const shareCodeArr|innerPkInviteList|authorCodeList) = \[[\s\S]*?" ${ScriptsDir}/${file}) -ne '0' ]; then
        echo -en "${file} | "
        echo $(grep -nEi "(let \w+Codes|const \w+Codes|let invite_pins|const shareID|const shareCodeArr|innerPkInviteList|authorCodeList) = \[[\s\S]*?" ${ScriptsDir}/${file})
        perl -0777 -i -pe "s/((?:const \w+Codes|let \w+Codes|let invite_pins|const shareID|const shareCodeArr|innerPkInviteList|authorCodeList) = \[)([\s\S]*?)(\])/\1''\3/ig" ${ScriptsDir}/${file} >/dev/null 2>&1
    fi
    if [ "${file##*.}" = "js" ] && [[ ${exJS[@]/"${file%.*}"/} == ${exJS[@]} ]] && [ $(grep -cEi "(helpAu.*?) = true" ${ScriptsDir}/${file}) -ne '0' ]; then
        echo -en "${file} | "
        echo $(grep -nEi "(helpAu.*?) = true" ${ScriptsDir}/${file})
        perl -0777 -i -pe "s/(helpAu.*?) = true/\1 = false/ig" ${ScriptsDir}/${file} >/dev/null 2>&1
    fi
    if [ "${file##*.}" = "js" ] && [[ ${exJS[@]/"${file%.*}"/} == ${exJS[@]} ]] && [ $(grep -cEi "await getAuthorShareCode(|\d)\(\);$" ${ScriptsDir}/${file}) -ne '0' ]; then
        echo -en "${file} | "
        echo $(grep -nEi "await getAuthorShareCode(|\d)\(\);$" ${ScriptsDir}/${file})
        perl -0777 -i -pe "s/await getAuthorShareCode(|\d)\(\);//ig" ${ScriptsDir}/${file} >/dev/null 2>&1
        #sed -ig "/await getAuthorShareCode\(\|\S\)();$/d" ${ScriptsDir}/${file} >/dev/null 2>&1
    fi
done

echo -e "=================================\n"

############################## Lxk0301脚本 ##########################################
echo -e "============ Lxk0301脚本 ============"
#替换内置
#perl -0777 -i -pe "s/((?:const \w+Codes|let \w+Codes|let invite_pins|const shareID) = \[)([\s\S]*?)(\])/\1'c2dj54vowh46iieh7u2ifzwzvu\@tzyicd7vcjefooqbns6eertieu\@vznl6lnj45ygubawzy4sypmk3wp7qavhgsxarra'\3/ig" ${ScriptsDir}/jdPlantBeanShareCodes.js >/dev/null 2>&1
#替换内置码库链接
perl -0777 -i -pe "s|http:\/\/share\.turinglabs\.net\/api\/.*?\`|http://xinhunshang.xyz:6001/submit_activity_codes/get/ddfactory/20/5\`|ig" ${ScriptsDir}/jd_jdfactory.js >/dev/null 2>&1 && echo -e "东东工厂库链接已替换"
perl -0777 -i -pe "s|http:\/\/share\.turinglabs\.net\/api\/.*?\`|http://xinhunshang.xyz:6001/submit_activity_codes/get/farm/20/5\`|ig" ${ScriptsDir}/jd_fruit.js >/dev/null 2>&1 && echo -e "东东农场库链接已替换"
perl -0777 -i -pe "s|http:\/\/share\.turinglabs\.net\/api\/.*?\`|http://xinhunshang.xyz:6001/submit_activity_codes/get/bean/20/5\`|ig" ${ScriptsDir}/jd_plantBean.js >/dev/null 2>&1 && echo -e "种豆得豆库链接已替换"
perl -0777 -i -pe "s|http:\/\/share\.turinglabs\.net\/api\/.*?\`|http://xinhunshang.xyz:6001/submit_activity_codes/get/pet/20/5\`|ig" ${ScriptsDir}/jd_pet.js >/dev/null 2>&1 && echo -e "东东萌宠库链接已替换"
perl -0777 -i -pe "s|http:\/\/share\.turinglabs\.net\/api\/.*?\`|http://xinhunshang.xyz:6001/submit_activity_codes/get/jxfactory/20/2\`|ig" ${ScriptsDir}/jd_dreamFactory.js >/dev/null 2>&1 && echo -e "京喜工厂库链接已替换"
perl -0777 -i -pe "s|http:\/\/share\.turinglabs\.net\/api\/.*?\`|http://xinhunshang.xyz:6001/submit_activity_codes/get/jxcfd/20/2\`|ig" ${ScriptsDir}/jd_cfd.js >/dev/null 2>&1 && echo -e "京喜财富岛库链接已替换"
perl -0777 -i -pe "s|http:\/\/share\.turinglabs\.net\/api\/.*?\`|http://xinhunshang.xyz:6001/submit_activity_codes/get/health/20/5\`|ig" ${ScriptsDir}/jd_health.js >/dev/null 2>&1 && echo -e "健康社区库链接已替换"
perl -0777 -i -pe "s|http:\/\/share\.turinglabs\.net\/api\/.*?\`|http://xinhunshang.xyz:6001/submit_activity_codes/get/sgmh/20/5\`|ig" ${ScriptsDir}/jd_sgmh.js >/dev/null 2>&1 && echo -e "闪购盲盒库链接已替换"
perl -0777 -i -pe "s|http:\/\/share\.turinglabs\.net\/api\/.*?\`|http://xinhunshang.xyz:6001/submit_activity_codes/get/carnivalcity/20/2\`|ig" ${ScriptsDir}/jd_carnivalcity.js >/dev/null 2>&1 && echo -e "手机狂欢城库链接已替换"
#perl -0777 -i -pe "s|http:\/\/share\.turinglabs\.net\/api\/.*?\`|http://xinhunshang.xyz:6001/submit_activity_codes/get/city/10/1\`|ig" ${ScriptsDir}/jd_city.js >/dev/null 2>&1 && echo -e "城城分现金库链接已替换"
perl -0777 -i -pe "s|https:\/\/code\.chiang\.fun\/api\/.*?\`|http://xinhunshang.xyz:6001/submit_activity_codes/get/jdzz/20/5\`|ig" ${ScriptsDir}/jd_jdzz.js >/dev/null 2>&1 && echo -e "京东赚赚库链接已替换"
perl -0777 -i -pe "s|https:\/\/code\.chiang\.fun\/api\/.*?\`|http://xinhunshang.xyz:6001/submit_activity_codes/get/jdcash/10/1\`|ig" ${ScriptsDir}/jd_cash.js >/dev/null 2>&1 && echo -e "领现金库链接已替换"
perl -0777 -i -pe "s|https:\/\/code\.chiang\.fun\/api\/.*?\`|http://xinhunshang.xyz:6001/submit_activity_codes/get/jdcrazyjoy/20\`|ig" ${ScriptsDir}/jd_crazy_joy.js >/dev/null 2>&1 && echo -e "疯狂JOY库链接已替换"

perl -0777 -i -pe "s|//pk助力|//pk助力\nawait \\$\.getScript(\"http://xinhunshang.xyz:6001/submit_activity_codes/get/zoopk/10\").then((text) => (\\$\.pkInviteList = JSON\.parse(text)\.data))|ig" ${ScriptsDir}/jd_zoo.js >/dev/null 2>&1 && echo -e "jd_zoo商圈云助力已添加"
perl -0777 -i -pe "s|//pk助力|await \\$\.getScript(\"http://xinhunshang.xyz:6001/submit_activity_codes/get/zoo/10/5\").then((text) => (\\$\.inviteList = JSON\.parse(text)\.data))|ig" ${ScriptsDir}/jd_zoo.js >/dev/null 2>&1 && echo -e "jd_zoo个人云助力已添加"
perl -0777 -i -pe "s|\\$\.inviteId = \\$\.oneInviteInfo\.inviteId;|\\$\.inviteId = \\$\.oneInviteInfo|ig" ${ScriptsDir}/jd_zoo.js >/dev/null 2>&1 && echo -e "jd_zoo内置KO"
#sed -i "/PK互助码：/a if \(process\.env\.Auto_Post\){\nlet nowTime = new Date\(\)\.getTime\(\) + new Date\(\)\.getTimezoneOffset\(\) \* 60 \* 1000 + 8 \* 60 \* 60 \* 1000;\nif \(new Date\(nowTime\)\.getHours\(\) === 0\) {\n\$\.getScript\(\`http://xinhunshang\.xyz:6001/submit_activity_codes/zoopk/\${data\.data\.result\.groupInfo\.groupAssistInviteId}/\${\$\.UserName}\`\)\.then\(\(text\) => \(console\.log\(text\)\)\);\n}\n}" ${ScriptsDir}/jd_zoo.js && echo -e "jd_zooPK自动上传"
sed -i "s/$.doSkillFlag = true;/ if (new Date()\.getHours()>= 18) {\\$\.doSkillFlag = true;}else{\\$\.doSkillFlag = false;}/" ${ScriptsDir}/jd_zoo.js && echo -e "jd_zoo已放弃上半场"

sed -i "/【开团成功】tuanId/a if \(process\.env\.Auto_Post\){\n\$\.getScript\(\`http://xinhunshang\.xyz:6001/submit_activity_codes/jxtuan/\${data\.data['tuanId']}/\${\$\.UserName}\`\)\.then\(\(text\) => \(console\.log\(text\)\)\);\n}" ${ScriptsDir}/jd_dreamFactory.js && echo -e "京喜工厂团ID自动上传"
sed -i "
/await jdDreamFactory()/ {
n
n
a await \$\.getScript\(\"http:\/\/xinhunshang\.xyz:6001\/submit_activity_codes\/get\/jxtuan\/20\/2\"\)\.then\(\(text\) => \(\$\.tuanIds = \$\.tuanIds\.concat\(JSON\.parse\(text\)\.data\)\)\)\nconsole\.log\(\$\.tuanIds\)
}" ${ScriptsDir}/jd_dreamFactory.js && echo -e "京喜工厂已内置私库"
sed -i "/await joinLeaderTuan/d" ${ScriptsDir}/jd_dreamFactory.js && echo -e "京喜工厂内置已KO"

echo -e "=================================\n"

############################## yangtingxiao脚本 ##########################################
echo -e "============ yangtingxiao脚本 ============"

perl -0777 -i -pe "s|.*?jd_nianBeastShareCode.*?\]\)\)|await \\$\.getScript(\"http://xinhunshang.xyz:6001/submit_activity_codes/get/zoopk/10\").then((text) => (shareCodeList = JSON\.parse(text)\.data))|ig" ${ScriptsDir}/yangtingxiao_jd_zoo.js >/dev/null 2>&1 && echo -e "yangtingxiao_jd_zoo商圈云助力已添加"
perl -0777 -i -pe "s|await zoo_getHomeData\('\S+-\S+'\);|await \\$\.getScript(\"http://xinhunshang.xyz:6001/submit_activity_codes/get/zoo/10/5\").then((text) => (shareCodeList = JSON\.parse(text)\.data))\nfor (let i in shareCodeList) {\nif (shareCodeList[i]) await zoo_getHomeData(shareCodeList[i]);\n}|ig" ${ScriptsDir}/yangtingxiao_jd_zoo.js >/dev/null 2>&1 && echo -e "yangtingxiao_jd_zoo个人云助力已添加"

sed -i 's|doPkSkill = true|doPkSkill = false|' $ScriptsDir/yangtingxiao_jd_zoo.js && echo -e "yangtingxiao_jd_zoo自动技能已禁用"
sed -i "/let doPkSkill/a if (new Date()\.getHours()>= 18) {doPkSkill = true;}else{doPkSkill = false;}" ${ScriptsDir}/yangtingxiao_jd_zoo.js && echo -e "yangtingxiao_jd_zoo已放弃上半场"

sed -i "
/商圈助力/ {
n
a console\.log\(merge\.nickname\+\`去助力PK码：\`\+inviteId\);switch \(data\.data\.bizCode\) \{case 0:console\.log\(\`助力成功\`\);break;case -201:console\.log\(\`助力已满\`\);\$\.oneInviteInfo\.max = true;break;case -202:console\.log\(\`已助力\`\);break;case -8:console\.log\(\`已经助力过该队伍\`\);break;case -6:case 108:console\.log\(\`助力次数已用光\`\);\$\.canHelp = false;break;default: console\.log\(\`怪兽大作战助力失败：\${JSON\.stringify\(data\)}\`\);\}
}" ${ScriptsDir}/yangtingxiao_jd_zoo.js && echo -e "yangtingxiao_jd_zoo商圈助力结果"

echo -e "=================================\n"

############################## Star261脚本 ##########################################
echo -e "============ Star261脚本 ============"

perl -0777 -i -pe "s|//pk助力|//pk助力\nawait \\$\.getScript(\"http://xinhunshang.xyz:6001/submit_activity_codes/get/zoopk/10\").then((text) => (\\$\.pkInviteList = JSON\.parse(text)\.data))|ig" ${ScriptsDir}/star261_jd_zoo.js >/dev/null 2>&1 && echo -e "star261_jd_zoo商圈云助力已添加"
perl -0777 -i -pe "s|//pk助力|await \\$\.getScript(\"http://xinhunshang.xyz:6001/submit_activity_codes/get/zoo/10/5\").then((text) => (\\$\.inviteList = JSON\.parse(text)\.data))|ig" ${ScriptsDir}/star261_jd_zoo.js >/dev/null 2>&1 && echo -e "star261_jd_zoo个人云助力已添加"
perl -0777 -i -pe "s|\\$\.inviteId = \\$\.oneInviteInfo\.inviteId;|\\$\.inviteId = \\$\.oneInviteInfo|ig" ${ScriptsDir}/star261_jd_zoo.js >/dev/null 2>&1 && echo -e "star261_jd_zoo内置KO"
#sed -i "/PK互助码：/a if \(process\.env\.Auto_Post\){\nlet nowTime = new Date\(\)\.getTime\(\) + new Date\(\)\.getTimezoneOffset\(\) \* 60 \* 1000 + 8 \* 60 \* 60 \* 1000;\nif \(new Date\(nowTime\)\.getHours\(\) === 0\) {\n\$\.getScript\(\`http://xinhunshang\.xyz:6001/submit_activity_codes/zoopk/\${data\.data\.result\.groupInfo\.groupAssistInviteId}/\${\$\.UserName}\`\)\.then\(\(text\) => \(console\.log\(text\)\)\);\n}\n}" ${ScriptsDir}/star261_jd_zoo.js && echo -e "star261_jd_zooPK自动上传"
sed -i "s/$.doSkillFlag = true;/ if (new Date()\.getHours()>= 18) {\\$\.doSkillFlag = true;}else{\\$\.doSkillFlag = false;}/" ${ScriptsDir}/star261_jd_zoo.js && echo -e "star261_jd_zoo已放弃上半场"

#let codeList = \[\]; 下3行
#\(codeList = JSON\.parse\(text\)\.data\)\)
sed -i "
/inviteCodeList\[k\]\.code/ {
n
n
n
n
a await \$\.getScript\(\"http:\/\/xinhunshang\.xyz:6001\/submit_activity_codes\/get\/name\/jxmc\/10\/5\"\)\.then\(\(text\) => \(codeList\.push\(JSON\.parse\(text\)\.data\)\)\)
}" ${ScriptsDir}/star261_jd_jxmc.js && echo -e "京喜牧场已内置私库"

echo -e "=================================\n"

############################## jdShare脚本 ##########################################
echo -e "============ jdShare脚本 ============"
perl -0777 -i -pe "s|http:\/\/api\.sharecode\.ga\/api\/.*?\`|http://xinhunshang.xyz:6001/submit_activity_codes/get/ddfactory/20/5\`|ig" ${ScriptsDir}/jdShare_jd_jdfactory.js >/dev/null 2>&1 && echo -e "东东工厂库链接已替换"
perl -0777 -i -pe "s|http:\/\/api\.sharecode\.ga\/api\/.*?\`|http://xinhunshang.xyz:6001/submit_activity_codes/get/farm/20/5\`|ig" ${ScriptsDir}/jdShare_jd_fruit.js >/dev/null 2>&1 && echo -e "东东农场库链接已替换"
perl -0777 -i -pe "s|http:\/\/api\.sharecode\.ga\/api\/.*?\`|http://xinhunshang.xyz:6001/submit_activity_codes/get/bean/20/5\`|ig" ${ScriptsDir}/jdShare_jd_plantBean.js >/dev/null 2>&1 && echo -e "种豆得豆库链接已替换"
perl -0777 -i -pe "s|http:\/\/api\.sharecode\.ga\/api\/.*?\`|http://xinhunshang.xyz:6001/submit_activity_codes/get/pet/20/5\`|ig" ${ScriptsDir}/jdShare_jd_pet.js >/dev/null 2>&1 && echo -e "东东萌宠库链接已替换"
perl -0777 -i -pe "s|http:\/\/api\.sharecode\.ga\/api\/.*?\`|http://xinhunshang.xyz:6001/submit_activity_codes/get/jxfactory/20/2\`|ig" ${ScriptsDir}/jdShare_jd_dreamFactory.js >/dev/null 2>&1 && echo -e "京喜工厂库链接已替换"
perl -0777 -i -pe "s|http:\/\/api\.sharecode\.ga\/api\/.*?\`|http://xinhunshang.xyz:6001/submit_activity_codes/get/jxcfd/20/2\`|ig" ${ScriptsDir}/jdShare_jd_cfd.js >/dev/null 2>&1 && echo -e "京喜财富岛库链接已替换"
perl -0777 -i -pe "s|http:\/\/api\.sharecode\.ga\/api\/.*?\`|http://xinhunshang.xyz:6001/submit_activity_codes/get/health/20/5\`|ig" ${ScriptsDir}/jdShare_jd_health.js >/dev/null 2>&1 && echo -e "健康社区库链接已替换"
perl -0777 -i -pe "s|http:\/\/api\.sharecode\.ga\/api\/.*?\`|http://xinhunshang.xyz:6001/submit_activity_codes/get/sgmh/20/5\`|ig" ${ScriptsDir}/jdShare_jd_sgmh.js >/dev/null 2>&1 && echo -e "闪购盲盒库链接已替换"
perl -0777 -i -pe "s|http:\/\/api\.sharecode\.ga\/api\/.*?\`|http://xinhunshang.xyz:6001/submit_activity_codes/get/carnivalcity/20/2\`|ig" ${ScriptsDir}/jdShare_jd_carnivalcity.js >/dev/null 2>&1 && echo -e "手机狂欢城库链接已替换"
sed -i "/【开团成功】tuanId/a if \(process\.env\.Auto_Post\){\n\$\.getScript\(\`http://xinhunshang\.xyz:6001/submit_activity_codes/jxtuan/\${data\.data['tuanId']}/\${\$\.UserName}\`\)\.then\(\(text\) => \(console\.log\(text\)\)\);\n}" ${ScriptsDir}/jdShare_jd_dreamFactory.js && echo -e "京喜工厂团ID自动上传"
sed -i "
/await jdDreamFactory()/ {
n
n
a await \$\.getScript\(\"http:\/\/xinhunshang\.xyz:6001\/submit_activity_codes\/get\/jxtuan\/20\/2\"\)\.then\(\(text\) => \(\$\.tuanIds = \$\.tuanIds\.concat\(JSON\.parse\(text\)\.data\)\)\)\nconsole\.log\(\$\.tuanIds\)
}" ${ScriptsDir}/jdShare_jd_dreamFactory.js && echo -e "京喜工厂已内置私库"
sed -i "/await joinLeaderTuan/d" ${ScriptsDir}/jdShare_jd_dreamFactory.js && echo -e "京喜工厂内置已KO"

echo -e "=================================\n"

echo -e "============ 处理脚本 ============"
HtmlDir=${ShellDir}/panel/public
for file in $(ls $HtmlDir); do
    if [ "${file##*.}" = "html" ]; then
        echo -e "${file} 已修改"
        perl -0777 -i -pe "s/京东薅羊毛控制面板|Dashboard/喝乌凹薅/ig" ${HtmlDir}/${file} >/dev/null 2>&1
        perl -0777 -i -pe "s/var animating = true;/var animating = false;/ig" ${HtmlDir}/${file} >/dev/null 2>&1
        #perl -0777 -i -pe "s|./css/main.css|https://raw.sevencdn.com/qhq/Myd/main/panel/public/css/main.css|ig" ${HtmlDir}/${file} >/dev/null 2>&1
        #sed -i "/.\/js\/script.js/d" ${HtmlDir}/${file}
        #sed -i "/>Stop</d" ${HtmlDir}/${file}
        #sed -i '/<canvas id="sakura"/' ${HtmlDir}/${file}
    fi
done
sed -i '/此方式得到的cookie有效期为30天/a const diy = true;' $ScriptsDir/getJDCookie.js && echo -e "DIY已标记"
sed -i 's|cat ${FileDiy}.*\?}|echo -e ""|' $ShellDir/git_pull.sh && echo -e "多余自定义判断已清理"
sed -i 's|\(\$(Combin_Sub \S*\?\) \S*\?)|\1)|g' $ShellDir/jd.sh && echo -e "jd.sh内置码已清理"
sed -i "/author;/d" $ScriptsDir/sendNotify.js && echo -e "通知结尾提示已删除"
sed -i 's|Name1=.*\?)|Name1=(fruit pet plantBean jdfactory dreamFactory crazy_joy jdzz cash sgmh cfd health)|' $ShellDir/export_sharecodes.sh
sed -i 's|Name2=.*\?)|Name2=(东东农场 东东萌宠 京东种豆得豆 东东工厂 京喜工厂 crazyJoy任务 京东赚赚 签到领现金 闪购盲盒 京喜财富岛 东东健康社区)|' $ShellDir/export_sharecodes.sh
sed -i 's|Name3=.*\?)|Name3=(Fruit Pet Bean JdFactory dreamFactory Joy Jdzz Cash Sgmh Cfd Health)|' $ShellDir/export_sharecodes.sh && echo -e "互助码整理脚本已更新"
sed -i "/## 生成互助规则模板/a  HelpType = 1" $ShellDir/export_sharecodes.sh && echo -e "修改生成互助规则模板"
sed -i 's|当前总红包：|当前红包：|' $ScriptsDir/jd_bean_change.js
sed -i 's|极速版红包：|极速红包：|' $ScriptsDir/jd_bean_change.js && echo -e "京豆变动通知内容格式已调整"

if [ ${iCan} = "true" ]; then
    echo -e "腾讯新闻"
    sed -i "s/process\.env\.\w*\?$/''/g" ${ScriptsDir}/Sunert_txnews_task.js
    sed -i "33r ${ScriptsDir}/Sunert_txnews_task.txt" ${ScriptsDir}/Sunert_txnews_task.js
    sed -i "s/process\.env\.\w*\?\.split()/''/g" ${ScriptsDir}/Sunert_txnews.js
    sed -i "32r ${ScriptsDir}/Sunert_txnews.txt" ${ScriptsDir}/Sunert_txnews.js
    echo -e "百度极速"
    sed -i "60r ${ScriptsDir}/Sunert_baidu_speed.txt" ${ScriptsDir}/Sunert_baidu_speed.js
    echo -e "中青看点"
    sed -i "s/\"false\";/\"true\";/" ${ScriptsDir}/Sunert_youth.js
    sed -i "35r ${ScriptsDir}/Sunert_youth.txt" ${ScriptsDir}/Sunert_youth.js
    sed -i "/delbody = 0;/a let readtimes;" ${ScriptsDir}/Sunert_Youth_Read.js
    sed -i "/YouthBodys = \[process\.env\.YOUTH_READ\]$/r ${ScriptsDir}/Sunert_Youth_Read.txt" ${ScriptsDir}/Sunert_Youth_Read.js
    sed -i "/timebodyVal = \$\.getdata('autotime_zq');$/r ${ScriptsDir}/Sunert_Youth_Read_Time.txt" ${ScriptsDir}/Sunert_Youth_Read.js

    echo -e "=================================\n"
fi

#sed -i '380c #[ -d ${ShellDir}/.git ] && Git_PullShell' /jd/git_pull.sh && echo "ExtraShell" >>/jd/git_pull.sh
#git fetch --all && git reset --hard
##############################  自  定  义  命  令  ##############################

## 京东试用脚本添加取关定时任务
#[ -f ${ScriptsDir}/jd_try.js ] && grep -q "5 10 \* \* \* bash jd jd_unsubscribe" ${ListCron}
#if [ $? -ne 0 ]; then
#  echo -e '# 京东试用脚本添加的取关定时任务\n5 10 * * * bash jd jd_unsubscribe' >>${ListCron}
#fi

#sed -i 's|11 9 \* \* \* bash jd qhqcz_post_code|1 0,9 * * * bash jd qhqcz_post_code|'  ${ConfigDir}/crontab.list
#sed -i 's|^.*bash jd jd_xtg$|30 11 \* \* \* bash jd jd_xtg|' ${ConfigDir}/crontab.list
sed -i 's|^\d.*bash jd jd_bean_change|#5 9 \* \* \* bash jd jd_bean_change|' ${ConfigDir}/crontab.list

#检查添加京喜团ID变量
if [[ $(grep -cEi 'export TUAN_ACTIVEID=".+?"' ${ConfigDir}/config.sh) -ne '0' ]]; then
    perl -0777 -i -pe 's/export TUAN_ACTIVEID=".+?"/export TUAN_ACTIVEID="bozIUUFcANuUdWpw3QdvPw=="/i' ${ConfigDir}/config.sh >/dev/null 2>&1
else
    perl -0777 -i -pe 's/## export/## export\n#京喜团ID\nexport TUAN_ACTIVEID="bozIUUFcANuUdWpw3QdvPw=="/i' ${ConfigDir}/config.sh >/dev/null 2>&1
fi

## 注释指定活动
echo -e "========== 暂时停用脚本 =========="
js_List="jd_cfd jd_dreamFactory jd_fruit jd_health jd_pet jd_plantBean jd_carnivalcity jd_jdfactory jd_sgmh jd_star_shop jd_jxmc"
for js_item in $js_List; do
    sed -i "s|\(^[0-9].*bash\) jd $js_item|# \1 jd $js_item|" ${ListCron} && echo -e "$js_item 已注释"
    #sed -i "/$js_item/d" ${ListCron} && echo -e "$js_item已删除"
done
echo -e "=================================\n"

## 删除过期活动
echo -e "========== 失效/过期脚本 =========="
js_List="qhqcz_jd_superBrand Ariszy_zy_618jc jd_superBrand jd_limitBox jd_ry618 jd_qqtmy long_hby_lottery adolf_flp adolf_superbox zooBaojiexiaoxiaole zooLongzhou zooLimitbox zooSupershophf star261_jd_zooMap star261_jd_zooCollect star261_jd_zoo yangtingxiao_jd_zoo jd_zoo jd_zooCollect txnews txnews_task"
for js_item in $js_List; do
    rm -rf ${ScriptsDir}/$js_item.js && sed -i "/$js_item/d" ${ListCron} && echo -e "$js_item 已删除"
done
#rm -rf ${ScriptsDir}/monk_shop_follow_sku.js && sed -i "/monk_shop_follow_sku/d" ${ListCron}
#rm -rf ${ScriptsDir}/zooOpencard01.js && sed -i "/zooOpencard01/d" ${ListCron}
echo -e "=================================\n"