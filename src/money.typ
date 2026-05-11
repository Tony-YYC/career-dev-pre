#import "@preview/touying:0.6.1": *
#import "@preview/cetz:0.4.2"
#import "@preview/fletcher:0.5.8" as fletcher: edge, node
#import "../lib.typ": *

#let cetz-canvas = touying-reducer.with(reduce: cetz.canvas, cover: cetz.draw.hide.with(bounds: true))
#let fletcher-diagram = touying-reducer.with(reduce: fletcher.diagram, cover: fletcher.hide)

#set text(lang: "zh")
#set par(leading: 0.8em, justify: true)
#show: sjtu-theme.with(
  aspect-ratio: "16-9",
  navigation: "mini-slides",
  footer: self => self.info.institution,
  config-info(
    title: [Generate 的"钱"],
    subtitle: [资本入场券，还是临床倒计时？],
    author: [职业发展课 · 案例分析 Pre],
    date: datetime.today(),
    institution: [Generate Biomedicines（NASDAQ: GENB）案例分析],
  ),
  config-common(slide-level: 2),
)

// ============================================================
// 颜色与小工具
// ============================================================
#let c-primary = rgb("#C9141E")
#let c-accent = rgb("#0C4842")
#let c-amber = rgb("#E8A33D")
#let c-gray = rgb("#666666")
#let c-light = rgb("#F4F4F4")

#let stat-card(label, value, sub: none, color: c-primary) = block(
  width: 100%,
  inset: 0.9em,
  radius: 6pt,
  fill: color.lighten(88%),
  stroke: (left: 4pt + color),
  {
    set par(justify: false, leading: 0.6em)
    text(size: 1.0em, fill: c-gray, label)
    v(0.4em)
    text(size: 1.5em, weight: "bold", fill: color, value)
    if sub != none {
      v(0.3em)
      text(size: 0.9em, fill: c-gray, sub)
    }
  },
)

#let bar(label, value-text, ratio, color, sub: none) = {
  let bar-w = 100%
  grid(
    columns: (8em, 1fr),
    column-gutter: 0.8em,
    row-gutter: 0.2em,
    align(right + horizon, text(size: 0.9em, label)),
    {
      stack(
        dir: ltr,
        rect(width: ratio * bar-w, height: 1.2em, fill: color, radius: 2pt),
      )
      if sub != none { text(size: 0.72em, fill: c-gray, sub) }
    },
    [],
    text(size: 0.78em, fill: c-gray, value-text),
  )
}

// ============================================================
// 标题页
// ============================================================
#title-slide-red()

// ============================================================
// I. 钱从哪里来
// ============================================================

= 钱

== 总览

#v(0.6em)

#grid(
  columns: (1fr, 1fr, 1fr),
  column-gutter: 1em,
  stat-card(
    [历史累计资金来源],
    [\$1.33B+],
    color: c-accent,
    sub: [优先股 \$805M + 合作付款 \$110M + 其他 + IPO 总额 \$400M],
  ),
  stat-card(
    [IPO 募资],
    [\$400M / \$369.3M],
    color: c-primary,
    sub: [\$16/股 × 25M 股；net proceeds 实际 \$369.3M],
  ),
  stat-card(
    [当前股价（截至 5/7 收盘）],
    [≈ \$13.59],
    color: c-amber,
    sub: [仍低于 \$16 IPO 发行价；首日最低跌至 \$12.65],
  ),
)

#v(1em)

#text(size: 0.95em)[
  Generate 已经成功用它的故事从投资者手中能拿到钱，但还没有证明它"能用这些钱做出上市药物"。\ 
  它从私募、大药企合作、IPO 三个来源成功融资；\
  但上市后股价始终未稳站发行价，说明*市场还在等临床兑现，并不愿意为一个 AI 故事买单*。
]

== 钱从哪里来：三条资金线

#text(size: 0.85em, fill: c-gray)[
  Generate 不是"靠 VC 输血"的早期 biotech，而是平台型公司——融资逻辑不是"卖一个药"，而是"证明平台能不断生成药物"。
]

#v(0.2em)

#align(center, fletcher-diagram(
  node-stroke: 0.6pt,
  node-corner-radius: 4pt,
  spacing: (3.0em, 1.0em),
  node-inset: 1.0em,
  node((1, 0), text(0.8em)[*VC / 战略股权* \ #text(0.85em)[Flagship · ADIA · Fidelity\ T. Rowe Price · Amgen ...]], fill: c-accent.lighten(85%), stroke: c-accent),
  node((0, 1), text(0.8em)[*BD 合作付款* \ #text(0.85em)[Amgen / Novartis\ upfront + 股权 + milestone]], fill: c-amber.lighten(80%), stroke: c-amber),
  node((1, 2), text(0.8em)[*IPO 公开市场* \ #text(0.85em)[2026.02 · NASDAQ: GENB\ 4 亿美元]], fill: c-primary.lighten(85%), stroke: c-primary),
  node((2, 1), text(0.85em)[*Generate* \ *Biomedicines*], fill: rgb("#FFF4F4"), stroke: 1pt + c-primary, corner-radius: 30pt, inset: 0.7em),
  edge((1, 0), (2, 1), "->", text(0.7em)[A/B/C ≈ \$813M]),
  edge((0, 1), (2, 1), "->", text(0.7em)[已到账 ≈ \$110M]),
  edge((1, 2), (2, 1), "->", text(0.7em)[IPO \$400M]),
  node((4, 0), text(0.8em)[GB-0895 Phase 3 \ #text(0.85em)[严重哮喘]], fill: c-light),
  node((4, 1), text(0.8em)[COPD Phase 1b \ GB-4362 / GB-5267], fill: c-light),
  node((4, 2), text(0.8em)[平台研发 + 组织运营], fill: c-light),
  edge((2, 1), (4, 0), "->"),
  edge((2, 1), (4, 1), "->"),
  edge((2, 1), (4, 2), "->"),
))

== 早期孵化与 Series B：从 Flagship 内部项目到独角兽

#grid(
  columns: (1fr, 2fr),
  column-gutter: 1em,
  // 左侧时间线（用 cetz 简单画）
  [
  #cetz-canvas(length: 1.5cm, {
    import cetz.draw: *
    set-style(stroke: (paint: c-gray, thickness: 0.6pt))
    line((0.4, 0), (0.4, -6.6), stroke: 1pt + c-primary)
    let dot(y, color) = circle((0.4, y), radius: 0.12, fill: color, stroke: none)

    dot(-0.5, c-accent)
    content((0.8, -0.5), anchor: "west", text(0.85em, weight: "bold", [2018–2020]))
    content((0.8, -1.0), anchor: "west", text(0.78em, fill: c-gray, [Flagship 内部孵化 · 未披露估值]))

    dot(-1.8, c-accent)
    content((0.8, -1.8), anchor: "west", text(0.85em, weight: "bold", [Series A]))
    content((0.8, -2.3), anchor: "west", text(0.78em, fill: c-gray, [Flagship 主导的内部融资]))
    content((0.8, -2.8), anchor: "west", text(0.78em, fill: c-gray, [\$40M · 26.40M股]))
    content((0.8, -3.3), anchor: "west", text(0.78em, fill: c-gray, [折合 ≈\$1.52/股]))

    dot(-4.0, c-primary)
    content((0.8, -4.0), anchor: "west", text(0.85em, weight: "bold", [2021.11 Series B]))
    content((0.8, -4.5), anchor: "west", text(0.78em, fill: c-gray, [首轮外部融资]))
    content((0.8, -5.0), anchor: "west", text(0.78em, fill: c-gray, [\$370M · 20.75M股]))
    content((0.8, -5.5), anchor: "west", text(0.78em, fill: c-gray, [折合 ≈\$18/股 · 高于 IPO 价]))

    dot(-6.2, c-amber)
    content((0.8, -6.2), anchor: "west", text(0.85em, [→ Series C / IPO（后续页）]))
  })
  #v(0.2em)
  #text(0.6em, fill: c-gray)[注：公司在IPO前进行了 1.5190:1 优先股->普通股合股，所有每股成本和股数均按招股书的合股后口径计算]
  ],
  block(inset: (left: 1em), {
    set par(justify: true)
    text(weight: "bold", [Venture studio 模式：自己造公司，再融资])
    v(0.3em)
    text(size: 0.88em)[
      Flagship 不是"别人创业再投钱"的普通 VC，而是先提出科学假设、搭团队、做早期验证，然后把公司孵化出来。因此，Generate 的 Series A 是"内部融资 + 资源支持"。Series A 估值在当时未对外披露，但是可以通过招股书倒推。
    ]
    v(0.6em)
    text(weight: "bold", [Series B（2021.11）：3.7 亿美元，正式跨入独角兽])
    v(0.3em)
    text(size: 0.88em)[
      投资人结构非常多元：*Flagship · ADIA 子公司 · Alaska Permanent Fund · Altitude · ARCH · Fidelity · Morningside · T. Rowe Price* — 既有长期持股的主权基金，也有跨界的科技 / 生物科技基金。资金用于"干湿实验闭环"平台、组织扩张和管线推进。
    ]
    v(0.6em)
    text(size: 0.85em, fill: c-primary)[
      *关键信号：B 轮折合普通股成本 ≈ \$18/股，甚至高于后来的 IPO 价 \$16/股。这反映出一级市场远比公开市场乐观。*
    ]
  }),
)

== Series C：资本寒冬中的战略背书

#grid(
  columns: (0.9fr, 1fr),
  column-gutter: 1.2em,
  block({
    text(weight: "bold", [2023.05 – 2025.01 累计 ≈ \$421.4M])
    v(0.3em)
    text(size: 0.88em)[
      在 2023 年 biotech 融资寒冬里仍完成大额股权融资，意义不在金额，而在*投资人结构的进化*：
    ]
    v(0.5em)
    text(size: 0.88em)[
      - *新增产业方*：Amgen（大药企）、NVentures（NVIDIA 生态）、MAPS Capital、Pictet Alternative Advisors
      - *老股东续投*：Flagship · ADIA · Fidelity · T. Rowe Price · ARCH · March
      - Samsung Life Science Fund 在后续追加投资方，这是产品制造能力方面的背书
    ]
    v(0.6em)
    text(size: 0.85em, fill: c-primary)[
      *Series B 展现了资本的看好；Series C 则进一步扩展到产业协同。* 大药企买股票，等于让外部产业为平台再背一次书。
    ]
  }),
  // 简化的"生态四象限"图
  [
  #text(fill: c-gray, size: 0.9em)[总股数折合普通股约 23.41M股，均价\$18/股，高于IPO发行价]
  #cetz-canvas(length: 1.2cm, {
    import cetz.draw: *
    let center = (5, 3.0)

    let corner(pos, label, color) = {
      // 先画线，再画矩形和文字，避免线覆盖在内容之上
      line(center, pos, stroke: (paint: color, thickness: 0.8pt, dash: "dashed"))
      rect((pos.at(0) - 1.8, pos.at(1) - 0.8), (pos.at(0) + 1.8, pos.at(1) + 0.8), fill: color.lighten(85%), stroke: 0.6pt + color, radius: 4pt)
      content(pos, text(0.78em, label))
    }

    corner((1.0, 6.0), [Flagship\ 资本孵化], c-accent)
    corner((9.0, 6.0), [NVentures\ 算力生态], c-amber)
    corner((1.0, 0.0), [Amgen / Novartis\ 药企验证], c-primary)
    corner((9.0, 0.0), [Samsung\ 制造背书], c-gray)

    // 中心圆和文字最后画，确保始终在最上层
    circle(center, radius: 2.0, fill: c-primary, stroke: none)
    content(center, text(0.85em, fill: white, weight: "bold")[Generate \ Platform])
  })
  ]
)

== Amgen / Novartis：不只是融资，而是平台验证

#text(size: 0.9em)[*BD 合作 = 大药企为平台付费*。注意需要区分"已到账"与"潜在 milestone" — 后者*不是现金*。]

#v(0.4em)

#grid(
  columns: (1fr, 1fr),
  column-gutter: 1.5em,
  block(
    inset: 0.6em,
    radius: 4pt,
    fill: c-amber.lighten(92%),
    stroke: (left: 3pt + c-amber),
    {
      text(weight: "bold", [Amgen（2022.01 起）])
      v(0.1em)
      text(size: 0.82em)[\$50M upfront + 2023 战略股权 \$25M + 2023 修订 \$5M + 2024 milestone \$5M]
      v(0.1em)
      bar([已到账], [≈ \$85M（含股权）], 0.045, c-amber)
      bar([潜在 milestone], [每项目最高 \$370M × 5 ≈ \$1.85B + royalty], 1.0, c-amber.lighten(50%))
      v(0.1em)
      text(size: 0.78em, fill: c-gray)[2024 / 2025 已确认 collaboration revenue \$18.2M / \$6.7M]
    },
  ),
  block(
    inset: 0.6em,
    radius: 4pt,
    fill: c-accent.lighten(92%),
    stroke: (left: 3pt + c-accent),
    {
      text(weight: "bold", [Novartis（2024.09）])
      v(0.3em)
      text(size: 0.82em)[\$50M upfront + \$15M Series C 股权购买]
      v(0.5em)
      bar([已到账], [≈ \$65M（含股权）], 0.06, c-accent)
      v(0.4em)
      bar([潜在 milestone], [总计 > \$1B + low-double-digit royalty], 0.55, c-accent.lighten(50%))
      v(0.4em)
      text(size: 0.78em, fill: c-gray)[截至招股书 milestone 尚未达成 — 仍是 contingent upside]
    },
  ),
)

#v(0.6em)

#text(size: 0.85em, fill: c-primary)[
  *upfront与股权是"确定的钱"，milestone 和专利使用费是"可能的钱"。\$19 亿 / \$10 亿显然不能全额算入现金余额。\
  但是，这也确实能够体现大药企对“AI药物研发平台”叙事的布局需求与乐观预期。*
]

// ============================================================
// II. IPO 与股价
// ============================================================

== 为什么必须 IPO？

#grid(
  columns: (1.1fr, 1fr),
  column-gutter: 1.2em,
  block({
    text(weight: "bold", size: 1.05em, [公司迫于临床阶段的现金压力而上市])
    v(0.5em)
    text(size: 1.0em)[
      #set par(leading: 0.8em, justify: true)
      + *无产品销售收入* 招股书明确披露持续亏损，需要大量资本支持临床、平台和商业化准备。
      + *巨额累计亏损* 2025 年净亏损 \$223M，2025 年底累计亏损 \$676M。
      + *Phase 3 全面启动* GB-0895 严重哮喘的两个全球 Phase 3 试验已开始；Phase 3 是最烧钱的临床阶段。
      + *现金不够撑过 12 个月* 2025 年底现金及其等价物仅 \$221.5M，2025 年 operating cash burn \$200.6M，*招股书披露 going concern uncertainty*。
    ]
    v(0.5em)
    text(size: 0.85em, fill: c-primary)[
      *对于Generate Biomedicines, IPO 不是资金盈利退出的节点，而是续命的方法。* 它给 Generate 带来推动 Phase 3 的时间窗口。
    ]
  }),
  // 现金漏斗示意
  cetz-canvas(length: 1.7cm, {
    import cetz.draw: *
    set-style(stroke: 0.8pt + c-gray)
    let funnel(y, w, label, fill-c) = {
      rect((4 - w, y), (4 + w, y - 0.9), fill: fill-c, stroke: 0.6pt + c-gray, radius: 2pt)
      content((4, y - 0.45), text(0.78em, white, weight: "bold", label))
    }
    funnel(7, 3.6, [2025 末现金 \$221.5M], c-accent)
    funnel(5.6, 3.0, [2025 burn \$200.6M / 年], c-amber)
    funnel(4.2, 2.4, [Phase 3 持续推高支出], c-primary.lighten(20%))
    funnel(2.8, 1.8, [≈ 13 个月 runway], c-primary)
    content((4, 1.5), text(0.85em, fill: c-primary, weight: "bold")[必须 IPO])
    line((4, 1.2), (4, 0.5), mark: (end: ">"), stroke: 1pt + c-primary)
  }),
)

== IPO 基本情况与募资用途

#grid(
  columns: (1fr, 1.2fr),
  column-gutter: 1.2em,
  block({
    text(weight: "bold", [IPO发行时的具体数据])
    v(0.3em)
    set par(leading: 0.7em)
    text(size: 0.9em)[
      - 定价：*2026-02-26*
      - 发行价：*\$16 / 股*
      - 发行规模：*25,000,000 股*
      - Gross proceeds：*\$400M*
      - Net proceeds（实际）：*\$369.3M*
      - 上市：2026-02-27 NASDAQ: *GENB*
      - 隐含市值：约 *\$2.04B*
      - 承销商：Goldman Sachs · Morgan Stanley
    ]
    v(0.6em)
    text(size: 0.85em, fill: c-primary)[
      招股书中高管给出的预期：\ *Runway 自此延长到 2028 上半年。*
    ]
  }),
  block({
    text(weight: "bold", [募集资金用途])
    v(0.4em)
    let segs = (
      ([GB-0895 Phase 3（severe asthma）], 300, c-primary),
      ([COPD Phase 1b 及下一阶段], 100, c-amber),
      ([平台 + 多项目至 IND-enabling], 75, c-accent),
      ([GB-4362 / GB-5267 Phase 1 topline], 15, c-gray),
    )
    block(width: 100%, {
      for (label, val, color) in segs {
        let pct = val / 320
        grid(
          columns: (1fr, auto),
          column-gutter: 0.5em,
          row-gutter: 0.2em,
          stack(dir: ltr,
            rect(width: pct * 100%, height: 1.4em, fill: color, radius: 2pt),
          ),
          align(right + horizon, text(size: 0.78em, [≈ \$#val M])),
          text(size: 0.8em, label),
          [],
        )
        v(0.2em)
      }
    })
    v(0.4em)
    text(size: 0.78em, fill: c-gray)[
      其余 ≈ \$10M 用于一般营运（G&A）资金。\
      *钱主要花在 GB-0895 Phase 3 上*，IPO 和 GB-0895 是同一个故事。
    ]
  }),
)

== 上市首日：成功发行但立刻破发

#grid(
  columns: (2.0fr, 1fr),
  column-gutter: 1em,
  align(center, image("../input/money/assets/image-20260505173810264.png", width: 100%)),
  block({
    text(weight: "bold", size: 1.0em, [首日的三个节点])
    v(0.5em)
    table(
      columns: (auto, auto, auto),
      stroke: 0.5pt + c-gray,
      align: (left, right, right),
      inset: 0.5em,
      table.header(
        text(0.85em, weight: "bold")[节点],
        text(0.85em, weight: "bold")[价格],
        text(0.85em, weight: "bold")[变化],
      ),
      text(0.85em)[2/26 IPO 定价], text(0.85em)[\$16.00], text(0.85em)[基准（市值 \$2.04B）],
      text(0.85em)[2/27 开盘], text(0.85em)[\$15.00], text(0.85em, fill: c-primary)[−6.25%],
      text(0.85em)[2/27 收盘], text(0.85em)[\$12.65], text(0.85em, fill: c-primary)[*−20.9%* \ （市值 \$1.61B）],
    )
    v(0.6em)
    text(size: 0.85em)[
      *发行成功 ≠ 二级市场认可估值。* Reuters 报道开盘即跌破发行价，WSJ 报道首日近 −21%。说明市场对 AI-driven biotech 估值与临床兑现保持谨慎。
    ]
  }),
)

== 上市后股价：低位震荡 → 分析师覆盖 → 短暂修复

#set par(leading: 0.8em, justify: true)
#grid(
  columns: (1fr, 1fr),
  column-gutter: 1em,
  [
    #align(center, image("../input/money/assets/image-20260505173810264.png", width: 100%))
    #text(size: 0.85em, fill: c-gray)[
      *"首日破发 → 低位震荡 → 分析师覆盖后修复 → Q1 财报回调"*。短期受流动性、覆盖、市场情绪影响；中长期取决于 GB-0895 Phase 3、COPD 数据与肿瘤管线。
    ]
  ],
  table(
    columns: (0.5fr, 1fr, 2fr),
    stroke: 0.5pt + c-gray,
    align: (left, left, left),
    inset: 0.5em,
    table.header(
      text(0.85em, weight: "bold")[时间],
      text(0.85em, weight: "bold")[价格 / 涨跌],
      text(0.85em, weight: "bold")[原因],
    ),
    text(0.82em)[3/4 – 3/6], text(0.82em)[低点 ≈ \$11；3/6 单日 −9.96%], text(0.82em)[价格发现继续；CEO Nally 在 \$12 自购 2 万股，未即时扭转。],
    text(0.82em)[3/24 – 3/26], text(0.82em)[3/26 +8.62%；波动加大], text(0.82em)[Piper Sandler、Morgan Stanley 等投行启动覆盖；目标价 \$20–\$24。],
    text(0.82em)[4/6], text(0.82em)[单日 −12%], text(0.82em)[无重大公告；小盘流动性差 + 缺少短期催化剂导致技术性回吐。],
    text(0.82em)[4/13], text(0.82em)[+12.18%], text(0.82em)[公司发布 corporate presentation，列出未来 12–24 月预期进展节点时间表。],
    text(0.82em)[5/4 – 5/5], text(0.82em)[累涨 +17%，接近 \$15.47 创新高], text(0.82em)[分析师覆盖后情绪延续 + 技术性突破 + 大盘AI板块影响。],
    text(0.82em, fill: c-primary)[*5/7*], text(0.82em, fill: c-primary)[*−11.18%*], text(0.82em, fill: c-primary)[*Q1 财报：现金 \$516.6M 但烧钱加速 +51%；市场担忧 burn rate 上升。*],
  )
)

== 市场为什么仍然谨慎？

#grid(
  columns: (1fr, 1fr),
  column-gutter: 1.2em,
  block(
    inset: 0.7em,
    radius: 4pt,
    fill: c-accent.lighten(92%),
    stroke: (left: 3pt + c-accent),
    {
      text(weight: "bold", fill: c-accent, [✓ 乐观因素])
      v(0.4em)
      set par(leading: 0.7em)
      text(size: 1em)[
        - *机构背书强*：Flagship + Amgen + Novartis
        - *Late-stage 资产*：GB-0895 已进入两个全球 Phase 3，2026-01-26 首例给药
        - *分析师覆盖广*：多家投行 Buy / Overweight，目标价 \$20–\$24
        - *董事会资源*：Frances Arnold、Stéphane Bancel 等
        - *2026 IPO 窗口回暖*
      ]
    },
  ),
  block(
    inset: 0.7em,
    radius: 4pt,
    fill: c-primary.lighten(92%),
    stroke: (left: 3pt + c-primary),
    {
      text(weight: "bold", fill: c-primary, [✗ 谨慎因素])
      v(0.4em)
      set par(leading: 0.7em)
      text(size: 1em)[
        - *AI 平台未被临床验证*：迄今无完全 AI-discovered drug 获 FDA 批准
        - *无产品销售收入*：Q1 仅 \$7.2M，且来自合作而非销售
        - *亏损扩大*：2025 净亏损 \$223M / 累计 \$676M
        - *烧钱加速*：Q1 operating cash outflow \$80.4M（YoY +51%）
        - *估值压力*：B/C 轮折合 ≈\$18/股，IPO 价 \$16，公开市场更挑剔
      ]
    },
  ),
)

#v(2em)

#text(size: 1em, fill: c-primary)[
  *市场不是不相信 AI，而是要求 Generate 把 AI 平台转化成成功的临床结果。*
]

// ============================================================
// III. 股东、现金与展望
// ============================================================

== 主要股东：上市后仍是 Flagship 体系主导

#grid(
  columns: (1.2fr, 1fr),
  column-gutter: 1.2em,
  table(
    columns: (1fr, auto, auto),
    stroke: 0.5pt + c-gray,
    align: (left, right, left),
    inset: 0.5em,
    table.header(
      text(0.85em, weight: "bold")[股东 / 个人],
      text(0.85em, weight: "bold")[IPO 后持股 %],
      text(0.85em, weight: "bold")[影响力],
    ),
    text(0.82em)[Flagship affiliated entities], text(0.82em, weight: "bold")[48.76%], text(0.82em)[最核心控制方],
    text(0.82em)[Noubar B. Afeyan], text(0.82em, weight: "bold")[48.78%], text(0.82em)[与 Flagship 高度重合],
    text(0.82em)[Michael Nally（CEO）], text(0.82em)[5.55%], text(0.82em)[兼 Flagship CEO-partner],
    text(0.82em)[Jason Silvers（CFO）], text(0.82em)[< 1%], text(0.82em)[资本市场叙事执行],
    text(0.82em)[Gevorg Grigoryan（CTO）], text(0.82em)[< 1%], text(0.82em)[技术创始人],
    text(0.82em)[Frances Arnold / S. Bancel 等董事], text(0.82em)[< 1%], text(0.82em)[董事会背书],
    text(0.82em, fill: c-primary)[*管理层 + 董事合计*], text(0.82em, weight: "bold", fill: c-primary)[*55.75%*], text(0.82em)[利益绑定显著],
    text(0.82em)[新公众投资者], text(0.82em)[≈ 19.6%], text(0.82em)[提供现金 / 流动性],
  ),
  block({
    text(weight: "bold", [核心控制方：Flagship + Afeyan 博士 = 创始资本控制层])
    v(0.4em)
    text(size: 0.84em)[
      Flagship Funds 与 Noubar Afeyan 不能简单相加（重叠披露）。Afeyan 通过控制链对 Flagship 持股具有投票/投资权，且自公司成立起任*董事会主席*。
    ]
    v(0.4em)
    text(size: 0.84em)[
      Flagship 是 *Venture Studio*（科学假设 → 团队 → 公司 → 持续融资），不是普通 VC。Generate 与 Flagship 体系存在多项关联交易：管理服务协议、基础 IP 许可。
    ]
    v(0.4em)
    text(size: 0.85em, fill: c-primary)[
      *优势*：资源整合 + 融资可信度。\
      *风险*：重大决策与战略方向持续被 Flagship 体系影响。
    ]
  }),
)

== 现金状况：IPO 后现金垫明显变厚

#grid(
  columns: (1.5fr, 1fr),
  column-gutter: 1.2em,
  // 现金柱状图
  cetz-canvas(length: 1.5cm, {
    import cetz.draw: *
    let baseline-y = 0
    let max-h = 5.5
    let scale = max-h / 600
    let bar(x, val, label, color) = {
      let h = val * scale
      rect((x - 0.6, baseline-y), (x + 0.6, baseline-y + h), fill: color, stroke: none, radius: 2pt)
      content((x, baseline-y + h + 0.3), text(0.8em, weight: "bold", [\$#val M]))
      content((x, baseline-y - 0.4), text(0.7em, label))
    }
    line((0, baseline-y), (10, baseline-y), stroke: 0.6pt + c-gray)
    bar(1.5, 393.6, [2024 末], c-accent.lighten(30%))
    bar(4.5, 221.5, [2025 末], c-amber)
    bar(7.5, 516.6, [2026 Q1 (IPO 后)], c-primary)
    line((0, baseline-y + 590.3 * scale), (10, baseline-y + 590.3 * scale), stroke: (paint: c-accent, dash: "dashed"))
    content((8.5, baseline-y + 590.3 * scale + 0.25), text(0.65em, fill: c-accent)[IPO pro forma \$590.3M])
    content((5, baseline-y - 1.4), text(0.72em, fill: c-gray, [Cash + Marketable Securities (M USD)]))
  }),
  block({
    text(weight: "bold", [Q1 资产负债表的结构性变化])
    v(0.4em)
    table(
      columns: (1fr, auto, auto),
      stroke: 0.5pt + c-gray,
      align: (left, right, right),
      inset: 0.45em,
      table.header(
        text(0.82em, weight: "bold")[指标],
        text(0.82em, weight: "bold")[2025 末],
        text(0.82em, weight: "bold")[2026 Q1],
      ),
      text(0.78em)[现金 + 有价证券], text(0.78em)[\$221.5M], text(0.78em, fill: c-primary, weight: "bold")[\$516.6M],
      text(0.78em)[总资产], text(0.78em)[\$330.2M], text(0.78em)[\$625.7M],
      text(0.78em)[总负债], text(0.78em)[\$141.6M], text(0.78em)[\$110.9M],
      text(0.78em)[可转换优先股], text(0.78em)[\$811.8M], text(0.78em)[*0*],
      text(0.78em)[股东权益], text(0.78em, fill: c-primary)[*−\$616.0M*], text(0.78em, fill: c-accent, weight: "bold")[*+\$514.8M*],
      text(0.78em)[普通股股数], text(0.78em)[33.1M], text(0.78em)[128.2M],
    )
    v(0.4em)
    text(size: 0.82em, fill: c-gray)[
      Q1 现金改善几乎全部来自 IPO（\$369.3M net）\ 公司将大部分 IPO 资金转入货币基金与美债等保本型短期投资。
    ]
  }),
)

== 烧钱速度：钱多了，但花得更快

#grid(
  columns: (0.8fr, 1fr),
  column-gutter: 2em,
  [
    #set par(leading: 0.65em, justify: true)
    #table(
      columns: (1fr, 0.5fr, 0.5fr, 0.5fr),
      stroke: 0.5pt + c-gray,
      align: (left, right, right, right),
      inset: 0.45em,
      table.header(
        text(weight: "bold")[指标（M USD）],
        text(weight: "bold")[25 Q1],
        text(weight: "bold")[26 Q1],
        text(weight: "bold")[变化],
      ),
      [Collaboration revenue], text(1em)[8.8], text(1em)[7.2], text(1em, fill: c-primary)[−18.1%],
      text(1em)[R&D expense], text(1em)[46.8], text(1em)[57.8], text(1em, fill: c-primary)[+23.5%],
      text(1em)[G&A expense], text(1em)[10.1], text(1em)[13.5], text(1em, fill: c-primary)[+33.3%],
      text(1em)[Net loss], text(1em)[44.3], text(1em)[61.7], text(1em, fill: c-primary)[+39.3%],
      text(1em, weight: "bold")[#par(leading: 0.65em)[*Operating cash outflow*]], text(1em, weight: "bold")[*53.2*], text(1em, weight: "bold", fill: c-primary)[*80.4*], text(1em, weight: "bold", fill: c-primary)[*+51.2%*],
      text(1em)[简单年化 burn], text(1em)[212.7], text(1em, fill: c-primary)[321.6], text(1em)[—],
    )
    #v(0.5em)
    #text(size: 0.8em, fill: c-gray)[注：公司在2026年5月8日发布了最新的2026Q1财报，其中的operating cash outflow大幅增长。因此，我们选择采用最新的2026Q1财报中的数据为基准进行估算，而不是2026年2月底招股书中的旧数据。]
  ],
  block({
    text(weight: "bold", [Runway：官方 vs 真实 burn])
    v(0.4em)
    set par(leading: 0.7em)
    text(size: 1em)[
      *官方表态*：Q1 末现金 \$516.6M 可支持运营到 *2028 H1*。
    ]
    v(0.3em)
    text(size: 1em)[
      *按 2026 Q1 burn 估算*：\$516.6M ÷ \$321.6M/年 ≈ *19 个月*（仅能坚持到 2027 Q3）。
    ]
    v(0.1em)
    text(size: 0.8em, fill: c-gray)[注：若按照招股书中的2025全年 cash burn \$200.6M/年估算，公司可支撑约 30 个月（至2028 Q3）。但我们倾向于使用最新的数据。]
    v(0.3em)
    text(size: 1em)[
      R&D 占 operating expenses *81%*；其中 GB-0895 外部研发支出从 \$3.8M 升至 \$15.6M（×4）。
    ]
    v(0.4em)
    text(size: 1em, fill: c-primary)[
      *钱确实多了，但用得更快了。* IPO 给 Generate 带来的是冲刺 GB-0895 Phase3 关键节点的时间，没有解决真正产出商业化的药物前平台无法变现的根本问题。
    ]
  }),
)

== 结论：钱能带来时间，但无法代表最终的成功

#grid(
  columns: (1fr, 1fr, 1fr),
  column-gutter: 1em,
  stat-card(
    [① 融资能力很强],
    [入场券],
    color: c-accent,
    sub: [Flagship 孵化 + Series B/C ≈\$770M BD \$110M \ IPO \$400M],
  ),
  stat-card(
    [② 公开市场谨慎],
    [还没买账],
    color: c-amber,
    sub: [首日 \$12.65；当前 ≈\$14.46 \ 仍低于 \$16 IPO 价\ 市场要求临床兑现],
  ),
  stat-card(
    [③ 核心矛盾],
    [钱多 ≠ 安全],
    color: c-primary,
    sub: [Cash \$516.6M 确实多 \ Q1 burn \$80.4M（+51% YoY）\ 按此速度仅剩 19 个月 runway],
  ),
)

#v(0.2em)

#align(center, block(
  width: 92%,
  inset: 0.7em,
  radius: 6pt,
  fill: c-primary.lighten(92%),
  stroke: (left: 4pt + c-primary),
  text(size: 1.0em, fill: c-primary, weight: "bold")[
    Generate Biomedicines 已获得资本市场和大药企的入场券；\
    但真正决定下一轮估值或者该公司的模式能否持续下去的，不是 AI 叙事或者研发平台本身，而是它能否把 AI 平台转化成临床结果。
  ],
))

#v(0.2em)

#align(center, text(size: 0.9em, fill: c-gray)[
  没有临床成果支撑，所谓 AI 驱动药物研发不过是南柯一梦。
])
