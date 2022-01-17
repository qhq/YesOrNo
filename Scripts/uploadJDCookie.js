/**
 * 1、打开App随机出现，自动捕抓 cookie 上传
 * 2、打开网页版个人中心，自动捕抓 cookie 上传
 * 
 * 
 *
 * hostname = me-api.jd.com, un.m.jd.com
 *
【Surge脚本配置】:
===================
[Script]
自动上车-id77 = type=http-request,pattern=^https:\/\/me\-api\.jd\.com\/user_new\/info\/GetJDUserInfoUnion,requires-body=1,max-size=0,timeout=1000,script-path=https://raw.githubusercontent.com/id77/QuantumultX/master/Script/uploadJDCookie.js,script-update-interval=0
自动上车-id77 = type=http-response,pattern=^https:\/\/un\.m\.jd\.com\/cgi\-bin\/app\/appjmp\?tokenKey=,requires-body=1,max-size=0,timeout=1000,script-path=https://raw.githubusercontent.com/id77/QuantumultX/master/Script/uploadJDCookie.js,script-update-interval=0
===================
【Loon脚本配置】:
===================
[Script]
http-request ^https:\/\/me\-api\.jd\.com\/user_new\/info\/GetJDUserInfoUnion tag=自动上车-id77, script-path=https://raw.githubusercontent.com/id77/QuantumultX/master/Script/uploadJDCookie.js,requires-body=1
http-response ^https:\/\/un\.m\.jd\.com\/cgi\-bin\/app\/appjmp\?tokenKey= tag=自动上车-id77, script-path=https://raw.githubusercontent.com/id77/QuantumultX/master/Script/uploadJDCookie.js,requires-body=1
===================
【 QX  脚本配置 】:
===================
[rewrite_local]
^https:\/\/me\-api\.jd\.com\/user_new\/info\/GetJDUserInfoUnion url script-echo-response https://raw.githubusercontent.com/id77/QuantumultX/master/Script/uploadJDCookie.js
^https:\/\/un\.m\.jd\.com\/cgi\-bin\/app\/appjmp\?tokenKey= url script-response-header https://raw.githubusercontent.com/id77/QuantumultX/master/Script/uploadJDCookie.js
 *
 */

const $ = new Env('🍪上传Cookie');
let CK;
if ($request.url.includes('appjmp')) {
    const setCookieContent = $response.headers['Set-Cookie'];
    CK =
        setCookieContent.match(/pt_key=[\w\-_]+;/)[0] +
        setCookieContent.match(/pt_pin=[\w\-_%]+;/)[0];
} else {
    CK = $request.headers['Cookie'] || $request.headers['cookie'];
}
//console.log(`\n==========\n抓取cookie：\n${CK}\n==========`)
const pin = CK.match(/pt_pin=(.+?);/)[1];
const key = CK.match(/pt_key=(.+?);/)[1];

const _TG_API_HOST = $.getdata('qhq_TG_API_HOST');
const _TGBotToken = $.getdata('qhq_TGBotToken');
const _TGUserID = $.getdata('qhq_TGUserID');
const _HOSTURL = $.getdata('qhq_HOSTURL');
const _APITOKEN = $.getdata('qhq_APITOKEN');
const ForceUpdate = $.getdata('qhq_ForceUpdate') || 'false';
const NoUpdate = $.getdata('qhq_NoUpdate') || 'true';

$.TG_API_HOST = _TG_API_HOST || 'api.telegram.org';
$.TGBotToken = _TGBotToken || '1825234231:AAEcJUh6jJ93zDd19XH9fl2cSzPiNVBX4xI';
$.TGUserIDs = [];
$.HOSTURLs = [];
$.APITOKENs = [];
let message = "";

if (_TGUserID) {
    $.TGUserIDs = _TGUserID.split(',');
}
if (_HOSTURL) {
    $.HOSTURLs = _HOSTURL.split(',');
}
if (_APITOKEN) {
    $.APITOKENs = _APITOKEN.split(',');
}

!(async () => {
    if (!pin || !key) {
        $.desc = '未找到Cookie';
        $.msg($.name, $.subt, $.desc);

        $.done();
    }

    try {
        const cookie = `pt_key=${key};pt_pin=${pin};`;
        //console.log(`\n当前cookie：\n${cookie}`);
        const userName = pin;
        const decodeName = decodeURIComponent(userName);
        const cookiesData = JSON.parse($.getdata('CookiesJD') || '[]');
        let updateIndex;
        let cookieName = '【账号】';
        const existCookie = cookiesData.find((item, index) => {
            const ck = item.cookie;
            const Account = ck
                ? ck.match(/pt_pin=.+?;/)
                    ? ck.match(/pt_pin=(.+?);/)[1]
                    : null
                : null;
            const verify = userName === Account;
            if (verify) {
                //console.log(`\n存档cookie：\n${ck}`);
                updateIndex = index;
                if (ck !== cookie) {
                    $.needUpdate = true;
                }
            }
            return verify;
        });
        let tipPrefix = '';
        if (existCookie) {
            cookiesData[updateIndex].cookie = cookie;
            cookieName = '【账号' + (updateIndex + 1) + '】';
            tipPrefix = '更新京东';
            console.log(`\npt_pin已存在`);
        } else {
            cookiesData.push({
                userName: decodeName,
                cookie: cookie,
            });
            cookieName = '【账号' + cookiesData.length + '】';
            tipPrefix = '首次写入京东';
            console.log(`\n新增cookie`);
            $.needUpdate = true;
        }
        $.setdata(JSON.stringify(cookiesData), 'CookiesJD');
        // $.msg(
        //   '用户名: ' + decodeName,
        //   '',
        //   tipPrefix + cookieName + 'Cookie成功 🎉'
        // );

        if (NoUpdate == 'true') {
            console.log(`\n本次不上传CK\n${cookie}`)
            return;
        }

        if ($.needUpdate || ForceUpdate == 'true') {
            for (const userId of $.TGUserIDs) {
                await tgBotNotify(cookie, userId);
                await showMsg(userId);
            }

            for (var i = 0; i <= $.HOSTURLs.length - 1; i++) {
                if ($.HOSTURLs[i] && $.APITOKENs[i]) {
                    await updateCookie(cookie, $.HOSTURLs[i], $.APITOKENs[i]);
                    for (const userId of $.TGUserIDs) {
                        await tgBotNotify(`${$.HOSTURLs[i]} - ${message}`, userId);
                    }
                }
            }

        }


    } catch (error) {
        $.msg('写入京东Cookie失败', '', '请重试 ⚠️');
        console.log(
            `\n写入京东Cookie出现错误 ‼️\n${JSON.stringify(
                error
            )}\n\n${error}\n\n${JSON.stringify($request.headers)}\n`
        );
    }
})()
    .catch((e) => $.logErr(e))
    .finally(() => $.done());

function tgBotNotify(text, TGUserID) {
    return new Promise((resolve) => {
        const opts = {
            url: `https://${$.TG_API_HOST}/bot${$.TGBotToken}/sendMessage`,
            headers: {
                'Content-Type': 'application/x-www-form-urlencoded',
            },
            body: `chat_id=${TGUserID}&text=${text}&disable_web_page_preview=true`,
        };
        $.post(opts, (err, resp, data) => {
            try {
                if (err) {
                    console.log(`${JSON.stringify(err)}`);
                } else {
                    //console.log(data)
                    data = JSON.parse(data);
                    if (data.ok) {
                        if (text.indexOf("pt_pin=") != -1) {
                            console.log(`已发送 Cookie 给 ${TGUserID}🎉。\n`);
                            message = `已发送 Cookie 给 ${TGUserID}🎉。`;
                        } else {
                            console.log(`${data.result.text}`);
                            message = `${data.result.text}`;
                        }
                    } else if (data.error_code === 400) {
                        console.log(`发送失败，请联系 ${TGUserID}。\n`);
                        message = `发送失败，请联系 ${TGUserID}。`;
                    } else if (data.error_code === 401) {
                        console.log(`${TGUserID} bot token 填写错误。\n`);
                        message = `${TGUserID} bot token 填写错误。`;
                    }
                }
            } catch (e) {
                $.logErr(e, resp);
            } finally {
                resolve();
            }
        });
    });
}

function updateCookie(cookie, ipAddress, apitoken) {
    return new Promise((resolve) => {
        const opts = {
            url: `http://${ipAddress}/openApi/updateCookie`,
            headers: {
                'api-token': apitoken,
                'Content-Type': 'application/json',
            },
            body: JSON.stringify({
                "cookie": cookie,
                "userMsg": "无备注",
                "defaultStatus": "false",
                "defaultName": "无备注",
                "defaultWeight": "1"
            }),
        };

        $.post(opts, (err, resp, data) => {
            try {
                if (err) {
                    console.log(`${JSON.stringify(err)}`);
                } else {
                    //console.log(data)
                    data = JSON.parse(data);
                    if (data.code == 1) {
                        console.log(`${data.msg.replace(/\n/g, '')}\n`);
                        message = `${data.msg.replace(/\n/g, '')}`;
                    } else if (data.code != 1) {
                        console.log(`${data.msg.replace(/\n/g, '')}\n`);
                        message = `${data.msg.replace(/\n/g, '')}`;
                    }
                }
            } catch (e) {
                $.logErr(e, resp);
            } finally {
                resolve();
            }
        });
    });
}

function showMsg() {
    return new Promise((resolve) => {
        $.msg($.name, $.subt, message || '服务不可用');
        resolve();
    });
}

// prettier-ignore
// https://raw.githubusercontent.com/chavyleung/scripts/master/Env.js
function Env(name, opts) {
    class Http {
        constructor(env) {
            this.env = env
        }

        send(opts, method = 'GET') {
            opts = typeof opts === 'string' ? { url: opts } : opts
            let sender = this.get
            if (method === 'POST') {
                sender = this.post
            }
            return new Promise((resolve, reject) => {
                sender.call(this, opts, (err, resp, body) => {
                    if (err) reject(err)
                    else resolve(resp)
                })
            })
        }

        get(opts) {
            return this.send.call(this.env, opts)
        }

        post(opts) {
            return this.send.call(this.env, opts, 'POST')
        }
    }

    return new (class {
        constructor(name, opts) {
            this.name = name
            this.http = new Http(this)
            this.data = null
            this.dataFile = 'box.dat'
            this.logs = []
            this.isMute = false
            this.isNeedRewrite = false
            this.logSeparator = '\n'
            this.encoding = 'utf-8'
            this.startTime = new Date().getTime()
            Object.assign(this, opts)
            this.log('', `🔔${this.name}, 开始!`)
        }

        isNode() {
            return 'undefined' !== typeof module && !!module.exports
        }

        isQuanX() {
            return 'undefined' !== typeof $task
        }

        isSurge() {
            return 'undefined' !== typeof $httpClient && 'undefined' === typeof $loon
        }

        isLoon() {
            return 'undefined' !== typeof $loon
        }

        isShadowrocket() {
            return 'undefined' !== typeof $rocket
        }

        toObj(str, defaultValue = null) {
            try {
                return JSON.parse(str)
            } catch {
                return defaultValue
            }
        }

        toStr(obj, defaultValue = null) {
            try {
                return JSON.stringify(obj)
            } catch {
                return defaultValue
            }
        }

        getjson(key, defaultValue) {
            let json = defaultValue
            const val = this.getdata(key)
            if (val) {
                try {
                    json = JSON.parse(this.getdata(key))
                } catch { }
            }
            return json
        }

        setjson(val, key) {
            try {
                return this.setdata(JSON.stringify(val), key)
            } catch {
                return false
            }
        }

        getScript(url) {
            return new Promise((resolve) => {
                this.get({ url }, (err, resp, body) => resolve(body))
            })
        }

        runScript(script, runOpts) {
            return new Promise((resolve) => {
                let httpapi = this.getdata('@chavy_boxjs_userCfgs.httpapi')
                httpapi = httpapi ? httpapi.replace(/\n/g, '').trim() : httpapi
                let httpapi_timeout = this.getdata('@chavy_boxjs_userCfgs.httpapi_timeout')
                httpapi_timeout = httpapi_timeout ? httpapi_timeout * 1 : 20
                httpapi_timeout = runOpts && runOpts.timeout ? runOpts.timeout : httpapi_timeout
                const [key, addr] = httpapi.split('@')
                const opts = {
                    url: `http://${addr}/v1/scripting/evaluate`,
                    body: { script_text: script, mock_type: 'cron', timeout: httpapi_timeout },
                    headers: { 'X-Key': key, 'Accept': '*/*' }
                }
                this.post(opts, (err, resp, body) => resolve(body))
            }).catch((e) => this.logErr(e))
        }

        loaddata() {
            if (this.isNode()) {
                this.fs = this.fs ? this.fs : require('fs')
                this.path = this.path ? this.path : require('path')
                const curDirDataFilePath = this.path.resolve(this.dataFile)
                const rootDirDataFilePath = this.path.resolve(process.cwd(), this.dataFile)
                const isCurDirDataFile = this.fs.existsSync(curDirDataFilePath)
                const isRootDirDataFile = !isCurDirDataFile && this.fs.existsSync(rootDirDataFilePath)
                if (isCurDirDataFile || isRootDirDataFile) {
                    const datPath = isCurDirDataFile ? curDirDataFilePath : rootDirDataFilePath
                    try {
                        return JSON.parse(this.fs.readFileSync(datPath))
                    } catch (e) {
                        return {}
                    }
                } else return {}
            } else return {}
        }

        writedata() {
            if (this.isNode()) {
                this.fs = this.fs ? this.fs : require('fs')
                this.path = this.path ? this.path : require('path')
                const curDirDataFilePath = this.path.resolve(this.dataFile)
                const rootDirDataFilePath = this.path.resolve(process.cwd(), this.dataFile)
                const isCurDirDataFile = this.fs.existsSync(curDirDataFilePath)
                const isRootDirDataFile = !isCurDirDataFile && this.fs.existsSync(rootDirDataFilePath)
                const jsondata = JSON.stringify(this.data)
                if (isCurDirDataFile) {
                    this.fs.writeFileSync(curDirDataFilePath, jsondata)
                } else if (isRootDirDataFile) {
                    this.fs.writeFileSync(rootDirDataFilePath, jsondata)
                } else {
                    this.fs.writeFileSync(curDirDataFilePath, jsondata)
                }
            }
        }

        lodash_get(source, path, defaultValue = undefined) {
            const paths = path.replace(/\[(\d+)\]/g, '.$1').split('.')
            let result = source
            for (const p of paths) {
                result = Object(result)[p]
                if (result === undefined) {
                    return defaultValue
                }
            }
            return result
        }

        lodash_set(obj, path, value) {
            if (Object(obj) !== obj) return obj
            if (!Array.isArray(path)) path = path.toString().match(/[^.[\]]+/g) || []
            path
                .slice(0, -1)
                .reduce((a, c, i) => (Object(a[c]) === a[c] ? a[c] : (a[c] = Math.abs(path[i + 1]) >> 0 === +path[i + 1] ? [] : {})), obj)[
                path[path.length - 1]
            ] = value
            return obj
        }

        getdata(key) {
            let val = this.getval(key)
            // 如果以 @
            if (/^@/.test(key)) {
                const [, objkey, paths] = /^@(.*?)\.(.*?)$/.exec(key)
                const objval = objkey ? this.getval(objkey) : ''
                if (objval) {
                    try {
                        const objedval = JSON.parse(objval)
                        val = objedval ? this.lodash_get(objedval, paths, '') : val
                    } catch (e) {
                        val = ''
                    }
                }
            }
            return val
        }

        setdata(val, key) {
            let issuc = false
            if (/^@/.test(key)) {
                const [, objkey, paths] = /^@(.*?)\.(.*?)$/.exec(key)
                const objdat = this.getval(objkey)
                const objval = objkey ? (objdat === 'null' ? null : objdat || '{}') : '{}'
                try {
                    const objedval = JSON.parse(objval)
                    this.lodash_set(objedval, paths, val)
                    issuc = this.setval(JSON.stringify(objedval), objkey)
                } catch (e) {
                    const objedval = {}
                    this.lodash_set(objedval, paths, val)
                    issuc = this.setval(JSON.stringify(objedval), objkey)
                }
            } else {
                issuc = this.setval(val, key)
            }
            return issuc
        }

        getval(key) {
            if (this.isSurge() || this.isLoon()) {
                return $persistentStore.read(key)
            } else if (this.isQuanX()) {
                return $prefs.valueForKey(key)
            } else if (this.isNode()) {
                this.data = this.loaddata()
                return this.data[key]
            } else {
                return (this.data && this.data[key]) || null
            }
        }

        setval(val, key) {
            if (this.isSurge() || this.isLoon()) {
                return $persistentStore.write(val, key)
            } else if (this.isQuanX()) {
                return $prefs.setValueForKey(val, key)
            } else if (this.isNode()) {
                this.data = this.loaddata()
                this.data[key] = val
                this.writedata()
                return true
            } else {
                return (this.data && this.data[key]) || null
            }
        }

        initGotEnv(opts) {
            this.got = this.got ? this.got : require('got')
            this.cktough = this.cktough ? this.cktough : require('tough-cookie')
            this.ckjar = this.ckjar ? this.ckjar : new this.cktough.CookieJar()
            if (opts) {
                opts.headers = opts.headers ? opts.headers : {}
                if (undefined === opts.headers.Cookie && undefined === opts.cookieJar) {
                    opts.cookieJar = this.ckjar
                }
            }
        }

        get(opts, callback = () => { }) {
            if (opts.headers) {
                delete opts.headers['Content-Type']
                delete opts.headers['Content-Length']
            }
            if (this.isSurge() || this.isLoon()) {
                if (this.isSurge() && this.isNeedRewrite) {
                    opts.headers = opts.headers || {}
                    Object.assign(opts.headers, { 'X-Surge-Skip-Scripting': false })
                }
                $httpClient.get(opts, (err, resp, body) => {
                    if (!err && resp) {
                        resp.body = body
                        resp.statusCode = resp.status
                    }
                    callback(err, resp, body)
                })
            } else if (this.isQuanX()) {
                if (this.isNeedRewrite) {
                    opts.opts = opts.opts || {}
                    Object.assign(opts.opts, { hints: false })
                }
                $task.fetch(opts).then(
                    (resp) => {
                        const { statusCode: status, statusCode, headers, body } = resp
                        callback(null, { status, statusCode, headers, body }, body)
                    },
                    (err) => callback(err)
                )
            } else if (this.isNode()) {
                let iconv = require('iconv-lite')
                this.initGotEnv(opts)
                this.got(opts)
                    .on('redirect', (resp, nextOpts) => {
                        try {
                            if (resp.headers['set-cookie']) {
                                const ck = resp.headers['set-cookie'].map(this.cktough.Cookie.parse).toString()
                                if (ck) {
                                    this.ckjar.setCookieSync(ck, null)
                                }
                                nextOpts.cookieJar = this.ckjar
                            }
                        } catch (e) {
                            this.logErr(e)
                        }
                        // this.ckjar.setCookieSync(resp.headers['set-cookie'].map(Cookie.parse).toString())
                    })
                    .then(
                        (resp) => {
                            const { statusCode: status, statusCode, headers, rawBody } = resp
                            callback(null, { status, statusCode, headers, rawBody }, iconv.decode(rawBody, this.encoding))
                        },
                        (err) => {
                            const { message: error, response: resp } = err
                            callback(error, resp, resp && iconv.decode(resp.rawBody, this.encoding))
                        }
                    )
            }
        }

        post(opts, callback = () => { }) {
            const method = opts.method ? opts.method.toLocaleLowerCase() : 'post'
            // 如果指定了请求体, 但没指定`Content-Type`, 则自动生成
            if (opts.body && opts.headers && !opts.headers['Content-Type']) {
                opts.headers['Content-Type'] = 'application/x-www-form-urlencoded'
            }
            if (opts.headers) delete opts.headers['Content-Length']
            if (this.isSurge() || this.isLoon()) {
                if (this.isSurge() && this.isNeedRewrite) {
                    opts.headers = opts.headers || {}
                    Object.assign(opts.headers, { 'X-Surge-Skip-Scripting': false })
                }
                $httpClient[method](opts, (err, resp, body) => {
                    if (!err && resp) {
                        resp.body = body
                        resp.statusCode = resp.status
                    }
                    callback(err, resp, body)
                })
            } else if (this.isQuanX()) {
                opts.method = method
                if (this.isNeedRewrite) {
                    opts.opts = opts.opts || {}
                    Object.assign(opts.opts, { hints: false })
                }
                $task.fetch(opts).then(
                    (resp) => {
                        const { statusCode: status, statusCode, headers, body } = resp
                        callback(null, { status, statusCode, headers, body }, body)
                    },
                    (err) => callback(err)
                )
            } else if (this.isNode()) {
                let iconv = require('iconv-lite')
                this.initGotEnv(opts)
                const { url, ..._opts } = opts
                this.got[method](url, _opts).then(
                    (resp) => {
                        const { statusCode: status, statusCode, headers, rawBody } = resp
                        callback(null, { status, statusCode, headers, rawBody }, iconv.decode(rawBody, this.encoding))
                    },
                    (err) => {
                        const { message: error, response: resp } = err
                        callback(error, resp, resp && iconv.decode(resp.rawBody, this.encoding))
                    }
                )
            }
        }
        /**
         *
         * 示例:$.time('yyyy-MM-dd qq HH:mm:ss.S')
         *    :$.time('yyyyMMddHHmmssS')
         *    y:年 M:月 d:日 q:季 H:时 m:分 s:秒 S:毫秒
         *    其中y可选0-4位占位符、S可选0-1位占位符，其余可选0-2位占位符
         * @param {string} fmt 格式化参数
         * @param {number} 可选: 根据指定时间戳返回格式化日期
         *
         */
        time(fmt, ts = null) {
            const date = ts ? new Date(ts) : new Date()
            let o = {
                'M+': date.getMonth() + 1,
                'd+': date.getDate(),
                'H+': date.getHours(),
                'm+': date.getMinutes(),
                's+': date.getSeconds(),
                'q+': Math.floor((date.getMonth() + 3) / 3),
                'S': date.getMilliseconds()
            }
            if (/(y+)/.test(fmt)) fmt = fmt.replace(RegExp.$1, (date.getFullYear() + '').substr(4 - RegExp.$1.length))
            for (let k in o)
                if (new RegExp('(' + k + ')').test(fmt))
                    fmt = fmt.replace(RegExp.$1, RegExp.$1.length == 1 ? o[k] : ('00' + o[k]).substr(('' + o[k]).length))
            return fmt
        }

        /**
         * 系统通知
         *
         * > 通知参数: 同时支持 QuanX 和 Loon 两种格式, EnvJs根据运行环境自动转换, Surge 环境不支持多媒体通知
         *
         * 示例:
         * $.msg(title, subt, desc, 'twitter://')
         * $.msg(title, subt, desc, { 'open-url': 'twitter://', 'media-url': 'https://github.githubassets.com/images/modules/open_graph/github-mark.png' })
         * $.msg(title, subt, desc, { 'open-url': 'https://bing.com', 'media-url': 'https://github.githubassets.com/images/modules/open_graph/github-mark.png' })
         *
         * @param {*} title 标题
         * @param {*} subt 副标题
         * @param {*} desc 通知详情
         * @param {*} opts 通知参数
         *
         */
        msg(title = name, subt = '', desc = '', opts) {
            const toEnvOpts = (rawopts) => {
                if (!rawopts) return rawopts
                if (typeof rawopts === 'string') {
                    if (this.isLoon()) return rawopts
                    else if (this.isQuanX()) return { 'open-url': rawopts }
                    else if (this.isSurge()) return { url: rawopts }
                    else return undefined
                } else if (typeof rawopts === 'object') {
                    if (this.isLoon()) {
                        let openUrl = rawopts.openUrl || rawopts.url || rawopts['open-url']
                        let mediaUrl = rawopts.mediaUrl || rawopts['media-url']
                        return { openUrl, mediaUrl }
                    } else if (this.isQuanX()) {
                        let openUrl = rawopts['open-url'] || rawopts.url || rawopts.openUrl
                        let mediaUrl = rawopts['media-url'] || rawopts.mediaUrl
                        let updatePasteboard =
                            rawopts['update-pasteboard'] || rawopts.updatePasteboard
                        return { 'open-url': openUrl, 'media-url': mediaUrl, 'update-pasteboard': updatePasteboard }
                    } else if (this.isSurge()) {
                        let openUrl = rawopts.url || rawopts.openUrl || rawopts['open-url']
                        return { url: openUrl }
                    }
                } else {
                    return undefined
                }
            }
            if (!this.isMute) {
                if (this.isSurge() || this.isLoon()) {
                    $notification.post(title, subt, desc, toEnvOpts(opts))
                } else if (this.isQuanX()) {
                    $notify(title, subt, desc, toEnvOpts(opts))
                }
            }
            if (!this.isMuteLog) {
                let logs = ['', '==============📣系统通知📣==============']
                logs.push(title)
                subt ? logs.push(subt) : ''
                desc ? logs.push(desc) : ''
                console.log(logs.join('\n'))
                this.logs = this.logs.concat(logs)
            }
        }

        log(...logs) {
            if (logs.length > 0) {
                this.logs = [...this.logs, ...logs]
            }
            console.log(logs.join(this.logSeparator))
        }

        logErr(err, msg) {
            const isPrintSack = !this.isSurge() && !this.isQuanX() && !this.isLoon()
            if (!isPrintSack) {
                this.log('', `❗️${this.name}, 错误!`, err)
            } else {
                this.log('', `❗️${this.name}, 错误!`, err.stack)
            }
        }

        wait(time) {
            return new Promise((resolve) => setTimeout(resolve, time))
        }

        done(val = {}) {
            const endTime = new Date().getTime()
            const costTime = (endTime - this.startTime) / 1000
            this.log('', `🔔${this.name}, 结束! 🕛 ${costTime} 秒`)
            this.log()
            if (this.isSurge() || this.isQuanX() || this.isLoon()) {
                $done(val)
            }
        }
    })(name, opts)
}
