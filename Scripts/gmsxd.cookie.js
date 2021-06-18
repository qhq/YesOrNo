/*
Quantumult X
[rewrite_local]
# 光明随心订签到
^https?:\/\/m.4008117117.com/api/user/web/identify/getEmployee url script-request-header https://raw.githubusercontent.com/qhq/YesOrNo/main/Scripts/gmsxd.cookie.js

[task_local]
#光明随心订签到
0 7 * * * https://raw.githubusercontent.com/qhq/YesOrNo/main/Scripts/gmsxd.js, tag=光明随心订签到, img-url=https://raw.githubusercontent.com/qhq/YesOrNo/main/icons/gmsxd.png, enabled=true
*/

const cookieName = '光明随心订'
const cookieKey = 'qhq_gmsxd_cookie'
const qhq = init()
const cookieVal = $request.headers['Cookie']
if (cookieVal) {
  if (qhq.setdata(cookieVal, cookieKey)) {
    qhq.msg(`${cookieName}`, '获取Cookie: 成功', '')
    qhq.log(`[${cookieName}] 获取Cookie: 成功, cookie: ${cookieVal}`)
  }
}

function init() {
  isSurge = () => {
    return undefined === this.$httpClient ? false : true
  }
  isQuanX = () => {
    return undefined === this.$task ? false : true
  }
  getdata = (key) => {
    if (isSurge()) return $persistentStore.read(key)
    if (isQuanX()) return $prefs.valueForKey(key)
  }
  setdata = (key, val) => {
    if (isSurge()) return $persistentStore.write(key, val)
    if (isQuanX()) return $prefs.setValueForKey(key, val)
  }
  msg = (title, subtitle, body) => {
    if (isSurge()) $notification.post(title, subtitle, body)
    if (isQuanX()) $notify(title, subtitle, body)
  }
  log = (message) => console.log(message)
  get = (url, cb) => {
    if (isSurge()) {
      $httpClient.get(url, cb)
    }
    if (isQuanX()) {
      url.method = 'GET'
      $task.fetch(url).then((resp) => cb(null, {}, resp.body))
    }
  }
  post = (url, cb) => {
    if (isSurge()) {
      $httpClient.post(url, cb)
    }
    if (isQuanX()) {
      url.method = 'POST'
      $task.fetch(url).then((resp) => cb(null, {}, resp.body))
    }
  }
  done = (value = {}) => {
    $done(value)
  }
  return { isSurge, isQuanX, msg, log, getdata, setdata, get, post, done }
}
qhq.done()