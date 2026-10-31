# HTML5 Slot Machine - 部署指南

## 项目概述

轻量级静态 HTML5 老虎机游戏，基于 Web Animations API，纯 JavaScript 实现，集成完整 SEO 与 GEO 优化。

## 生产环境

| 项目 | 值 |
|------|-----|
| **生产 URL** | https://slotmachine.vip01.cc.cd/ |
| **托管方式** | Cloudflare Pages + Worker 反代 |
| **Pages 项目** | slotmachine-casino |
| **Pages 别名** | slotmachine-casino.pages.dev |
| **代理 Worker** | slotmachine-pages-proxy |
| **DNS** | slotmachine.vip01.cc.cd CNAME → slotmachine-casino.pages.dev |
| **路由** | slotmachine.vip01.cc.cd/* → slotmachine-pages-proxy |

## 部署步骤（可复用）

### 前置条件
- Node.js >= 18
- Cloudflare API Token（Pages:Edit, Workers:Edit 权限）
- Cloudflare Account ID

### 方式一：一键脚本（推荐）
```powershell
$env:CLOUDFLARE_API_TOKEN = "<your-token>"
$env:CLOUDFLARE_ACCOUNT_ID = "<your-account-id>"
.\deploy-slot.ps1
```

### 方式二：手动部署
```powershell
# 1. 安装依赖
npm install

# 2. 构建
npm run build

# 3. 复制额外文件到 dist/
Copy-Item _headers, robots.txt, sitemap.xml -Destination dist\

# 4. 部署到 Cloudflare Pages
npx wrangler pages deploy dist --project-name slotmachine-casino --branch main

# 5. 验证
curl -s -o /dev/null -w "%{http_code}" https://slotmachine.vip01.cc.cd/
```

### 方式三：GitHub Actions 自动部署
推送代码到 GitHub main 分支，CI 自动构建并部署。

## SEO/GEO 优化清单

### Meta 标签
- [x] `<title>` - 包含关键词与品牌名
- [x] `<meta name="description">` - 150-160 字符描述
- [x] `<meta name="keywords">` - 相关关键词
- [x] `<meta name="author">` - 作者信息
- [x] `<meta name="robots">` - index, follow, max-image-preview:large
- [x] `<meta name="msvalidate.01">` - Bing 验证
- [x] `<meta http-equiv="Content-Language">` - 语言声明
- [x] `<meta name="geo.region">` / `<meta name="geo.placename">` - 地理定位
- [x] `<meta name="language">` - 语言

### Open Graph
- [x] og:type, og:site_name, og:title, og:description
- [x] og:url, og:image, og:image:width, og:image:height
- [x] og:image:secure_url, og:locale, og:locale:alternate

### Twitter Card
- [x] twitter:card (summary_large_image)
- [x] twitter:site, twitter:creator
- [x] twitter:title, twitter:description, twitter:image

### 结构化数据 (JSON-LD)
- [x] WebApplication - 应用信息
- [x] Organization - 组织/作者信息
- [x] FAQPage - 常见问题
- [x] BreadcrumbList - 面包屑导航
- [x] HowTo - 游戏步骤

### 区域适配 (GEO)
- [x] hreflang (zh-CN, en, x-default)
- [x] Content-Language meta
- [x] geo.region / geo.placename
- [x] og:locale / og:locale:alternate

### 技术 SEO
- [x] Canonical URL
- [x] robots.txt (允许所有爬虫 + sitemap 引用)
- [x] sitemap.xml (含图片扩展)
- [x] 语义化 HTML5 (header, nav, main, section, article, footer)
- [x] 图片 alt 文本
- [x] aria-label / aria-live (无障碍)
- [x] skip-link (键盘导航)

### 安全与性能
- [x] CSP, HSTS, X-Frame-Options, X-Content-Type-Options
- [x] Referrer-Policy, Permissions-Policy
- [x] CSS/JS 缓存 (1 年 immutable)
- [x] HTML 缓存 (max-age=0, must-revalidate)
- [x] 资源预加载 (preload)

## 部署后验证

```powershell
# 检查 HTTP 状态
curl -s -o /dev/null -w "%{http_code}" https://slotmachine.vip01.cc.cd/

# 检查安全头
curl -sI https://slotmachine.vip01.cc.cd/ | grep -i "content-security-policy\|x-frame-options\|strict-transport"

# 检查 meta 标签
curl -s https://slotmachine.vip01.cc.cd/ | grep -i "msvalidate\|og:title\|twitter:card\|application/ld+json"

# 检查 robots.txt
curl -s https://slotmachine.vip01.cc.cd/robots.txt

# 检查 sitemap.xml
curl -s https://slotmachine.vip01.cc.cd/sitemap.xml
```

## 代码托管

| 平台 | 仓库 | 状态 |
|------|------|------|
| GitHub | https://github.com/vip-4/html5-slot-machine | ✅ |
| Gitee | https://gitee.com/vip882/html5-slot-machine | ✅ |
| AtomGit | https://atomgit.com/zzw1208/html5-slot-machine | ✅ |

## 搜索引擎提交

1. **Bing Webmaster Tools**: meta 验证标签已部署，登录控制台完成验证并提交 sitemap
2. **Google Search Console**: 使用相同验证标签，提交 sitemap
3. **百度搜索资源平台**: 使用相同验证标签，提交 sitemap

## 注意事项

- `dist/` 目录为构建产物，已在 `.gitignore` 中排除
- `node_modules/` 已在 `.gitignore` 中排除
- 敏感凭证不得提交到版本控制
- 部署前确保 `img/og-image.png` 和 `img/favicon-32.png` 存在
- 构建命令: `npm run build` (webpack production mode)