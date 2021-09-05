#!/usr/bin/env bash

echo -e "\033[33m[*]\033[0m DIY版本：2021-08-30 09:00"
DockerName=$(hostname)
echo -e "\033[33m[*]\033[0m 当前容器：${DockerName}"

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

##############################  定  义  下  载  代  理  （内置功能）  ##############################
[[ ${EnableExtraShellProxyDownload} == true ]] && ProxyJudge=${ExtraShellProxyUrl} || ProxyJudge=""

##############################  作  者  昵  称  &  脚  本  地  址  &  脚  本  名  称  （必填）  ##############################

author_list="qhqcz Sunert Aaron_lv smiek2221 star261 curtinlv yangtingxiao jiulan cdle JDHelloWorld SuperManito longzhuzhu moposmall panghu Wenmoux passerby Tsukasa007 Annyoo2021 shufflewzc zero205 airacg"

# 自用库
scripts_base_url_qhqcz=${ProxyJudge}https://raw.githubusercontent.com/qhq/YesOrNo/main/Scripts/
my_scripts_list_qhqcz="iQIYI.js post_code.js getName.js notice.js jd_bean_change.js jd_bean_change_new.js jd_dreamFactory_tuan.js jd_zqfl.py jd_enen.js jd_unsubscriLive.js jd_cleancart.js jd_ckcheck.js jdWuLiu.js jd_shop_sign.js"

# 中青、聚看、腾讯、百度 #https://raw.sevencdn.com/Sunert/Scripts/master/Task/
scripts_base_url_Sunert=${ProxyJudge}https://gitee.com/Sunert/Scripts/raw/master/Task/
my_scripts_list_Sunert="baidu_speed.js youth.js Youth_Read.js txnews.js"

# Aaron-lv
# https://github.com/Aaron-lv/sync/tree/jd_scripts
scripts_base_url_Aaron_lv=${ProxyJudge}https://raw.githubusercontent.com/Aaron-lv/sync/jd_scripts/
my_scripts_list_Aaron_lv="jd_cfd.js jd_sendBeans.js jd_big_winner.js jd_cfdtx.js jd_necklace.js jd_joy_reward.js jd_joy_run.js jd_bean_sign.js jx_sign.js jd_mohe.js jd_jxmc.js jd_nzmh.js jd_wish.js jd_daily_lottery.js jd_health.js jd_cash.js jd_redPacket.js jd_live.js jd_ccSign.js"

# smiek2221
# https://github.com/smiek2221/scripts
scripts_base_url_smiek2221=${ProxyJudge}https://raw.githubusercontent.com/smiek2221/scripts/master/
my_scripts_list_smiek2221="jd_sign_graphics.js jd_necklace.js jd_joy.js jd_joy_steal.js gua_wealth_island.js gua_MMdou.js gua_wealth_island_help.js"

# star261
# https://github.com/star261/jd/tree/main/
scripts_base_url_star261=${ProxyJudge}https://raw.githubusercontent.com/star261/jd/main/scripts/
my_scripts_list_star261="jd_jxmc.js jd_productZ4Brand.js"

# yangtingxiao
# https://github.com/yangtingxiao/QuantumultX/tree/master
scripts_base_url_yangtingxiao=${ProxyJudge}https://raw.githubusercontent.com/yangtingxiao/QuantumultX/master/scripts/jd/
my_scripts_list_yangtingxiao="jd_lotteryMachine.js"

# 龙王庙红包雨
# https://github.com/longzhuzhu/nianyu/
scripts_base_url_longzhuzhu=${ProxyJudge}https://raw.githubusercontent.com/longzhuzhu/nianyu/main/qx/
my_scripts_list_longzhuzhu="long_half_redrain.js long_super_redrain.js"

# moposmall
# https://github.com/moposmall/Script
scripts_base_url_moposmall=${ProxyJudge}https://raw.githubusercontent.com/moposmall/Script/main/Me/
my_scripts_list_moposmall="jx_mc.js jx_mc_coin.js jx_mc_emptycabbage.js"

# 柠檬/panghu
# https://github.com/panghu999/panghu/
scripts_base_url_panghu=${ProxyJudge}https://raw.githubusercontent.com/panghu999/panghu/master/
my_scripts_list_panghu=""

# Wenmoux 温某人
# https://github.com/Wenmoux/scripts/wen/jd/
scripts_base_url_Wenmoux=${ProxyJudge}https://raw.githubusercontent.com/Wenmoux/scripts/wen/jd/
my_scripts_list_Wenmoux="jd_ddnc_farmpark.js"

# JDHelloWorld
# https://github.com/JDHelloWorld/jd_scripts/
scripts_base_url_JDHelloWorld=${ProxyJudge}https://raw.githubusercontent.com/JDHelloWorld/jd_scripts/main/
my_scripts_list_JDHelloWorld="jd_api_test.ts"

# 写着玩 passerby
# https://github.com/passerby-b/JDDJ/
scripts_base_url_passerby=${ProxyJudge}https://raw.githubusercontent.com/passerby-b/JDDJ/main/
my_scripts_list_passerby=""

# SuperManito
# https://github.com/SuperManito/scripts
scripts_base_url_SuperManito=${ProxyJudge}https://gitee.com/SuperManito/scripts/raw/master/
my_scripts_list_SuperManito=""

# songyangzz
# https://github.com/songyangzz/jd_scripts
scripts_base_url_songyangzz=${ProxyJudge}https://raw.githubusercontent.com/songyangzz/jd_scripts/master/
my_scripts_list_songyangzz="jd_joy.js"

# cdle
# https://github.com/cdle/jd_study
scripts_base_url_cdle=${ProxyJudge}https://raw.githubusercontent.com/cdle/xdd/main/scripts/
my_scripts_list_cdle="jd_angryBean.js"

# qqsdff
# https://github.com/qqsdff/script
scripts_base_url_qqsdff=${ProxyJudge}https://raw.githubusercontent.com/qqsdff/script/main/jd/
my_scripts_list_qqsdff="jd_jbczy.js"

# curtinlv
# https://github.com/curtinlv/JD-Script
scripts_base_url_curtinlv=${ProxyJudge}https://raw.githubusercontent.com/curtinlv/JD-Script/main/
my_scripts_list_curtinlv="jd_cashHelp.py jd_qjd.py"

# Tsukasa007
# https://github.com/Tsukasa007/my_script
scripts_base_url_Tsukasa007=${ProxyJudge}https://raw.githubusercontent.com/Tsukasa007/my_script/master/
my_scripts_list_Tsukasa007="jd_joypark_joy.js jd_joypark_task.js"

# jiulan
# https://github.com/jiulan/platypus/
scripts_base_url_jiulan=${ProxyJudge}https://raw.githubusercontent.com/jiulan/platypus/main/scripts/
my_scripts_list_jiulan="jd_lsj.js jd_cfdtx.js"

# Annyoo2021
# https://github.com/Annyoo2021/scripts
scripts_base_url_Annyoo2021=${ProxyJudge}https://raw.githubusercontent.com/Annyoo2021/scripts/main/
my_scripts_list_Annyoo2021="jd_jxzpk.js"

# shufflewzc
# https://github.com/shufflewzc/faker2
scripts_base_url_shufflewzc=${ProxyJudge}https://raw.githubusercontent.com/shufflewzc/faker2/main/
my_scripts_list_shufflewzc="jd_try.js jd_DrawEntrance.js jd_moneyTree_heip.js jd_dwapp.js jd_fan.js"

# zero205
# https://github.com/zero205/JD_tencent_scf
scripts_base_url_zero205=${ProxyJudge}https://raw.githubusercontent.com/zero205/JD_tencent_scf/main/
my_scripts_list_zero205="jd_dpqd.js"

# airacg
# https://github.com/airacg/jd_task
scripts_base_url_airacg=${ProxyJudge}https://raw.githubusercontent.com/airacg/jd_task/main/
my_scripts_list_airacg="jd-reward-joy.js jd-task-price.js jd-task-invokeKey.js jd-task-validate.js jx-help-cashback.js"

############################## 随机函数 ##########################################
cd ${ShellDir}
#git remote -v | grep "supermanito" -wq
#[ $? -ne 0 ] && clear && echo -e "\033[31m\n非本项目用户禁止使用！\n\033[0m" && exit 1

rand() {
    min=$1
    max=$(($2 - $min + 1))
    num=$(cat /proc/sys/kernel/random/uuid | cksum | awk -F ' ' '{print $1}')
    echo $(($num % $max + $min))
}

echo -e "\033[33m[*]\033[0m 执行自定义脚本🔔\n"
echo -e "+----------------- 下载脚本 -----------------+"
for author in $author_list; do
    eval scripts_list=\$my_scripts_list_$author
    eval url_list=\$scripts_base_url_$author
    ## 判断脚本来源仓库
    format_url=$(echo $url_list | awk -F '.com' '{print$NF}' | sed 's/.$//')
  if [[ $(echo $url_list | egrep -o "github|gitee") == "github" ]]; then
    repository_platform="https://github.com"
    repository_branch=$(echo $format_url | awk -F '/' '{print$4}')
    reformat_url=$(echo $format_url | sed "s|$repository_branch|tree/$repository_branch|g")
    [[ ${EnableExtraShellProxy} == true ]] && DownloadJudgment="(代理)" || DownloadJudgment=""
  elif [[ $(echo $url_list | egrep -o "github|gitee") == "gitee" ]]; then
    repository_platform="https://gitee.com"
    reformat_url=$(echo $format_url | sed "s|/raw/|/tree/|g")
    DownloadJudgment=""
  fi
    repository_url="$repository_platform$reformat_url"
    echo -e "\033[33m[更新]\033[0m $author 的活动脚本${DownloadJudgment}:"
    echo -e "\033[33m[仓库]\033[0m $repository_url "

  for js in $scripts_list; do
    croname=""
    script_date_standard=""

    eval url=$url_list$js
    eval name=$author"_"$js
    wget -q --no-check-certificate $url -O $ScriptsDir/$name.new
    if [ $? -eq 0 ]; then
      mv -f $ScriptsDir/$name.new $ScriptsDir/$name
      echo -e "\033[32m[ OK ]\033[0m $name"

      case $name in
      jddjCookie.js | sign_graphics_validate.js | JDJRValidator_Pure.js | ZooFaker_Necklace.js)
        continue
        ;;
      esac

      croname=$(echo "$name" | awk -F\. '{print $1}' | perl -pe "{s|jd_||; s|jx_||; s|jr_||;}")
      script_date_standard=$(cat $ScriptsDir/$name | grep "https" | awk '{if($1~/^[0-59]/) print $1,$2,$3,$4,$5}' | sort | uniq | head -n 1)
      case $name in
      jd_cashHelp.py)
        script_date="8 */4 * * *" # 指定签到领现金的定时
        ;;
      jd_qjd.py)
        script_date="1 0 * * *" # 指定抢京豆的定时
        ;;
      *)
        if [[ -z ${script_date_standard} ]]; then
          script_date=$(cat $ScriptsDir/$name | egrep "cron|script-path|tag|$name" | head -n 1 | sed "s/[a-zA-Z\"\-\.\=\:\_]//g" | awk '{if($1~/^[0-59]/) print $1,$2,$3,$4,$5; else if ($1~/^[*]/) print $2,$3,$4,$5,$6}')
        else
          script_date=${script_date_standard}
        fi
        ;;
      esac

      if [ -z "${script_date}" ]; then
        cron_min=$(rand 1 59)
        cron_hour=$(rand 7 9)
        [ $(grep -c "$croname" $ListCrontabUser) -eq 0 ] && sed -i "/hang up/a${cron_min} ${cron_hour} * * * $TaskCmd $croname" $ListCrontabUser
      else
        [ $(grep -c "$croname" $ListCrontabUser) -eq 0 ] && sed -i "/hang up/a${script_date} $TaskCmd $croname" $ListCrontabUser
      fi
    else
      [ -f $ScriptsDir/$name.new ] && rm -f $ScriptsDir/$name.new
      echo -e "\033[31m[ERR!]\033[0m $name 更新失败，使用上一次正常的版本"
    fi
  done
  echo ''
  index=$(($index + 1))
done
echo -e "+--------------------------------------------+\n"

if [[ $AutoTs = "true" ]]; then
    echo -e "+---------------- 处理ts文件 ----------------+"
    isok="false"
    for file in $(ls $ScriptsDir); do
        if [ "${file##*.}" = "ts" ]; then
            [ ! -d ${LogDir}/${file%%.*} ] && mkdir -p ${LogDir}/${file%%.*} && echo " 已新建 log/${file%%.*}"
            #if [ ! -e ${ScriptsDir}/${file%%.*}.js ]; then
            if [ isok = "false" ]; then
                echo " npm install -g ts-node typescript axios --unsafe-perm=true --allow-root"
                npm install -g ts-node typescript axios --unsafe-perm=true --allow-root
            fi
            tsc ${ScriptsDir}/${file} && echo " ${file} 已转成 ${file%%.*}.js"
            isok="true"
            #fi
            [ $(grep -c "bash jd ${file%%.*}" /jd/config/crontab.list) -eq 0 ] && sed -i "/hangup/a# ${cron_min} ${cron_hour} * * * bash jd ${file%%.*}" /jd/config/crontab.list
        fi
    done
    [ $(grep -c "jd_zqfl" /jd/config/crontab.list) -eq 0 ] && sed -i "/hangup/a# 领京豆-早起福利\r1 0 * * * bash jd jd_zqfl" /jd/config/crontab.list
    [ $(grep -c "curtinlv_jd_qjd" /jd/config/crontab.list) -eq 0 ] && sed -i "/hangup/a# 抢京豆\r0 6 * * * bash jd curtinlv_jd_qjd" /jd/config/crontab.list
    echo -e "+--------------------------------------------+\n"
fi

echo -e "+----------------- 清理内置 -----------------+"
exJS=(qhqcz_post_code.js) #需排除的脚本
for file in $(ls $ScriptsDir); do
    #[[ ${array[@]/${var}/} != ${array[@]} ]] && echo "Yes" || echo "No"
    if [ "${file##*.}" = "js" ] && [[ ${exJS[@]/"${file%.*}"/} == ${exJS[@]} ]] && [ $(grep -cEi "nickName ||" ${ScriptsDir}/${file}) -ne '0' ]; then
        #    perl -0777 -i -pe "s/\\$.nickName \|\|/\\$.custName \|\| \\$.nickName \|\|/ig" ${ScriptsDir}/${file} >/dev/null 2>&1
        #    perl -0777 -i -pe "s/\\$\{\\$.nickName\}/\\$\{\\$.custName \|\| \\$.nickName\}/ig" ${ScriptsDir}/${file} >/dev/null 2>&1
        #    perl -0777 -i -pe "s/([^\/\`])\\$\{\\$.UserName\}/\1\\$\{\\$.custName \|\| \\$.UserName\}/ig" ${ScriptsDir}/${file} >/dev/null 2>&1
        perl -0777 -i -pe "s/京东账号(.*?)\\$\{\\$.nickName \|\| /京东账号\1\\$\{/ig" ${ScriptsDir}/${file} >/dev/null 2>&1
        perl -0777 -i -pe "s/京东账号(.*?)\\$\{\\$.nickName\}/京东账号\1\\$\{\\$.UserName\}/ig" ${ScriptsDir}/${file} >/dev/null 2>&1
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
    if [ "${file##*.}" = "js" ] && [[ ${exJS[@]/"${file%.*}"/} == ${exJS[@]} ]] && [ $(grep -cEi "await getAuthorShareCode" ${ScriptsDir}/${file}) -ne '0' ]; then
        echo -en " ${file} | "
        echo $(grep -nEi "await getAuthorShareCode" ${ScriptsDir}/${file})

        #perl -0777 -i -pe "s/await getAuthorShareCode(|\d)\(\);//ig" ${ScriptsDir}/${file} >/dev/null 2>&1
        [ $(grep -c "function getAuthorShareCode999" ${ScriptsDir}/${file}) -eq 0 ] && sed -i "/function getAuthorShareCode/i\ function getAuthorShareCode999(){}" ${ScriptsDir}/${file} >/dev/null 2>&1
        [ $(grep -c "function getAuthorShareCode999" ${ScriptsDir}/${file}) -ne 0 ] && perl -0777 -i -pe "s/await getAuthorShareCode(|\d)\(/await getAuthorShareCode999(/ig" ${ScriptsDir}/${file} >/dev/null 2>&1
        #sed -ig "/await getAuthorShareCode\(\|\S\)();$/d" ${ScriptsDir}/${file} >/dev/null 2>&1
    fi
    if [ "${file##*.}" = "js" ] && [[ ${exJS[@]/"${file%.*}"/} == ${exJS[@]} ]] && [ $(grep -cEi "await getAuthorShareCode(|\d)\(\);$" ${ScriptsDir}/${file}) -ne '0' ]; then
        echo -en " ${file} | "
        echo $(grep -nEi "await getAuthorShareCode(|\d)\(\);$" ${ScriptsDir}/${file})
        perl -0777 -i -pe "s/await getAuthorShareCode(|\d)\(\);//ig" ${ScriptsDir}/${file} >/dev/null 2>&1
        #sed -ig "/await getAuthorShareCode\(\|\S\)();$/d" ${ScriptsDir}/${file} >/dev/null 2>&1
    fi
    #if [ $(grep -cEi "invokeKey=NRp8OPxZMFXmGkaE" ${ScriptsDir}/${file}) -ne '0' ]; then
    #    echo -en " ${file} | "
    #    echo $(grep -nEi "invokeKey=NRp8OPxZMFXmGkaE" ${ScriptsDir}/${file})
    #    perl -0777 -i -pe "s/invokeKey=NRp8OPxZMFXmGkaE/invokeKey=qRKHmL4sna8ZOP9F/ig" ${ScriptsDir}/${file} >/dev/null 2>&1
    #fi
done
echo -e "+--------------------------------------------+\n"

#echo -e "+-------------- Lxk0301 脚本 ---------------+"
#替换内置
#perl -0777 -i -pe "s/((?:const \w+Codes|let \w+Codes|let invite_pins|const shareID) = \[)([\s\S]*?)(\])/\1'c2dj54vowh46iieh7u2ifzwzvu\@tzyicd7vcjefooqbns6eertieu\@vznl6lnj45ygubawzy4sypmk3wp7qavhgsxarra'\3/ig" ${ScriptsDir}/jdPlantBeanShareCodes.js >/dev/null 2>&1
#替换内置码库链接
#echo -e "+--------------------------------------------+\n"

echo -e "+------------ JDHelloWorld 脚本 -------------+"
perl -0777 -i -pe "s|([^'])https:\/\/api\.sharecode\.ga\/api\/[^r].*?\`|\1http://xinhunshang.xyz:6001/help/v3/get/ddfactory/5/20\`|ig" ${ScriptsDir}/jd_jdfactory.js >/dev/null 2>&1 && echo -e " 东东工厂库链接已替换"
perl -0777 -i -pe "s|([^'])https:\/\/api\.sharecode\.ga\/api\/[^r].*?\`|\1http://xinhunshang.xyz:6001/help/v3/get/farm/5/20\`|ig" ${ScriptsDir}/jd_fruit.js >/dev/null 2>&1 && echo -e " 东东农场库链接已替换"
perl -0777 -i -pe "s|([^'])https:\/\/api\.sharecode\.ga\/api\/[^r].*?\`|\1http://xinhunshang.xyz:6001/help/v3/get/bean/5/20\`|ig" ${ScriptsDir}/jd_plantBean.js >/dev/null 2>&1 && echo -e " 种豆得豆库链接已替换"
perl -0777 -i -pe "s|([^'])https:\/\/api\.sharecode\.ga\/api\/[^r].*?\`|\1http://xinhunshang.xyz:6001/help/v3/get/pet/5/20\`|ig" ${ScriptsDir}/jd_pet.js >/dev/null 2>&1 && echo -e " 东东萌宠库链接已替换"
perl -0777 -i -pe "s|([^'])https:\/\/api\.sharecode\.ga\/api\/[^r].*?\`|\1http://xinhunshang.xyz:6001/help/v3/get/jxfactory/2/20\`|ig" ${ScriptsDir}/jd_dreamFactory.js >/dev/null 2>&1 && echo -e " 京喜工厂库链接已替换"
perl -0777 -i -pe "s|([^'])https:\/\/api\.sharecode\.ga\/api\/[^r].*?\`|\1http://xinhunshang.xyz:6001/help/v3/get/jxcfd/1/20\`|ig" ${ScriptsDir}/jd_cfd.ts >/dev/null 2>&1 && echo -e " 京喜财富岛库链接已替换"
perl -0777 -i -pe "s|([^'])https:\/\/api\.sharecode\.ga\/api\/[^r].*?\`|\1http://xinhunshang.xyz:6001/help/v3/get/jxmc/5/10\`|ig" ${ScriptsDir}/jd_jxmc.ts >/dev/null 2>&1 && echo -e " 京喜牧场库链接已替换"
perl -0777 -i -pe "s|([^'])https:\/\/api\.sharecode\.ga\/api\/[^r].*?\`|\1http://xinhunshang.xyz:6001/help/v3/get/health/5/20\`|ig" ${ScriptsDir}/jd_health.js >/dev/null 2>&1 && echo -e " 健康社区库链接已替换"
perl -0777 -i -pe "s|([^'])https:\/\/api\.sharecode\.ga\/api\/[^r].*?\`|\1http://xinhunshang.xyz:6001/help/v3/get/sgmh/5/20\`|ig" ${ScriptsDir}/jd_sgmh.js >/dev/null 2>&1 && echo -e " 闪购盲盒库链接已替换"
#perl -0777 -i -pe "s|([^'])https:\/\/api\.sharecode\.ga\/api\/[^r].*?\`|\1http://xinhunshang.xyz:6001/help/v3/get/carnivalcity/2/20\`|ig" ${ScriptsDir}/jd_carnivalcity.js >/dev/null 2>&1 && echo -e " 手机狂欢城库链接已替换"
perl -0777 -i -pe "s|([^'])https:\/\/code\.chiang\.fun\/api\/.*?\`|\1http://xinhunshang.xyz:6001/help/v3/get/jdcash/5/20\`|ig" ${ScriptsDir}/jd_cash.js >/dev/null 2>&1 && echo -e " 领现金库链接已替换"
sed -i "/【开团成功】tuanId/a if \(process\.env\.Auto_Post\){\n\$\.getScript\(\`http://xinhunshang\.xyz:6001/v3/submit_activity_codes/jxtuan/\${data\.data['tuanId']}/\${\$\.UserName}\`\)\.then\(\(text\) => \(console\.log\(text\)\)\);\n}" ${ScriptsDir}/jd_dreamFactory.js && echo -e " 京喜工厂团ID自动上传"
sed -i "
/await jdDreamFactory()/ {
n
n
a await \$\.getScript\(\"http:\/\/xinhunshang\.xyz:6001\/help\/v3\/get\/jxtuan\/2\/20\"\)\.then\(\(text\) => \(\$\.tuanIds = \$\.tuanIds\.concat\(JSON\.parse\(text\)\.data\)\)\)\nconsole\.log\(\$\.tuanIds\)
}" ${ScriptsDir}/jd_dreamFactory.js && echo -e " 京喜工厂已内置私库"
sed -i "/await joinLeaderTuan/d" ${ScriptsDir}/jd_dreamFactory.js && echo -e " 京喜工厂内置已KO"
sed -i 's|production\.status === 3|production.status === 3 \&\& process.env.JX_SXTZ|' ${ScriptsDir}/jd_dreamFactory.js && echo -e " 京喜工厂失效通知开关"
[ $(grep -c "51.15.187.136" ${ScriptsDir}/jd_fruit.js) -eq 0 ] && sed -i "/【水果名称】/a await $.get({url: 'http://51.15.187.136:8080/activeJdFruitCode?code=' + $.farmInfo.farmUserPro.shareCode}, function (err, resp, data) {console.log('互助码状态:' + resp.body);})" ${ScriptsDir}/jd_fruit.js >/dev/null 2>&1 && echo -e " 东东农场passerby互助码激活已添加"
[ $(grep -c "51.15.187.136" ${ScriptsDir}/jd_dreamFactory.js) -eq 0 ] && sed -i "/好友互助码】/a await $.get({url: 'http://51.15.187.136:8080/activeJdFactoryCode?code=' + data.user.encryptPin}, function (err, resp, data) {console.log('互助码状态:' + resp.body);})" ${ScriptsDir}/jd_dreamFactory.js >/dev/null 2>&1 && echo -e " 京喜工厂passerby互助码激活已添加"
[ $(grep -c "51.15.187.136" ${ScriptsDir}/jd_cfd.ts) -eq 0 ] && sed -i "/旧的可继续使用/a await $.get({url: 'http://51.15.187.136:8080/activeJdCfdCode?code=' + $.UserName}, function (err, resp, data) {console.log('互助码状态:' + resp.body);})" ${ScriptsDir}/jd_cfd.ts >/dev/null 2>&1 && echo -e " 财富岛passerby互助码激活已添加"
sed -i "s|QueryUserInfo\`), (err,|QueryUserInfo\`), async (err,|" ${ScriptsDir}/jd_cfd.ts >/dev/null 2>&1
[ $(grep -c "xinhunshang.xyz:6001/v3/submit_activity_codes" ${ScriptsDir}/jd_jxmc.ts) -eq 0 ] && sed -i "/'助力码：'/a\await axios.get\(\`http://xinhunshang.xyz:6001/v3/submit_activity_codes/jxmc/$\{homePageInfo.data.sharekey\}/$\{cookie.match(/pt_pin=([^;]*)/)\![1]\}\`\).then\(\(text\) => \(console.log\(text.data\)\)\);" ${ScriptsDir}/jd_jxmc.ts >/dev/null 2>&1 && echo -e " 京喜牧场提交私库已添加"
sed -i "s|md5 !== res.data|md5 !== md5|" ${ScriptsDir}/jd_cfd_loop.ts >/dev/null 2>&1 && echo -e " MD5验证已移除"
#sed -i "s|if(_0x\w\{6\}==='1'|if('1'==='1'|" ${ScriptsDir}/jd_dreamFactory.js >/dev/null 2>&1 && echo -e " 尝试"
sed -i "s|_0x\w\{6\}\['sendNotify'\].*\?\]);||" ${ScriptsDir}/jd_dreamFactory.js >/dev/null 2>&1 && echo -e " 移除上报失败推送"
sed -i "s|_0x\w\{6\}\['sendNotify'\].*\?\]);||" ${ScriptsDir}/jd_plantBean.js >/dev/null 2>&1 && echo -e " 移除上报失败推送"
sed -i "s|_0x\w\{6\}\['sendNotify'\].*\?\]);||" ${ScriptsDir}/jd_fruit.js >/dev/null 2>&1 && echo -e " 移除上报失败推送"
#sed -i 's|&& allMessage)|\&\& allMessage.indexOf("已可兑换")!=-1)|' ${ScriptsDir}/jd_dreamFactory.js && echo -e " 京喜工厂改为可兑换提醒"
sed -i "/errMsg);/d" ${ScriptsDir}/jd_fruit.js && echo -e " 农场异常不做通知"
sed -i "/errMsg);/d" ${ScriptsDir}/jd_pet.js && echo -e " 萌宠异常不做通知"
sed -i "/errMsg);/d" ${ScriptsDir}/jd_plantBean.js && echo -e " 种豆异常不做通知"
sed -i "/authorCode.map/d" ${ScriptsDir}/jd_cash.js && echo -e " 领现金助力错误已修复"
sed -i 's|首页->好物0元造进行兑换|我的->京喜工厂 进行兑换|g' $ScriptsDir/jd_dreamFactory.js
[ $(grep -c "www.helpu.cf" ${ScriptsDir}/jd_fruit.js) -eq 0 ] && sed -i "/【水果名称】/a await $.get({url: 'http://www.helpu.cf/jdcodes/submit.php?type=farm&code=' + $.farmInfo.farmUserPro.shareCode}, function (err, resp, data) {console.log('互助码状态:' + resp.body);})" ${ScriptsDir}/jd_fruit.js >/dev/null 2>&1 && echo -e " 东东农场helpu互助码激活已添加"
[ $(grep -c "www.helpu.cf" ${ScriptsDir}/jd_dreamFactory.js) -eq 0 ] && sed -i "/好友互助码】/a await $.get({url: 'http://www.helpu.cf/jdcodes/submit.php?type=jxfactory&code=' + data.user.encryptPin}, function (err, resp, data) {console.log('互助码状态:' + resp.body);})" ${ScriptsDir}/jd_dreamFactory.js >/dev/null 2>&1 && echo -e " 京喜工厂helpu互助码激活已添加"
[ $(grep -c "www.helpu.cf" ${ScriptsDir}/jd_cfd.ts) -eq 0 ] && sed -i "/旧的可继续使用/a await $.get({url: 'http://www.helpu.cf/jdcodes/submit.php?code=' + $\{res.strMyShareId\} + '&type=jxcfd&user=' + $.UserName}, function (err, resp, data) {console.log('互助码状态:' + resp.body);})" ${ScriptsDir}/jd_cfd.ts >/dev/null 2>&1 && echo -e " 财富岛helpu互助码激活已添加"
perl -0777 -i -pe "s|\"inviterId\":\".*?\"|\"inviterId\":\"\/ZOWSn4R7zs=\"|ig" ${ScriptsDir}/jd_speed_sign.js >/dev/null 2>&1
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
#sed -i "/开团成功tuanId为/a $.getScript\(\`http://xinhunshang.xyz:6001/v3/submit_activity_codes/jxtuan/$\{data.data['tuanId']\}/$\{$.UserName\}\`\).then\(\(text\) => \(console.log\(text\)\)\);" ${ScriptsDir}/qhqcz_jd_dreamFactory_tuan.js >/dev/null 2>&1 && echo -e " 京喜工厂库链接已替换"
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
#[ $(grep -c "xinhunshang" ${ScriptsDir}/smiek2221_gua_wealth_island.js) -eq 0 ] && sed -i "/\\$.InviteList.push(/i\await $.getScript\(\`http://xinhunshang.xyz:6001/v3/submit_activity_codes/jxcfd/$\{$.HomeInfo.strMyShareId\}/$\{$.UserName\}\`\).then\(\(text\) => \(console.log\(text\)\)\);" ${ScriptsDir}/smiek2221_gua_wealth_island.js >/dev/null 2>&1 && echo -e " 财富大陆提交私库已添加"
#[ $(grep -c "xinhunshang" ${ScriptsDir}/smiek2221_gua_wealth_island.js) -eq 0 ] && sed -i "/(HelpAuthorFlag)/i\await $.getScript('http://xinhunshang.xyz:6001/help/v3/get/jxcfd/2/5').then((text) => ($.InviteList.push(...JSON.parse(text).data)));\nconsole.log($.InviteList)"  ${ScriptsDir}/smiek2221_gua_wealth_island.js >/dev/null 2>&1 && echo -e " 财富大陆拉取私库已添加"
[ $(grep -c "xinhunshang.xyz:6001/v3/submit_activity_codes" ${ScriptsDir}/smiek2221_gua_wealth_island_help.js) -eq 0 ] && sed -i "/\\$.InviteList.push(/i\await $.getScript\(\`http://xinhunshang.xyz:6001/v3/submit_activity_codes/jxcfd/$\{$.HomeInfo.strMyShareId\}/$\{$.UserName\}\`\).then\(\(text\) => \(console.log\(text\)\)\);" ${ScriptsDir}/smiek2221_gua_wealth_island_help.js >/dev/null 2>&1 && echo -e " 财富大陆提交私库已添加"
#[ $(grep -c "xinhunshang.xyz:6001/help" ${ScriptsDir}/smiek2221_gua_wealth_island_help.js) -eq 0 ] && sed -i "/(HelpAuthorFlag)/i\await $.getScript('http://xinhunshang.xyz:6001/help/v3/get/jxcfd/2/5').then((text) => ($.InviteList.push(...JSON.parse(text).data)));\nconsole.log($.InviteList)"  ${ScriptsDir}/smiek2221_gua_wealth_island_help.js >/dev/null 2>&1 && echo -e " 财富大陆拉取私库已添加"
[ $(grep -c "xinhunshang.xyz:6001/help" ${ScriptsDir}/smiek2221_gua_wealth_island_help.js) -eq 0 ] && sed -i "
/\\$.InviteList);/ {
n
a $.InviteLists = []\n$.InviteLists.push(...$.InviteList);\nawait $.getScript('http://xinhunshang.xyz:6001/help/v3/get/jxcfd/2/5').then((text) => ($.InviteList.push(...JSON.parse(text).data)));\nconsole.log($.InviteList)
}" ${ScriptsDir}/smiek2221_gua_wealth_island_help.js && echo -e " 财富大陆拉取私库已添加"
#perl -0777 -i -pe "s|https:\/\/jd\.smiek\.tk\/info_carnivalcity|http://xinhunshang.xyz:6001/help/v3/get/carnivalcity/2/20|ig" ${ScriptsDir}/smiek2221_gua_carnivalcity.js >/dev/null 2>&1 && echo -e " 手机狂欢城库链接已替换"
#perl -0777 -i -pe "s|https:\/\/cdn\.jsdelivr\.net\/.*?\.json||ig" ${ScriptsDir}/smiek2221_gua_carnivalcity.js >/dev/null 2>&1 && echo -e " 手机狂欢城库链接已替换"
echo -e "+--------------------------------------------+\n"

echo -e "+--------------- Aaron-lv 脚本 --------------+"
[ $(grep -cEi "\\$.strMyShareIds = \[\];" ${ScriptsDir}/Aaron_lv_jd_cfd.js) -eq '0' ] && sed -i "/\\$.strMyShareIds = /a\$.strMyShareIds = [];" ${ScriptsDir}/Aaron_lv_jd_cfd.js >/dev/null 2>&1
sed -i "
/await cfd();/ {
n
n
n
n
a await \$\.getScript\(\"http:\/\/xinhunshang\.xyz:6001\/help\/v3\/get\/jxcfd\/1\/10\"\)\.then\(\(text\) => \($.shareCodes\.push\(...JSON\.parse\(text\)\.data\)\)\);\nconsole.log($.shareCodes)
}" ${ScriptsDir}/Aaron_lv_jd_cfd.js && echo -e " 京喜财富岛已内置私库"

[ $(grep -c "qhq/YesOrNo/main/json/friendPins.json" ${ScriptsDir}/Aaron_lv_jd_joy_run.js) -eq 0 ] && perl -0777 -i -pe "s|\".*?friendPins.json\"|\"https://raw.githubusercontent.com/qhq/YesOrNo/main/json/friendPins.json\"|ig" ${ScriptsDir}/Aaron_lv_jd_joy_run.js >/dev/null 2>&1 && echo -e " 宠汪汪赛跑助力库已替换"
perl -0777 -i -pe "s|http:\/\/share\.turinglabs\.net\/api\/v3\/joy\/query\/1\/|http://xinhunshang.xyz:6001/help/v3/get/LKYLToken/5/1|ig" ${ScriptsDir}/Aaron_lv_jd_joy_run.js >/dev/null 2>&1 && echo -e " 宠汪汪赛跑Token已替换"
sed -i "s|const readTokenRes = ''|const readTokenRes = await readToken();|g" ${ScriptsDir}/Aaron_lv_jd_joy_run.js && echo -e " 宠汪汪赛跑助力读取网络Token"
sed -i "s|// return;|return;|g" ${ScriptsDir}/Aaron_lv_jd_joy_run.js && echo -e " 宠汪汪赛跑助力无Token退出"
sed -i "s|invite(new_invite_pins)|invite(friendsArr)|g" ${ScriptsDir}/Aaron_lv_jd_joy_run.js
sed -i "s|run(new_run_pins)|run(friendsArr)|g" ${ScriptsDir}/Aaron_lv_jd_joy_run.js
#sed -i "/updatePkActivityIdRes.length/d" ${ScriptsDir}/Aaron_lv_jd_carnivalcity_help.js
#perl -0777 -i -pe "s|http:\/\/share\.turinglabs\.net\/api\/v3\/carnivalcity\/query\/20\/|http://xinhunshang.xyz:6001/help/v3/get/carnivalcity/2/20|ig" ${ScriptsDir}/Aaron_lv_jd_carnivalcity_help.js >/dev/null 2>&1 && echo -e " 手机狂欢城库链接已替换"
perl -0777 -i -pe "s|([^'])https:\/\/code\.chiang\.fun\/api\/.*?\`|\1http://xinhunshang.xyz:6001/help/v3/get/jdcash/5/20\`|ig" ${ScriptsDir}/Aaron_lv_jd_cash.js >/dev/null 2>&1 && echo -e " 领现金库链接已替换"
sed -i "/cookiesArr.length/i\ $.authorCode = []" ${ScriptsDir}/Aaron_lv_jd_cash.js
echo -e "+--------------------------------------------+\n"


echo -e "+----------------- 处理文件 -----------------+"
HtmlDir=${ShellDir}/panel/public
for file in $(ls $HtmlDir); do
    if [ "${file##*.}" = "html" ]; then
        echo -e " 已修改 ${file}"
        perl -0777 -i -pe "s/京东薅羊毛控制面板|Dashboard/喝乌凹薅/ig" ${HtmlDir}/${file} >/dev/null 2>&1
        perl -0777 -i -pe "s/var animating = true;/var animating = false;/ig" ${HtmlDir}/${file} >/dev/null 2>&1
        #perl -0777 -i -pe "s|./css/main.css|https://raw.sevencdn.com/qhq/Myd/main/panel/public/css/main.css|ig" ${HtmlDir}/${file} >/dev/null 2>&1
        #sed -i "/.\/js\/script.js/d" ${HtmlDir}/${file}
        #sed -i "/>Stop</d" ${HtmlDir}/${file}
        #sed -i '/<canvas id="sakura"/' ${HtmlDir}/${file}
    fi
done
sed -i 's|cat ${FileDiy}.*\?}|echo -e ""|' $ShellDir/git_pull.sh && echo -e " 多余自定义判断已清理"
sed -i 's|\(\$(Combin_Sub \S*\?\) \S*\?)|\1)|g' $ShellDir/jd.sh && echo -e " jd.sh内置码已清理"
sed -i "/author;/d" $ScriptsDir/sendNotify.js && echo -e " 通知结尾提示已删除"
#sed -i 's|&& allMessage)|\&\& allMessage.indexOf("可以收取")!=-1)|' ${ScriptsDir}/panghu_jd_wsdlb.js && echo -e " 大老板修改为可收取提醒"
sed -i "s|\^export.*\?,|^export\\\s(cash_zlzh)=[\\\'\\\\\"](.*?)[\\\'\\\\\"]{0,1}$',|" ${ScriptsDir}/curtinlv_jd_cashHelp.py >/dev/null 2>&1 && echo -e " cashHelp正则修改"
sed -i "s|\^export.*\?,|^export\\\s(qjd_zlzh)=[\\\'\\\\\"](.*?)[\\\'\\\\\"]{0,1}$',|" ${ScriptsDir}/curtinlv_jd_qjd.py >/dev/null 2>&1 && echo -e " qjd正则修改"
sed -i "/请重新登录获取cookie/d" ${ScriptsDir}/Tsukasa007_jd_joypark_task.js && echo -e " 汪汪乐园ck失效通知移除"
[ $(grep -c "NOTIFY_SKIP_LIST" ${ScriptsDir}/sendNotify.js) -eq 0 ] && sed -i "/fs.accessSync/i\    const notifySkipList = process.env.NOTIFY_SKIP_LIST ? process.env.NOTIFY_SKIP_LIST.split('&') : [];\n    const titleIndex = notifySkipList.findIndex((item) => item === text);\n    if (titleIndex !== -1) {\n      console.log(\`\\n🔕🔕 ${text} 在推送黑名单中，已跳过推送 🔕🔕\\n\`);\n      return;\n    }" ${ScriptsDir}/sendNotify.js >/dev/null 2>&1 && echo -e " 通知黑名单已添加"
#[ -f ${ConfigDir}/sendNotify.json ] && cp ${ConfigDir}/sendNotify.json ${ScriptsDir}/tools/sendNotify.json
perl -0777 -i -pe "s/await \\$.notify.sendNotify\(\`\\$\{\\$.name\}\`, notifyMsg\);//ig" ${ScriptsDir}/shufflewzc_jd_try.js >/dev/null 2>&1 && echo -e " 京东试用取消通知"

case ${DockerName} in
jd_Q)
    #echo -e " jd_Q 容器独立代码"
    [ $(grep -c "const ONE_BY_ONE" ${ScriptsDir}/jd_dreamFactory.js) -eq 0 ] && sed -i "/const jdCookieNode/a\const ONE_BY_ONE = \$.isNode() ? (process.env.ONE_BY_ONE ? process.env.ONE_BY_ONE : 'false'):'false';\nconsole.log(\`1对1推送：\${ONE_BY_ONE}\`);" ${ScriptsDir}/jd_dreamFactory.js >/dev/null 2>&1
    if [ $(grep -c "&& ONE_BY_ONE" ${ScriptsDir}/jd_dreamFactory.js) -eq 0 ]; then
        sed -i "/allMessage.*小时后兑换超时/a\    if (\$.isNode() && ONE_BY_ONE == 'true') {\n        await notify.sendNotify2(\`\${\$.name} - \${\$.UserName}\`, \`【京东账号\${\$.index}】\${\$.UserName}\\\\n【生产商品】\${\$.productName}\${expiredTime}小时后兑换超时\\\n【兑换截止时间】\${\$.exchangeEndTime}\\\n请速去京喜APP->我的->京喜工厂进行兑换\`, { url: jxOpenUrl })\n    }" ${ScriptsDir}/jd_dreamFactory.js >/dev/null 2>&1
        sed -i "/allMessage.*已可兑换/a\    if (\$.isNode() && ONE_BY_ONE == 'true') {\n        await notify.sendNotify2(\`\${\$.name} - \${\$.UserName}\`, \`【京东账号\${\$.index}】\${\$.UserName}\\\\n【生产商品】\${\$.productName}已可兑换\\\n【兑换截止时间】\${\$.exchangeEndTime}\\\n请速去京喜APP->我的->京喜工厂进行兑换\`, { url: jxOpenUrl })\n    }" ${ScriptsDir}/jd_dreamFactory.js >/dev/null 2>&1 && echo -e " 京喜工厂1对1推送已添加"
    fi
    [ $(grep -c "const ONE_BY_ONE" ${ScriptsDir}/jd_fruit.js) -eq 0 ] && sed -i "/new Env/a\const ONE_BY_ONE = \$.isNode() ? (process.env.ONE_BY_ONE ? process.env.ONE_BY_ONE : 'false'):'false';\nconsole.log(\`1对1推送：\${ONE_BY_ONE}\`);" ${ScriptsDir}/jd_fruit.js >/dev/null 2>&1
    if [ $(grep -c "&& ONE_BY_ONE" ${ScriptsDir}/jd_fruit.js) -eq 0 ]; then
        sed -i "/(isFruitFinished)/a\    if (\$.isNode() && ONE_BY_ONE == 'true') {\n        await notify.sendNotify2(\`\${\$.name} - \${\$.UserName}\`, \`京东账号\${\$.index} \${\$.UserName}\\\n\${\$.farmInfo.farmUserPro.name}已可领取\\\n请去京东APP或微信小程序查看\`,)\n    }" ${ScriptsDir}/jd_fruit.js >/dev/null 2>&1
        sed -i "/farmInfo.treeState === 2/a\    if (\$.isNode() && ONE_BY_ONE == 'true') {\n        await notify.sendNotify2(\`\${\$.name} - \${\$.UserName}\`, \`京东账号\${\$.index} \${\$.UserName}\\\n\${\$.farmInfo.farmUserPro.name}已可领取\\\n请去京东APP或微信小程序查看\`,)\n    }" ${ScriptsDir}/jd_fruit.js >/dev/null 2>&1
        sed -i "/farmInfo.treeState === 0/a\    if (\$.isNode() && ONE_BY_ONE == 'true') {\n        await notify.sendNotify2(\`\${\$.name} - \${\$.UserName}\`, \`京东账号\${\$.index} \${\$.UserName}\\\n您忘了种植新的水果\\\n请去京东APP或微信小程序选购并种植新的水果\`,)\n    }" ${ScriptsDir}/jd_fruit.js >/dev/null 2>&1 && echo -e " 京东农场1对1推送已添加"
    fi
    perl -0777 -i -pe "s/await notify.sendNotify\((.*?)账号/await notify.sendNotify2\(\1账号/ig" ${ScriptsDir}/jd_pet.js >/dev/null 2>&1 && echo -e " 京东萌宠已启用1对1推送"
    ;;
jdQ)
    echo -e " jdQ 容器独立代码"
    ;;
*)
    echo " 默认参数"
    ;;
esac


## 验证调用
wget -q ${ProxyJudge}https://raw.githubusercontent.com/qhq/YesOrNo/main/Scripts/sendNotify.js -O ${ScriptsDir}/sendNotify.js
wget -q ${ProxyJudge}https://raw.githubusercontent.com/smiek2221/scripts/master/sign_graphics_validate.js -O ${ScriptsDir}/sign_graphics_validate.js
wget -q ${ProxyJudge}https://raw.githubusercontent.com/smiek2221/scripts/master/JDJRValidator_Pure.js -O ${ScriptsDir}/JDJRValidator_Pure.js
wget -q ${ProxyJudge}https://raw.githubusercontent.com/smiek2221/scripts/master/ZooFaker_Necklace.js -O ${ScriptsDir}/ZooFaker_Necklace.js
## utils
[ ! -d ${ScriptsDir}/utils ] && mkdir ${ScriptsDir}/utils
js_List="JDJRValidator_Pure JDSignValidator JD_DailyBonus ZooFaker_Necklace"
for js_item in $js_List; do
    wget -q ${ProxyJudge}https://raw.githubusercontent.com/Aaron-lv/sync/jd_scripts/utils/$js_item.js -O ${ScriptsDir}/utils/$js_item.js
done
#wget -q ${ProxyJudge}https://raw.githubusercontent.com/Aaron-lv/sync/jd_scripts/utils/JDJRValidator_Pure.js -O ${ScriptsDir}/utils/JDJRValidator_Pure.js
#wget -q ${ProxyJudge}https://raw.githubusercontent.com/Aaron-lv/sync/jd_scripts/utils/JDSignValidator.js -O ${ScriptsDir}/utils/JDSignValidator.js
#wget -q ${ProxyJudge}https://raw.githubusercontent.com/Aaron-lv/sync/jd_scripts/utils/JD_DailyBonus.js -O ${ScriptsDir}/utils/JD_DailyBonus.js
#wget -q ${ProxyJudge}https://raw.githubusercontent.com/Aaron-lv/sync/jd_scripts/utils/ZooFaker_Necklace.js -O ${ScriptsDir}/utils/ZooFaker_Necklace.js
## function
[ ! -d ${ScriptsDir}/function ] && mkdir ${ScriptsDir}/function
js_List="common config eval jdValidate jdcookie jxAlgo sendNotify"
for js_item in $js_List; do
    wget -q ${ProxyJudge}https://raw.githubusercontent.com/airacg/jd_task/main/function/$js_item.js -O ${ScriptsDir}/function/$js_item.js
done
#wget -q ${ProxyJudge}https://raw.githubusercontent.com/airacg/jd_task/main/function/common.js -O ${ScriptsDir}/function/common.js
#wget -q ${ProxyJudge}https://raw.githubusercontent.com/airacg/jd_task/main/function/config.js -O ${ScriptsDir}/function/config.js
#wget -q ${ProxyJudge}https://raw.githubusercontent.com/airacg/jd_task/main/function/eval.js -O ${ScriptsDir}/function/eval.js
#wget -q ${ProxyJudge}https://raw.githubusercontent.com/airacg/jd_task/main/function/jdValidate.js -O ${ScriptsDir}/function/jdValidate.js
#wget -q ${ProxyJudge}https://raw.githubusercontent.com/airacg/jd_task/main/function/jdcookie.js -O ${ScriptsDir}/function/jdcookie.js
#wget -q ${ProxyJudge}https://raw.githubusercontent.com/airacg/jd_task/main/function/jxAlgo.js -O ${ScriptsDir}/function/jxAlgo.js
#wget -q ${ProxyJudge}https://raw.githubusercontent.com/airacg/jd_task/main/function/sendNotify.js -O ${ScriptsDir}/function/sendNotify.js

sed -i '/sendNotify 推送通知功能/a const diy = true;' $ScriptsDir/sendNotify.js && echo -e " DIY已标记"

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

## 注释指定活动
js_List="qhqcz_notice jd_bean_change qhqcz_jd_enen qhqcz_jd_cleancart qhqcz_jd_unsubscriLive qhqcz_getName jd_big_winner jd_star_shop jd_speed_redEnvelope jd_joy_park jd_EsportsManager"
if [ -n "$js_List" ]; then
    echo -e "+--------------- 暂时停用脚本 ---------------+"
    for js_item in $js_List; do
        sed -i "s|\(^[0-9].*bash\) jd $js_item|# \1 jd $js_item|" ${ListCron} && echo -e " \033[32m[已停用]\033[0m $js_item"
        #sed -i "/$js_item/d" ${ListCron} && echo -e "$js_item已删除"
    done
    echo -e "+--------------------------------------------+\n"
fi

## 强制取消定时注释
js_List="qhqcz_jd_ckcheck"
if [ -n "$js_List" ]; then
    echo -e "+--------------- 强制开启脚本 ---------------+"
    for js_item in $js_List; do
        sed -i "s/^#\([0-9].*bash\) jd $js_item/\1 jd $js_item/g" ${ListCron}
        sed -i "s/^# \([0-9].*bash\) jd $js_item/\1 jd $js_item/g" ${ListCron} && echo -e " \033[32m[已开启]\033[0m $js_item"
        #sed -i "/$js_item/d" ${ListCron} && echo -e "$js_item已删除"
    done
    echo -e "+--------------------------------------------+\n"
fi

## 删除过期活动
js_List="shufflewzc_jd_mb star261_jd_appliances smiek2221_gua_doge qhqcz_jd_superBrand jiulan_jd_shop_sign star261_jd_golden_machine zero205_jd_kxcdz star261_jd_fan smiek2221_jd_qcshj zero205_jd_ccSign smiek2221_gua_xiaolong star261_jd_decompression smiek2221_gua_carnivalcity Aaron_lv_jd_carnivalcity_help"
if [ -n "$js_List" ]; then
    echo -e "+-------------- 删除过期脚本 ---------------+"
    for js_item in $js_List; do
        rm -rf ${ScriptsDir}/$js_item.js && sed -i "/$js_item/d" ${ListCron} && echo -e " \033[32m[已删除]\033[0m $js_item"
    done
    echo -e "+--------------------------------------------+\n"
fi

## 自动提取脚本名称注释
echo -e "+----------------- 添加注释 -----------------+"
js_List=$(grep -Eo "bash jd \w+" ${ConfigDir}/crontab.list)
for Cron in ${js_List}; do
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

############################## 同步文件 ##########################################
#cd $ConfigDir
#echo -e "下载 server.js "
#wget -q --no-check-certificate ${ProxyJudge}https://raw.githubusercontent.com/qhq/YesOrNo/main/Scripts/server.js -O server.js.new
#if [ $? -eq 0 ]; then
#  mv -f server.js.new server.js
#  echo -e "更新 server.js 完成"
#else
#  rm -rf server.js.new
#  echo -e "更新 server.js 失败，使用上一次正常的版本...\n"
#fi
#cp /jd/config/server.js /jd/panel/server.js
#pm2 restart /jd/panel/server.js

##############################  自  定  义  命  令  ##############################

## 京东试用脚本添加取关定时任务
#[ -f ${ScriptsDir}/jd_try.js ] && grep -q "5 10 \* \* \* bash jd jd_unsubscribe" ${ListCron}
#if [ $? -ne 0 ]; then
#  echo -e '# 京东试用脚本添加的取关定时任务\n5 10 * * * bash jd jd_unsubscribe' >>${ListCron}
#fi

## 修正定时
#grep -q "bash git_pull" ${ListCron} && sed -i "/&*bash git_pull/c$(rand 1 59) 1,7,13,19 \* \* \* sleep $(rand 1 59) && bash git_pull >>\$\{JD_DIR\}\/log\/git_pull.log 2>&1" ${ListCron}
grep -q "qhqcz_post_code" ${ListCron} && sed -i '/&*qhqcz_post_code/c0 0,6,12,18 * * * bash jd qhqcz_post_code' ${ListCron}
grep -q "qhqcz_jd_ckcheck" ${ListCron} && sed -i '/&*qhqcz_jd_ckcheck/c0 7-19/2 * * * bash jd qhqcz_jd_ckcheck' ${ListCron}
#sed -i "s|\(^[0-9].*bash\) jd qhqcz_jd_dreamFactory_tuan|${cron_min} * * * * bash jd qhqcz_jd_dreamFactory_tuan|" ${ListCron} && echo -e " qhqcz_jd_dreamFactory_tuan 注释已修改"
#grep -q "Aaron_lv_jd_joy_run" ${ListCron} && perl -0777 -i -pe "s/\d.*?Aaron_lv_jd_joy_run/5 10,14 * * * bash jd Aaron_lv_jd_joy_run/ig" ${ListCron}
#grep -q "airacg_jd-task-validate" ${ListCron} && perl -0777 -i -pe "s/\d.*?airacg_jd-task-validate/58 7,15,23 * * * bash jd airacg_jd-task-validate/ig" ${ListCron}
#grep -q "airacg_jd-reward-joy" ${ListCron} && perl -0777 -i -pe "s/\d.*?&& bash jd airacg_jd-reward-joy/59 7,15,23 * * * sleep 58 && bash jd airacg_jd-reward-joy/ig" ${ListCron}
#grep -q "airacg_jd-reward-joy" ${ListCron} && perl -0777 -i -pe "s/\d.*? \* bash jd airacg_jd-reward-joy/0 0-16\/8 * * * bash jd airacg_jd-reward-joy/ig" ${ListCron}

## 检查配置文件变量
[ $(grep -c 'export invokeKey=\"RtKLB8euDo7KwsO0\"' ${ConfigDir}/config.sh) -eq 0 ] && perl -0777 -i -pe 's/export invokeKey=.*+/export invokeKey="RtKLB8euDo7KwsO0"/i' ${ConfigDir}/config.sh >/dev/null 2>&1


## 删除不知如何产生的垃圾文件
DeletedCacheFiles="app.eb41fc5f.js"
for del in ${DeletedCacheFiles}; do
    [ -f ${ScriptsDir}/$del ] && rm -rf ${ScriptsDir}/$del
done

############################## 环境判断 ##############################
python_model_check() {
    if python3 -c '''print("JD")''' >/dev/null 2>&1; then
        echo "1"
    else
        echo "0"
    fi
}
result=$(python_model_check $1)
if [ $result != 1 ]; then
    echo -e " Python3环境安装中"
    apk update && apk add --no-cache build-base g++ cairo-dev jpeg-dev pango-dev giflib-dev python3 py3-pip && cd /jd/scripts && npm install canvas --build-from-source && pip3 install requests && pip3 install --upgrade pip && cd /jd
fi

# 依赖
package_name="png-js date-fns axios crypto-js ts-md5 tslib @types/node dotenv typescript fs require tslib jsdom"

install_dependencies_normal() {
    for i in $@; do
        case $i in
        canvas)
            cd /jd/scripts
            #if [[ "$(echo $(npm ls $i) | grep ERR)" != "" ]]; then
            #    npm uninstall $i
            #fi
            if [[ "$(npm ls $i)" =~ (empty) ]]; then
                echo -e " 正在安装 $i"
                apk add --no-cache build-base g++ cairo-dev pango-dev giflib-dev && npm i $i --prefix /jd/scripts --build-from-source
            fi
            ;;
        *)
            #if [[ "$(npm ls $i)" =~ $i ]]; then
            #    npm uninstall $i
            #elif [[ "$(echo $(npm ls $i -g) | grep ERR)" != "" ]]; then
            #    npm uninstall $i -g
            #fi
            if [[ "$(npm ls $i -g)" =~ (empty) ]]; then
                echo -e " 正在安装 $i"
                [[ $i = "typescript" ]] && npm i $i -g --force || npm i $i -g
            fi
            ;;
        esac
    done
}
install_dependencies_force() {
    for i in $@; do
        case $i in
        canvas)
            cd /jd/scripts
            #if [[ "$(npm ls $i)" =~ $i && "$(echo $(npm ls $i) | grep ERR)" != "" ]]; then
            #    npm uninstall $i
            #    rm -rf /jd/scripts/node_modules/$i
            #    rm -rf /usr/local/lib/node_modules/lodash/*
            #fi
            if [[ "$(npm ls $i)" =~ (empty) ]]; then
                echo -e " 正在安装 $i"
                apk add --no-cache build-base g++ cairo-dev pango-dev giflib-dev && npm i $i --prefix /jd/scripts --build-from-source --force
            fi
            ;;
        *)
            cd /jd/scripts
            #if [[ "$(npm ls $i)" =~ $i ]]; then
            #    npm uninstall $i
            #    rm -rf /jd/scripts/node_modules/$i
            #    rm -rf /usr/local/lib/node_modules/lodash/*
            #elif [[ "$(npm ls $i -g)" =~ $i && "$(echo $(npm ls $i -g) | grep ERR)" != "" ]]; then
            #    npm uninstall $i -g
            #    rm -rf /jd/scripts/node_modules/$i
            #    rm -rf /usr/local/lib/node_modules/lodash/*
            #fi
            if [[ "$(npm ls $i -g)" =~ (empty) ]]; then
                echo -e " 正在安装 $i"
                npm i $i -g --force
            fi
            ;;
        esac
    done
}
install_dependencies_all() {
    install_dependencies_normal $package_name
    #for i in $package_name; do
    #    install_dependencies_force $i
    #done
}
install_dependencies_all
echo -e "\033[32m[Done]\033[0m 结束🔔\n"
