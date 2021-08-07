#!/usr/bin/env bash

echo -e " 2021-08-06 15:00"

#sed -i 's|\(0xa\|0x23\)|40|g' $ShellDir/jd.sh && echo -e " 不解释"

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

author_list="qhqcz Sunert smiek2221 yangtingxiao longzhuzhu moposmall panghu Wenmoux JDHelloWorld passerby star261 curtinlv SuperManito cdle jiulan Tsukasa007 Annyoo2021 Aaron_lv shufflewzc zero205"

# 自用库
scripts_base_url_qhqcz=${ProxyJudge}https://raw.githubusercontent.com/qhq/YesOrNo/main/Scripts/
my_scripts_list_qhqcz="iQIYI.js post_code.js getName.js jd_bean_change.js jd_dreamFactory_tuan.js jd_superBrand.js jd_zqfl.py jd_summer_movement.js jd_enen.js jd_unsubscriLive.js jd_cleancart.js"

# 中青、聚看、腾讯、百度 #https://raw.sevencdn.com/Sunert/Scripts/master/Task/
scripts_base_url_Sunert=${ProxyJudge}https://gitee.com/Sunert/Scripts/raw/master/Task/
my_scripts_list_Sunert="baidu_speed.js youth.js Youth_Read.js jukan.js txnews.js"

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
my_scripts_list_panghu="jd_wsdlb.js jd_lsj.js jd_joy-park.js jd_pk.js jd_wish.js"

# star261
# https://github.com/star261/jd/tree/main/
scripts_base_url_star261=${ProxyJudge}https://raw.githubusercontent.com/star261/jd/main/scripts/
my_scripts_list_star261="jd_jxmc.js jd_summer_movement.js jd_summer_movement_bet.js jd_productZ4Brand.js"

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
scripts_base_url_cdle=${ProxyJudge}https://raw.githubusercontent.com/cdle/jd_study/main/
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

# smiek2221
# https://github.com/smiek2221/scripts
scripts_base_url_smiek2221=${ProxyJudge}https://raw.githubusercontent.com/smiek2221/scripts/master/
my_scripts_list_smiek2221="jd_sign_graphics.js jd_summer_movement.js jd_necklace.js jd_summer_movement_help.js jd_joy.js jd_joy_steal.js gua_wealth_island.js gua_MMdou.js gua_wealth_island_help.js gua_doge.js"

# jiulan
# https://github.com/jiulan/platypus/
scripts_base_url_jiulan=${ProxyJudge}https://raw.githubusercontent.com/jiulan/platypus/main/scripts/
my_scripts_list_jiulan="jd_lsj.js jd_cfdtx.js"

# Annyoo2021
# https://github.com/Annyoo2021/scripts
scripts_base_url_Annyoo2021=${ProxyJudge}https://raw.githubusercontent.com/Annyoo2021/scripts/main/
my_scripts_list_Annyoo2021="jd_jxzpk.js"

# Aaron-lv
# https://github.com/Aaron-lv/sync/tree/jd_scripts
scripts_base_url_Aaron_lv=${ProxyJudge}https://raw.githubusercontent.com/Aaron-lv/sync/jd_scripts/
my_scripts_list_Aaron_lv="jd_cfd.js jd_sendBeans.js jd_big_winner.js jd_cfdtx.js jd_necklace.js jd_joy_reward.js jd_joy_run.js jd_bean_sign.js jx_sign.js"

# shufflewzc
# https://github.com/shufflewzc/faker2
scripts_base_url_shufflewzc=${ProxyJudge}https://raw.githubusercontent.com/shufflewzc/faker2/main/
my_scripts_list_shufflewzc="jd_mb.js"

# zero205
# https://github.com/zero205/JD_tencent_scf
scripts_base_url_zero205=${ProxyJudge}https://raw.githubusercontent.com/zero205/JD_tencent_scf/main/
my_scripts_list_zero205="jd_dpqd.js"


############################## 随机函数 ##########################################
cd ${ShellDir}
git remote -v | grep "supermanito" -wq
[ $? -ne 0 ] && clear && echo -e "\033[31m\n非本项目用户禁止使用！\n\033[0m" && exit 1

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
    if [[ ${EnableExtraShellProxyDownload} == true ]]; then
      DownloadJudgment="[代理]"
    else
      DownloadJudgment=""
    fi
  elif [[ $(echo $url_list | egrep -o "github|gitee") == "gitee" ]]; then
    repository_platform="https://gitee.com"
    reformat_url=$(echo $format_url | sed "s|/raw/|/tree/|g")
    DownloadJudgment=""
  fi
  repository_url=$(echo "$repository_platform$reformat_url")
  echo -e "\033[33m[更新]\033[0m $author 的活动脚本${DownloadJudgment}:"
  echo -e "\033[33m[仓库]\033[0m $repository_url "

  for js in $scripts_list; do
    eval url=$url_list$js
    eval name=$author"_"$js
    wget -q --no-check-certificate $url -O ${ScriptsDir}/$name.new
    if [ $? -eq 0 ]; then
      mv -f ${ScriptsDir}/$name.new ${ScriptsDir}/$name
      echo -e "\033[32m[Done]\033[0m $name"

      [[ $name == "jddj_cookie.js" ]] && continue
      [[ $name == "sign_graphics_validate.js" ]] && continue
      [[ $name == "JDJRValidator_Pure.js" ]] && continue
      [[ $name == "ZooFaker_Necklace.js" ]] && continue

      croname=$(echo "$name" | awk -F\. '{print $1}')
      script_date_standard=$(cat ${ScriptsDir}/$name | grep "https" | awk '{if($1~/^[0-59]/) print $1,$2,$3,$4,$5}' | sort | uniq | head -n 1)
      if [[ $name == "jd_cashHelp.py" ]]; then
        script_date="8 */4 * * *" # 指定签到领现金脚本定时
      elif [[ $name == "jd_jxgc_tuan.py" ]]; then
        script_date="0 0,7,10 * * *" # 指定京喜工厂开团脚本定时
      else
        if [[ ${script_date_standard} == "" ]]; then
          script_date=$(cat ${ScriptsDir}/$name | grep "cron" | head -n 1 | sed "s/[a-zA-Z]//g" | awk '{if($1~/^[0-59]/) print $1,$2,$3,$4,$5; else if ($1~/^[*]/) print $2,$3,$4,$5,$6}')
        else
          script_date=${script_date_standard}
        fi
      fi

      if [ -z "${script_date}" ]; then
        cron_min=$(rand 1 59)
        cron_hour=$(rand 7 9)
        [ $(grep -c "$croname" ${ListCron}) -eq 0 ] && sed -i "/hang up/a${cron_min} ${cron_hour} * * * bash jd $croname" ${ListCron}
      else
        [ $(grep -c "$croname" ${ListCron}) -eq 0 ] && sed -i "/hang up/a${script_date} bash jd $croname" ${ListCron}
      fi
    else
      [ -f ${ScriptsDir}/$name.new ] && rm -f ${ScriptsDir}/$name.new
      echo -e "\033[31m[ERROR]\033[0m $name 更新失败，使用上一次正常的版本"
    fi
  done
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
perl -0777 -i -pe "s|([^'])https:\/\/api\.sharecode\.ga\/api\/.*?\`|\1http://xinhunshang.xyz:6001/help/v3/get/ddfactory/5/20\`|ig" ${ScriptsDir}/jd_jdfactory.js >/dev/null 2>&1 && echo -e " 东东工厂库链接已替换"
perl -0777 -i -pe "s|([^'])https:\/\/api\.sharecode\.ga\/api\/.*?\`|\1http://xinhunshang.xyz:6001/help/v3/get/farm/5/20\`|ig" ${ScriptsDir}/jd_fruit.js >/dev/null 2>&1 && echo -e " 东东农场库链接已替换"
perl -0777 -i -pe "s|([^'])https:\/\/api\.sharecode\.ga\/api\/.*?\`|\1http://xinhunshang.xyz:6001/help/v3/get/bean/5/20\`|ig" ${ScriptsDir}/jd_plantBean.js >/dev/null 2>&1 && echo -e " 种豆得豆库链接已替换"
perl -0777 -i -pe "s|([^'])https:\/\/api\.sharecode\.ga\/api\/.*?\`|\1http://xinhunshang.xyz:6001/help/v3/get/pet/5/20\`|ig" ${ScriptsDir}/jd_pet.js >/dev/null 2>&1 && echo -e " 东东萌宠库链接已替换"
perl -0777 -i -pe "s|([^'])https:\/\/api\.sharecode\.ga\/api\/.*?\`|\1http://xinhunshang.xyz:6001/help/v3/get/jxfactory/2/20\`|ig" ${ScriptsDir}/jd_dreamFactory.js >/dev/null 2>&1 && echo -e " 京喜工厂库链接已替换"
perl -0777 -i -pe "s|([^'])https:\/\/api\.sharecode\.ga\/api\/.*?\`|\1http://xinhunshang.xyz:6001/help/v3/get/jxcfd/1/20\'|ig" ${ScriptsDir}/jd_cfd.ts >/dev/null 2>&1 && echo -e " 京喜财富岛库链接已替换"
perl -0777 -i -pe "s|([^'])https:\/\/api\.sharecode\.ga\/api\/.*?\`|\1http://xinhunshang.xyz:6001/help/v3/get/jxmc/5/10\'|ig" ${ScriptsDir}/jd_jxmc.ts >/dev/null 2>&1 && echo -e " 京喜牧场库链接已替换"
perl -0777 -i -pe "s|([^'])https:\/\/api\.sharecode\.ga\/api\/.*?\`|\1http://xinhunshang.xyz:6001/help/v3/get/health/5/20\`|ig" ${ScriptsDir}/jd_health.js >/dev/null 2>&1 && echo -e " 健康社区库链接已替换"
perl -0777 -i -pe "s|([^'])https:\/\/api\.sharecode\.ga\/api\/.*?\`|\1http://xinhunshang.xyz:6001/help/v3/get/sgmh/5/20\`|ig" ${ScriptsDir}/jd_sgmh.js >/dev/null 2>&1 && echo -e " 闪购盲盒库链接已替换"
perl -0777 -i -pe "s|([^'])https:\/\/api\.sharecode\.ga\/api\/.*?\`|\1http://xinhunshang.xyz:6001/help/v3/get/carnivalcity/2/20\`|ig" ${ScriptsDir}/jd_carnivalcity.js >/dev/null 2>&1 && echo -e " 手机狂欢城库链接已替换"
perl -0777 -i -pe "s|([^'])https:\/\/code\.chiang\.fun\/api\/.*?\`|\1http://xinhunshang.xyz:6001/help/v3/get/jdcash/5/20\`|ig" ${ScriptsDir}/jd_cash.js >/dev/null 2>&1 && echo -e " 领现金库链接已替换"
sed -i "/【开团成功】tuanId/a if \(process\.env\.Auto_Post\){\n\$\.getScript\(\`http://xinhunshang\.xyz:6001/submit_activity_codes/jxtuan/\${data\.data['tuanId']}/\${\$\.UserName}\`\)\.then\(\(text\) => \(console\.log\(text\)\)\);\n}" ${ScriptsDir}/jd_dreamFactory.js && echo -e " 京喜工厂团ID自动上传"
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
[ $(grep -c "xinhunshang.xyz:6001/submit_activity_codes" ${ScriptsDir}/jd_jxmc.ts) -eq 0 ] && sed -i "/'助力码：'/a\await axios.get\(\`http://xinhunshang.xyz:6001/submit_activity_codes/jxmc/$\{homePageInfo.data.sharekey\}/$\{cookie.match(/pt_pin=([^;]*)/)\![1]\}\`\).then\(\(text\) => \(console.log\(text.data\)\)\);" ${ScriptsDir}/jd_jxmc.ts >/dev/null 2>&1 && echo -e " 京喜牧场提交私库已添加"
sed -i "s|md5 !== res.data|md5 !== md5|" ${ScriptsDir}/jd_cfd_loop.ts >/dev/null 2>&1 && echo -e " MD5验证已移除"
#sed -i "s|if(_0x\w\{6\}==='1'|if('1'==='1'|" ${ScriptsDir}/jd_dreamFactory.js >/dev/null 2>&1 && echo -e " 尝试"
sed -i "s|_0x\w\{6\}\['sendNotify'\].*\?\]);||" ${ScriptsDir}/jd_dreamFactory.js >/dev/null 2>&1 && echo -e " 移除上报失败推送"
sed -i "s|_0x\w\{6\}\['sendNotify'\].*\?\]);||" ${ScriptsDir}/jd_plantBean.js >/dev/null 2>&1 && echo -e " 移除上报失败推送"
sed -i "s|_0x\w\{6\}\['sendNotify'\].*\?\]);||" ${ScriptsDir}/jd_fruit.js >/dev/null 2>&1 && echo -e " 移除上报失败推送"
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
[ $(grep -c "xinhunshang.xyz:6001/submit_activity_codes" ${ScriptsDir}/smiek2221_jd_summer_movement.js) -eq 0 ] && sed -i "/\\$.inviteList.push({/i\await $.getScript\(\`http://xinhunshang.xyz:6001/submit_activity_codes/summer/$\{data.data.result.inviteId\}/$\{$.UserName\}\`\).then\(\(text\) => \(console.log\(text\)\)\);" ${ScriptsDir}/smiek2221_jd_summer_movement.js >/dev/null 2>&1 && echo -e " 燃动夏日提交私库已添加"
[ $(grep -c "xinhunshang.xyz:6001/help" ${ScriptsDir}/smiek2221_jd_summer_movement.js) -eq 0 ] && sed -i "/开始内部京东账号【邀请好友助力】/i\await $.getScript('http://xinhunshang.xyz:6001/help/v3/get/summer/2/5').then((text) => ($.inviteList = $.inviteList.concat(JSON.parse(text).data)));"  ${ScriptsDir}/smiek2221_jd_summer_movement.js >/dev/null 2>&1 && echo -e " 燃动夏日拉取私库已添加"
#[ $(grep -c "xinhunshang" ${ScriptsDir}/smiek2221_gua_wealth_island.js) -eq 0 ] && sed -i "/\\$.InviteList.push(/i\await $.getScript\(\`http://xinhunshang.xyz:6001/submit_activity_codes/jxcfd/$\{$.HomeInfo.strMyShareId\}/$\{$.UserName\}\`\).then\(\(text\) => \(console.log\(text\)\)\);" ${ScriptsDir}/smiek2221_gua_wealth_island.js >/dev/null 2>&1 && echo -e " 财富大陆提交私库已添加"
#[ $(grep -c "xinhunshang" ${ScriptsDir}/smiek2221_gua_wealth_island.js) -eq 0 ] && sed -i "/(HelpAuthorFlag)/i\await $.getScript('http://xinhunshang.xyz:6001/help/v3/get/jxcfd/2/5').then((text) => ($.InviteList.push(...JSON.parse(text).data)));\nconsole.log($.InviteList)"  ${ScriptsDir}/smiek2221_gua_wealth_island.js >/dev/null 2>&1 && echo -e " 财富大陆拉取私库已添加"
[ $(grep -c "xinhunshang.xyz:6001/submit_activity_codes" ${ScriptsDir}/smiek2221_gua_wealth_island_help.js) -eq 0 ] && sed -i "/\\$.InviteList.push(/i\await $.getScript\(\`http://xinhunshang.xyz:6001/submit_activity_codes/jxcfd/$\{$.HomeInfo.strMyShareId\}/$\{$.UserName\}\`\).then\(\(text\) => \(console.log\(text\)\)\);" ${ScriptsDir}/smiek2221_gua_wealth_island_help.js >/dev/null 2>&1 && echo -e " 财富大陆提交私库已添加"
#[ $(grep -c "xinhunshang.xyz:6001/help" ${ScriptsDir}/smiek2221_gua_wealth_island_help.js) -eq 0 ] && sed -i "/(HelpAuthorFlag)/i\await $.getScript('http://xinhunshang.xyz:6001/help/v3/get/jxcfd/2/5').then((text) => ($.InviteList.push(...JSON.parse(text).data)));\nconsole.log($.InviteList)"  ${ScriptsDir}/smiek2221_gua_wealth_island_help.js >/dev/null 2>&1 && echo -e " 财富大陆拉取私库已添加"
[ $(grep -c "xinhunshang.xyz:6001/help" ${ScriptsDir}/smiek2221_gua_wealth_island_help.js) -eq 0 ] && sed -i "
/\\$.InviteList);/ {
n
a $.InviteLists = []\n$.InviteLists.push(...$.InviteList);\nawait $.getScript('http://xinhunshang.xyz:6001/help/v3/get/jxcfd/2/5').then((text) => ($.InviteList.push(...JSON.parse(text).data)));\nconsole.log($.InviteList)
}" ${ScriptsDir}/smiek2221_gua_wealth_island_help.js && echo -e " 财富大陆拉取私库已添加"
echo -e "+--------------------------------------------+\n"

echo -e "+--------------- Aaron-lv 脚本 --------------+"
[ $(grep -cEi "\\$.strMyShareIds = \[\];" ${ScriptsDir}/Aaron_lv_jd_cfd.js) -eq '0' ] && sed -i "/\\$.strMyShareIds = /a\$.strMyShareIds = [];" ${ScriptsDir}/Aaron_lv_jd_cfd.js >/dev/null 2>&1
sed -i "
/await cfd();/ {
n
n
n
a await \$\.getScript\(\"http:\/\/xinhunshang\.xyz:6001\/help\/v3\/get\/jxcfd\/1\/10\"\)\.then\(\(text\) => \($.shareCodes\.push\(...JSON\.parse\(text\)\.data\)\)\);\nconsole.log($.shareCodes)
}" ${ScriptsDir}/Aaron_lv_jd_cfd.js && echo -e " 京喜财富岛已内置私库"
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
sed -i '/sendNotify 推送通知功能/a const diy = true;' $ScriptsDir/sendNotify.js && echo -e " DIY已标记"
sed -i 's|cat ${FileDiy}.*\?}|echo -e ""|' $ShellDir/git_pull.sh && echo -e " 多余自定义判断已清理"
sed -i 's|\(\$(Combin_Sub \S*\?\) \S*\?)|\1)|g' $ShellDir/jd.sh && echo -e " jd.sh内置码已清理"
sed -i "/author;/d" $ScriptsDir/sendNotify.js && echo -e " 通知结尾提示已删除"
sed -i 's|Name1=.*\?)|Name1=(fruit pet plantBean jdfactory dreamFactory crazy_joy jdzz cash sgmh cfd health)|' $ShellDir/jd.sh
sed -i 's|Name2=.*\?)|Name2=(东东农场 东东萌宠 京东种豆得豆 东东工厂 京喜工厂 crazyJoy任务 京东赚赚 签到领现金 闪购盲盒 京喜财富岛 东东健康社区)|' $ShellDir/jd.sh
sed -i 's|Name3=.*\?)|Name3=(Fruit Pet Bean JdFactory dreamFactory Joy Jdzz Cash Sgmh Cfd Health)|' $ShellDir/jd.sh && echo -e " 互助码整理脚本已更新"
#sed -i "s|\"j\[drx\]_|\"^j[drx]_|g" $ShellDir/jd.sh && echo -e " 第三方脚本识别已修正"
sed -i 's|当前总红包：|当前红包：|' $ScriptsDir/jd_bean_change.js
sed -i 's|极速版红包：|极速红包：|' $ScriptsDir/jd_bean_change.js && echo -e " 京豆变动通知内容格式已调整"
sed -i 's|&& allMessage)|\&\& allMessage.indexOf("可以收取")!=-1)|' ${ScriptsDir}/panghu_jd_wsdlb.js && echo -e " 大老板修改为可收取提醒"
#sed -i 's|&& allMessage)|\&\& allMessage.indexOf("已可兑换")!=-1)|' ${ScriptsDir}/jd_dreamFactory.js && echo -e " 京喜工厂改为可兑换提醒"
grep -q "qhqcz_post_code" ${ListCron} && sed -i '/&*qhqcz_post_code/c2 9,10,13,14 * * * bash jd qhqcz_post_code' ${ListCron}
#sed -i "s|\(^[0-9].*bash\) jd qhqcz_jd_dreamFactory_tuan|${cron_min} * * * * bash jd qhqcz_jd_dreamFactory_tuan|" ${ListCron} && echo -e " qhqcz_jd_dreamFactory_tuan 注释已修改"
#sed -i "s|'User-Agent': '.*\?'|'User-Agent': 'jdapp;android;9.3.5;10;2346663656561603-4353564623932316;network/wifi;model/ONEPLUS A5010;addressid/138709979;aid/2dfceea045ed292a;oaid/;osVer/29;appBuild/86390;partner/jingdong;eufv/1;Mozilla/5.0 (Linux; Android 10; ONEPLUS A5010 Build/QKQ1.191014.012; wv) AppleWebKit/537.36 (KHTML, like Gecko) Version/4.0 Chrome/77.0.3865.120 MQQBrowser/6.2 TBS/045230 Mobile Safari/537.36'|g" ${ShellDir}/panel/server.js && echo -e " 扫码已修复"
sed -i "s|ccdd == 1|true|g" $ScriptsDir/smiek2221_jd_summer_movement.js && echo -e " 取消正道的光"
sed -i "s|\^export.*\?,|^export\\\s(cash_zlzh)=[\\\'\\\\\"](.*?)[\\\'\\\\\"]{0,1}$',|" ${ScriptsDir}/curtinlv_jd_cashHelp.py >/dev/null 2>&1 && echo -e " cashHelp正则修改"
sed -i "s|\^export.*\?,|^export\\\s(qjd_zlzh)=[\\\'\\\\\"](.*?)[\\\'\\\\\"]{0,1}$',|" ${ScriptsDir}/curtinlv_jd_qjd.py >/dev/null 2>&1 && echo -e " qjd正则修改"
#sed -i "/errMsg);/d" ${ScriptsDir}/jd_fruit.js && echo -e " 农场异常不做通知"
#sed -i "/errMsg);/d" ${ScriptsDir}/jd_pet.js && echo -e " 萌宠异常不做通知"
#sed -i "/errMsg);/d" ${ScriptsDir}/jd_plantBean.js && echo -e " 种豆异常不做通知"
sed -i "/authorCode.map/d" ${ScriptsDir}/jd_cash.js && echo -e " 领现金助力错误已修复"
sed -i "/请重新登录获取cookie/d" ${ScriptsDir}/Tsukasa007_jd_joypark_task.js && echo -e " 汪汪乐园ck失效通知移除"
[ $(grep -c "NOTIFY_SKIP_LIST" ${ScriptsDir}/sendNotify.js) -eq 0 ] && sed -i "/fs.accessSync/i\    const notifySkipList = process.env.NOTIFY_SKIP_LIST ? process.env.NOTIFY_SKIP_LIST.split('&') : [];\n    const titleIndex = notifySkipList.findIndex((item) => item === text);\n    if (titleIndex !== -1) {\n      console.log(\`\\n🔕🔕 ${text} 在推送黑名单中，已跳过推送 🔕🔕\\n\`);\n      return;\n    }"  ${ScriptsDir}/sendNotify.js >/dev/null 2>&1 && echo -e " 通知黑名单已添加"

[ $(grep -c "qhq/YesOrNo/main/json/friendPins.json" ${ScriptsDir}/Aaron_lv_jd_joy_run.js) -eq 0 ] && perl -0777 -i -pe "s|\".*?friendPins.json\"|\"https://raw.githubusercontent.com/qhq/YesOrNo/main/json/friendPins.json\"|ig" ${ScriptsDir}/Aaron_lv_jd_joy_run.js >/dev/null 2>&1 && echo -e " 宠汪汪赛跑助力库已替换"
perl -0777 -i -pe "s|http:\/\/share\.turinglabs\.net\/api\/v3\/joy\/query\/1\/|http://xinhunshang.xyz:6001/help/v3/get/LKYLToken/5/1|ig" ${ScriptsDir}/Aaron_lv_jd_joy_run.js >/dev/null 2>&1 && echo -e " 宠汪汪赛跑Token已替换"
sed -i "s|const readTokenRes = ''|const readTokenRes = await readToken();|g" ${ScriptsDir}/Aaron_lv_jd_joy_run.js && echo -e " 宠汪汪赛跑助力读取网络Token"
sed -i "s|// return;|return;|g" ${ScriptsDir}/Aaron_lv_jd_joy_run.js && echo -e " 宠汪汪赛跑助力无Token退出"


## 验证调用
#sed -i "s|require('\./sign_graphics_validate\.js')|require('./smiek2221_sign_graphics_validate.js')|" $ScriptsDir/smiek2221_jd_sign_graphics.js && echo -e " smiek2221_jd_sign_graphics 调用已修正"
#sed -i "s|require('\./MovementFaker\.js')|require('./smiek2221_MovementFaker.js')|" $ScriptsDir/smiek2221_jd_summer_movement.js && echo -e " smiek2221_jd_summer_movement 调用已修正"
wget -q ${DownloadJudgment}https://raw.githubusercontent.com/smiek2221/scripts/master/sign_graphics_validate.js -O ${ScriptsDir}/sign_graphics_validate.js
wget -q ${DownloadJudgment}https://raw.githubusercontent.com/smiek2221/scripts/master/JDJRValidator_Pure.js -O ${ScriptsDir}/JDJRValidator_Pure.js
wget -q ${DownloadJudgment}https://raw.githubusercontent.com/smiek2221/scripts/master/ZooFaker_Necklace.js -O ${ScriptsDir}/ZooFaker_Necklace.js
wget -q ${DownloadJudgment}https://raw.githubusercontent.com/Aaron-lv/sync/jd_scripts/utils/JDJRValidator_Pure.js -O ${ScriptsDir}/utils/JDJRValidator_Pure.js
wget -q ${DownloadJudgment}https://raw.githubusercontent.com/Aaron-lv/sync/jd_scripts/utils/JDSignValidator.js -O ${ScriptsDir}/utils/JDSignValidator.js
wget -q ${DownloadJudgment}https://raw.githubusercontent.com/Aaron-lv/sync/jd_scripts/utils/JD_DailyBonus.js -O ${ScriptsDir}/utils/JD_DailyBonus.js
wget -q ${DownloadJudgment}https://raw.githubusercontent.com/Aaron-lv/sync/jd_scripts/utils/ZooFaker_Necklace.js -O ${ScriptsDir}/utils/ZooFaker_Necklace.js


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
echo -e "+--------------- 暂时停用脚本 ---------------+"
js_List="jd_bean_change qhqcz_jd_enen passerby_jd_fruit2 passerby_jd_dreamFactory2 jd_big_winner jd_star_shop smiek2221_jd_summer_movement_help jd_speed_redEnvelope jd_joy_park panghu_jd_joy-park panghu_jd_pk jd_EsportsManager qhqcz_jd_cleancart qhqcz_jd_unsubscriLive qhqcz_getName qhqcz_jd_jxsign"
for js_item in $js_List; do
    sed -i "s|\(^[0-9].*bash\) jd $js_item|# \1 jd $js_item|" ${ListCron} && echo -e " \033[32m[已注释]\033[0m $js_item"
    #sed -i "/$js_item/d" ${ListCron} && echo -e "$js_item已删除"
done
echo -e "+--------------------------------------------+\n"

## 强制取消定时注释
echo -e "+--------------- 强制开启脚本 ---------------+"
js_List=""
for js_item in $js_List; do
    sed -i "s/^#\([0-9].*bash\) jd $js_item/\1 jd $js_item/g" ${ListCron}
    sed -i "s/^# \([0-9].*bash\) jd $js_item/\1 jd $js_item/g" ${ListCron} && echo -e " \033[32m[已开启]\033[0m $js_item"
    #sed -i "/$js_item/d" ${ListCron} && echo -e "$js_item已删除"
done
echo -e "+--------------------------------------------+\n"

## 删除过期活动
echo -e "+-------------- 删除过期脚本 ---------------+"
js_List="qqsdff_jd_jbczy passerby_jd_cfd2 passerby_jd_dreamFactory2 passerby_jd_fruit2 Public_jd_nzmh Public_jd_lsj curtinlv_jd_zjd qhqcz_91wii zero205_jd_bean_sign zero205_jd_jxqd jiulan_jd_shop_sign Wenmoux_jd_wxFans qhqcz_jd_jxsign qhqcz_gua_doge"
for js_item in $js_List; do
    rm -rf ${ScriptsDir}/$js_item.js && sed -i "/$js_item/d" ${ListCron} && echo -e " \033[32m[已删除]\033[0m $js_item"
done
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


##############################  自  定  义  命  令  ##############################

## 京东试用脚本添加取关定时任务
#[ -f ${ScriptsDir}/jd_try.js ] && grep -q "5 10 \* \* \* bash jd jd_unsubscribe" ${ListCron}
#if [ $? -ne 0 ]; then
#  echo -e '# 京东试用脚本添加的取关定时任务\n5 10 * * * bash jd jd_unsubscribe' >>${ListCron}
#fi

## 修正定时
#grep -q "bash git_pull" ${ListCron} && sed -i "/&*bash git_pull/c$(rand 1 59) 1,7,13,19 \* \* \* sleep $(rand 1 59) && bash git_pull >>\$\{JD_DIR\}\/log\/git_pull.log 2>&1" ${ListCron}

#检查添加京喜团ID变量
#if [[ $(grep -cEi 'export TUAN_ACTIVEID=".+?"' ${ConfigDir}/config.sh) -ne '0' ]]; then
#    perl -0777 -i -pe 's/export TUAN_ACTIVEID=".+?"/export TUAN_ACTIVEID="T_zZaWP6by9yA1wehxM4mg=="/i' ${ConfigDir}/config.sh >/dev/null 2>&1
#else
#    perl -0777 -i -pe 's/## export/## export\n#京喜团ID\nexport TUAN_ACTIVEID="T_zZaWP6by9yA1wehxM4mg=="/i' ${ConfigDir}/config.sh >/dev/null 2>&1
#fi

## 删除不知如何产生的垃圾文件
DeletedCacheFiles="app.eb41fc5f.js"
for del in ${DeletedCacheFiles}; do
  [ -f ${ScriptsDir}/$del ] && rm -rf ${ScriptsDir}/$del
done

#[ -f ${ConfigDir}/account.json ] && cp ${ConfigDir}/account.json ${ScriptsDir}/tools/account.json


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

# 依赖
package_name="png-js date-fns axios crypto-js ts-md5 tslib @types/node dotenv typescript fs require tslib"

install_dependencies_normal(){
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
install_dependencies_force(){
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
install_dependencies_all(){
    install_dependencies_normal $package_name
    #for i in $package_name; do
    #    install_dependencies_force $i
    #done
}
install_dependencies_all
echo -e "\033[32m[Done]\033[0m 结束🔔\n"
