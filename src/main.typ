#import "@preview/touying:0.6.1": *
#import "@preview/cetz:0.4.2"
#import "@preview/fletcher:0.5.8" as fletcher: edge, node
#import "../lib.typ": *

#let cetz-canvas = touying-reducer.with(reduce: cetz.canvas, cover: cetz.draw.hide.with(bounds: true))
#let fletcher-diagram = touying-reducer.with(reduce: fletcher.diagram, cover: fletcher.hide)

#let clean-section-slide(config: (:), title: none, ..args, body) = touying-slide-wrapper(self => {
  self = utils.merge-dicts(self, config-common(freeze-slide-counter: true), config-page(
    footer: sjtu-footer,
    margin: (x: 2.4cm, y: 1.6cm),
  ))
  touying-slide(self: self, config: config, {
    context {
      let sections = query(heading.where(level: 1)).filter(it => it.outlined != false)
      let current-page = here().page()
      let current-index = sections.filter(it => it.location().page() <= current-page).len() - 1
      let items = sections.enumerate().map(pair => {
        let (idx, hd) = pair
        let active = idx == current-index
        let fill = if active { self.colors.primary } else { utils.update-alpha(self.colors.neutral-darkest, 34%) }
        let rule = line(
          length: 100%,
          stroke: (paint: fill, thickness: if active { 1.6pt } else { 0.7pt }),
        )
        align(left + horizon, block(width: 100%, {
          rule
          v(0.7em)
          link(hd.location(), text(
            size: if active { 2.45em } else { 1.75em },
            weight: "bold",
            fill: fill,
            hd.body,
          ))
          v(0.35em)
          text(
            size: 0.78em,
            fill: utils.update-alpha(fill, if active { 82% } else { 48% }),
            [Part #str(idx + 1)],
          )
        }))
      })
      set align(left + horizon)
      grid(
        columns: (1fr, auto),
        align(horizon, {
          text(size: 0.95em, fill: self.colors.neutral-darkest.lighten(35%), self.info.title)
          v(1.25em)
          grid(columns: sections.map(_ => 1fr), column-gutter: 1.2cm, ..items)
        }),
        image("../vi/sjtu-vi-sjtugate.png", height: 1.55cm),
      )
    }
  })
})

#set text(lang: "zh")
#set par(leading: 0.8em, justify: true)
#show: sjtu-theme.with(
  aspect-ratio: "16-9",
  navigation: "mini-slides",
  footer: self => self.info.institution,
  config-info(
    title: [Generate Biomedicines 案例分析],
    subtitle: [事、钱、人：从生成式蛋白药物平台到资本市场验证],
    author: [第 7 组 \ 组员：李屹哲 王炳祺 董思成 马艺萌 吕乐凡 俞奕成],
    date: datetime.today(),
    institution: [Generate Biomedicines（NASDAQ: GENB）案例分析],
  ),
  config-common(slide-level: 2, new-section-slide-fn: clean-section-slide),
)

// ============================================================
// 颜色与小工具
// ============================================================
#let c-primary = rgb("#C9141E")
#let c-accent = rgb("#0C4842")
#let c-amber = rgb("#E8A33D")
#let c-blue = rgb("#315C9D")
#let c-gray = rgb("#666666")
#let c-light = rgb("#F4F4F4")

#let card(title, body, color: c-primary, fill-light: 92%) = block(
  width: 100%,
  inset: 0.72em,
  radius: 6pt,
  fill: color.lighten(fill-light),
  stroke: (left: 3pt + color),
  {
    set par(justify: false, leading: 0.65em)
    text(size: 1.0em, weight: "bold", fill: color, title)
    v(0.35em)
    text(size: 0.9em, fill: rgb("#222222"), body)
  },
)

#let stat(label, value, sub: none, color: c-primary) = block(
  width: 100%,
  inset: 0.8em,
  radius: 6pt,
  fill: color.lighten(90%),
  stroke: (left: 4pt + color),
  {
    set par(justify: false, leading: 0.55em)
    text(size: 0.9em, fill: c-gray, label)
    v(0.35em)
    text(size: 1.5em, weight: "bold", fill: color, value)
    if sub != none {
      v(0.25em)
      text(size: 0.9em, fill: c-gray, sub)
    }
  },
)

#let pill(body, color: c-primary) = box(
  inset: (x: 0.7em, y: 0.24em),
  radius: 99pt,
  fill: color.lighten(88%),
  stroke: 0.5pt + color,
  text(size: 0.78em, weight: "bold", fill: color, body),
)

#let mini-arrow(label, color: c-primary) = block(
  inset: 0.55em,
  radius: 4pt,
  fill: color.lighten(88%),
  stroke: 0.6pt + color,
  text(size: 0.82em, weight: "bold", fill: color, label),
)

#let source-note(body) = text(size: 0.8em, fill: c-gray, body)

#let logo-dir = "../input/money/assets/logo"

#let logo-cell(path, height: 0.55cm) = block(
  width: 100%,
  height: 0.95cm,
  inset: 0.12cm,
  radius: 4pt,
  fill: white,
  stroke: 0.45pt + c-gray.lighten(45%),
  align(center + horizon, image(path, height: height)),
)

#let person-card(path, name, title) = block(
  width: 100%,
  inset: 0.8em,
  radius: 6pt,
  fill: c-light,
  stroke: 0.5pt + c-gray.lighten(45%),
  grid(
    columns: (1.2cm, 1fr),
    column-gutter: 1.0em,
    align(center + horizon, image(path, width: 1.8cm)),
    {
      set par(leading: 0.8em, justify: false)
      text(size: 1.0em, weight: "bold", name)
      linebreak()
      text(size: 0.7em, fill: c-gray, title)
    },
  ),
)

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

#let money-pill(body, color: c-primary) = box(
  inset: (x: 0.65em, y: 0.22em),
  radius: 99pt,
  fill: color.lighten(88%),
  stroke: 0.5pt + color,
  text(size: 0.76em, weight: "bold", fill: color, body),
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
#title-slide()

= 事

== Generate Biomedicines：从"发现药物"到"生成药物"

#v(0.2em)

#align(center, fletcher-diagram(
  node-stroke: 0.6pt,
  node-corner-radius: 5pt,
  node-inset: 0.58em,
  spacing: (2.05em, 0.8em),
  node((0, 0), text(1em)[*科学创始人* \ Grigoryan], fill: c-accent.lighten(88%), stroke: c-accent),
  node((1, 0), text(1em)[*平台闭环* \ DBTL], fill: c-primary.lighten(90%), stroke: c-primary),
  node((2, 0), text(1em)[*Chroma* \ 蛋白生成], fill: c-amber.lighten(86%), stroke: c-amber),
  node((3, 0), text(1em)[*管线验证* \ anti-TSLP抗体], fill: c-blue.lighten(86%), stroke: c-blue),
  node((4, 0), text(1em)[*外部验证* \ 论文 · 专利 · 合作], fill: c-light, stroke: c-gray),
  edge((0, 0), (1, 0), "->"),
  edge((1, 0), (2, 0), "->"),
  edge((2, 0), (3, 0), "->"),
  edge((3, 0), (4, 0), "->"),
))

#v(0.8em)

#grid(
  columns: (1fr, 1fr, 1fr),
  column-gutter: 1em,
  stat([公司定位], [Generative Biology], sub: [用机器学习 + 生物工程生成蛋白药物], color: c-accent),
  stat([核心竞争力], [Generate平台], sub: [Generate 卖的是通过平台持续产生候选药物的能力], color: c-primary),
  stat([验证路径], [模型生成→临床试验], sub: [从 Chroma 到 GB-0895 Phase 3], color: c-amber),
)

== 本部分要回答的三个问题

#grid(
  columns: (1fr, 1fr, 1fr),
  column-gutter: 1em,
  card(
    [① 科学起点是谁？],
    [为什么 Generate 有资格讲"AI 蛋白设计"？
    \ 科学创始人的背景如何连接到公司平台？],
    color: c-accent,
  ),
  move(
    dy: 6em,
    card(
      [② 平台如何工作？],
      [Generate Platform 与传统筛选式药物发现有什么不同？
      \ Chroma 能生成什么？],
      color: c-primary,
    )
  ),
  move(
    dy: 10em,
    card(
      [③ 是否被验证？],
      [论文、专利、临床管线和大药企合作，
      \ 能否共同形成一条证据链？],
      color: c-amber,
    )
  ),
)

== 科学创始人：Gevorg Grigoryan

#grid(
  columns: (0.72fr, 1.28fr),
  column-gutter: 1.2em,
  align(center, image("../input/affair/assets/image1.png", height: 10.0cm)),
  block({
    text(size: 1.05em, weight: "bold", [Co-Founder & Chief Technology Officer])
    v(0.35em)
    text(size: 0.88em)[
      Gevorg Grigoryan 是 Generate 的核心科学源头，负责 Generate Platform 的发展；他的研究长期围绕*计算蛋白设计、机器学习、蛋白结构-功能关系*展开。
    ]
    v(0.6em)
    grid(
      columns: (1fr, 1fr),
      column-gutter: 0.7em,
      row-gutter: 0.55em,
      mini-arrow([计算蛋白设计], color: c-accent),
      mini-arrow([蛋白互作网络], color: c-primary),
      mini-arrow([结构-功能编码], color: c-amber),
      mini-arrow([机器学习建模], color: c-blue),
    )
    v(0.7em)
    block(
      inset: 0.7em,
      radius: 5pt,
      fill: c-light,
      stroke: (left: 3pt + c-gray),
      text(size: 0.85em)[
        Grigoryan在计算生物学方向上的工作奠定了Generate平台的基础：\
        #text(fill: c-gray)[
          AI模型负责学习蛋白结构与功能间的关系，再由人类湿实验验证
        ]
      ],
    )
  }),
)

== 公司主要做什么：生成式蛋白药物设计

#grid(
  columns: (0.65fr, 1fr),
  column-gutter: 1.2em,
  block({
    text(size: 1.0em, weight: "bold", [Generate 的主营业务不是"找到一个药"，而是搭建一个生成平台])
    v(0.4em)
    text(size: 0.9em)[
      平台把 AI 模型、高通量实验、生物工程和临床转化串联起来，用于设计不同形式的蛋白药物。
    ]
    v(0.45em)
    text(size: 0.86em)[
      - *输入*：疾病靶点、目标结构、功能约束、药物属性
      - *生成*：抗体、酶、蛋白复合物、细胞治疗相关蛋白
      - *验证*：表达、折叠、亲和力、稳定性、体内外功能
      - *应用*：免疫炎症、肿瘤等治疗方向
    ]
  }),
  cetz-canvas(length: 1.4cm, {
    import cetz.draw: *
    let box-node(pos, label, color) = {
      rect((pos.at(0) - 1.75, pos.at(1) - 0.48), (pos.at(0) + 1.75, pos.at(1) + 0.48), fill: color.lighten(88%), stroke: 0.6pt + color, radius: 4pt)
      content(pos, text(0.72em, weight: "bold", fill: color, label))
    }
    box-node((0, 3), [治疗目标], c-accent)
    box-node((4, 3), [AI 生成], c-primary)
    box-node((8, 3), [蛋白候选物], c-amber)
    box-node((4, 0.8), [实验反馈], c-blue)
    line((1.75, 3), (2.25, 3), mark: (end: ">"), stroke: 1pt + c-gray)
    line((5.75, 3), (6.25, 3), mark: (end: ">"), stroke: 1pt + c-gray)
    line((7.6, 2.55), (5.6, 1.2), mark: (end: ">"), stroke: 0.8pt + c-blue)
    line((2.4, 1.2), (0.6, 2.55), mark: (end: ">"), stroke: 0.8pt + c-blue)
    content((4, 4.45), text(0.8em, fill: c-primary, weight: "bold")[蛋白药物生成工厂])
  }),
)

== 为什么要这样做：传统药物发现的瓶颈

#grid(
  columns: (1fr, 1fr),
  column-gutter: 1.1em,
  block({
    text(weight: "bold", fill: c-gray, [传统发现：筛选和优化])
    v(0.4em)
    fletcher-diagram(
      node-stroke: 0.6pt,
      node-corner-radius: 4pt,
      node-inset: 0.72em,
      spacing: (2.0em, 0.8em),
      node((0, 0), text(0.72em)[已有分子库\ 抗体库], fill: c-light),
      node((1, 0), text(0.72em)[筛选], fill: c-light),
      node((2, 0), text(0.72em)[多轮优化], fill: c-light),
      node((3, 0), text(0.72em)[候选药物], fill: c-light),
      edge((0, 0), (1, 0), "->"),
      edge((1, 0), (2, 0), "->"),
      edge((2, 0), (3, 0), "->"),
    )
    v(0.6em)
    text(size: 0.84em)[
      - 有效，但受限于已有分子库
      - 面对复杂靶点时，搜索空间不够大
      - 周期长，反复试错成本高。
    ]
  }),
  block({
    text(weight: "bold", fill: c-primary, [Generate：按目标生成])
    v(0.4em)
    fletcher-diagram(
      node-stroke: 0.6pt,
      node-corner-radius: 4pt,
      node-inset: 0.72em,
      spacing: (2.0em, 0.8em),
      node((0, 0), text(0.72em)[目标条件\ 药物属性], fill: c-accent.lighten(88%), stroke: c-accent),
      node((1, 0), text(0.72em)[AI 生成], fill: c-primary.lighten(90%), stroke: c-primary),
      node((2, 0), text(0.72em)[高通量验证], fill: c-amber.lighten(86%), stroke: c-amber),
      node((3, 0), text(0.72em)[模型学习], fill: c-blue.lighten(88%), stroke: c-blue),
      edge((0, 0), (1, 0), "->"),
      edge((1, 0), (2, 0), "->"),
      edge((2, 0), (3, 0), "->"),
    )
    v(0.6em)
    text(size: 0.84em)[
      - 从目标功能出发生成蛋白
      - 理论上能探索更大的蛋白空间
      - 可以缩短从设计到候选分子的迭代路径。
    ]
  }),
)

== Generate Platform：Design–Build–Test–Learn 闭环

#grid(
  columns: (1.15fr, 0.85fr),
  column-gutter: 1.2em,
  cetz-canvas(length: 1.6cm, {
    import cetz.draw: *
    let center = (4, 3)
    let node(pos, label, sub, color) = {
      circle(pos, radius: 0.9, fill: color.lighten(88%), stroke: 0.8pt + color)
      content(pos, text(0.72em, weight: "bold", fill: color, label + [\ ] + text(0.62em, weight: "regular", fill: c-gray, sub)))
    }
    node((4, 5.4), [Design], [AI 模型], c-primary)
    node((7.2, 3), [Build], [DNA / 表达], c-amber)
    node((4, 0.6), [Test], [高通量实验], c-blue)
    node((0.8, 3), [Learn], [数据回流], c-accent)
    circle(center, radius: 1.15, fill: c-primary, stroke: none)
    content(center, text(0.82em, fill: white, weight: "bold")[Living\ Feedback\ Loop])
    line((4.65, 4.85), (6.55, 3.65), mark: (end: ">"), stroke: 1pt + c-gray)
    line((6.55, 2.35), (4.65, 1.15), mark: (end: ">"), stroke: 1pt + c-gray)
    line((3.35, 1.15), (1.45, 2.35), mark: (end: ">"), stroke: 1pt + c-gray)
    line((1.45, 3.65), (3.35, 4.85), mark: (end: ">"), stroke: 1pt + c-gray)
  }),
  block({
    text(weight: "bold", [技术核心是 AI设计 + 湿实验验证])
    v(0.45em)
    text(size: 0.88em)[
      - 模型先提出设计方案
      - 实验系统把设计做出来
      - 高通量检测给出真实数据
      - 数据再反哺下一轮模型
    ]
    v(0.7em)
    block(
      inset: 0.7em,
      radius: 5pt,
      fill: c-primary.lighten(93%),
      stroke: (left: 3pt + c-primary),
      text(size: 0.86em, fill: c-primary)[
        招股书中声称，Generate平台通过整合DBTL循环
        搭建起了数据和技术的双重壁垒
      ],
    )
  }),
)

== 核心模型 Chroma：可编程蛋白生成

#grid(
  columns: (1.2fr, 0.6fr),
  column-gutter: 1em,
  block({
    align(center, image("../input/affair/assets/image3.png", width: 100%))
    v(0.25em)
    source-note([Chroma 论文机制图：扩散生成蛋白骨架，再由设计网络输出全原子结构。])
  }),
  block({
    text(weight: "bold", [Chroma 的关键词：programmable])
    v(0.45em)
    text(size: 0.86em)[
      Chroma 基于扩散模型与图神经网络，能够生成蛋白结构和序列，并接受条件约束。
    ]
    v(5em)
    block(
      inset: 0.7em,
      radius: 5pt,
      fill: c-primary.lighten(90%),
      stroke: (left: 3pt + c-primary),
      text(size: 0.82em)[
        "Chroma可以在对称性、形状、结构/基序的条件约束下生成蛋白，甚至可以接受自然语言Prompt。"
      ],
    )
  }),
)

== 产品管线：平台不是只停留在论文，正在向临床进展

#table(
  columns: (1fr, 1fr, 1fr, 1fr, 1fr),
  stroke: 0.5pt + c-gray,
  align: (left, center, center, center, center),
  inset: 0.42em,
  table.header(
    text(0.8em, weight: "bold")[项目],
    text(0.8em, weight: "bold")[方向],
    text(0.8em, weight: "bold")[Preclinical],
    text(0.8em, weight: "bold")[Phase 1],
    text(0.8em, weight: "bold")[Phase 3],
  ),
  text(0.8em, weight: "bold")[GB-0895], text(0.78em)[重度哮喘\ anti-TSLP],
  block(fill: c-accent.lighten(86%), radius: 2pt, inset: 0.25em, [✓]),
  block(fill: c-accent.lighten(86%), radius: 2pt, inset: 0.25em, [✓]),
  block(fill: c-primary.lighten(84%), radius: 2pt, inset: 0.25em, text(fill: c-primary, weight: "bold")[Phase 3]),
  text(0.8em, weight: "bold")[GB-4362], text(0.78em)[MMAE payload\ neutralizer],
  block(fill: c-accent.lighten(86%), radius: 2pt, inset: 0.25em, [✓]),
  block(fill: c-amber.lighten(82%), radius: 2pt, inset: 0.25em, text(fill: c-amber, weight: "bold")[2026]),
  [],
  text(0.8em, weight: "bold")[GB-5267], text(0.78em)[MUC16 armored\ CAR-T],
  block(fill: c-accent.lighten(86%), radius: 2pt, inset: 0.25em, [✓]),
  block(fill: c-amber.lighten(82%), radius: 2pt, inset: 0.25em, text(fill: c-amber, weight: "bold")[2026]),
  [],
)

#v(0.75em)

#grid(
  columns: (1fr, 1fr, 1fr),
  column-gutter: 0.85em,
  card([GB-0895], [长效 anti-TSLP 抗体，是最接近商业验证的核心资产。], color: c-primary),
  card([GB-4362], [用于降低 MMAE ADC 相关毒性，体现平台能做功能型蛋白。], color: c-amber),
  card([GB-5267], [MUC16 靶向 armored CAR-T，说明平台进入肿瘤细胞治疗场景。], color: c-blue),
)

== 代表项目：GB-0895 anti-TSLP 抗体

#grid(
  columns: (1.1fr, 0.9fr),
  column-gutter: 1.2em,
  cetz-canvas(length: 1.5cm, {
    import cetz.draw: *
    let label(pos, body, color) = {
      rect((pos.at(0) - 1.55, pos.at(1) - 0.42), (pos.at(0) + 1.55, pos.at(1) + 0.42), fill: color.lighten(88%), stroke: 0.6pt + color, radius: 4pt)
      content(pos, text(0.7em, weight: "bold", fill: color, body))
    }
    label((1.2, 4.8), [气道上皮细胞], c-accent)
    label((4.2, 3.5), [TSLP 信号], c-amber)
    label((7.2, 4.8), [炎症通路激活], c-primary)
    label((4.2, 1.25), [GB-0895 阻断], c-blue)
    line((2.75, 4.55), (3.3, 3.8), mark: (end: ">"), stroke: 1pt + c-gray)
    line((5.1, 3.8), (6.0, 4.55), mark: (end: ">"), stroke: 1pt + c-gray)
    line((4.2, 2.9), (4.2, 1.75), mark: (end: ">"), stroke: 1pt + c-blue)
    line((5.35, 1.6), (6.2, 4.25), stroke: (paint: c-primary, thickness: 1.2pt, dash: "dashed"))
    content((6.9, 2.55), text(0.68em, fill: c-primary)[减少下游炎症])
  }),
  block({
    text(weight: "bold", [为什么选择 GB-0895 作为代表？])
    v(0.45em)
    text(size: 0.88em)[
      - 靶点 TSLP 已被临床验证，是气道炎症上游因子
      - Generate 的目标不是重新证明 TSLP，而是优化药物属性
      - 核心卖点是*长效、高亲和力、每 6 个月仅需给药一次*
    ]
    v(0.7em)
    block(
      inset: 0.72em,
      radius: 5pt,
      fill: c-primary.lighten(93%),
      stroke: (left: 3pt + c-primary),
      text(size: 0.86em, fill: c-primary)[
        如果长效给药优势成立，它会直接影响患者便利性和依从性。
      ],
    )
  }),
)

== 市场与患者需求：为什么重度哮喘值得做？

#grid(
  columns: (1.15fr, 0.85fr),
  column-gutter: 1.2em,
  cetz-canvas(length: 1.35cm, {
    import cetz.draw: *
    let base = 0.4
    let scale = 4.7 / 180
    let bar(x, val, label, color) = {
      let h = val * scale
      rect((x - 0.65, base), (x + 0.65, base + h), fill: color, stroke: none, radius: 2pt)
      content((x, base + h + 0.35), text(0.78em, weight: "bold", fill: color)[\$#val B])
      content((x, base - 0.45), text(0.72em, label))
    }
    line((0.6, base), (7.2, base), stroke: 0.6pt + c-gray)
    bar(2.2, 100.5, [2026E], c-amber)
    bar(5.4, 179.2, [2031E], c-primary)
    content((4, 6), text(0.82em, fill: c-gray)[Asthma biologics market size])
  }),
  block({
    text(weight: "bold", [直接切入一个已成规模、仍在增长的市场])
    v(0.4em)
    text(size: 0.88em)[
      - 重度哮喘患者需要长期治疗
      - 现有生物制剂虽有效，但给药频率和依从性仍是重大痛点。
    ]
    v(0.5em)
    grid(
      columns: (1fr, 1fr),
      gutter: 1em,
      mini-arrow([已验证靶点], color: c-accent),
      mini-arrow([明确患者需求], color: c-primary),
      mini-arrow([长效给药优势], color: c-amber),
      mini-arrow([商业规模可观], color: c-blue),
    )
    v(0.55em)
    source-note([第三方市场研究估算：2026 年约 100.5 亿美元，2031 年约 179.2 亿美元。])
  }),
)

== 临床进展：SOLAIRIA-1/2 如何验证 GB-0895？

#grid(
  columns: (1.6fr, 0.8fr),
  column-gutter: 1.1em,
  block({
    cetz-canvas(length: 2.0cm, {
      import cetz.draw: *
      let y = 2.4
      let step(x, label, color) = {
        circle((x, y), radius: 0.45, fill: color.lighten(85%), stroke: 0.8pt + color)
        content((x, y), text(0.72em, weight: "bold", fill: color, label.at(0)))
        content((x, y - 0.9), text(0.68em, label.at(1)))
      }
      step(0.8, ([1], [筛选\ 入组]), c-accent)
      step(2.6, ([2], [随机\ 分组]), c-primary)
      step(4.4, ([3], [Week 0\ 给药]), c-amber)
      step(6.2, ([4], [Week 26\ 给药]), c-blue)
      step(8.0, ([5], [Week 52\ 终点]), c-primary)
      for x in (1.25, 3.05, 4.85, 6.65) {
        line((x, y), (x + 0.9, y), mark: (end: ">"), stroke: 0.8pt + c-gray)
      }
      content((4.4, 3.55), text(0.78em, fill: c-primary, weight: "bold")[300mg SC · 每 6 个月一次])
      content((8.0, 3.25), text(0.65em, fill: c-gray)[主要终点：52 周急性加重率])
    })
  }),
  block({
    text(weight: "bold", [Phase 3 是平台故事的关键压力测试])
    v(0.4em)
    text(size: 0.86em)[
      - 两项全球 Phase 3：SOLAIRIA-1 / SOLAIRIA-2
      - 计划纳入约 1600 名重度哮喘患者
      - 覆盖 40 多个国家
      - 比较 GB-0895 300mg Q26W 与 placebo
    ]
    v(0.55em)
    text(size: 0.86em, fill: c-primary)[
      GB-0895 的 Phase 3 结果，会成为判断 Generate 平台价值的核心节点。
    ]
  }),
)

== 专利布局：平台专利 + 应用专利 + 分子专利

#grid(
  columns: (1fr, 1fr, 1fr),
  column-gutter: 0.9em,
  card(
    [平台层],
    [ US 20250218530 A1 \
      基于扩散模型的生成式蛋白设计 \ \
      保护的是Generate平台中用于生成蛋白的的Chroma模型],
    color: c-primary,
  ),
  card(
    [应用层],
    [US 20240161864 A1 \
     机器学习引导交叉反应性抗体生成 \ \
     保护的是Generate平台在抗体设计上的具体应用],
    color: c-amber,
  ),
  card(
    [产品层],
    [ 自2025年起陆续进入国家阶段申请\ \
      保护的是围绕 GB-0895 等候选分子的抗体序列、用途和给药方案],
    color: c-accent,
  ),
)

#v(0.8em)

#align(center, cetz-canvas(length: 1.2cm, {
  import cetz.draw: *
  rect((0, 0), (8.8, 1.0), fill: c-primary.lighten(88%), stroke: 0.6pt + c-primary, radius: 4pt)
  rect((0.65, 1.0), (8.15, 2.0), fill: c-amber.lighten(85%), stroke: 0.6pt + c-amber, radius: 4pt)
  rect((1.3, 2.0), (7.5, 3.0), fill: c-accent.lighten(88%), stroke: 0.6pt + c-accent, radius: 4pt)
  content((4.4, 0.5), text(0.78em, weight: "bold", fill: c-primary)[平台方法：可复用的生成能力])
  content((4.4, 1.5), text(0.78em, weight: "bold", fill: c-amber)[应用场景：特定任务和功能优化])
  content((4.4, 2.5), text(0.78em, weight: "bold", fill: c-accent)[候选分子：具体产品权利])
}))

#v(0.55em)

== 专利实例：US20250218530A1 用于生成式蛋白设计的扩散模型

#grid(
  columns: (0.3fr, 0.3fr,0.3fr),
  column-gutter: 1em,
  block({
    align(center, image("../input/affair/assets/image5.png", width: 75%))
    v(0.25em)
    source-note([Chroma基于形状约束生成全新设计的蛋白分子])
  }),
    block({
    align(center, image("../input/affair/assets/image6.png", width: 100%))
  }),
  block({
    text(weight: "bold", [权利要求1：])
    v(0.45em)
    text(size: 0.86em)[
      一个基于扩散模型框架，接受特定设计要求，包含可编程能量函数和约束空间采样两步，用于de novo蛋白设计的系统。
    ]
    v(0.5em)
    text(weight: "bold", [实施例：不同约束条件下生成蛋白])
    v(0.45em)
    text(size: 0.86em)[
      输入： \
      形状条件：代表字母‘A’的三维点云文件; \
      输出： \
      一个氨基酸骨架整体走向为‘A’形状的全新蛋白质。
    ]
  }),
)

== 合作网络：大药企与癌症中心验证平台价值

#grid(
  columns: (1.1fr, 0.9fr),
  column-gutter: 1.15em,
  cetz-canvas(length: 1.22cm, {
    import cetz.draw: *
    let center = (4, 3)

    let partner(pos, label, sub, color) = {
      // 先画线
      line(center, pos, stroke: (paint: color, thickness: 0.8pt, dash: "dashed"))
      // 再画矩形和文字
      rect((pos.at(0) - 1.55, pos.at(1) - 0.55), (pos.at(0) + 1.55, pos.at(1) + 0.55), fill: color.lighten(88%), stroke: 0.6pt + color, radius: 4pt)
      content(pos, text(0.68em, weight: "bold", fill: color, label + [\ ] + text(0.58em, fill: c-gray, weight: "regular", sub)))
    }

    // 先调用所有 partner（线在最底层）
    partner((0.9, 5.5), [Amgen], [5 个靶点], c-amber)
    partner((7.1, 5.5), [Novartis], [多靶点合作], c-accent)
    partner((0.9, 0.5), [MD Anderson], [肿瘤转化], c-blue)
    partner((7.1, 0.5), [Roswell Park], [细胞治疗], c-gray)

    // 中心圆和文字最后画，压住所有线头
    circle(center, radius: 1.12, fill: c-primary, stroke: none)
    content(center, text(0.8em, fill: white, weight: "bold")[Generate\ Platform])
  }),
  block({
    text(weight: "bold", [大药企的合作体现了Generate平台的技术前景])
    v(0.45em)
    text(size: 0.86em)[
      Amgen 与 Novartis 付费合作，说明大药企愿意为平台能力下注；癌症中心合作则为肿瘤管线提供临床转化资源。
    ]
    v(0.55em)
    text(size: 0.86em)[
      - Amgen：upfront 5000 万美元，潜在交易价值约 19 亿美元
      - Novartis：6500 万美元 upfront / 股权，潜在里程碑超过 10 亿美元
      - 学术医疗机构：补足肿瘤和细胞治疗场景
    ]
  }),
)

== 小结：技术故事成立，但商业验证仍在路上

#grid(
  columns: (1fr, 1fr),
  column-gutter: 1.2em,
  block(
    inset: 0.75em,
    radius: 6pt,
    fill: c-accent.lighten(92%),
    stroke: (left: 4pt + c-accent),
    {
      text(weight: "bold", fill: c-accent, [平台证据])
      v(0.4em)
      text(size: 0.9em)[
        - 科学创始人与平台逻辑连续
        - Chroma 有 Nature 论文与实验验证
        - 专利布局覆盖平台、应用和分子
        - GB-0895 已进入全球 Phase 3
        - Amgen / Novartis 等合作形成外部背书
      ]
    },
  ),
  block(
    inset: 0.75em,
    radius: 6pt,
    fill: c-primary.lighten(92%),
    stroke: (left: 4pt + c-primary),
    {
      text(weight: "bold", fill: c-primary, [未验证风险])
      v(0.4em)
      text(size: 0.9em)[
        - AI 生成药物还缺少最终临床成功样本
        - Phase 3 结果决定 GB-0895 的真实价值
        - 生产放大、监管接受度仍有不确定性
        - IP 稳定性和竞品压力会影响商业化空间
      ]
    },
  ),
)

#v(0.85em)

#align(center, block(
  width: 92%,
  inset: 0.75em,
  radius: 6pt,
  fill: c-primary.lighten(93%),
  stroke: (left: 4pt + c-primary),
  text(size: 1.02em, fill: c-primary, weight: "bold")[
    Generate 在"技术和平台叙事"上已经形成较强证据链；\
    但商业公司需要的不是技术故事，而是临床证据。
  ],
))


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

#v(0.7em)

#grid(
  columns: (1fr, 1fr, 1fr, 1fr, 1fr),
  column-gutter: 0.45em,
  logo-cell(logo-dir + "/flagship-pioneering.png"),
  logo-cell(logo-dir + "/amgen.png", height: 0.5cm),
  logo-cell(logo-dir + "/novartis.png", height: 0.42cm),
  logo-cell(logo-dir + "/nventures.png", height: 0.42cm),
  logo-cell(logo-dir + "/Samsung-Ventures.jpg", height: 0.38cm),
)

== 钱从哪里来：三条资金线

#text(size: 0.85em, fill: c-gray)[
  Generate 是平台型公司——融资逻辑并非卖一个药，而是证明平台能不断生成药物。
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
  columns: (1fr, 1.8fr),
  column-gutter: 0.2em,
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
  #set par(leading: 0.8em)
  #text(0.6em, fill: c-gray)[注：公司在IPO前进行了 1.5190:1 优先股->普通股转换（合股），所有每股成本和股数均按招股书数据折合到合股后的普通股计算。]
  ],
  block(inset: (left: 1em), {
    set par(leading: 0.8em, justify: true)
    grid(
      columns: (1fr, 3.1cm),
      column-gutter: 0.6em,
      align(left + horizon, text(size: 0.92em, weight: "bold", [Venture studio 模式：自己造公司，再融资])),
      logo-cell(logo-dir + "/flagship-pioneering.png", height: 0.6cm),
    )
    v(0.15em)
    text(size: 0.8em)[
      Generate Biomedicines 在早期使用Venture Studio模式（和传统VC略有区别）：\
      Flagship 先提出科学假设、搭团队、做早期验证，然后把公司孵化出来。\
      因此，Generate 的 Series A 是内部融资 + 额外的资源支持。Series A 估值在当时未对外披露，但是可以通过招股书倒推。
    ]
    v(0.35em)
    text(size: 0.92em, weight: "bold", [Series B（2021.11）：3.7 亿美元，正式跨入独角兽])
    v(0.0em)
    text(size: 0.72em, fill: c-gray)[背景：一级资本市场流动性充裕，风险资本狂热于深科技资产]
    grid(
      columns: (1fr, 1fr, 1.2fr),
      align: center,
      column-gutter: 0.2em,
      money-pill([主权基金/长线资本], color: c-accent),
      money-pill([顶级交叉基金], color: c-primary),
      money-pill([生物科技/跨界的科技基金], color: c-amber),
    )
    text(size: 0.8em)[
      投资人结构非常多元：*Flagship · ADIA 子公司 · Alaska Permanent Fund · Altitude · ARCH · Fidelity · Morningside · T. Rowe Price*。
      \ 资金用于"干湿实验闭环"平台、组织扩张和管线推进。
    ]
    v(0.1em)
    text(size: 0.8em, fill: c-primary)[
      *关键信号：B 轮折合普通股成本 ≈ \$18/股，甚至高于后来的 IPO 价 \$16/股。这反映出当时的一级市场远比后来的公开市场乐观。*
    ]
  }),
)

== Series C：资本寒冬中的战略背书

#grid(
  columns: (0.9fr, 1fr),
  column-gutter: 1.2em,
  block({
    set par(leading: 1.0em)
    text(weight: "bold", [2023.05 – 2025.01 累计 ≈ \$421.4M])
    v(0.3em)
    text(size: 0.88em)[
      在 2023 年 biotech 融资寒冬里仍完成大额股权融资，意义不仅在于金额，更在*投资人结构的进化和信心的体现*：
    ]
    v(0.5em)
    text(size: 0.88em)[
      - *新增产业方*：Amgen（大药企）、NVentures（NVIDIA 生态）、MAPS Capital、Pictet Alternative Advisors
        - Samsung Life Science Fund 后续追加为投资方，这是产品制造能力方面的背书
      - *老股东续投*：Flagship · ADIA · Fidelity · T. Rowe Price · ARCH · March
    ]
    v(0.6em)
    text(size: 0.85em, fill: c-primary)[
      *Series B 展现了资本的看好；Series C 则进一步扩展到产业协同。* 大药企进场融资，等于让外部产业为平台概念再背一次书。
    ]
  }),
  // 简化的"生态四象限"图
  [
  #text(weight: "bold", size: 0.9em)[总股数折合普通股约 23.41M股，均价\$18/股，高于IPO发行价]
  #text(fill: c-gray, size: 0.8em)[背景：加息周期，流动性紧缩，biotech 融资寒冬，估值压力上升]
  #v(0.2em)
  #grid(
    columns: (1fr, 1fr, 1fr, 1fr),
    column-gutter: 0.45em,
    row-gutter: 0.35em,
    logo-cell(logo-dir + "/flagship-pioneering.png", height: 0.42cm),
    logo-cell(logo-dir + "/nventures.png", height: 0.38cm),
    logo-cell(logo-dir + "/amgen.png", height: 0.43cm),
    logo-cell(logo-dir + "/Samsung-Ventures.jpg", height: 0.36cm),
  )
  #v(0.2em)
  #align(center)[
  #cetz-canvas(length: 1.0cm, {
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
    corner((1.0, 0.0), [Amgen / Novartis\ 药企验证/变现], c-primary)
    corner((9.0, 0.0), [Samsung\ 制造产业背书], c-blue)

    // 中心圆和文字最后画，确保始终在最上层
    circle(center, radius: 2.0, fill: c-primary, stroke: none)
    content(center, text(0.85em, fill: white, weight: "bold")[Generate \ Platform])
  })
  ]
  ]
)

== Amgen / Novartis：不只是融资，而是平台验证

#set par(leading: 0.8em)

#text(size: 0.85em)[*BD 合作 = 大药企为平台付费*。这是AI药物研发平台的重要变现渠道/收入来源。注意需要区分已到账现金与潜在 milestone。]

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
      grid(
        columns: (1fr, 3.0cm),
        column-gutter: 0.5em,
        align(left + horizon, text(weight: "bold", [Amgen（2022.01 起）])),
        logo-cell(logo-dir + "/amgen.png", height: 0.42cm),
      )
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
      grid(
        columns: (1fr, 3.0cm),
        column-gutter: 0.5em,
        align(left + horizon, text(weight: "bold", [Novartis（2024.09）])),
        logo-cell(logo-dir + "/novartis.png", height: 0.36cm),
      )
      v(0.15em)
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
  *upfront与股权是确定的钱，milestone 和专利使用费是未来可能的钱。\$19 亿 / \$10 亿显然不能算入现金余额。\
  但是，这确实能够体现大药企对“AI药物研发平台”叙事的布局需求与乐观预期。*
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
    set par(leading: 0.8em)
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
      ([平台 + 推动多项目至 IND], 75, c-accent),
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
    set par(leading: 0.8em)
    text(size: 0.78em, fill: c-gray)[
      其余 ≈ \$10M 用于一般营运（G&A）资金。\
      *钱主要花在 GB-0895 Phase 3 上*，IPO 和 GB-0895 的临床推进同步进行。
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
      text(0.85em)[2/26 IPO 定价], text(0.85em)[\$16.00], text(0.85em)[基准\ （市值 \$2.04B）],
      text(0.85em)[2/27 开盘], text(0.85em)[\$15.00], text(0.85em, fill: c-primary)[−6.25%],
      text(0.85em)[2/27 收盘], text(0.85em)[\$12.65], text(0.85em, fill: c-primary)[*−20.9%* \ （市值 \$1.61B）],
    )
    v(0.6em)
    text(size: 0.85em)[
      *发行成功 ≠ 二级市场认可估值。* Reuters 报道开盘即跌破发行价，WSJ 报道首日近 −21%。说明市场对 AI-driven biotech 估值与临床兑现保持谨慎。
    ]
  }),
)

== 上市后股价：低位震荡 → 分析师覆盖 → 短暂修复 → 又回调

#set par(leading: 0.8em, justify: true)
#grid(
  columns: (0.9fr, 1fr),
  column-gutter: 1em,
  [
    #align(center, image("../input/money/assets/image-20260505173810264.png", width: 100%))
    #text(size: 0.85em, fill: c-gray)[
      *"首日破发 → 低位震荡 → 分析师覆盖后修复 → Q1 财报又回调"*。短期受流动性、覆盖、市场情绪影响；中长期取决于 GB-0895 Phase 3、COPD 数据与肿瘤管线。 \
      典型的新兴biotech的风格：受市场情绪影响，波动剧烈
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
    text(0.82em)[3/4–3/6], text(0.82em)[低点 ≈ \$11；3/6 单日 −9.96%], text(0.82em)[价格发现继续；CEO Nally 在 \$12 自购 2 万股，仍未即时扭转趋势。],
    text(0.82em)[3/24–3/26], text(0.82em)[3/26 +8.62%；波动加大], text(0.82em)[Piper Sandler、Morgan Stanley 等投行启动覆盖，给出乐观评级；目标价 \$20–\$24。],
    text(0.82em)[4/6], text(0.82em)[单日 −12%], text(0.82em)[无重大公告；小盘流动性差 + 缺少短期进展节点导致技术性回吐。],
    text(0.82em)[4/13], text(0.82em)[+12.18%], text(0.82em)[公司发布 corporate presentation，列出未来 12–24 月预期进展节点时间表。],
    text(0.82em)[5/4–5/5], text(0.82em)[累涨 +17%，接近 \$15.47 创新高], text(0.82em)[分析师覆盖后情绪延续 + 技术性突破 + 大盘AI板块影响。],
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
      text(size: 0.9em)[
        - *AI 平台未被临床验证*：迄今无完全 AI-discovered drug 获 FDA 批准
        - *无产品销售收入*：Q1 仅 \$7.2M，且来自合作而非销售
        - *亏损扩大*：2025 净亏损 \$223M / 累计 \$676M
        - *烧钱加速*：Q1 operating cash outflow \$80.4M（YoY +51%）
        - *估值压力*：B/C 轮折合 ≈\$18/股，IPO 价 \$16，公开市场更挑剔
        - *市场情绪*：2026上半年，二级市场（仅美股而言） biotech 板块的热度降低。投资者的预期相比以往更保守，情绪更冷静。
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
  [
  #table(
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
  )
  #text(size: 1.0em, fill: c-primary)[
    *优势*：资源整合 + 融资可信度。\
    *风险*：重大决策与战略方向持续被 Flagship 体系影响。
  ]
  ],
  block({
    set par(leading: 0.8em, justify: true)
    grid(
      columns: (1fr, 3.5cm),
      column-gutter: 0.7em,
      align(left + horizon, text(size: 0.9em, weight: "bold", [核心控制方：Flagship + Afeyan 博士 = 创始资本控制层])),
      logo-cell(logo-dir + "/flagship-pioneering.png", height: 0.6cm),
    )
    v(0.2em)
    person-card(
      logo-dir + "/dr-noubar-afeyan.webp",
      [Noubar B. Afeyan],
      [Flagship Pioneering 创始人；Generate 董事会主席 \ Moderna 联合创始人及董事会主席],
    )
    v(0.3em)
    text(size: 0.9em)[
      Flagship Funds 与 Noubar Afeyan 的股权不能简单相加（重叠披露）。Afeyan 通过多个关联投资实体的控制链对 Flagship 持股，从而间接对 Genrate 持股，具有投票/投资权，且自公司成立起任*董事会主席*。
    ]
    v(0.3em)
    text(size: 0.9em)[
      Flagship 是 *Venture Studio* （科学假设 → 团队 → 公司 → 持续融资），不是普通 VC。Generate 与 Flagship 体系存在多项关联交易：管理服务协议、基础 IP 许可。
    ]
  }),
)

== 现金状况：IPO 后现金储备明显变多

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
      text(0.78em)[（普通股）股东权益], text(0.78em, fill: c-primary)[*−\$616.0M*], text(0.78em, fill: c-accent, weight: "bold")[*+\$514.8M*],
      text(0.78em)[普通股股数], text(0.78em)[33.1M], text(0.78em)[128.2M],
    )
    v(0.2em)
    text(size: 0.9em, fill: c-gray)[
     - Q1 现金改善几乎全部来自 IPO（\$369.3M net）
     - 公司将大部分 IPO 资金转入货币基金与美债等保本型短期投资。
    ]
    v(0.2em)
    text(size: 0.8em, fill: c-gray)[
      2026 Q1 实际现金结余低于IPO后预估值，原因是公司在 2026 Q1 已经烧掉了很多钱。
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

== 结论：钱能带来时间，但无法保证最终的成功

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

// ============================================================
// 人的部分辅助函数
// ============================================================
#let human-card(title, body, color: c-primary, fill-light: 92%) = block(
  width: 100%,
  inset: 0.72em,
  radius: 6pt,
  fill: color.lighten(fill-light),
  stroke: (left: 3pt + color),
  {
    set par(justify: false, leading: 0.62em)
    text(size: 0.98em, weight: "bold", fill: color, title)
    v(0.35em)
    text(size: 0.86em, body)
  },
)

#let human-stat(label, value, sub: none, color: c-primary) = block(
  width: 100%,
  inset: 0.58em,
  radius: 6pt,
  fill: color.lighten(90%),
  stroke: (left: 4pt + color),
  {
    set par(justify: false, leading: 0.48em)
    text(size: 0.78em, fill: c-gray, label)
    v(0.24em)
    text(size: 1.1em, weight: "bold", fill: color, value)
    if sub != none {
      v(0.18em)
      text(size: 0.8em, fill: c-gray, sub)
    }
  },
)

#let human-pill(body, color: c-primary) = box(
  inset: (x: 0.65em, y: 0.22em),
  radius: 99pt,
  fill: color.lighten(88%),
  stroke: 0.5pt + color,
  text(size: 0.76em, weight: "bold", fill: color, body),
)

#let human-person(name, title, origin, value, color: c-primary) = block(
  width: 100%,
  inset: 0.62em,
  radius: 6pt,
  fill: color.lighten(92%),
  stroke: 0.55pt + color,
  {
    set par(justify: false, leading: 0.58em)
    text(size: 0.82em, weight: "bold", fill: color, name)
    v(0.22em)
    text(size: 0.69em, fill: c-gray, title)
    v(0.2em)
    text(size: 0.68em, weight: "bold", origin)
    v(0.18em)
    text(size: 0.68em, value)
  },
)

#let human-bar(label, val, ratio, color, sub: none) = grid(
  columns: (7.2em, 1fr, 4.2em),
  column-gutter: 0.65em,
  row-gutter: 0.18em,
  align(right + horizon, text(size: 0.78em, label)),
  {
    stack(dir: ltr, rect(width: ratio * 100%, height: 1.05em, fill: color, radius: 2pt))
    if sub != none { text(size: 0.64em, fill: c-gray, sub) }
  },
  align(right + horizon, text(size: 0.74em, fill: c-gray, val)),
)

#let human-source-note(body) = text(size: 0.74em, fill: c-gray, body)

#let human-photo-box(path, name, role, color: c-primary) = block(
  width: 100%,
  inset: 0.45em,
  radius: 6pt,
  fill: color.lighten(93%),
  stroke: 0.55pt + color,
  {
    align(center, image(path, width: 72%))
    v(0.35em)
    set par(justify: false, leading: 0.55em)
    text(size: 0.9em, weight: "bold", fill: color, name)
    v(0.18em)
    text(size: 0.72em, fill: c-gray, role)
  },
)

#let human-shot(path, caption, height: 6.4cm) = block(
  width: 100%,
  inset: 0.2em,
  radius: 4pt,
  fill: white,
  stroke: 0.45pt + c-gray.lighten(35%),
  {
    align(center, image(path, height: height))
    v(0.12em)
    human-source-note(caption)
  },
)

// ============================================================
// III. 人
// ============================================================

= 人

== Generate 的"人"是三种能力的组合

#grid(
  columns: (1fr, 1fr, 1fr),
  column-gutter: 1em,
  human-stat([科学能力], [Protein Design], sub: [Gevorg Grigoryan / Molly Gibson\ 支撑生成式蛋白平台], color: c-accent),
  human-stat([资本能力], [Flagship], sub: [Afeyan + venture creation\ 提供公司创设与融资网络], color: c-primary),
  human-stat([药企能力], [Clinical + IPO], sub: [Merck / GSK / Amgen / Goldman\ 推动临床、BD 与上市], color: c-amber),
)

#v(0.35em)

#align(center, cetz-canvas(length: 0.8cm, {
  import cetz.draw: *
  let tri-node(pos, label, color) = {
    circle(pos, radius: 1.8, fill: color.lighten(86%), stroke: 0.8pt + color)
    content(pos, text(0.78em, weight: "bold", fill: color, label))
  }
  circle((4, 2.25), radius: 1.0, fill: c-primary, stroke: none)
  content((4, 2.25), text(0.82em, fill: white, weight: "bold")[GENB])
  line((3.35, 4.25), (1.95, 1.65), stroke: 1pt + c-gray)
  line((4.65, 4.25), (6.05, 1.65), stroke: 1pt + c-gray)
  line((2.45, 0.8), (5.55, 0.8), stroke: 1pt + c-gray)
  tri-node((4, 5.1), [科学创始人\ 技术可信度], c-accent)
  tri-node((1.3, 0.8), [资本平台\ 创业孵化], c-primary)
  tri-node((6.7, 0.8), [药企经理人\ 临床转化], c-amber)
}))

== 从创立、经营到激励

#grid(
  columns: (1fr, 1fr, 1fr),
  column-gutter: 0.9em,
  human-card([① 创始来源], [公司是 Flagship 内部提出命题、组建团队、整合科学家与数据驱动探索。], color: c-accent),
  human-card([② 管理层配置], [CEO、CFO、CTO、CSO、CMO、法务与人力岗位共同把科研平台改造成临床阶段公司。], color: c-primary),
  human-card([③ 激励机制], [现金薪酬只是基础，期权和长期股权激励把高管、董事和关键员工绑定到同一条价值曲线。], color: c-amber),
)

#v(0.85em)

#align(center, fletcher-diagram(
  node-stroke: 0.6pt,
  node-corner-radius: 5pt,
  node-inset: 0.72em,
  spacing: (2.25em, 0.8em),
  node((0, 0), text(0.82em)[Flagship\ 创设命题], fill: c-accent.lighten(88%), stroke: c-accent),
  node((1, 0), text(0.82em)[科学创始人\ 平台基础], fill: c-primary.lighten(90%), stroke: c-primary),
  node((2, 0), text(0.82em)[职业管理层\ 临床与资本], fill: c-amber.lighten(86%), stroke: c-amber),
  node((3, 0), text(0.82em)[股权激励\ 长期绑定], fill: c-blue.lighten(88%), stroke: c-blue),
  node((4, 0), text(0.82em)[管线兑现\ 公司价值], fill: c-light, stroke: c-gray),
  edge((0, 0), (1, 0), "->"),
  edge((1, 0), (2, 0), "->"),
  edge((2, 0), (3, 0), "->"),
  edge((3, 0), (4, 0), "->"),
))

== 创立来源：Flagship 孵化出的平台型公司

#grid(
  columns: (0.95fr, 1.1fr),
  column-gutter: 1.2em,
  cetz-canvas(length: 1.45cm, {
    import cetz.draw: *
    line((0.6, 0), (0.6, -6.2), stroke: 1pt + c-primary)
    let dot(y, label, sub, color) = {
      circle((0.6, y), radius: 0.13, fill: color, stroke: none)
      content((1.0, y), anchor: "west", text(0.82em, weight: "bold", fill: color, label))
      content((1.0, y - 0.45), anchor: "west", text(0.72em, fill: c-gray, sub))
    }
    dot(-0.45, [2018], [Flagship VL56, Inc. 成立], c-accent)
    dot(-1.8, [2019], [整合 VL57 相关探索], c-amber)
    dot(-3.15, [2020], [更名 Generate Biomedicines], c-primary)
    dot(-4.5, [2021], [引入职业 CEO，组织转向临床化], c-blue)
    dot(-5.85, [2026], [IPO：成为公众公司], c-primary)
  }),
  block({
    text(weight: "bold", [venture creation])
    v(0.45em)
    text(size: 0.9em)[
      Generate 的早期问题意识是：能否使用生成式 AI 系统性地产生新的蛋白质疗法，而不是靠传统试错发现。
    ]
    v(0.55em)
    text(size: 0.88em)[
      这意味着创立团队一开始就要同时解决三个问题：科学假设是否站得住、公司结构能否融资、平台能否持续产生候选药物。
    ]
    v(0.65em)
    block(
      inset: 0.72em,
      radius: 5pt,
      fill: c-primary.lighten(93%),
      stroke: (left: 3pt + c-primary),
      text(size: 0.86em, fill: c-primary)[
        Generate 的"人"从一开始就是商业模式的一部分，而不是技术完成后的附属配置。
      ],
    )
  }),
)

== Noubar Afeyan：资本与创业平台的核心人物

#set par(leading: 0.8em)

#grid(
  columns: (0.72fr, 1.15fr, 1fr),
  column-gutter: 0.85em,
  [
    #human-photo-box("../input/human/extracted/background/media/image26.jpeg", [Noubar B. Afeyan], [Chair / Co-founder], color: c-primary)
    #v(0.1em)
    #human-stat([代表履历], [Flagship / Moderna], sub: [Flagship 创始人兼 CEO；Moderna 联合创始人], color: c-accent)
  ],
  human-shot("../input/human/extracted/background/media/image23.jpeg", [履历：联合创始人，自 2018 年起担任董事会主席。他于 1999 年创立了 Flagship Pioneering 并担任其首席执行官，目前管理约 140 亿美元的资产，孵化了超过 100 家企业。他也是 Moderna 的联合创始人，并自 2012 年起担任其董事会主席。], height: 7.5cm),
  block({
    text(weight: "bold", [平台型创业者，而非日常经营者])
    v(0.35em)
    text(size: 0.84em)[
      Afeyan 的价值在于把高风险科学假设变成可融资组织：提出命题、配置资本、建立董事会和治理结构，并通过 Flagship 网络持续导入资源。
    ]
    v(0.5em)
    grid(
      columns: (1fr, 1fr),
      column-gutter: 0.45em,
      row-gutter: 0.4em,
      human-pill([科学假设], color: c-accent),
      human-pill([公司创设], color: c-primary),
      human-pill([融资网络], color: c-amber),
      human-pill([治理结构], color: c-blue),
  ``)
    human-shot("../input/human/extracted/background/media/image24.jpeg", [教育背景：MIT 生化工程博士、McGill 化工学士。], height: 3.0cm)
  }),
)

== Gevorg Grigoryan：Generate 技术平台的科学大脑

#grid(
  columns: (0.62fr, 1.08fr, 1fr),
  column-gutter: 0.85em,
  [
    #human-photo-box("../input/human/extracted/background/media/image8.jpeg", [Gevorg Grigoryan], [Co-founder / CTO], color: c-accent)
    #v(0.28em)
    #human-stat([科研产出], [50+ papers], color: c-primary)
  ],
  human-shot("../input/human/extracted/background/media/image9.jpeg", [Generate CTO、Dartmouth 教职与研究背景。], height: 10.0cm),
  block({
    text(weight: "bold", [技术平台的科学可信度来源])
    v(0.2em)
    text(size: 0.83em)[
      Grigoryan 的价值在于把蛋白质序列、结构与功能之间的规律，转化成 Generate Platform 可以学习和生成的科学问题。
    ]
    v(0.2em)
    grid(
      columns: (1fr, 1fr),
      column-gutter: 0.45em,
      row-gutter: 0.38em,
      human-pill([序列], color: c-accent),
      human-pill([结构], color: c-primary),
      human-pill([功能], color: c-amber),
      human-pill([模型学习], color: c-blue),
    )
    v(0.45em)
    human-shot("../input/human/extracted/background/media/image10.jpeg", [教育背景：MIT Ph.D.；计算机科学与生物化学背景。], height: 3.7cm)
  }),
)

== Beth Grous：组织扩张和人才留任能力

#grid(
  columns: (0.62fr, 1.08fr, 1fr),
  column-gutter: 0.85em,
  [
    #human-photo-box("../input/human/extracted/background/media/image11.jpeg", [Beth Grous], [Chief People Officer], color: c-amber)
    #v(0.28em)
    #human-stat([加入时间], [2023], color: c-primary)
  ],
  human-shot("../input/human/extracted/background/media/image12.jpeg", [履历亮点：Tripadvisor、Nuance、Sanofi 人力资源领导岗位。], height: 10.0cm),
  block({
    text(weight: "bold", [AI Biotech 竞争的另一面是人才竞争])
    v(0.35em)
    text(size: 0.83em)[
      - Generate 同时需要机器学习、蛋白工程、湿实验、临床和监管人才。
      - CPO 的任务是让公司从科学小团队扩张成能支撑临床和上市公司运营的组织。
    ]
    v(0.5em)
    human-shot("../input/human/extracted/background/media/image13.jpeg", [教育背景：Cornell。], height: 2.0cm)
  }),
)

== Aarif Khakoo：从平台到候选药物的科学转化

#grid(
  columns: (0.62fr, 1.02fr, 1.06fr),
  column-gutter: 0.85em,
  [
    #human-photo-box("../input/human/extracted/background/media/image14.jpeg", [Aarif Khakoo], [Chief Scientific Officer], color: c-accent)
    #v(0.28em)
    #human-stat([加入时间], [2026], sub: [医师科学家；研发负责人], color: c-primary)
  ],
  human-shot("../input/human/extracted/background/media/image15.jpeg", [履历：Scribe Therapeutics、Calico、Amgen 等研发岗位。], height: 9.0cm),
  block({
    text(weight: "bold", [把平台能力变成可推进项目])
    v(0.35em)
    text(size: 0.83em)[
      平台生成分子之后，还要判断靶点、成药性、制造、临床价值和项目优先级。Khakoo 对应的是候选分子选择和研发转化能力。
    ]
    v(0.5em)
    human-shot("../input/human/extracted/background/media/image16.jpeg", [教育背景截图：Columbia M.D. / MBA。], height: 6.0cm)
  }),
)

== Laurie Lee：后期临床能力支撑 GB-0895

#grid(
  columns: (0.62fr, 1.03fr, 1.05fr),
  column-gutter: 0.85em,
  [
    #human-photo-box("../input/human/extracted/background/media/image17.jpeg", [Laurie Lee], [CMO, Immunology & Inflammation], color: c-primary)
    #v(0.28em)
    #human-stat([加入时间], [2025], sub: [后期临床开发与医学策略], color: c-accent)
  ],
  human-shot("../input/human/extracted/background/media/image18.jpeg", [履历：CSL Behring、GSK 等免疫与临床开发岗位。], height: 10.0cm),
  block({
    text(weight: "bold", [药物临床 Phase 3 需要真实临床执行经验])
    v(0.35em)
    text(size: 0.83em)[
      GB-0895 已进入严重哮喘 Phase 3。Lee 的价值在于后期临床、医学开发和监管申报经验，支撑 Generate 从平台公司走向药品公司。
    ]
    v(0.5em)
    human-shot("../input/human/extracted/background/media/image19.jpeg", [教育背景：Ohio State M.D. / Notre Dame / Duke fellowship。], height: 3.75cm)
  }),
)

== Sean Martin：法务、合规和上市治理

#grid(
  columns: (0.62fr, 1.08fr, 1fr),
  column-gutter: 0.85em,
  [
    #human-photo-box("../input/human/extracted/background/media/image20.jpeg", [Sean Martin], [CLO / General Counsel], color: c-gray)
    #v(0.28em)
    #human-stat([加入时间], [2022], color: c-primary)
  ],
  human-shot("../input/human/extracted/background/media/image21.jpeg", [履历：Baxter、Apollo、Amgen、联邦助理检察官背景。], height: 9.55cm),
  block({
    text(weight: "bold", [AI Biotech 的法务不是后台小角色])
    v(0.35em)
    text(size: 0.83em)[
      - Generate 的价值来自平台、专利、数据和合作协议
      - IPO 后还要面对 SEC 披露、董事会治理、薪酬激励和合规要求。
    ]
    v(0.5em)
    human-shot("../input/human/extracted/background/media/image22.jpeg", [教育背景：Harvard J.D. / University of Michigan。], height: 4.7cm)
  }),
)

== Michael Nally：药企商业化经验进入 AI Biotech

#grid(
  columns: (0.62fr, 1.04fr, 1.05fr),
  column-gutter: 0.85em,
  [
    #human-photo-box("../input/human/extracted/background/media/image2.jpeg", [Michael Nally], [CEO · 2021 加入], color: c-primary)
    #v(0.28em)
    #align(center, human-pill([Merck 18 年], color: c-accent))
    #v(0.25em)
    #align(center, human-pill([CMO / Vaccines], color: c-amber))
  ],
  human-shot("../input/human/extracted/background/media/image3.jpeg", [履历：Generate CEO、Flagship CEO/Partner、Merck CMO / Vaccines。], height: 9.0cm),
  block({
    text(weight: "bold", [从大型药企管理进入 AI Biotech])
    v(0.35em)
    text(size: 0.83em)[
      Nally 负责把 Generate 从科学平台带向临床、BD、IPO 和商业化准备。他的 Merck 背景带来的是产品组合管理、全球运营和市场准入经验。
    ]
    v(0.4em)
    fletcher-diagram(
      node-stroke: 0.6pt,
      node-corner-radius: 4pt,
      node-inset: 0.48em,
      spacing: (1.45em, 0.5em),
      node((0, 0), text(0.8em)[Merck\ 商业化], fill: c-accent.lighten(88%), stroke: c-accent),
      node((1, 0), text(0.8em)[Generate\ CEO], fill: c-primary.lighten(90%), stroke: c-primary),
      node((2, 0), text(0.8em)[临床推进\ IPO], fill: c-amber.lighten(86%), stroke: c-amber),
      edge((0, 0), (1, 0), "->"),
      edge((1, 0), (2, 0), "->"),
    )
    v(0.5em)
    human-shot("../input/human/extracted/background/media/image4.jpeg", [教育背景：Harvard MBA / LSE / Middlebury。], height: 3.0cm)
  }),
)

== Jason Silvers：融资与资本市场叙事的执行者

#grid(
  columns: (0.62fr, 1.05fr, 1.02fr),
  column-gutter: 0.85em,
  [
    #human-photo-box("../input/human/extracted/background/media/image5.jpeg", [Jason Silvers], [President & CFO], color: c-blue)
    #v(0.28em)
    #human-stat([参与交易], [\$400B+], color: c-primary)
  ],
  human-shot("../input/human/extracted/background/media/image6.jpeg", [履历：Goldman Sachs 合伙人、医疗健康投行业务。], height: 9.0cm),
  block({
    text(weight: "bold", [CFO 的核心工作是翻译资本故事])
    v(0.35em)
    text(size: 0.83em)[
      对无商业化产品、仍然亏损的 biotech 来说，CFO 不只是财务岗位，而是把平台、临床、BD 和资金需求变成资本市场可理解叙事的人。
    ]
    v(0.5em)
    human-shot("../input/human/extracted/background/media/image7.jpeg", [教育经历：Yale J.D. / Johns Hopkins M.D. / Brown Chemistry。], height: 5.0cm)
  }),
)

== 核心人物矩阵

#grid(
  columns: (1fr, 1fr, 1fr, 1fr, 1fr),
  column-gutter: 0.55em,
  row-gutter: 0.55em,
  human-person([Afeyan], [Chair / Co-founder], [Flagship / Moderna], [创业孵化、资本网络、治理], color: c-primary),
  human-person([Grigoryan], [Co-founder / CTO], [Dartmouth], [蛋白设计平台科学基础], color: c-accent),
  human-person([Gibson], [Co-founder], [Flagship], [生成式生物学命题推进], color: c-amber),
  human-person([Nally], [CEO], [Merck], [战略、商业化、组织管理], color: c-primary),
  human-person([Silvers], [President & CFO], [Goldman Sachs], [融资、IPO、资本市场], color: c-blue),
  human-person([Khakoo], [CSO], [Scribe / Amgen], [科学战略和项目转化], color: c-accent),
  human-person([Lee], [CMO], [GSK / CSL], [后期临床开发], color: c-primary),
  human-person([Martin], [CLO], [Baxter / Amgen], [法务、合规、上市治理], color: c-gray),
  human-person([Grous], [CPO], [Tripadvisor / Sanofi], [人才招聘和组织扩张], color: c-amber),
  human-person([de Alwis], [Clinical Dev.], [Merck], [临床执行能力], color: c-blue),
)

#v(0.5em)

#text(size: 0.86em, fill: c-primary)[
  结构性特征：科学家主导平台起源，药企经理人推动临床开发，投行背景 CFO 打通融资和 IPO，法务与人力保证公众公司运行。
]

== 管理层结构

#grid(
  columns: (1fr, 1fr, 1fr, 1fr),
  column-gutter: 0.65em,
  row-gutter: 0.55em,
  human-card([CEO], [整合科学、临床、融资和公司战略], color: c-primary),
  human-card([CFO], [融资、BD、IPO 与资本市场沟通], color: c-blue),
  human-card([CTO], [Generate Platform 的技术路线和模型能力], color: c-accent),
  human-card([CSO], [候选分子选择与研发转化], color: c-amber),
  human-card([CMO], [临床开发、医学策略和监管路径], color: c-primary),
  human-card([CLO], [知识产权、合作协议和上市治理], color: c-gray),
  human-card([CPO], [复合型人才招聘和长期留任], color: c-accent),
  human-card([Clinical Head], [试验设计、运营执行和数据读取], color: c-blue),
)

#v(0.7em)

#align(center, text(size: 0.95em, weight: "bold", fill: c-primary)[
  管理组织的搭建符合上市 biotech 标准。
])

== 人员结构：研发密集型 + AI/数据交叉型团队

#grid(
  columns: (1.15fr, 0.9fr),
  column-gutter: 1em,
  [
    #align(center, image("../input/human/extracted/background/media/image25.jpeg", width: 100%))
    #v(0.15em)
    #human-source-note([关联员工的技能与专业背景])
  ],
  grid(
    columns: (1fr),
    row-gutter: 0.32em,
    human-stat([员工规模线索], [328], sub: [关联员工口径：生命科学研发与数据科学交叉], color: c-accent),
    human-stat([高学历员工], [138], sub: [截至 2025-12-31，M.D. / Ph.D. 等高级学位], color: c-primary),
    human-stat([计算机科学背景], [21], sub: [与生化、化学、生物技术背景共同构成平台团队], color: c-blue),
  ),
)

== 从平台到药物：每个环节都对应一种人才

#align(center, cetz-canvas(length: 2.4cm, {
  import cetz.draw: *
  let step(x, label, owner, color) = {
    rect((x - 0.82, 3.0), (x + 0.82, 3.95), fill: color.lighten(88%), stroke: 0.6pt + color, radius: 4pt)
    content((x, 3.48), text(0.9em, weight: "bold", fill: color, label + [\ ] + text(0.8em, weight: "regular", fill: c-gray, owner)))
  }
  step(0.7, [AI Model], [CTO], c-blue)
  step(2.25, [Protein Design], [Grigoryan], c-accent)
  step(3.8, [Wet Lab], [研发团队], c-amber)
  step(5.35, [IND], [Khakoo], c-primary)
  step(6.9, [Clinical], [Lee / de Alwis], c-blue)
  step(8.45, [IPO / BD], [Nally / Silvers], c-primary)
  step(10.0, [Governance], [Martin / Board], c-gray)
  for x in (1.52, 3.07, 4.62, 6.17, 7.72, 9.27) {
    line((x, 3.48), (x + 0.15, 3.48), mark: (end: ">"), stroke: 0.75pt + c-gray)
  }
}))

#v(0.85em)

#grid(
  columns: (1fr, 1fr),
  column-gutter: 1em,
  human-card([为什么这条链重要？], [AI 药物研发不是模型单点胜利，而是模型、实验、临床、融资和治理共同运转。某个环节缺人，平台价值就无法转化。], color: c-primary),
  human-card([Generate 的团队含义], [它把关键岗位放在价值链上：科学家解释"能不能生成"，临床团队解释"能不能进人体"，CFO/CEO 解释"能不能融资并上市"。], color: c-accent),
)

== 高管薪酬：现金只是底座，期权才是核心

#grid(
  columns: (1.08fr, 0.92fr),
  column-gutter: 1.15em,
  block({
    text(weight: "bold", [2025 named executive officers 薪酬结构])
    v(0.45em)
    table(
      columns: (1fr, auto, auto, auto),
      stroke: 0.5pt + c-gray,
      align: (left, right, right, right),
      inset: 0.45em,
      table.header(
        text(0.8em, weight: "bold")[高管],
        text(0.8em, weight: "bold")[总薪酬],
        text(0.8em, weight: "bold")[期权奖励],
        text(0.8em, weight: "bold")[期权占比],
      ),
      text(0.78em)[Michael Nally], text(0.78em)[\$5.53M], text(0.78em, fill: c-primary)[\$4.45M], text(0.78em)[≈ 80%],
      text(0.78em)[Jason Silvers], text(0.78em)[\$2.22M], text(0.78em, fill: c-primary)[\$1.45M], text(0.78em)[≈ 65%],
      text(0.78em)[Gevorg Grigoryan], text(0.78em)[\$2.3M], text(0.78em)[\$1.56M], text(0.78em)[≈ 68%],
    )
    v(0.55em)
    text(size: 0.84em)[
      高管收入结构不是"高固定工资"，而是基础工资 + 现金激励 + 长期股权激励。Generate 试图让管理层和股东共享同一套长期价值函数。
    ]
  }),
  cetz-canvas(length: 1.6cm, {
    import cetz.draw: *
    let base = 0.5
    let scale = 4.6 / 5.6
    let stacked(x, name, salary, option, other, color) = {
      let h1 = salary * scale
      let h2 = option * scale
      let h3 = other * scale
      rect((x - 0.42, base), (x + 0.42, base + h1), fill: c-accent, stroke: none)
      rect((x - 0.42, base + h1), (x + 0.42, base + h1 + h2), fill: color, stroke: none)
      rect((x - 0.42, base + h1 + h2), (x + 0.42, base + h1 + h2 + h3), fill: c-amber, stroke: none)
      content((x, base - 0.45), text(0.68em, name))
      content((x, base + h1 + h2 + h3 + 0.3), text(0.72em, weight: "bold", fill: color)[\$#calc.round(salary + option + other, digits: 2) M])
    }
    line((0.8, base), (6.8, base), stroke: 0.6pt + c-gray)
    stacked(2.1, [Nally], 0.62, 4.45, 0.46, c-primary)
    stacked(5.1, [Silvers], 0.55, 1.45, 0.22, c-primary)
    rect((1.0, 5.7), (1.25, 5.95), fill: c-accent, stroke: none)
    content((1.45, 5.82), anchor: "west", text(0.62em)[Base / cash])
    rect((3.2, 5.7), (3.45, 5.95), fill: c-primary, stroke: none)
    content((3.65, 5.82), anchor: "west", text(0.62em)[Option awards])
    rect((5.7, 5.7), (5.95, 5.95), fill: c-amber, stroke: none)
    content((6.15, 5.82), anchor: "west", text(0.62em)[Incentive / other])
  }),
)

== IPO 时点股权激励：关键岗位继续被长期绑定

#grid(
  columns: (1fr, 1fr, 1fr),
  column-gutter: 0.8em,
  human-stat([Nally 期权], [1,689,190 股], sub: [两笔各 844,595 股；CEO 获最大级别长期激励], color: c-primary),
  human-stat([Silvers 期权], [570,101 股], sub: [295,608 + 274,493 股；CFO 与上市结果绑定], color: c-blue),
  human-stat([Grigoryan 期权], [491,976 股], sub: [295,608 + 196,368 股；绑定科学平台创造者], color: c-accent),
)

#v(0.8em)

#grid(
  columns: (1fr, 1fr, 1fr),
  column-gutter: 0.8em,
  human-stat([2026 Plan 预留], [11,852,719 股], sub: [用于未来发行], color: c-primary),
  human-stat([拟授予期权], [4,799,160 股], sub: [执行官、董事和员工], color: c-amber),
  human-stat([潜在稀释], [≈ 7.62%], sub: [按 2025-12-31 已发行普通股口径估算], color: c-gray),
)

#v(0.25em)

#text(size: 0.78em)[
  这说明 Generate 上市以后仍会持续依赖股权激励来招聘、留任和约束关键人才；代价则是未来股本稀释。
]

== 为什么必须重度依赖股权激励？

#align(center, fletcher-diagram(
  node-stroke: 0.6pt,
  node-corner-radius: 5pt,
  node-inset: 0.7em,
  spacing: (1.9em, 0.7em),
  node((0, 0), text(0.8em)[临床阶段\ 持续烧钱], fill: c-primary.lighten(90%), stroke: c-primary),
  node((1, 0), text(0.8em)[现金有限\ 优先投研发], fill: c-amber.lighten(86%), stroke: c-amber),
  node((2, 0), text(0.8em)[复合型人才\ 稀缺], fill: c-accent.lighten(88%), stroke: c-accent),
  node((3, 0), text(0.8em)[股权激励\ 长期绑定], fill: c-blue.lighten(88%), stroke: c-blue),
  node((4, 0), text(0.8em)[IPO / 临床成功\ 才能兑现], fill: c-light, stroke: c-gray),
  edge((0, 0), (1, 0), "->"),
  edge((1, 0), (2, 0), "->"),
  edge((2, 0), (3, 0), "->"),
  edge((3, 0), (4, 0), "->"),
))

#v(0.85em)

#grid(
  columns: (1fr, 1fr),
  column-gutter: 1em,
  human-card([公司现实], [仍无获批产品，未来会持续亏损，需要大量资本支持研发和临床开发。成熟药企式现金薪酬并不适合这个阶段。], color: c-primary),
  human-card([人才现实], [AI + Biotech 人才同时被科技公司、药企、大学实验室和其他 biotech 争夺。股权是最有效的长期留才工具之一。], color: c-accent),
)

#v(0.55em)

#align(center, text(size: 0.95em, weight: "bold", fill: c-primary)[
  股权激励的逻辑：少用当期现金，多给未来上行；但上行必须靠临床结果兑现。
])

== 总结：团队优势与人员相关风险

#grid(
  columns: (1fr, 1fr),
  column-gutter: 1.15em,
  block(
    inset: 0.75em,
    radius: 6pt,
    fill: c-accent.lighten(92%),
    stroke: (left: 4pt + c-accent),
    {
      text(weight: "bold", fill: c-accent, [团队优势])
      v(0.4em)
      text(size: 0.88em)[
        - Flagship 背书强，创业与融资资源充足
        - 科学创始人具备蛋白质设计深度能力
        - CEO / CFO 连接药企经验与资本市场
        - 临床高管具备 GSK、CSL、Amgen、Merck 等背景
        - 组织覆盖 AI、实验、临床、融资和治理
      ]
    },
  ),
  block(
    inset: 0.75em,
    radius: 6pt,
    fill: c-primary.lighten(92%),
    stroke: (left: 4pt + c-primary),
    {
      text(weight: "bold", fill: c-primary, [潜在风险])
      v(0.4em)
      text(size: 0.88em)[
        - 高度依赖关键科学家和管理层
        - 股权激励带来未来稀释
        - 强背景不能替代临床数据
        - AI 药物发现模式仍需真实临床成功验证
        - Flagship 体系影响力强，治理独立性需持续观察
      ]
    },
  ),
)

#v(0.85em)

#align(center, block(
  width: 92%,
  inset: 0.78em,
  radius: 6pt,
  fill: c-primary.lighten(93%),
  stroke: (left: 4pt + c-primary),
  text(size: 1.0em, weight: "bold", fill: c-primary)[
    Generate 的"人"给公司提供了很强的起点；\
    但这些人的价值最终要通过 GB-0895、GB-4362、GB-5267 等管线的临床结果来证明。
  ],
))

== 小组分工 <touying:unoutlined>

#let role-card(title, color, people1, people2) = block(
  width: 100%,
  inset: 0.9em,
  radius: 6pt,
  fill: color.lighten(92%),
  stroke: (left: 4pt + color),
  {
    set par(justify: false, leading: 0.72em)
    text(size: 1.25em, weight: "bold", fill: color, title)
    v(0.75em)
    text(size: 0.92em, fill: c-gray)[负责组员]
    v(0.35em)
    text(size: 1.05em)[组员 1：#people1]
    v(0.3em)
    text(size: 1.05em)[组员 2：#people2]
  },
)

#let tool-logo(path, height: 1.2cm) = block(
  width: 100%,
  height: 1.5cm,
  inset: 0.08cm,
  radius: 5pt,
  fill: white,
  align(center + horizon, image(path, height: height)),
)

#v(0.75em)

#grid(
  columns: (1fr, 1fr, 1fr),
  column-gutter: 1.0em,
  role-card([事], c-accent, [李屹哲], [吕乐凡]),
  role-card([钱], c-primary, [俞奕成], [王炳祺]),
  role-card([人], c-amber, [董思成], [马艺萌]),
)

#v(0.9em)

#align(center, text(size: 0.9em, fill: c-gray)[
  每个部分由两位组员共同负责资料整理、内容设计与页面校准。
])

#v(0.3em)

#align(center, text(size: 0.78em, fill: c-gray)[使用的工具及资源])

#v(0.25em)

#align(center,
  box(
    width: 80%,
    grid(
      columns: (1fr, 1fr, 1fr, 1fr, 1fr),
      column-gutter: 0.55em,
      tool-logo("assets/logo/typst.png"),
      tool-logo("assets/logo/touying.png"),
      tool-logo("assets/logo/SJTUG.png"),
      tool-logo("assets/logo/chatgpt.png"),
      tool-logo("assets/logo/claude-logo.png"),
    )
  )
)


== End <touying:unoutlined>

#end-slide-red[
  Thanks for your listening
]
