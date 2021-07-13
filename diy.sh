#!/usr/bin/env bash

echo -e " 2021-07-14 00:11"

############################## DIY更新状态检查 ##############################
iCan=true
FileDiy=${ConfigDir}/diy.sh
if [ -f ${FileDiy} ]; then
    echo " "
else
    echo -e "当前系统时间：$(date "+%Y-%m-%d %H:%M")"
    grep -iq "const diy = true;" ${JD_DIR}/scripts/sendNotify.js
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

############################## 环境判断 ##############################
python_model_check()
{
  if python3 -c '''print("JD")''' >/dev/null 2>&1
  then
      echo "1"
  else
      echo "0"
  fi
}
result=`python_model_check $1`
if [ $result == 1 ]
then
  echo -e " Python3环境已安装\n"
else
  echo -e " Python3环境安装中"
  apk update && apk add --no-cache build-base g++ cairo-dev jpeg-dev pango-dev giflib-dev python3 py3-pip && cd /jd/scripts && npm install canvas --build-from-source && pip3 install requests && pip3 install --upgrade pip && cd /jd
fi


##############################  定  义  下  载  代  理  （内置功能）  ##############################
if [[ ${EnableExtraShellProxyDownload} == true ]]; then
    DownloadJudgment=${ExtraShellProxyUrl}
else
    DownloadJudgment=
fi


##############################  作  者  昵  称  &  脚  本  地  址  &  脚  本  名  称  （必填）  ##############################

author_list="qhqcz Sunert smiek2221 yangtingxiao longzhuzhu moposmall panghu Wenmoux JDHelloWorld passerby curtinlv SuperManito cdle Public Tsukasa007"

# 自用库
scripts_base_url_qhqcz=${DownloadJudgment}https://raw.githubusercontent.com/qhq/YesOrNo/main/Scripts/
my_scripts_list_qhqcz="91wii.js iQIYI.js post_code.js jd_bean_change.js jd_jxsign.js jd_dreamFactory_tuan.js jd_superBrand.js jd_zqfl.py jd_summer_movement.js"

# 中青、聚看、腾讯、百度 #https://raw.sevencdn.com/Sunert/Scripts/master/Task/
scripts_base_url_Sunert=https://gitee.com/Sunert/Scripts/raw/master/Task/
my_scripts_list_Sunert="baidu_speed.js youth.js Youth_Read.js jukan.js txnews.js"

# yangtingxiao
scripts_base_url_yangtingxiao=${DownloadJudgment}https://raw.githubusercontent.com/yangtingxiao/QuantumultX/master/scripts/jd/
my_scripts_list_yangtingxiao="jd_lotteryMachine.js"

# 龙王庙红包雨
scripts_base_url_longzhuzhu=${DownloadJudgment}https://raw.githubusercontent.com/longzhuzhu/nianyu/main/qx/
my_scripts_list_longzhuzhu="long_half_redrain.js long_super_redrain.js"

# moposmall
scripts_base_url_moposmall=${DownloadJudgment}https://raw.githubusercontent.com/moposmall/Script/main/Me/
my_scripts_list_moposmall="jx_mc.js jx_mc_coin.js jx_mc_emptycabbage.js"

# 柠檬/panghu
scripts_base_url_panghu=${DownloadJudgment}https://raw.githubusercontent.com/panghu999/panghu/master/
my_scripts_list_panghu="jd_wsdlb.js jd_lsj.js jd_joy-park.js jd_pk.js jd_wish.js jd_senbeans.js"

# star
scripts_base_url_star261=${DownloadJudgment}https://raw.githubusercontent.com/yuthpoetry/autosync/star261/scripts/
my_scripts_list_star261="jd_jxmc.js"

# Wenmoux 温某人
scripts_base_url_Wenmoux=${DownloadJudgment}https://raw.githubusercontent.com/Wenmoux/scripts/wen/jd/
my_scripts_list_Wenmoux="jd_ddnc_farmpark.js jd_wxFans.js"

# 二代
scripts_base_url_JDHelloWorld=${DownloadJudgment}https://raw.githubusercontent.com/JDHelloWorld/jd_scripts/main/
my_scripts_list_JDHelloWorld="jd_api_test.js"

# 写着玩
scripts_base_url_passerby=${DownloadJudgment}https://raw.githubusercontent.com/passerby-b/JDDJ/main/
my_scripts_list_passerby="jd_cfd2.js jd_dreamFactory2.js jd_fruit2.js"

# SuperManito
scripts_base_url_SuperManito=https://gitee.com/SuperManito/scripts/raw/master/
my_scripts_list_SuperManito=""

# songyangzz
scripts_base_url_songyangzz=${DownloadJudgment}https://raw.githubusercontent.com/songyangzz/jd_scripts/master/
my_scripts_list_songyangzz="jd_joy.js"

# cdle
scripts_base_url_cdle=${DownloadJudgment}https://raw.githubusercontent.com/cdle/jd_study/main/
my_scripts_list_cdle=""

# qqsdff
scripts_base_url_qqsdff=${DownloadJudgment}https://raw.githubusercontent.com/qqsdff/script/main/jd/
my_scripts_list_qqsdff="jd_jbczy.js"

## curtinlv
scripts_base_url_curtinlv=${DownloadJudgment}https://raw.githubusercontent.com/curtinlv/JD-Script/main/
my_scripts_list_curtinlv="jd_zjd.py jd_qjd.py jd_cashHelp.py"

## Tsukasa007
scripts_base_url_Tsukasa007=${DownloadJudgment}https://raw.githubusercontent.com/Tsukasa007/my_script/master/
my_scripts_list_Tsukasa007="jd_joypark_joy.js jd_joypark_task.js"

## smiek2221
scripts_base_url_smiek2221=${DownloadJudgment}https://raw.githubusercontent.com/smiek2221/scripts/master/
my_scripts_list_smiek2221="jd_sign_graphics.js jd_summer_movement.js jd_necklace.js jd_summer_movement_help.js jd_joy.js jd_joy_steal.js gua_wealth_island.js"

## Public
scripts_base_url_Public=${DownloadJudgment}https://raw.githubusercontent.com/jiulan/platypus/main/scripts/
my_scripts_list_Public="jd_lsj.js jd_nzmh.js"


############################## 随机函数 ##########################################
rand() {
    min=$1
    max=$(($2 - $min + 1))
    num=$(cat /proc/sys/kernel/random/uuid | cksum | awk -F ' ' '{print $1}')
    echo $(($num % $max + $min))
}
echo -e "+----------------- 下载脚本 -----------------+"
cd $ScriptsDir # 在 git_pull.sh 中已经定义 ScriptsDir 此变量，diy.sh 由 git_pull.sh 调用，因此可以直接使用此变量
#index=1
for author in $author_list; do
    echo -e " 下载 $author 的脚本"
    # 下载my_scripts_list中的每个js文件，重命名增加前缀"作者昵称_"，增加后缀".new"
    eval scripts_list=\$my_scripts_list_$author
    #echo $scripts_list
    eval url_list=\$scripts_base_url_$author
    #echo $url_list
    for js in $scripts_list; do
        eval url=$url_list$js
        echo " 地址 $url"
        eval name=$author"_"$js
        #echo $name
        wget -q --no-check-certificate $url -O $name.new

        # 如果上一步下载没问题，才去掉后缀".new"，如果上一步下载有问题，就保留之前正常下载的版本
        # 随机添加个cron到crontab.list
        if [ $? -eq 0 ]; then
            mv -f $name.new $name
            echo -e " 更新 $name 完成...\n"
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
            echo -e " 更新 $name 失败，使用上一次正常的版本...\n"
        fi
    done
    #index=$(($index + 1))
done
echo -e "+--------------------------------------------+\n"


if [[ $AutoTs = "true" ]]; then
echo -e "+---------------- 处理ts文件 ----------------+"
    isok="false"
    for file in $(ls $ScriptsDir); do
        if [ "${file##*.}" = "ts" ]; then
            [ ! -d ${LogDir}/${file%%.*} ] && mkdir -p ${LogDir}/${file%%.*} && echo " log/${file%%.*} 已新建"
            #if [ ! -e ${ScriptsDir}/${file%%.*}.js ]; then
                if [ isok = "false" ]; then
                    echo " npm install -g ts-node typescript axios --unsafe-perm=true --allow-root"
                    npm install -g ts-node typescript axios --unsafe-perm=true --allow-root
                fi
                tsc ${ScriptsDir}/${file} && echo " ${file}已转成${file%%.*}.js"
                isok="true"
            #fi
            [ $(grep -c "bash jd ${file%%.*}" /jd/config/crontab.list) -eq 0 ] && sed -i "/hangup/a# ${cron_min} ${cron_hour} * * * bash jd ${file%%.*}" /jd/config/crontab.list
        fi
    done
    [ $(grep -c "jd_zqfl" /jd/config/crontab.list) -eq 0 ] && sed -i "/hangup/a# 领京豆-早起福利\r1 0 * * * bash jd jd_zqfl" /jd/config/crontab.list
    [ $(grep -c "curtinlv_jd_qjd" /jd/config/crontab.list) -eq 0 ] && sed -i "/hangup/a# 抢京豆\r0 6 * * * bash jd curtinlv_jd_qjd" /jd/config/crontab.list
echo -e "+--------------------------------------------+\n"
fi


echo -e "+----------------- 添加注释 -----------------+"
JsList=$(grep -Eo "bash jd \w+" ${ConfigDir}/crontab.list)
for Cron in ${JsList}; do
    #echo -e "${ScriptsDir}/${Cron##* }.js"
    jname=${Cron##* }
    if [ -e ${ScriptsDir}/${Cron##* }.js ]; then
        jbz=$(sed -n "/new Env(\S\+);/p" ${ScriptsDir}/${Cron##* }.js)
        jbz=$(echo ${jbz/\"/\'})
        jbz=$(echo ${jbz/\"/\'})
        jbz=$(echo ${jbz#*\'})
        jbz=$(echo ${jbz%\'*})
        #echo " $jname : $jbz"
        #grep -cEi "^# ${jbz}\$" ${ListCron}
        if [ -n "$jbz" ] && [ $(grep -cEi "^# ${jbz}\$" ${ListCron}) -eq '0' ]; then
            echo " $jname : $jbz"
            sed -i "s/\(.*\?bash\) jd $jname/# $jbz\n\1 jd $jname/g" ${ListCron}
        fi
    fi
done
echo -e "+--------------------------------------------+\n"

echo -e "+----------------- 清理内置 -----------------+"

exJS=(qhqcz_post_code.js) #需排除的脚本
for file in $(ls $ScriptsDir); do
    #[[ ${array[@]/${var}/} != ${array[@]} ]] && echo "Yes" || echo "No"
    if [ "${file##*.}" = "js" ] && [[ ${exJS[@]/"${file%.*}"/} == ${exJS[@]} ]] && [ $(grep -cEi "nickName" ${ScriptsDir}/${file}) -ne '0' ] && [ $(grep -cEi "custName" ${ScriptsDir}/${file}) -eq '0' ]; then
        #perl -0777 -i -pe "s/(^|.*?)\\$.nickName = (['\\$].+)\n/\1\\$.nickName = \2\n\1\\$.custName = (process.env.CUSTNAME ? process.env.CUSTNAME : '').split(',')[i];\n/i" ${ScriptsDir}/${file} >/dev/null 2>&1
        #perl -0777 -i -pe "s/(^|\s+)\\$.nickName = (''|\\$.*?);/\1\\$.nickName = \2;\1\\$.custName = (process.env.CUSTNAME ? process.env.CUSTNAME : '').split(',')[i];/ig" ${ScriptsDir}/${file} >/dev/null 2>&1
        perl -0777 -i -pe "s/(.*?) \\$.nickName = (.*?)\n/\1 \\$.nickName = \2\n\1 \\$.custName = (process.env.CUSTNAME ? process.env.CUSTNAME : '').split(',')[i];\n/i" ${ScriptsDir}/${file} >/dev/null 2>&1
        #perl -0777 -i -pe "s/(^|.*?)\\$.UserName = (decodeURIComponent.*?)\n/\1\\$.UserName = \2\n\1\\$.custName = (process.env.CUSTNAME ? process.env.CUSTNAME : '').split(',')[i];\n/ig" ${ScriptsDir}/${file} >/dev/null 2>&1
        perl -0777 -i -pe "s/\\$.nickName \|\|/\\$.custName \|\| \\$.nickName \|\|/ig" ${ScriptsDir}/${file} >/dev/null 2>&1
        perl -0777 -i -pe "s/\\$\{\\$.nickName\}/\\$\{\\$.custName \|\| \\$.nickName\}/ig" ${ScriptsDir}/${file} >/dev/null 2>&1
        perl -0777 -i -pe "s/([^\/\`])\\$\{\\$.UserName\}/\1\\$\{\\$.custName \|\| \\$.UserName\}/ig" ${ScriptsDir}/${file} >/dev/null 2>&1
    fi
    if [ "${file##*.}" = "js" ] && [[ ${exJS[@]/"${file%.*}"/} == ${exJS[@]} ]] && [ $(grep -cEi "(let \w+Codes|const \w+Codes|let invite_pins|const shareID|const shareCodeArr|innerPkInviteList|authorCodeList|InviteList) = \[[\s\S]*?" ${ScriptsDir}/${file}) -ne '0' ]; then
        echo -en " ${file} | "
        echo $(grep -nEi "(let \w+Codes|const \w+Codes|let invite_pins|const shareID|const shareCodeArr|innerPkInviteList|authorCodeList|InviteList) = \[[\s\S]*?" ${ScriptsDir}/${file})
        perl -0777 -i -pe "s/((?:const \w+Codes|let \w+Codes|let invite_pins|const shareID|const shareCodeArr|innerPkInviteList|authorCodeList|InviteList) = \[)([\s\S]*?)(\])/\1''\3/ig" ${ScriptsDir}/${file} >/dev/null 2>&1
    fi
    if [ "${file##*.}" = "js" ] && [[ ${exJS[@]/"${file%.*}"/} == ${exJS[@]} ]] && [ $(grep -cEi "(helpAu.*?) = true" ${ScriptsDir}/${file}) -ne '0' ]; then
        echo -en " ${file} | "
        echo $(grep -nEi "(helpAu.*?) = true" ${ScriptsDir}/${file})
        perl -0777 -i -pe "s/(helpAu.*?) = true/\1 = false/ig" ${ScriptsDir}/${file} >/dev/null 2>&1
    fi
    if [ "${file##*.}" = "js" ] && [[ ${exJS[@]/"${file%.*}"/} == ${exJS[@]} ]] && [ $(grep -cEi "await getAuthorShareCode(|\d)\(\);$" ${ScriptsDir}/${file}) -ne '0' ]; then
        echo -en " ${file} | "
        echo $(grep -nEi "await getAuthorShareCode(|\d)\(\);$" ${ScriptsDir}/${file})
        perl -0777 -i -pe "s/await getAuthorShareCode(|\d)\(\);//ig" ${ScriptsDir}/${file} >/dev/null 2>&1
        #sed -ig "/await getAuthorShareCode\(\|\S\)();$/d" ${ScriptsDir}/${file} >/dev/null 2>&1
    fi
done

echo -e "+--------------------------------------------+\n"

#echo -e "+-------------- Lxk0301 脚本 ---------------+"
#替换内置
#perl -0777 -i -pe "s/((?:const \w+Codes|let \w+Codes|let invite_pins|const shareID) = \[)([\s\S]*?)(\])/\1'c2dj54vowh46iieh7u2ifzwzvu\@tzyicd7vcjefooqbns6eertieu\@vznl6lnj45ygubawzy4sypmk3wp7qavhgsxarra'\3/ig" ${ScriptsDir}/jdPlantBeanShareCodes.js >/dev/null 2>&1
#替换内置码库链接
#echo -e "+--------------------------------------------+\n"

echo -e "+------------ JDHelloWorld 脚本 -------------+"
perl -0777 -i -pe "s|https:\/\/api\.sharecode\.ga\/api\/.*?\`|http://xinhunshang.xyz:6001/help/v3/get/ddfactory/5/20\`|ig" ${ScriptsDir}/jd_jdfactory.js >/dev/null 2>&1 && echo -e " 东东工厂库链接已替换"
perl -0777 -i -pe "s|https:\/\/api\.sharecode\.ga\/api\/.*?\`|http://xinhunshang.xyz:6001/help/v3/get/farm/5/20\`|ig" ${ScriptsDir}/jd_fruit.js >/dev/null 2>&1 && echo -e " 东东农场库链接已替换"
perl -0777 -i -pe "s|https:\/\/api\.sharecode\.ga\/api\/.*?\`|http://xinhunshang.xyz:6001/help/v3/get/bean/5/20\`|ig" ${ScriptsDir}/jd_plantBean.js >/dev/null 2>&1 && echo -e " 种豆得豆库链接已替换"
perl -0777 -i -pe "s|https:\/\/api\.sharecode\.ga\/api\/.*?\`|http://xinhunshang.xyz:6001/help/v3/get/pet/5/20\`|ig" ${ScriptsDir}/jd_pet.js >/dev/null 2>&1 && echo -e " 东东萌宠库链接已替换"
perl -0777 -i -pe "s|https:\/\/api\.sharecode\.ga\/api\/.*?\`|http://xinhunshang.xyz:6001/help/v3/get/jxfactory/2/20\`|ig" ${ScriptsDir}/jd_dreamFactory.js >/dev/null 2>&1 && echo -e " 京喜工厂库链接已替换"
perl -0777 -i -pe "s|https:\/\/api\.sharecode\.ga\/api\/.*?\'|http://xinhunshang.xyz:6001/help/v3/get/jxcfd/1/20\'|ig" ${ScriptsDir}/jd_cfd.ts >/dev/null 2>&1 && echo -e " 京喜财富岛库链接已替换"
perl -0777 -i -pe "s|https:\/\/api\.sharecode\.ga\/api\/.*?\'|http://xinhunshang.xyz:6001/help/v3/get/jxmc/5/10\'|ig" ${ScriptsDir}/jd_jxmc.ts >/dev/null 2>&1 && echo -e " 京喜牧场库链接已替换"
perl -0777 -i -pe "s|https:\/\/api\.sharecode\.ga\/api\/.*?\`|http://xinhunshang.xyz:6001/help/v3/get/health/5/20\`|ig" ${ScriptsDir}/jd_health.js >/dev/null 2>&1 && echo -e " 健康社区库链接已替换"
perl -0777 -i -pe "s|https:\/\/api\.sharecode\.ga\/api\/.*?\`|http://xinhunshang.xyz:6001/help/v3/get/sgmh/5/20\`|ig" ${ScriptsDir}/jd_sgmh.js >/dev/null 2>&1 && echo -e " 闪购盲盒库链接已替换"
perl -0777 -i -pe "s|https:\/\/api\.sharecode\.ga\/api\/.*?\`|http://xinhunshang.xyz:6001/help/v3/get/carnivalcity/2/20\`|ig" ${ScriptsDir}/jd_carnivalcity.js >/dev/null 2>&1 && echo -e " 手机狂欢城库链接已替换"
sed -i "/【开团成功】tuanId/a if \(process\.env\.Auto_Post\){\n\$\.getScript\(\`http://xinhunshang\.xyz:6001/submit_activity_codes/jxtuan/\${data\.data['tuanId']}/\${\$\.UserName}\`\)\.then\(\(text\) => \(console\.log\(text\)\)\);\n}" ${ScriptsDir}/jd_dreamFactory.js && echo -e " 京喜工厂团ID自动上传"
sed -i "
/await jdDreamFactory()/ {
n
n
a await \$\.getScript\(\"http:\/\/xinhunshang\.xyz:6001\/help\/v3\/get\/jxtuan\/2\/20\"\)\.then\(\(text\) => \(\$\.tuanIds = \$\.tuanIds\.concat\(JSON\.parse\(text\)\.data\)\)\)\nconsole\.log\(\$\.tuanIds\)
}" ${ScriptsDir}/jd_dreamFactory.js && echo -e " 京喜工厂已内置私库"
sed -i "/await joinLeaderTuan/d" ${ScriptsDir}/jd_dreamFactory.js && echo -e " 京喜工厂内置已KO"
sed -i 's|production\.status === 3|production.status === 3 \&\& process.env.JX_SXTZ|' ${ScriptsDir}/jd_dreamFactory.js && echo -e " 京喜工厂失效通知开关"
sed -i "/【水果名称】/a await $.get({url: 'http://51.15.187.136:8080/activeJdFruitCode?code=' + $.farmInfo.farmUserPro.shareCode}, function (err, resp, data) {console.log('互助码状态:' + resp.body);})" ${ScriptsDir}/jd_fruit.js >/dev/null 2>&1 && echo -e " 东东农场passerby互助码激活已添加"
sed -i "/好友互助码】/a await $.get({url: 'http://51.15.187.136:8080/activeJdFactoryCode?code=' + data.user.encryptPin}, function (err, resp, data) {console.log('互助码状态:' + resp.body);})" ${ScriptsDir}/jd_dreamFactory.js >/dev/null 2>&1 && echo -e " 京喜工厂passerby互助码激活已添加"
sed -i "/旧的可继续使用/a await $.get({url: 'http://51.15.187.136:8080/activeJdCfdCode?code=' + $.UserName}, function (err, resp, data) {console.log('互助码状态:' + resp.body);})" ${ScriptsDir}/jd_cfd.js >/dev/null 2>&1 && echo -e " 财富岛passerby互助码激活已添加"
sed -i "s|QueryUserInfo\`), (err,|QueryUserInfo\`), async (err,|" ${ScriptsDir}/jd_cfd.js >/dev/null 2>&1

echo -e "+--------------------------------------------+\n"

echo -e "+-------------- passerby 脚本 ---------------+"
#perl -0777 -i -pe "s|http:\/\/51\.15\.187\.136:8080\/query.*?\`|http://xinhunshang.xyz:6001/help/v3/get/ddfactory/5/20\`|ig" ${ScriptsDir}/passerby_jd_jdfactory.js >/dev/null 2>&1 && echo -e " 东东工厂库链接已替换"
perl -0777 -i -pe "s|http:\/\/51\.15\.187\.136:8080\/query.*?\`|http://xinhunshang.xyz:6001/help/v3/get/farm/5/20\`|ig" ${ScriptsDir}/passerby_jd_fruit2.js >/dev/null 2>&1 && echo -e " 东东农场库链接已替换"
#perl -0777 -i -pe "s|http:\/\/51\.15\.187\.136:8080\/query.*?\`|http://xinhunshang.xyz:6001/help/v3/get/bean/5/20\`|ig" ${ScriptsDir}/passerby_jd_plantBean.js >/dev/null 2>&1 && echo -e " 种豆得豆库链接已替换"
#perl -0777 -i -pe "s|http:\/\/51\.15\.187\.136:8080\/query.*?\`|http://xinhunshang.xyz:6001/help/v3/get/pet/5/20\`|ig" ${ScriptsDir}/passerby_jd_pet.js >/dev/null 2>&1 && echo -e " 东东萌宠库链接已替换"
perl -0777 -i -pe "s|http:\/\/51\.15\.187\.136:8080\/query.*?\`|http://xinhunshang.xyz:6001/help/v3/get/jxfactory/2/20\`|ig" ${ScriptsDir}/passerby_jd_dreamFactory2.js >/dev/null 2>&1 && echo -e " 京喜工厂库链接已替换"
perl -0777 -i -pe "s|http:\/\/51\.15\.187\.136:8080\/query.*?\`|http://xinhunshang.xyz:6001/help/v3/get/jxcfd/1/20\`|ig" ${ScriptsDir}/passerby_jd_cfd2.js >/dev/null 2>&1 && echo -e " 京喜财富岛库链接已替换"
#perl -0777 -i -pe "s|http:\/\/51\.15\.187\.136:8080\/query.*?\`|http://xinhunshang.xyz:6001/help/v3/get/health/5/20\`|ig" ${ScriptsDir}/passerby_jd_health.js >/dev/null 2>&1 && echo -e " 健康社区库链接已替换"
#perl -0777 -i -pe "s|http:\/\/51\.15\.187\.136:8080\/query.*?\`|http://xinhunshang.xyz:6001/help/v3/get/sgmh/5/20\`|ig" ${ScriptsDir}/passerby_jd_sgmh.js >/dev/null 2>&1 && echo -e " 闪购盲盒库链接已替换"
#perl -0777 -i -pe "s|http:\/\/51\.15\.187\.136:8080\/query.*?\`|http://xinhunshang.xyz:6001/help/v3/get/carnivalcity/2/20\`|ig" ${ScriptsDir}/passerby_jd_carnivalcity.js >/dev/null 2>&1 && echo -e " 手机狂欢城库链接已替换"

echo -e "+--------------------------------------------+\n"

#echo -e "+--------------- star261 脚本 ---------------+"
#perl -0777 -i -pe "s|https:\/\/raw\.githubusercontent\.com\/star261\/jd\/main\/code\/dreamFactory_tuan\.json|http://xinhunshang.xyz:6001/help/v3/get/jxtuan/2/20|ig" ${ScriptsDir}/qhqcz_jd_dreamFactory_tuan.js >/dev/null 2>&1 && echo -e " 京喜工厂库链接已替换"
#sed -i "/res = await getAuthorShareCode/a await $.getScript('http://xinhunshang.xyz:6001/help/v3/get/jxtuan/2/20').then((text) => (res = JSON.parse(text).data))" ${ScriptsDir}/qhqcz_jd_dreamFactory_tuan.js >/dev/null 2>&1 && echo -e " 京喜工厂库链接已替换"
#sed -i "/开团成功tuanId为/a $.getScript\(\`http://xinhunshang.xyz:6001/submit_activity_codes/jxtuan/$\{data.data['tuanId']\}/$\{$.UserName\}\`\).then\(\(text\) => \(console.log\(text\)\)\);" ${ScriptsDir}/qhqcz_jd_dreamFactory_tuan.js >/dev/null 2>&1 && echo -e " 京喜工厂库链接已替换"
#sed -i "
#/inviteCodeList\[k\]\.code/ {
#n
#n
#n
#n
#a await \$\.getScript\(\"http:\/\/xinhunshang\.xyz:6001\/help\/v3\/get\/jxmc\/5\/10\"\)\.then\(\(text\) => #\(codeList\.push\(JSON\.parse\(text\)\.data\)\)\)
#}" ${ScriptsDir}/star261_jd_jxmc.js && echo -e " 京喜牧场已内置私库"
#echo -e "+--------------------------------------------+\n"

echo -e "+-------------- smiek2221 脚本 --------------+"
#sed -i "/\\$.inviteList.push({/i\await $.getScript\(\`http://xinhunshang.xyz:6001/submit_activity_codes/summer/$\{data.data.result.inviteId\}/$\{$.UserName\}\`\).then\(\(text\) => \(console.log\(text\)\)\);" ${ScriptsDir}/smiek2221_jd_summer_movement.js >/dev/null 2>&1 && echo -e " 燃动夏日私库已添加"
#sed -i "/开始内部京东账号【邀请好友助力】/i\await $.getScript('http://xinhunshang.xyz:6001/help/v3/get/summer/2/5').then((text) => ($.inviteList = $.inviteList.concat(JSON.parse(text).data)));"  ${ScriptsDir}/smiek2221_jd_summer_movement.js >/dev/null 2>&1 && echo -e " 燃动夏日私库已添加"
sed -i "/\\$.InviteList.push(/i\await $.getScript\(\`http://xinhunshang.xyz:6001/submit_activity_codes/jxcfd/$\{$.HomeInfo.strMyShareId\}/$\{$.UserName\}\`\).then\(\(text\) => \(console.log\(text\)\)\);" ${ScriptsDir}/smiek2221_gua_wealth_island.js >/dev/null 2>&1 && echo -e " 财富大陆提交私库已添加"
sed -i "/(HelpAuthorFlag)/i\await $.getScript('http://xinhunshang.xyz:6001/help/v3/get/jxcfd/2/5').then((text) => ($.inviteList = $.inviteList.concat(JSON.parse(text).data)));"  ${ScriptsDir}/smiek2221_gua_wealth_island.js >/dev/null 2>&1 && echo -e " 财富大陆拉取私库已添加"
echo -e "+--------------------------------------------+\n"


echo -e "+----------------- 处理文件 -----------------+"
HtmlDir=${ShellDir}/panel/public
for file in $(ls $HtmlDir); do
    if [ "${file##*.}" = "html" ]; then
        echo -e " ${file} 已修改"
        perl -0777 -i -pe "s/京东薅羊毛控制面板|Dashboard/喝乌凹薅/ig" ${HtmlDir}/${file} >/dev/null 2>&1
        perl -0777 -i -pe "s/var animating = true;/var animating = false;/ig" ${HtmlDir}/${file} >/dev/null 2>&1
        #perl -0777 -i -pe "s|./css/main.css|https://raw.sevencdn.com/qhq/Myd/main/panel/public/css/main.css|ig" ${HtmlDir}/${file} >/dev/null 2>&1
        #sed -i "/.\/js\/script.js/d" ${HtmlDir}/${file}
        #sed -i "/>Stop</d" ${HtmlDir}/${file}
        #sed -i '/<canvas id="sakura"/' ${HtmlDir}/${file}
    fi
done
sed -i '/sendNotify 推送通知功能/a const diy = true;' $ScriptsDir/sendNotify.js && echo -e " DIY已标记"
sed -i 's|cat ${FileDiy}.*\?}|echo -e ""|' $ShellDir/git_pull.sh && echo -e " 多余自定义判断已清理"
sed -i 's|\(\$(Combin_Sub \S*\?\) \S*\?)|\1)|g' $ShellDir/jd.sh && echo -e " jd.sh内置码已清理"
sed -i "/author;/d" $ScriptsDir/sendNotify.js && echo -e " 通知结尾提示已删除"
sed -i 's|Name1=.*\?)|Name1=(fruit pet plantBean jdfactory dreamFactory crazy_joy jdzz cash sgmh cfd health)|' $ShellDir/export_sharecodes.sh
sed -i 's|Name2=.*\?)|Name2=(东东农场 东东萌宠 京东种豆得豆 东东工厂 京喜工厂 crazyJoy任务 京东赚赚 签到领现金 闪购盲盒 京喜财富岛 东东健康社区)|' $ShellDir/export_sharecodes.sh
sed -i 's|Name3=.*\?)|Name3=(Fruit Pet Bean JdFactory dreamFactory Joy Jdzz Cash Sgmh Cfd Health)|' $ShellDir/export_sharecodes.sh && echo -e " 互助码整理脚本已更新"
sed -i "/## 生成互助规则模板/a  HelpType = 1" $ShellDir/export_sharecodes.sh && echo -e " 修改生成互助规则模板"
sed -i "s|\"j\[drx\]_|\"^j[drx]_|g" $ShellDir/jd.sh && echo -e " 第三方脚本识别已修正"
sed -i 's|当前总红包：|当前红包：|' $ScriptsDir/jd_bean_change.js
sed -i 's|极速版红包：|极速红包：|' $ScriptsDir/jd_bean_change.js && echo -e " 京豆变动通知内容格式已调整"
sed -i 's|&& allMessage)|\&\& allMessage.indexOf("可以收取")!=-1)|' ${ScriptsDir}/panghu_jd_wsdlb.js && echo -e " 大老板修改为可收取提醒"
#sed -i 's|&& allMessage)|\&\& allMessage.indexOf("已可兑换")!=-1)|' ${ScriptsDir}/jd_dreamFactory.js && echo -e " 京喜工厂改为可兑换提醒"
grep -q "qhqcz_post_code" ${ListCron} && sed -i '/&*qhqcz_post_code/c2 9 * * * bash jd jqhqcz_post_code' ${ListCron}
#sed -i "s|\(^[0-9].*bash\) jd qhqcz_jd_dreamFactory_tuan|${cron_min} * * * * bash jd qhqcz_jd_dreamFactory_tuan|" ${ListCron} && echo -e " qhqcz_jd_dreamFactory_tuan 注释已修改"
#sed -i "s|'User-Agent': '.*\?'|'User-Agent': 'jdapp;android;9.3.5;10;2346663656561603-4353564623932316;network/wifi;model/ONEPLUS A5010;addressid/138709979;aid/2dfceea045ed292a;oaid/;osVer/29;appBuild/86390;partner/jingdong;eufv/1;Mozilla/5.0 (Linux; Android 10; ONEPLUS A5010 Build/QKQ1.191014.012; wv) AppleWebKit/537.36 (KHTML, like Gecko) Version/4.0 Chrome/77.0.3865.120 MQQBrowser/6.2 TBS/045230 Mobile Safari/537.36'|g" ${ShellDir}/panel/server.js && echo -e " 扫码已修复"
sed -i "s|ccdd == 1|true|g" $ScriptsDir/smiek2221_jd_summer_movement.js && echo -e " 去你🐎的正道的光"

## 验证
#sed -i "s|require('\./sign_graphics_validate\.js')|require('./smiek2221_sign_graphics_validate.js')|" $ScriptsDir/smiek2221_jd_sign_graphics.js && echo -e " smiek2221_jd_sign_graphics 调用已修正"
#sed -i "s|require('\./MovementFaker\.js')|require('./smiek2221_MovementFaker.js')|" $ScriptsDir/smiek2221_jd_summer_movement.js && echo -e " smiek2221_jd_summer_movement 调用已修正"
[ -f ${ScriptsDir}/sign_graphics_validate.js ] || wget -q ${DownloadJudgment}https://raw.githubusercontent.com/smiek2221/scripts/master/sign_graphics_validate.js -O ${ScriptsDir}/sign_graphics_validate.js
[ -f ${ScriptsDir}/JDJRValidator_Pure.js ] || wget -q ${DownloadJudgment}https://raw.githubusercontent.com/smiek2221/scripts/master/JDJRValidator_Pure.js -O ${ScriptsDir}/JDJRValidator_Pure.js
[ -f ${ScriptsDir}/ZooFaker_Necklace.js ] || wget -q ${DownloadJudgment}https://raw.githubusercontent.com/smiek2221/scripts/master/ZooFaker_Necklace.js -O ${ScriptsDir}/ZooFaker_Necklace.js



if [[ $iCan = "true" ]]; then
    echo -e " 腾讯新闻"
    #sed -i "s/process\.env\.\w*\?$/''/g" ${ScriptsDir}/Sunert_txnews_task.js
    #sed -i "33r ${ScriptsDir}/Sunert_txnews_task.txt" ${ScriptsDir}/Sunert_txnews_task.js
    sed -i "s/process\.env\.\w*\?\.split()/''/g" ${ScriptsDir}/Sunert_txnews.js
    sed -i "32r ${ScriptsDir}/Sunert_txnews.txt" ${ScriptsDir}/Sunert_txnews.js
    echo -e " 百度极速"
    sed -i "60r ${ScriptsDir}/Sunert_baidu_speed.txt" ${ScriptsDir}/Sunert_baidu_speed.js
    echo -e " 中青看点"
    sed -i "s/\"false\";/\"true\";/" ${ScriptsDir}/Sunert_youth.js
    sed -i "35r ${ScriptsDir}/Sunert_youth.txt" ${ScriptsDir}/Sunert_youth.js
    sed -i "/delbody = 0;/a let readtimes;" ${ScriptsDir}/Sunert_Youth_Read.js
    sed -i "/YouthBodys = \[process\.env\.YOUTH_READ\]$/r ${ScriptsDir}/Sunert_Youth_Read.txt" ${ScriptsDir}/Sunert_Youth_Read.js
    sed -i "/timebodyVal = \$\.getdata('autotime_zq');$/r ${ScriptsDir}/Sunert_Youth_Read_Time.txt" ${ScriptsDir}/Sunert_Youth_Read.js
fi
echo -e "+--------------------------------------------+\n"

#sed -i '380c #[ -d ${ShellDir}/.git ] && Git_PullShell' /jd/git_pull.sh && echo "ExtraShell" >>/jd/git_pull.sh
#git fetch --all && git reset --hard
##############################  自  定  义  命  令  ##############################

## 京东试用脚本添加取关定时任务
#[ -f ${ScriptsDir}/jd_try.js ] && grep -q "5 10 \* \* \* bash jd jd_unsubscribe" ${ListCron}
#if [ $? -ne 0 ]; then
#  echo -e '# 京东试用脚本添加的取关定时任务\n5 10 * * * bash jd jd_unsubscribe' >>${ListCron}
#fi
## 修正定时
#grep -q "jdJxncTokens" ${ListCron} && sed -i '/&*jdJxncTokens/c#4 8 * * * bash jd jdJxncTokens' ${ListCron}

## bug fix
#[ -f ${ScriptsDir}/main.3b9712aa.js ] && rm -rf ${ScriptsDir}/main.3b9712aa.js

#检查添加京喜团ID变量
#if [[ $(grep -cEi 'export TUAN_ACTIVEID=".+?"' ${ConfigDir}/config.sh) -ne '0' ]]; then
#    perl -0777 -i -pe 's/export TUAN_ACTIVEID=".+?"/export TUAN_ACTIVEID="T_zZaWP6by9yA1wehxM4mg=="/i' ${ConfigDir}/config.sh >/dev/null 2>&1
#else
#    perl -0777 -i -pe 's/## export/## export\n#京喜团ID\nexport TUAN_ACTIVEID="T_zZaWP6by9yA1wehxM4mg=="/i' ${ConfigDir}/config.sh >/dev/null 2>&1
#fi

## 注释指定活动
echo -e "+--------------- 暂时停用脚本 ---------------+"
js_List="jd_bean_change passerby_jd_fruit2 passerby_jd_dreamFactory2 jd_big_winner jd_star_shop smiek2221_jd_summer_movement_help"
for js_item in $js_List; do
    sed -i "s|\(^[0-9].*bash\) jd $js_item|# \1 jd $js_item|" ${ListCron} && echo -e " $js_item 已注释"
    #sed -i "/$js_item/d" ${ListCron} && echo -e "$js_item已删除"
done
echo -e "+--------------------------------------------+\n"

## 强制取消定时注释
echo -e "+--------------- 强制开启脚本 ---------------+"
js_List=""
for js_item in $js_List; do
    sed -i "s/^#\([0-9].*bash\) jd $js_item/\1 jd $js_item/g" ${ListCron}
    sed -i "s/^# \([0-9].*bash\) jd $js_item/\1 jd $js_item/g" ${ListCron} && echo -e " $js_item 已开启"
    #sed -i "/$js_item/d" ${ListCron} && echo -e "$js_item已删除"
done
echo -e "+--------------------------------------------+\n"

## 删除过期活动
echo -e "+-------------- 失效/过期脚本 ---------------+"
js_List="qqsdff_jd_jbczy Tsukasa007_jd_sign Andy_Andy_sendBeans smiek2221_MovementFaker SuperManito_jd_khyl SuperManito_jx_cfd_lottery Wenmoux_jd_europeancup cdle_jd_joy_park_help SuperManito_jd_jxzpk passerby_jd_fruit2 passerby_jd_dreamFactory2 passerby_jd_cfd2"
for js_item in $js_List; do
    rm -rf ${ScriptsDir}/$js_item.js && sed -i "/$js_item/d" ${ListCron} && echo -e " $js_item 已删除"
done
#rm -rf ${ScriptsDir}/monk_shop_follow_sku.js && sed -i "/monk_shop_follow_sku/d" ${ListCron}
#rm -rf ${ScriptsDir}/zooOpencard01.js && sed -i "/zooOpencard01/d" ${ListCron}
echo -e "+--------------------------------------------+\n"


############################## 同步文件 ##########################################
#cd $ConfigDir
#echo -e "下载 server.js "
#wget -q --no-check-certificate ${DownloadJudgment}https://raw.githubusercontent.com/qhq/YesOrNo/main/Scripts/server.js -O server.js.new
#if [ $? -eq 0 ]; then
#  mv -f server.js.new server.js
#  echo -e "更新 server.js 完成"
#else
#  rm -rf server.js.new
#  echo -e "更新 server.js 失败，使用上一次正常的版本...\n"
#fi
#cp /jd/config/server.js /jd/panel/server.js
#pm2 restart /jd/panel/server.js

## remove env
#grep -q "JD_COOKIE" /etc/profile && sed -i "/JD_COOKIE/d" /etc/profile

