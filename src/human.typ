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
    title: [Generate 的"人"],
    subtitle: [科学、资本与药企经验如何拼成一家 AI Biotech],
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
    set par(justify: false, leading: 0.62em)
    text(size: 0.98em, weight: "bold", fill: color, title)
    v(0.35em)
    text(size: 0.86em, body)
  },
)

#let stat(label, value, sub: none, color: c-primary) = block(
  width: 100%,
  inset: 0.58em,
  radius: 6pt,
  fill: color.lighten(90%),
  stroke: (left: 4pt + color),
  {
    set par(justify: false, leading: 0.48em)
    text(size: 0.78em, fill: c-gray, label)
    v(0.24em)
    text(size: 1.2em, weight: "bold", fill: color, value)
    if sub != none {
      v(0.18em)
      text(size: 0.8em, fill: c-gray, sub)
    }
  },
)

#let pill(body, color: c-primary) = box(
  inset: (x: 0.65em, y: 0.22em),
  radius: 99pt,
  fill: color.lighten(88%),
  stroke: 0.5pt + color,
  text(size: 0.76em, weight: "bold", fill: color, body),
)

#let person(name, title, origin, value, color: c-primary) = block(
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

#let bar(label, val, ratio, color, sub: none) = grid(
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

#let source-note(body) = text(size: 0.74em, fill: c-gray, body)

#let photo-box(path, name, role, color: c-primary) = block(
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

#let shot(path, caption, height: 6.4cm) = block(
  width: 100%,
  inset: 0.2em,
  radius: 4pt,
  fill: white,
  stroke: 0.45pt + c-gray.lighten(35%),
  {
    align(center, image(path, height: height))
    v(0.12em)
    source-note(caption)
  },
)

// ============================================================
// 标题页
// ============================================================
#title-slide-red()

= 人

== Generate 的"人"是三种能力的组合

#grid(
  columns: (1fr, 1fr, 1fr),
  column-gutter: 1em,
  stat([科学能力], [Protein Design], sub: [Gevorg Grigoryan / Molly Gibson\ 支撑生成式蛋白平台], color: c-accent),
  stat([资本能力], [Flagship], sub: [Afeyan + venture creation\ 提供公司创设与融资网络], color: c-primary),
  stat([药企能力], [Clinical + IPO], sub: [Merck / GSK / Amgen / Goldman\ 推动临床、BD 与上市], color: c-amber),
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
  card([① 创始来源], [公司是 Flagship 内部提出命题、组建团队、整合科学家与数据驱动探索。], color: c-accent),
  card([② 管理层配置], [CEO、CFO、CTO、CSO、CMO、法务与人力岗位共同把科研平台改造成临床阶段公司。], color: c-primary),
  card([③ 激励机制], [现金薪酬只是基础，期权和长期股权激励把高管、董事和关键员工绑定到同一条价值曲线。], color: c-amber),
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

== 主要创始人体系：Flagship 团队 + 科学创始人

#grid(
  columns: (1.15fr, 0.85fr),
  column-gutter: 1.1em,
  cetz-canvas(length: 1.35cm, {
    import cetz.draw: *
    let center = (4, 3)
    let member(pos, label, sub, color) = {
      line(center, pos, stroke: (paint: color, thickness: 0.8pt, dash: "dashed"))
      rect((pos.at(0) - 1.35, pos.at(1) - 0.48), (pos.at(0) + 1.35, pos.at(1) + 0.48), fill: color.lighten(88%), stroke: 0.55pt + color, radius: 4pt)
      content(pos, text(0.68em, weight: "bold", fill: color, label + [\ ] + text(0.58em, fill: c-gray, weight: "regular", sub)))
    }
    member((0.9, 5.4), [Noubar Afeyan], [Flagship / Moderna], c-primary)
    member((4, 5.75), [Molly Gibson], [生成式生物学], c-amber)
    member((7.1, 5.4), [G. von Maltzahn], [连续创业者], c-accent)
    member((0.9, 0.6), [Avak Kahvejian], [Flagship 高层], c-blue)
    member((7.1, 0.6), [Gevorg Grigoryan], [蛋白设计 CTO], c-primary)
    circle(center, radius: 1.1, fill: c-primary, stroke: none)
    content(center, text(0.8em, fill: white, weight: "bold")[Generate\ Platform])
  }),
  block({
    text(weight: "bold", [两类创始能力叠加])
    v(0.45em)
    text(size: 0.88em)[
      - *Flagship origination team*：提出创业命题、配置资本、组织公司
      - *科学创始人*：把蛋白质结构、序列和功能规律转化为平台假设
      - *平台目标*：不是只做一个分子，而是反复生成、验证和推进蛋白药物
    ]
    v(0.65em)
    text(size: 0.88em, fill: c-primary)[
      创始结构决定了 Generate 的叙事：科学可信度 + 资本组织能力 + 可复制平台。
    ]
  }),
)

== Noubar Afeyan：资本与创业平台的核心人物

#set par(leading: 0.8em)

#grid(
  columns: (0.72fr, 1.15fr, 1fr),
  column-gutter: 0.85em,
  [
    #photo-box("../input/human/extracted/background/media/image26.jpeg", [Noubar B. Afeyan], [Chair / Co-founder], color: c-primary)
    #v(0.32em)
    #stat([代表履历], [Flagship / Moderna], sub: [Flagship 创始人兼 CEO；Moderna 联合创始人], color: c-accent)
  ],
  shot("../input/human/extracted/background/media/image23.jpeg", [履历：联合创始人，自 2018 年起担任董事会主席。他于 1999 年创立了 Flagship Pioneering 并担任其首席执行官，目前管理约 140 亿美元的资产，孵化了超过 100 家企业。他也是 Moderna 的联合创始人，并自 2012 年起担任其董事会主席。], height: 7.5cm),
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
      pill([科学假设], color: c-accent),
      pill([公司创设], color: c-primary),
      pill([融资网络], color: c-amber),
      pill([治理结构], color: c-blue),
  ``)
    shot("../input/human/extracted/background/media/image24.jpeg", [教育背景：MIT 生化工程博士、McGill 化工学士。], height: 3.0cm)
  }),
)

== Gevorg Grigoryan：Generate 技术平台的科学大脑

#grid(
  columns: (0.62fr, 1.08fr, 1fr),
  column-gutter: 0.85em,
  [
    #photo-box("../input/human/extracted/background/media/image8.jpeg", [Gevorg Grigoryan], [Co-founder / CTO], color: c-accent)
    #v(0.28em)
    #stat([科研产出], [50+ papers], color: c-primary)
  ],
  shot("../input/human/extracted/background/media/image9.jpeg", [Generate CTO、Dartmouth 教职与研究背景。], height: 10.0cm),
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
      pill([序列], color: c-accent),
      pill([结构], color: c-primary),
      pill([功能], color: c-amber),
      pill([模型学习], color: c-blue),
    )
    v(0.45em)
    shot("../input/human/extracted/background/media/image10.jpeg", [教育背景：MIT Ph.D.；计算机科学与生物化学背景。], height: 3.7cm)
  }),
)

== Beth Grous：组织扩张和人才留任能力

#grid(
  columns: (0.62fr, 1.08fr, 1fr),
  column-gutter: 0.85em,
  [
    #photo-box("../input/human/extracted/background/media/image11.jpeg", [Beth Grous], [Chief People Officer], color: c-amber)
    #v(0.28em)
    #stat([加入时间], [2023], color: c-primary)
  ],
  shot("../input/human/extracted/background/media/image12.jpeg", [履历亮点：Tripadvisor、Nuance、Sanofi 人力资源领导岗位。], height: 10.0cm),
  block({
    text(weight: "bold", [AI Biotech 竞争的另一面是人才竞争])
    v(0.35em)
    text(size: 0.83em)[
      - Generate 同时需要机器学习、蛋白工程、湿实验、临床和监管人才。
      - CPO 的任务是让公司从科学小团队扩张成能支撑临床和上市公司运营的组织。
    ]
    v(0.5em)
    shot("../input/human/extracted/background/media/image13.jpeg", [教育背景：Cornell。], height: 2.0cm)
  }),
)

== Aarif Khakoo：从平台到候选药物的科学转化

#grid(
  columns: (0.62fr, 1.02fr, 1.06fr),
  column-gutter: 0.85em,
  [
    #photo-box("../input/human/extracted/background/media/image14.jpeg", [Aarif Khakoo], [Chief Scientific Officer], color: c-accent)
    #v(0.28em)
    #stat([加入时间], [2026], sub: [医师科学家；研发负责人], color: c-primary)
  ],
  shot("../input/human/extracted/background/media/image15.jpeg", [履历：Scribe Therapeutics、Calico、Amgen 等研发岗位。], height: 9.0cm),
  block({
    text(weight: "bold", [把平台能力变成可推进项目])
    v(0.35em)
    text(size: 0.83em)[
      平台生成分子之后，还要判断靶点、成药性、制造、临床价值和项目优先级。Khakoo 对应的是候选分子选择和研发转化能力。
    ]
    v(0.5em)
    shot("../input/human/extracted/background/media/image16.jpeg", [教育背景截图：Columbia M.D. / MBA。], height: 6.0cm)
  }),
)

== Laurie Lee：后期临床能力支撑 GB-0895

#grid(
  columns: (0.62fr, 1.03fr, 1.05fr),
  column-gutter: 0.85em,
  [
    #photo-box("../input/human/extracted/background/media/image17.jpeg", [Laurie Lee], [CMO, Immunology & Inflammation], color: c-primary)
    #v(0.28em)
    #stat([加入时间], [2025], sub: [后期临床开发与医学策略], color: c-accent)
  ],
  shot("../input/human/extracted/background/media/image18.jpeg", [履历：CSL Behring、GSK 等免疫与临床开发岗位。], height: 10.0cm),
  block({
    text(weight: "bold", [药物临床 Phase 3 需要真实临床执行经验])
    v(0.35em)
    text(size: 0.83em)[
      GB-0895 已进入严重哮喘 Phase 3。Lee 的价值在于后期临床、医学开发和监管申报经验，支撑 Generate 从平台公司走向药品公司。
    ]
    v(0.5em)
    shot("../input/human/extracted/background/media/image19.jpeg", [教育背景：Ohio State M.D. / Notre Dame / Duke fellowship。], height: 3.75cm)
  }),
)

== Sean Martin：法务、合规和上市治理

#grid(
  columns: (0.62fr, 1.08fr, 1fr),
  column-gutter: 0.85em,
  [
    #photo-box("../input/human/extracted/background/media/image20.jpeg", [Sean Martin], [CLO / General Counsel], color: c-gray)
    #v(0.28em)
    #stat([加入时间], [2022], color: c-primary)
  ],
  shot("../input/human/extracted/background/media/image21.jpeg", [履历：Baxter、Apollo、Amgen、联邦助理检察官背景。], height: 9.55cm),
  block({
    text(weight: "bold", [AI Biotech 的法务不是后台小角色])
    v(0.35em)
    text(size: 0.83em)[
      - Generate 的价值来自平台、专利、数据和合作协议
      - IPO 后还要面对 SEC 披露、董事会治理、薪酬激励和合规要求。
    ]
    v(0.5em)
    shot("../input/human/extracted/background/media/image22.jpeg", [教育背景：Harvard J.D. / University of Michigan。], height: 4.7cm)
  }),
)

== Michael Nally：药企商业化经验进入 AI Biotech

#grid(
  columns: (0.62fr, 1.04fr, 1.05fr),
  column-gutter: 0.85em,
  [
    #photo-box("../input/human/extracted/background/media/image2.jpeg", [Michael Nally], [CEO · 2021 加入], color: c-primary)
    #v(0.28em)
    #align(center, pill([Merck 18 年], color: c-accent))
    #v(0.25em)
    #align(center, pill([CMO / Vaccines], color: c-amber))
  ],
  shot("../input/human/extracted/background/media/image3.jpeg", [履历：Generate CEO、Flagship CEO/Partner、Merck CMO / Vaccines。], height: 9.0cm),
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
    shot("../input/human/extracted/background/media/image4.jpeg", [教育背景：Harvard MBA / LSE / Middlebury。], height: 3.0cm)
  }),
)

== Jason Silvers：融资与资本市场叙事的执行者

#grid(
  columns: (0.62fr, 1.05fr, 1.02fr),
  column-gutter: 0.85em,
  [
    #photo-box("../input/human/extracted/background/media/image5.jpeg", [Jason Silvers], [President & CFO], color: c-blue)
    #v(0.28em)
    #stat([参与交易], [\$400B+], color: c-primary)
  ],
  shot("../input/human/extracted/background/media/image6.jpeg", [履历：Goldman Sachs 合伙人、医疗健康投行业务。], height: 9.0cm),
  block({
    text(weight: "bold", [CFO 的核心工作是翻译资本故事])
    v(0.35em)
    text(size: 0.83em)[
      对无商业化产品、仍然亏损的 biotech 来说，CFO 不只是财务岗位，而是把平台、临床、BD 和资金需求变成资本市场可理解叙事的人。
    ]
    v(0.5em)
    shot("../input/human/extracted/background/media/image7.jpeg", [教育经历：Yale J.D. / Johns Hopkins M.D. / Brown Chemistry。], height: 5.0cm)
  }),
)

== 核心人物矩阵

#grid(
  columns: (1fr, 1fr, 1fr, 1fr, 1fr),
  column-gutter: 0.55em,
  row-gutter: 0.55em,
  person([Afeyan], [Chair / Co-founder], [Flagship / Moderna], [创业孵化、资本网络、治理], color: c-primary),
  person([Grigoryan], [Co-founder / CTO], [Dartmouth], [蛋白设计平台科学基础], color: c-accent),
  person([Gibson], [Co-founder], [Flagship], [生成式生物学命题推进], color: c-amber),
  person([Nally], [CEO], [Merck], [战略、商业化、组织管理], color: c-primary),
  person([Silvers], [President & CFO], [Goldman Sachs], [融资、IPO、资本市场], color: c-blue),
  person([Khakoo], [CSO], [Scribe / Amgen], [科学战略和项目转化], color: c-accent),
  person([Lee], [CMO], [GSK / CSL], [后期临床开发], color: c-primary),
  person([Martin], [CLO], [Baxter / Amgen], [法务、合规、上市治理], color: c-gray),
  person([Grous], [CPO], [Tripadvisor / Sanofi], [人才招聘和组织扩张], color: c-amber),
  person([de Alwis], [Clinical Dev.], [Merck], [临床执行能力], color: c-blue),
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
  card([CEO], [整合科学、临床、融资和公司战略], color: c-primary),
  card([CFO], [融资、BD、IPO 与资本市场沟通], color: c-blue),
  card([CTO], [Generate Platform 的技术路线和模型能力], color: c-accent),
  card([CSO], [候选分子选择与研发转化], color: c-amber),
  card([CMO], [临床开发、医学策略和监管路径], color: c-primary),
  card([CLO], [知识产权、合作协议和上市治理], color: c-gray),
  card([CPO], [复合型人才招聘和长期留任], color: c-accent),
  card([Clinical Head], [试验设计、运营执行和数据读取], color: c-blue),
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
    #source-note([关联员工的技能与专业背景])
  ],
  grid(
    columns: (1fr),
    row-gutter: 0.32em,
    stat([员工规模线索], [328], sub: [关联员工口径：生命科学研发与数据科学交叉], color: c-accent),
    stat([高学历员工], [138], sub: [截至 2025-12-31，M.D. / Ph.D. 等高级学位], color: c-primary),
    stat([计算机科学背景], [21], sub: [与生化、化学、生物技术背景共同构成平台团队], color: c-blue),
  ),
)

== 从平台到药物：每个环节都对应一种人才

#align(center, cetz-canvas(length: 1.45cm, {
  import cetz.draw: *
  let step(x, label, owner, color) = {
    rect((x - 0.82, 3.0), (x + 0.82, 3.95), fill: color.lighten(88%), stroke: 0.6pt + color, radius: 4pt)
    content((x, 3.48), text(0.64em, weight: "bold", fill: color, label + [\ ] + text(0.56em, weight: "regular", fill: c-gray, owner)))
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
  card([为什么这条链重要？], [AI 药物研发不是模型单点胜利，而是模型、实验、临床、融资和治理共同运转。某个环节缺人，平台价值就无法转化。], color: c-primary),
  card([Generate 的团队含义], [它把关键岗位放在价值链上：科学家解释"能不能生成"，临床团队解释"能不能进人体"，CFO/CEO 解释"能不能融资并上市"。], color: c-accent),
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
      text(0.78em)[Gevorg Grigoryan], text(0.78em)[未在讲稿中单列], text(0.78em)[长期股权绑定], text(0.78em)[创始科学家],
    )
    v(0.55em)
    text(size: 0.84em)[
      高管收入结构不是"高固定工资"，而是基础工资 + 现金激励 + 长期股权激励。Generate 试图让管理层和股东共享同一套长期价值函数。
    ]
  }),
  cetz-canvas(length: 1.2cm, {
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
  stat([Nally 期权], [1,689,190 股], sub: [两笔各 844,595 股；CEO 获最大级别长期激励], color: c-primary),
  stat([Silvers 期权], [570,101 股], sub: [295,608 + 274,493 股；CFO 与上市结果绑定], color: c-blue),
  stat([Grigoryan 期权], [491,976 股], sub: [295,608 + 196,368 股；绑定科学平台创造者], color: c-accent),
)

#v(0.8em)

#grid(
  columns: (1fr, 1fr, 1fr),
  column-gutter: 0.8em,
  stat([2026 Plan 预留], [11,852,719 股], sub: [用于未来发行], color: c-primary),
  stat([拟授予期权], [4,799,160 股], sub: [执行官、董事和员工], color: c-amber),
  stat([潜在稀释], [≈ 7.62%], sub: [按 2025-12-31 已发行普通股口径估算], color: c-gray),
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
  node((0, 0), text(0.76em)[临床阶段\ 持续烧钱], fill: c-primary.lighten(90%), stroke: c-primary),
  node((1, 0), text(0.76em)[现金有限\ 优先投研发], fill: c-amber.lighten(86%), stroke: c-amber),
  node((2, 0), text(0.76em)[复合型人才\ 稀缺], fill: c-accent.lighten(88%), stroke: c-accent),
  node((3, 0), text(0.76em)[股权激励\ 长期绑定], fill: c-blue.lighten(88%), stroke: c-blue),
  node((4, 0), text(0.76em)[IPO / 临床成功\ 才能兑现], fill: c-light, stroke: c-gray),
  edge((0, 0), (1, 0), "->"),
  edge((1, 0), (2, 0), "->"),
  edge((2, 0), (3, 0), "->"),
  edge((3, 0), (4, 0), "->"),
))

#v(0.85em)

#grid(
  columns: (1fr, 1fr),
  column-gutter: 1em,
  card([公司现实], [仍无获批产品，未来会持续亏损，需要大量资本支持研发和临床开发。成熟药企式现金薪酬并不适合这个阶段。], color: c-primary),
  card([人才现实], [AI + Biotech 人才同时被科技公司、药企、大学实验室和其他 biotech 争夺。股权是最有效的长期留才工具之一。], color: c-accent),
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
