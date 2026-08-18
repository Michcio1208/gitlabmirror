# Generates index.html for the Analog Electronics guide.
# Run with: python3 build.py

import html as H

PAGE = """<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8" />
<meta name="viewport" content="width=device-width, initial-scale=1.0" />
<title>Analog Electronics — A Comprehensive Guide</title>
<style>
  :root {
    --bg: #0f1216; --panel: #161b22; --panel-2: #1c232c; --border: #2a3340;
    --text: #d6dde6; --muted: #8a96a5; --accent: #4ea1ff; --accent-2: #6ee7b7;
    --warn: #f59e0b; --danger: #ef4444; --code-bg: #0b0f14; --link: #7cc4ff;
  }
  * { box-sizing: border-box; }
  html, body {
    margin: 0; padding: 0; background: var(--bg); color: var(--text);
    font-family: -apple-system, BlinkMacSystemFont, "Segoe UI", Roboto, Helvetica, Arial, sans-serif;
    line-height: 1.65; font-size: 16px;
  }
  a { color: var(--link); text-decoration: none; }
  a:hover { text-decoration: underline; }
  .layout { display: grid; grid-template-columns: 280px 1fr; min-height: 100vh; }
  aside.sidebar {
    background: var(--panel); border-right: 1px solid var(--border);
    padding: 24px 16px; position: sticky; top: 0; height: 100vh; overflow-y: auto;
  }
  .brand { display: flex; align-items: center; gap: 10px; margin-bottom: 24px; }
  .brand-mark {
    width: 36px; height: 36px; border-radius: 8px;
    background: linear-gradient(135deg, var(--accent), var(--accent-2));
    display: flex; align-items: center; justify-content: center;
    color: #0b0f14; font-weight: 800; font-family: "JetBrains Mono", monospace;
  }
  .brand h1 { font-size: 1rem; margin: 0; line-height: 1.1; }
  .brand p { margin: 0; font-size: 0.78rem; color: var(--muted); }
  .search {
    width: 100%; padding: 8px 10px; background: var(--code-bg);
    border: 1px solid var(--border); border-radius: 6px;
    color: var(--text); font-size: 0.85rem; margin-bottom: 16px;
  }
  .search:focus { outline: 1px solid var(--accent); }
  nav.toc ul { list-style: none; padding: 0; margin: 0; }
  nav.toc li { margin: 2px 0; }
  nav.toc a { display: block; padding: 6px 10px; border-radius: 6px; color: var(--text); font-size: 0.88rem; }
  nav.toc a:hover { background: var(--panel-2); text-decoration: none; }
  nav.toc a.active { background: var(--panel-2); color: var(--accent-2); }
  nav.toc .group {
    text-transform: uppercase; letter-spacing: 0.08em;
    font-size: 0.7rem; color: var(--muted); margin: 14px 8px 6px;
  }
  main { padding: 32px 48px 96px; max-width: 1100px; }
  header.hero { padding: 24px 0 12px; border-bottom: 1px solid var(--border); margin-bottom: 24px; }
  header.hero h1 {
    font-size: 2.1rem; margin: 0 0 8px;
    background: linear-gradient(90deg, var(--accent), var(--accent-2));
    -webkit-background-clip: text; background-clip: text; color: transparent;
  }
  header.hero p { color: var(--muted); max-width: 70ch; margin: 0; }
  section { padding: 24px 0; border-bottom: 1px solid var(--border); scroll-margin-top: 20px; }
  section:last-child { border-bottom: none; }
  section h2 { font-size: 1.55rem; margin: 0 0 8px; color: #e8eef6; }
  section h3 { font-size: 1.15rem; margin: 22px 0 8px; color: #e8eef6; }
  section p { margin: 10px 0; }
  .callout {
    border-left: 3px solid var(--accent); background: var(--panel);
    padding: 12px 14px; border-radius: 6px; margin: 14px 0; font-size: 0.94rem;
  }
  .callout.warn { border-color: var(--warn); }
  .callout.danger { border-color: var(--danger); }
  .callout.tip { border-color: var(--accent-2); }
  .callout strong { color: #fff; }
  pre, code { font-family: "JetBrains Mono", "SF Mono", Menlo, Consolas, monospace; }
  pre {
    background: var(--code-bg); border: 1px solid var(--border); border-radius: 8px;
    padding: 14px 16px; overflow-x: auto; font-size: 0.86rem; line-height: 1.55;
  }
  code { background: var(--code-bg); padding: 2px 6px; border-radius: 4px; font-size: 0.86em; }
  pre code { background: transparent; padding: 0; }
  .formula {
    background: var(--panel-2); border: 1px dashed var(--border);
    padding: 10px 14px; border-radius: 6px; margin: 10px 0;
    font-family: "JetBrains Mono", monospace; color: #d6f0e1; font-size: 0.95rem;
  }
  .formula .var { color: #ffd28a; }
  table { width: 100%; border-collapse: collapse; margin: 14px 0; font-size: 0.92rem; }
  th, td { text-align: left; padding: 8px 10px; border-bottom: 1px solid var(--border); }
  th { color: var(--muted); font-weight: 600; }
  .diagram {
    background: var(--panel); border: 1px solid var(--border);
    border-radius: 8px; padding: 16px; margin: 16px 0; text-align: center;
  }
  .diagram svg { max-width: 100%; height: auto; }
  .diagram .caption { color: var(--muted); font-size: 0.85rem; margin-top: 8px; }
  .quiz { background: var(--panel); border: 1px solid var(--border); border-radius: 8px; padding: 16px 18px; margin: 18px 0; }
  .quiz h4 { margin: 0 0 10px; color: var(--accent-2); }
  .quiz .options label {
    display: block; padding: 6px 8px; margin: 4px 0;
    border: 1px solid var(--border); border-radius: 6px; cursor: pointer;
  }
  .quiz .options label:hover { background: var(--panel-2); }
  .quiz .feedback { margin-top: 10px; font-size: 0.9rem; }
  .quiz button {
    margin-top: 10px; background: var(--accent); color: #0b0f14;
    border: none; padding: 6px 12px; border-radius: 6px; font-weight: 600; cursor: pointer;
  }
  .quiz button:hover { filter: brightness(1.1); }
  .correct { color: var(--accent-2); }
  .incorrect { color: var(--danger); }
  .menu-toggle {
    display: none; background: var(--panel); border: 1px solid var(--border);
    color: var(--text); padding: 8px 12px; border-radius: 6px; margin-bottom: 16px; cursor: pointer;
  }
  .progress {
    position: fixed; top: 0; left: 0; right: 0; height: 3px;
    background: var(--accent); transform-origin: left; transform: scaleX(0);
    z-index: 1000; transition: transform 0.1s linear;
  }
  @media (max-width: 900px) {
    .layout { grid-template-columns: 1fr; }
    aside.sidebar {
      position: fixed; top: 0; left: -100%; width: 280px; z-index: 999;
      transition: left 0.25s ease;
    }
    aside.sidebar.open { left: 0; }
    main { padding: 20px; }
    .menu-toggle { display: inline-block; }
  }
  .to-top {
    position: fixed; right: 24px; bottom: 24px;
    background: var(--panel-2); border: 1px solid var(--border); color: var(--text);
    width: 42px; height: 42px; border-radius: 50%;
    display: none; align-items: center; justify-content: center; cursor: pointer; z-index: 50;
  }
  .to-top:hover { background: var(--accent); color: #0b0f14; }
  .to-top.visible { display: flex; }
  details {
    background: var(--panel); border: 1px solid var(--border);
    border-radius: 8px; padding: 10px 14px; margin: 12px 0;
  }
  details summary { cursor: pointer; color: var(--accent-2); font-weight: 600; }
  details[open] summary { margin-bottom: 8px; }
  .glossary-term { color: var(--accent-2); font-weight: 600; }
</style>
</head>
<body>
<div class="progress" id="progress"></div>
<div class="layout">
"""

# ============== SIDEBAR ==============
SIDEBAR = """
  <aside class="sidebar" id="sidebar">
    <div class="brand">
      <div class="brand-mark">μΩ</div>
      <div>
        <h1>Analog Electronics</h1>
        <p>A comprehensive guide</p>
      </div>
    </div>
    <input type="text" class="search" id="search" placeholder="Search the guide…" />
    <nav class="toc" id="toc">
      <div class="group">Foundations</div>
      <ul>
        <li><a href="#intro">Introduction</a></li>
        <li><a href="#basics">Circuit Basics</a></li>
        <li><a href="#laws">Ohm's &amp; Kirchhoff's Laws</a></li>
        <li><a href="#components">Passive Components</a></li>
        <li><a href="#units">Units &amp; Notation</a></li>
      </ul>
      <div class="group">Semiconductors</div>
      <ul>
        <li><a href="#diodes">Diodes</a></li>
        <li><a href="#bjt">BJTs</a></li>
        <li><a href="#fet">FETs / MOSFETs</a></li>
        <li><a href="#thyristors">Thyristors &amp; Triacs</a></li>
      </ul>
      <div class="group">Building Blocks</div>
      <ul>
        <li><a href="#amplifiers">Amplifiers</a></li>
        <li><a href="#opamps">Op-Amps</a></li>
        <li><a href="#filters">Filters</a></li>
        <li><a href="#oscillators">Oscillators</a></li>
        <li><a href="#power">Power Supplies</a></li>
        <li><a href="#signal_cond">Signal Conditioning</a></li>
      </ul>
      <div class="group">Practice &amp; Reference</div>
      <ul>
        <li><a href="#design">Design Workflow</a></li>
        <li><a href="#simulation">Simulation (SPICE)</a></li>
        <li><a href="#troubleshoot">Troubleshooting</a></li>
        <li><a href="#noise">Noise &amp; Thermal</a></li>
        <li><a href="#glossary">Glossary</a></li>
        <li><a href="#cheatsheet">Cheat Sheet</a></li>
        <li><a href="#quiz">Self-Test Quiz</a></li>
      </ul>
    </nav>
  </aside>
"""

HERO = """
  <main>
    <button class="menu-toggle" onclick="document.getElementById('sidebar').classList.toggle('open')">☰ Menu</button>
    <header class="hero">
      <h1>Analog Electronics — A Comprehensive Guide</h1>
      <p>From Ohm's law to op-amp filter design — a deep, practical walkthrough of the continuous-signal circuits that power audio, sensors, power, RF, and instrumentation. Includes schematics, formulas, SPICE snippets, and self-test questions.</p>
    </header>
"""

INTRO = """
    <section id="intro">
      <h2>1. Introduction</h2>
      <p><strong>Analog electronics</strong> deals with continuously varying signals — voltages and currents that can take any value within a range, as opposed to digital signals restricted to discrete levels (0/1). Real-world phenomena (sound, light, temperature, pressure, motion) are inherently analog, so analog circuits are the bridge between the physical world and digital processing.</p>
      <h3>Why analog still matters</h3>
      <ul>
        <li><strong>The physical world is analog.</strong> Every sensor outputs a continuous signal that must be conditioned before an ADC sees it.</li>
        <li><strong>Power electronics is analog.</strong> Motors, converters, regulators — all use analog control loops.</li>
        <li><strong>RF and audio</strong> are still best handled by analog techniques (mixing, filtering, impedance matching).</li>
        <li><strong>Digital ICs contain analog blocks.</strong> PLLs, serializers, I/O buffers — all built from analog primitives.</li>
      </ul>
      <div class="callout tip"><strong>Tip:</strong> Modern design is <em>mixed-signal</em>. You'll typically use analog front-ends feeding ADCs, with a microcontroller or DSP in the middle. Master analog and the whole chain becomes intuitive.</div>
      <h3>What you'll learn</h3>
      <ol>
        <li>The mathematical laws that govern every circuit.</li>
        <li>Behavior and models of resistors, capacitors, inductors, diodes, transistors.</li>
        <li>How to design small-signal amplifiers and op-amp circuits.</li>
        <li>How to build filters, oscillators, and linear regulators.</li>
        <li>A practical workflow: from spec → schematic → SPICE → breadboard → PCB.</li>
      </ol>
    </section>
"""

BASICS = """
    <section id="basics">
      <h2>2. Circuit Basics</h2>
      <h3>Voltage, current, resistance</h3>
      <p>Three foundational quantities:</p>
      <ul>
        <li><strong>Voltage (V)</strong> — electric potential difference, measured in volts [V]. The "push" that drives current.</li>
        <li><strong>Current (I)</strong> — rate of charge flow, measured in amperes [A].</li>
        <li><strong>Resistance (R)</strong> — opposition to current, measured in ohms [Ω].</li>
      </ul>
      <h3>Power &amp; energy</h3>
      <div class="formula">P = V · I &nbsp;&nbsp;=&nbsp;&nbsp; I²·R &nbsp;&nbsp;=&nbsp;&nbsp; V²/R &nbsp;&nbsp;&nbsp; [W, watts]</div>
      <p>Power dissipation in resistors turns electrical energy into heat. Always size resistors with at least 2× safety margin on wattage.</p>
      <h3>AC vs. DC</h3>
      <ul>
        <li><strong>DC (Direct Current):</strong> Constant polarity and magnitude. Batteries, regulated supplies.</li>
        <li><strong>AC (Alternating Current):</strong> Periodically reversing. Mains power, audio, RF.</li>
      </ul>
      <p>For sinusoidal AC of the form <code>v(t) = V<sub>peak</sub>·sin(ωt)</code>:</p>
      <div class="formula">V<sub>rms</sub> = V<sub>peak</sub> / √2 &nbsp;&nbsp;≈&nbsp;&nbsp; 0.707 · V<sub>peak</sub></div>
      <div class="diagram">
        <svg viewBox="0 0 500 160" xmlns="http://www.w3.org/2000/svg">
          <defs>
            <pattern id="grid1" width="25" height="20" patternUnits="userSpaceOnUse">
              <path d="M 25 0 L 0 0 0 20" fill="none" stroke="#2a3340" stroke-width="0.5"/>
            </pattern>
          </defs>
          <rect width="500" height="160" fill="url(#grid1)"/>
          <line x1="20" y1="80" x2="480" y2="80" stroke="#8a96a5" stroke-width="1"/>
          <line x1="250" y1="20" x2="250" y2="140" stroke="#8a96a5" stroke-width="1"/>
          <path d="M 20 80 Q 70 20 120 80 T 220 80 T 320 80 T 420 80 T 480 80" fill="none" stroke="#4ea1ff" stroke-width="2.5"/>
          <text x="240" y="18" fill="#8a96a5" font-size="11">V_peak</text>
          <line x1="245" y1="20" x2="245" y2="80" stroke="#f59e0b" stroke-dasharray="3,3"/>
          <text x="430" y="98" fill="#8a96a5" font-size="11">time →</text>
          <text x="8" y="84" fill="#8a96a5" font-size="11">0</text>
        </svg>
        <div class="caption">A sinusoidal AC signal: peak, RMS, and period.</div>
      </div>
      <h3>Frequency &amp; period</h3>
      <div class="formula">f = 1 / T &nbsp;&nbsp;&nbsp;&nbsp; ω = 2π·f &nbsp;&nbsp;&nbsp;&nbsp; f [Hz], T [s], ω [rad/s]</div>
      <p>Useful reference: 1 kHz has a period of 1 ms. Audio sits in 20 Hz–20 kHz; mains is 50/60 Hz; radio spans kHz to GHz.</p>
    </section>
"""

LAWS = """
    <section id="laws">
      <h2>3. Ohm's Law &amp; Kirchhoff's Laws</h2>
      <h3>Ohm's Law</h3>
      <div class="formula">V = I · R &nbsp;&nbsp;⟹&nbsp;&nbsp; I = V / R &nbsp;&nbsp;⟹&nbsp;&nbsp; R = V / I</div>
      <p>Applies to <em>ohmic</em> conductors (resistors at fixed temperature). It is <strong>not</strong> valid for diodes, transistors, or anything nonlinear without using a small-signal model.</p>
      <h3>Kirchhoff's Current Law (KCL)</h3>
      <p>The sum of currents entering a node equals the sum leaving it.</p>
      <div class="formula">Σ I<sub>in</sub> = Σ I<sub>out</sub></div>
      <h3>Kirchhoff's Voltage Law (KVL)</h3>
      <p>The sum of voltages around any closed loop is zero.</p>
      <div class="formula">Σ V<sub>loop</sub> = 0</div>
      <h3>Worked example: voltage divider</h3>
      <p>The simplest analog circuit: two resistors in series across a supply produce a lower voltage at the midpoint.</p>
      <div class="formula">V<sub>out</sub> = V<sub>in</sub> · <span class="var">R₂</span> / (<span class="var">R₁</span> + <span class="var">R₂</span>)</div>
      <div class="diagram">
        <svg viewBox="0 0 360 180" xmlns="http://www.w3.org/2000/svg">
          <line x1="20" y1="30" x2="20" y2="150" stroke="#d6dde6" stroke-width="2"/>
          <line x1="200" y1="30" x2="200" y2="150" stroke="#d6dde6" stroke-width="2"/>
          <line x1="20" y1="30" x2="200" y2="30" stroke="#d6dde6" stroke-width="2"/>
          <line x1="20" y1="150" x2="200" y2="150" stroke="#d6dde6" stroke-width="2"/>
          <rect x="60" y="20" width="40" height="20" fill="#1c232c" stroke="#6ee7b7"/>
          <text x="65" y="35" fill="#6ee7b7" font-size="12">R1</text>
          <rect x="120" y="20" width="40" height="20" fill="#1c232c" stroke="#6ee7b7"/>
          <text x="125" y="35" fill="#6ee7b7" font-size="12">R2</text>
          <line x1="200" y1="90" x2="260" y2="90" stroke="#4ea1ff" stroke-width="2"/>
          <circle cx="200" cy="90" r="4" fill="#4ea1ff"/>
          <text x="265" y="94" fill="#4ea1ff" font-size="13">Vout</text>
          <text x="30" y="20" fill="#8a96a5" font-size="12">Vin</text>
          <text x="195" y="20" fill="#8a96a5" font-size="12">GND</text>
        </svg>
        <div class="caption">Voltage divider: simple, but only "stiff" when loaded lightly.</div>
      </div>
      <div class="callout warn"><strong>Warning:</strong> A voltage divider's output <em>collapses</em> when you draw current. Use a buffer (op-amp follower) for any non-trivial load.</div>
      <h3>Series and parallel resistors (quick reference)</h3>
      <pre><code>// Quick mental model
Resistors:
  Series:  R_total = R1 + R2 + ...
  Parallel: 1/R_total = 1/R1 + 1/R2 + ...   (R_eq = R1·R2/(R1+R2) for two)
Capacitors:
  Series:  1/C_total = 1/C1 + 1/C2 + ...
  Parallel: C_total = C1 + C2 + ...
Inductors:
  Series:  L_total = L1 + L2 + ...
  Parallel: 1/L_total = 1/L1 + 1/L2 + ...</code></pre>
    </section>
"""

COMPONENTS = """
    <section id="components">
      <h2>4. Passive Components</h2>
      <h3>Resistors</h3>
      <p>Resistors oppose current and drop voltage. Key parameters:</p>
      <ul>
        <li><strong>Resistance</strong> in ohms [Ω], from milliohms (shunts) to gigaohms (sensing).</li>
        <li><strong>Tolerance:</strong> ±1%, ±5%, etc.</li>
        <li><strong>Power rating:</strong> 1/8 W, 1/4 W, 1 W… never exceed 50% in continuous duty.</li>
        <li><strong>Temperature coefficient (TCR):</strong> ppm/°C — critical in precision circuits.</li>
      </ul>
      <h4>E-series preferred values</h4>
      <p>Resistors are made in standard logarithmic steps so that any value can be approximated by combining two values.</p>
      <table>
        <tr><th>Series</th><th>Tolerance</th><th>Values per decade</th></tr>
        <tr><td>E12</td><td>±10%</td><td>12</td></tr>
        <tr><td>E24</td><td>±5%</td><td>24</td></tr>
        <tr><td>E96</td><td>±1%</td><td>96</td></tr>
        <tr><td>E192</td><td>±0.5% (or better)</td><td>192</td></tr>
      </table>
      <h3>Capacitors</h3>
      <p>Capacitors store energy in an electric field. Their impedance depends on frequency:</p>
      <div class="formula">X<sub>C</sub> = 1 / (2π·f·C)</div>
      <p>Common types and trade-offs:</p>
      <table>
        <tr><th>Type</th><th>Range</th><th>Pros</th><th>Cons</th></tr>
        <tr><td>Ceramic (MLCC)</td><td>pF – 100 µF</td><td>Cheap, small, low ESR</td><td>Piezoelectric, voltage coefficient, C0G/NP0 for precision</td></tr>
        <tr><td>Electrolytic (Al)</td><td>1 µF – 1 F</td><td>High capacity, cheap</td><td>Polarized, ESR, leakage, lifetime</td></tr>
        <tr><td>Tantalum</td><td>1 µF – 1000 µF</td><td>Stable, small</td><td>Expensive, can fail short</td></tr>
        <tr><td>Film</td><td>nF – 10 µF</td><td>Precise, stable, AC-rated</td><td>Bulky for high values</td></tr>
      </table>
      <h3>Inductors</h3>
      <p>Inductors store energy in a magnetic field. Their impedance rises with frequency:</p>
      <div class="formula">X<sub>L</sub> = 2π·f·L</div>
      <p>Used in filters, DC-DC converters, and RF circuits. Watch out for <strong>parasitic resistance (DCR)</strong> and <strong>self-resonant frequency (SRF)</strong>.</p>
      <h3>Transformers</h3>
      <p>Two coupled inductors. The turns ratio N<sub>1</sub>/N<sub>2</sub> sets the voltage ratio and (inversely) the current ratio. They also provide <strong>galvanic isolation</strong>, which is invaluable for safety and noise rejection in mains-powered designs.</p>
    </section>
"""

UNITS = """
    <section id="units">
      <h2>5. Units, Notation &amp; Prefixes</h2>
      <p>Analog electronics is a quantitative discipline — sloppy notation causes real bugs. Here's the convention used throughout this guide.</p>
      <h3>SI prefixes</h3>
      <table>
        <tr><th>Prefix</th><th>Symbol</th><th>Factor</th><th>Example</th></tr>
        <tr><td>nano</td><td>n</td><td>10⁻⁹</td><td>10 nF = 0.01 µF</td></tr>
        <tr><td>micro</td><td>µ</td><td>10⁻⁶</td><td>100 µA</td></tr>
        <tr><td>milli</td><td>m</td><td>10⁻³</td><td>3.3 mA</td></tr>
        <tr><td>kilo</td><td>k</td><td>10³</td><td>4.7 kΩ</td></tr>
        <tr><td>mega</td><td>M</td><td>10⁶</td><td>1 MΩ</td></tr>
        <tr><td>giga</td><td>G</td><td>10⁹</td><td>1 GHz</td></tr>
      </table>
      <h3>Lower-case vs. upper-case</h3>
      <ul>
        <li><strong>DC</strong> quantities (constants or averages): upper-case — V, I, R.</li>
        <li><strong>AC / instantaneous</strong> values: lower-case — v(t), i(t).</li>
        <li><strong>Peak</strong> amplitudes: V<sub>pk</sub>, V<sub>pp</sub> (peak-to-peak).</li>
        <li><strong>RMS</strong> (heating equivalent): V<sub>rms</sub>.</li>
      </ul>
      <h3>Decibels (dB)</h3>
      <div class="formula">Gain<sub>dB</sub> = 20·log<sub>10</sub>(A<sub>v</sub>) &nbsp;&nbsp; (voltage ratio)<br/>Gain<sub>dB</sub> = 10·log<sub>10</sub>(P<sub>out</sub>/P<sub>in</sub>) &nbsp;&nbsp; (power ratio)</div>
      <p>Useful reference: +3 dB ≈ ×2 in power, +6 dB ≈ ×2 in voltage, +20 dB = ×10, −20 dB = ÷10.</p>
    </section>
"""

DIODES = """
    <section id="diodes">
      <h2>6. Diodes</h2>
      <p>A diode is a one-way valve for current — it conducts when forward-biased (anode more positive than cathode by ~0.6–0.7 V for silicon) and blocks reverse current up to its <strong>breakdown voltage</strong>.</p>
      <h3>I-V characteristic</h3>
      <div class="diagram">
        <svg viewBox="0 0 500 220" xmlns="http://www.w3.org/2000/svg">
          <line x1="250" y1="20" x2="250" y2="200" stroke="#8a96a5"/>
          <line x1="20" y1="160" x2="480" y2="160" stroke="#8a96a5"/>
          <text x="455" y="178" fill="#8a96a5" font-size="11">V</text>
          <text x="252" y="32" fill="#8a96a5" font-size="11">I</text>
          <text x="20" y="175" fill="#8a96a5" font-size="11">0</text>
          <path d="M 250 160 L 270 160 Q 290 159 300 145 Q 320 110 380 50" fill="none" stroke="#6ee7b7" stroke-width="2.5"/>
          <path d="M 250 160 L 230 160 Q 210 161 200 165 Q 180 170 150 170" fill="none" stroke="#ef4444" stroke-width="2.5"/>
          <text x="320" y="80" fill="#6ee7b7" font-size="12">Forward</text>
          <text x="160" y="190" fill="#ef4444" font-size="12">Reverse (leakage)</text>
          <text x="270" y="155" fill="#ffd28a" font-size="11">~0.7V</text>
        </svg>
        <div class="caption">Diode I-V curve: sharp turn-on around 0.6–0.7 V.</div>
      </div>
      <h3>Shockley equation</h3>
      <div class="formula">I<sub>D</sub> = I<sub>S</sub> · ( e<sup>V<sub>D</sub>/(n·V<sub>T</sub>)</sup> − 1 )</div>
      <p>Where I<sub>S</sub> is saturation current (~10⁻¹⁵ A for small signal diodes), n is the ideality factor (~1–2), and V<sub>T</sub> = kT/q ≈ 26 mV at 25°C.</p>
      <h3>Common diode types</h3>
      <table>
        <tr><th>Type</th><th>Use</th></tr>
        <tr><td>Rectifier (1N400x)</td><td>AC to DC conversion in power supplies</td></tr>
        <tr><td>Schottky</td><td>Low forward drop (~0.3 V), fast switching</td></tr>
        <tr><td>Zener</td><td>Voltage reference / regulator (reverse biased)</td></tr>
        <tr><td>TVS</td><td>Transient suppression / ESD protection</td></tr>
        <tr><td>LED</td><td>Light emitter; V<sub>f</sub> depends on color</td></tr>
        <tr><td>Photodiode</td><td>Light sensor (reverse-biased or photovoltaic)</td></tr>
      </table>
      <h3>Half-wave rectifier (worked example)</h3>
      <pre><code>      D1
  ────►|──── Vout
  │         │
 Vin       Rload
  │         │
  └─────────┘</code></pre>
      <p>During the positive half-cycle, D1 conducts and V<sub>out</sub> ≈ V<sub>in</sub> − 0.7 V. During the negative half-cycle, D1 blocks and V<sub>out</sub> = 0. To smooth the output, add a capacitor — a <em>peak detector</em>.</p>
      <div class="formula">V<sub>ripple</sub> ≈ I<sub>load</sub> / (f · C)</div>
      <h3>Zener regulator (simple, low-power)</h3>
      <p>Below the Zener voltage V<sub>Z</sub>, the diode is off. Reverse-biased past V<sub>Z</sub>, the voltage is clamped near V<sub>Z</sub> (within tolerance and current range). Always include a series resistor to limit current:</p>
      <div class="formula">R<sub>series</sub> = (V<sub>in</sub> − V<sub>Z</sub>) / (I<sub>load</sub> + I<sub>Z,min</sub>)</div>
    </section>
"""

BJT = """
    <section id="bjt">
      <h2>7. Bipolar Junction Transistors (BJTs)</h2>
      <p>A BJT is a current-controlled device with three terminals: <strong>Base (B)</strong>, <strong>Collector (C)</strong>, and <strong>Emitter (E)</strong>. There are two flavors: <em>NPN</em> (current flows in) and <em>PNP</em> (current flows out).</p>
      <h3>Operating regions</h3>
      <table>
        <tr><th>Region</th><th>B-E</th><th>B-C</th><th>Use</th></tr>
        <tr><td>Cutoff</td><td>Reverse</td><td>Reverse</td><td>Switch OFF</td></tr>
        <tr><td>Active (forward)</td><td>Forward</td><td>Reverse</td><td>Amplifier</td></tr>
        <tr><td>Saturation</td><td>Forward</td><td>Forward</td><td>Switch ON</td></tr>
      </table>
      <h3>Key equations (NPN, active region)</h3>
      <div class="formula">
        I<sub>C</sub> = β · I<sub>B</sub> &nbsp;&nbsp; (β typically 50–400)<br/>
        I<sub>E</sub> = I<sub>C</sub> + I<sub>B</sub> &nbsp; ≈ I<sub>C</sub><br/>
        V<sub>BE</sub> ≈ 0.7 V (silicon)
      </div>
      <h3>Common-emitter amplifier (small signal)</h3>
      <pre><code>      Rc
  Vcc ──┬──┐
        │  │
        │  ├── C
        │  │       B
   Rb   │  │       │
 Vbb ──┤  │   ─────┤
        │  │   │    │
        │  │   Rb2  Q1 (NPN)
        │  │   │    │
        │  │   ─────┤ E
        │  │        │
        │  │       Re
        │  │        │
        └──────────┴── GND</code></pre>
      <h3>Small-signal parameters</h3>
      <div class="formula">
        g<sub>m</sub> = I<sub>C</sub> / V<sub>T</sub> &nbsp;&nbsp; (V<sub>T</sub> ≈ 26 mV at 25°C)<br/>
        r<sub>π</sub> = β / g<sub>m</sub><br/>
        r<sub>e</sub> = V<sub>T</sub> / I<sub>E</sub> &nbsp; (intrinsic emitter resistance)
      </div>
      <p>Voltage gain of a CE stage with emitter degeneration (bypass capacitor across R<sub>E</sub>):</p>
      <div class="formula">A<sub>v</sub> ≈ − R<sub>C</sub> / r<sub>e</sub></div>
      <div class="callout"><strong>Biasing matters.</strong> Without a stable bias point, the transistor drifts with temperature (the "thermal runaway" problem). Always use a divider + emitter resistor or a current mirror to set the Q-point reliably.</div>
      <h3>Transistor as a switch (saturation)</h3>
      <p>To turn an NPN fully ON, drive enough base current that I<sub>B</sub> ≥ I<sub>C,sat</sub>/β<sub>forced</sub> (use β<sub>forced</sub> ≈ 10 for hard saturation). V<sub>CE,sat</sub> ≈ 0.2 V, V<sub>BE,sat</sub> ≈ 0.8 V.</p>
    </section>
"""

FET = """
    <section id="fet">
      <h2>8. Field-Effect Transistors (FETs &amp; MOSFETs)</h2>
      <p>FETs are <em>voltage-controlled</em>: the gate voltage creates an electric field that controls current between source and drain. They have very high input impedance — easy to drive from high-impedance sources.</p>
      <h3>Types</h3>
      <ul>
        <li><strong>JFET</strong> — depletion-mode only; usually n-channel (2N3819, etc.).</li>
        <li><strong>MOSFET</strong> — either depletion or enhancement; the workhorse of modern electronics.</li>
        <li><strong>Enhancement-mode n-MOS</strong> — turns ON when V<sub>GS</sub> &gt; V<sub>th</sub> (~1–4 V). Used in digital and switching.</li>
        <li><strong>Power MOSFET</strong> — large die area, low R<sub>DS(on)</sub>, used as switches in motor drivers and SMPS.</li>
      </ul>
      <h3>Square-law equation (saturation)</h3>
      <div class="formula">I<sub>D</sub> = ½ · μ·C<sub>ox</sub>·(W/L)·(V<sub>GS</sub> − V<sub>th</sub>)² &nbsp; (long-channel)</div>
      <p>Transconductance:</p>
      <div class="formula">g<sub>m</sub> = 2·I<sub>D</sub> / (V<sub>GS</sub> − V<sub>th</sub>)</div>
      <h3>MOSFET as a switch</h3>
      <p>For a low-side n-MOS switch driving a load to V+:</p>
      <pre><code>     Load (e.g. motor)
 V+ ────┐
        │
        ├── Drain
       Q1 (n-MOS)
        ├── Source
        │── GND
       Gate
        │
   (from MCU IO, 0 or 3.3V)</code></pre>
      <p>When V<sub>GS</sub> &gt; V<sub>th</sub>, the MOSFET is fully on and R<sub>DS(on)</sub> is in the milliohm range. Power dissipated: P = I²·R<sub>DS(on)</sub>.</p>
      <div class="callout warn"><strong>Gate care:</strong> MOSFET gates are sensitive to ESD. Always handle by the case, and consider a 100 Ω gate resistor + 10 kΩ pull-down to keep the device off during power-up.</div>
    </section>
"""

THYRISTORS = """
    <section id="thyristors">
      <h2>9. Thyristors &amp; Triacs</h2>
      <p>Thyristors are latching switches. Once triggered, they stay on until the current through them falls below the <em>holding current</em>.</p>
      <h3>SCR (Silicon Controlled Rectifier)</h3>
      <p>A four-layer (PNPN) device. Conducts only one direction. Triggered by a small gate current when forward-biased. Used in DC latching, crowbars, and phase-controlled motor drives.</p>
      <h3>Triac</h3>
      <p>Essentially two SCRs in anti-parallel — conducts in both directions. The workhorse of AC light dimmers and small AC motor speed controls.</p>
      <h3>Phase-angle control (dimmer)</h3>
      <p>Fire the triac at a controlled delay after each zero-crossing of the AC mains. The earlier the firing angle, the more power is delivered. Watch for EMI from the fast edges — RC snubbers are mandatory.</p>
      <div class="callout danger"><strong>Safety:</strong> Mains-voltage circuits are <em>lethal</em>. Always use an isolation transformer, proper enclosure, and current-limited protection when experimenting.</div>
    </section>
"""

AMPLIFIERS = """
    <section id="amplifiers">
      <h2>10. Amplifiers</h2>
      <p>An amplifier takes a small signal and produces a larger one, ideally without distortion. We classify amplifiers by their <strong>small-signal parameters</strong>:</p>
      <div class="formula">
        A<sub>v</sub> = v<sub>out</sub> / v<sub>in</sub> &nbsp; (voltage gain, V/V)<br/>
        A<sub>i</sub> = i<sub>out</sub> / i<sub>in</sub> &nbsp; (current gain, A/A)<br/>
        A<sub>p</sub> = A<sub>v</sub>·A<sub>i</sub> &nbsp;&nbsp; (power gain, W/W)<br/>
        Gain(dB) = 20·log<sub>10</sub>(A<sub>v</sub>) &nbsp; (for voltage)
      </div>
      <h3>The four ideal amplifier types</h3>
      <table>
        <tr><th>Type</th><th>Input Z</th><th>Output Z</th><th>Use</th></tr>
        <tr><td>Voltage amp</td><td>∞</td><td>0</td><td>Sensor buffering</td></tr>
        <tr><td>Current amp</td><td>0</td><td>∞</td><td>Driving low-Z loads</td></tr>
        <tr><td>Transconductance (V→I)</td><td>∞</td><td>∞</td><td>Op-amp with R in feedback</td></tr>
        <tr><td>Transresistance (I→V)</td><td>0</td><td>0</td><td>Photodiode amp</td></tr>
      </table>
      <h3>Classes of operation</h3>
      <ul>
        <li><strong>Class A:</strong> Conduction angle 360°. High linearity, low efficiency (~25%).</li>
        <li><strong>Class B:</strong> 180° — push-pull. ~78% theoretical efficiency. Crossover distortion at zero crossing.</li>
        <li><strong>Class AB:</strong> Small bias to remove crossover. Compromise; standard for audio.</li>
        <li><strong>Class C:</strong> &lt; 180°. High efficiency, very distorted — used with RF tank circuits.</li>
        <li><strong>Class D:</strong> Switching (PWM). &gt;90% efficiency. Audio after low-pass filter.</li>
      </ul>
      <h3>Common amplifier topologies</h3>
      <table>
        <tr><th>Topology</th><th>Transistor</th><th>Use</th></tr>
        <tr><td>Common emitter (CE)</td><td>BJT</td><td>Voltage amp, inverting</td></tr>
        <tr><td>Common base (CB)</td><td>BJT</td><td>Current buffer, high-freq</td></tr>
        <tr><td>Common collector (CC) / emitter follower</td><td>BJT</td><td>Buffer, gain ≈ 1</td></tr>
        <tr><td>Common source (CS)</td><td>FET</td><td>Voltage amp, inverting</td></tr>
        <tr><td>Source follower</td><td>FET</td><td>Buffer, high input Z</td></tr>
        <tr><td>Differential pair</td><td>2× BJT/FET</td><td>Input stage of op-amps</td></tr>
        <tr><td>Push-pull</td><td>2× BJTs</td><td>Class B/AB output stage</td></tr>
      </table>
    </section>
"""

OPAMPS = """
    <section id="opamps">
      <h2>11. Operational Amplifiers (Op-Amps)</h2>
      <p>The op-amp is the most ubiquitous analog building block. An <em>ideal</em> op-amp has infinite input impedance, zero output impedance, and infinite open-loop gain. Real op-amps (e.g. LM358, TL072, OPA2227, AD8628) approximate this within their specs.</p>
      <h3>The "golden rules" of ideal op-amp analysis</h3>
      <ol>
        <li>The output does whatever it takes to make <code>V+ = V−</code> (in negative feedback).</li>
        <li>No current flows into the input terminals.</li>
      </ol>
      <h3>Essential circuits</h3>
      <h4>Inverting amplifier</h4>
      <div class="formula">V<sub>out</sub> = −(R<sub>f</sub>/R<sub>in</sub>) · V<sub>in</sub></div>
      <pre><code>      Rf
 Vin ──/\/\/──┐──┐
              │  ├──┬── Vout
             ─┴─ │  │
             ─┴─ │  │  (op-amp)
              │  │  │
              └──┴──┘ (inverting input; non-inv tied to GND)</code></pre>
      <h4>Non-inverting amplifier</h4>
      <div class="formula">V<sub>out</sub> = (1 + R<sub>f</sub>/R<sub>g</sub>) · V<sub>in</sub></div>
      <h4>Voltage follower (buffer)</h4>
      <p>Gain = 1. Used to isolate high-impedance sources from low-impedance loads.</p>
      <h4>Summing amplifier</h4>
      <div class="formula">V<sub>out</sub> = −(V<sub>1</sub>·R<sub>f</sub>/R<sub>1</sub> + V<sub>2</sub>·R<sub>f</sub>/R<sub>2</sub> + V<sub>3</sub>·R<sub>f</sub>/R<sub>3</sub>)</div>
      <h4>Difference amplifier</h4>
      <p>Subtracts two inputs. With R<sub>1</sub>=R<sub>2</sub> and R<sub>3</sub>=R<sub>4</sub>:</p>
      <div class="formula">V<sub>out</sub> = (V<sub>2</sub> − V<sub>1</sub>) · (R<sub>3</sub>/R<sub>1</sub>)</div>
      <h4>Integrator &amp; differentiator</h4>
      <pre><code>Integrator:     C in feedback → Vout = -1/(RC) ∫ Vin dt
Differentiator: C at input    → Vout = -RC · dVin/dt</code></pre>
      <h4>Instrumentation amplifier</h4>
      <p>Three op-amps forming a high-CMRR differential amp with very high input impedance. Standard for sensor signal conditioning (strain gauges, thermocouples, EKG).</p>
      <h3>Real-world op-amp limitations</h3>
      <table>
        <tr><th>Spec</th><th>What it means</th></tr>
        <tr><td>Input offset voltage (V<sub>os</sub>)</td><td>Small mismatch; output sits ≠ 0 when input is 0</td></tr>
        <tr><td>Input bias current (I<sub>b</sub>)</td><td>DC current into inputs; matters with high-Z sources</td></tr>
        <tr><td>Slew rate (SR)</td><td>Max dV/dt of output; limits large-signal bandwidth</td></tr>
        <tr><td>Gain-bandwidth product (GBW)</td><td>Unity-gain frequency; sets max useful frequency</td></tr>
        <tr><td>CMRR / PSRR</td><td>Rejection of common-mode / supply noise</td></tr>
        <tr><td>Rail-to-rail?</td><td>Can output swing to both supply rails?</td></tr>
      </table>
      <div class="callout tip"><strong>Design rule:</strong> Always include a feedback network that keeps the DC gain low (e.g. 1–10) so offsets and bias currents don't saturate the output. Use precision op-amps (e.g. OPA227, LT1012) when V<sub>os</sub> matters.</div>
    </section>
"""

FILTERS = """
    <section id="filters">
      <h2>12. Filters</h2>
      <p>Filters shape the frequency content of a signal. Four basic types:</p>
      <table>
        <tr><th>Type</th><th>Passes</th><th>Rejects</th></tr>
        <tr><td>Low-pass (LPF)</td><td>Below f<sub>c</sub></td><td>Above f<sub>c</sub></td></tr>
        <tr><td>High-pass (HPF)</td><td>Above f<sub>c</sub></td><td>Below f<sub>c</sub></td></tr>
        <tr><td>Band-pass (BPF)</td><td>f<sub>1</sub> to f<sub>2</sub></td><td>Outside</td></tr>
        <tr><td>Band-stop (notch)</td><td>Outside f<sub>1</sub>–f<sub>2</sub></td><td>Between</td></tr>
      </table>
      <h3>First-order RC low-pass</h3>
      <div class="formula">f<sub>c</sub> = 1 / (2π·R·C) &nbsp;&nbsp; (−3 dB cutoff, 20 dB/decade roll-off)</div>
      <h3>Second-order Sallen-Key (active)</h3>
      <p>Op-amp-based filter with adjustable Q and gain. Reference circuit (LPF):</p>
      <pre><code>     C1      R1
Vin ──||──┬──/\/\/──┐
         │          ├──┐
         │       C2 │  ├── +V
         │          │  │\
         │       R2 │  │ \──┬── Vout
         │          │  │ /   │
         └──────────┤  │/    │
                    ─┴─      │
                              │
            (FB from Vout to − input via Rf/Rg)</code></pre>
      <p>Butterworth response (Q = 0.707) is achieved when R<sub>1</sub> = R<sub>2</sub> = R and C<sub>1</sub> = C<sub>2</sub> = C, with closed-loop gain = 1 (unity-gain follower).</p>
      <h3>Butterworth vs. Chebyshev vs. Bessel</h3>
      <ul>
        <li><strong>Butterworth:</strong> Maximally flat passband, moderate roll-off. Best general-purpose choice.</li>
        <li><strong>Chebyshev:</strong> Sharper roll-off, but passband ripple. Use when steepness matters more than flatness.</li>
        <li><strong>Bessel:</strong> Linear phase (no pulse distortion). Best for time-domain signals (audio, data).</li>
      </ul>
      <h3>Higher-order filters</h3>
      <p>Cascade multiple 2nd-order stages. Each stage contributes 12 dB/octave. A 4th-order filter has 24 dB/octave roll-off, which is typical for high-quality audio crossovers.</p>
      <div class="callout"><strong>Worked design — audio anti-alias LPF:</strong> Sample rate f<sub>s</sub> = 48 kHz. Place cutoff at f<sub>c</sub> = 20 kHz. Use a 2nd-order Sallen-Key Butterworth. Pick C = 1 nF, then R = 1/(2π·f<sub>c</sub>·C) ≈ 7.96 kΩ (use 8.06 kΩ E96).</div>
    </section>
"""

OSCILLATORS = """
    <section id="oscillators">
      <h2>13. Oscillators</h2>
      <p>An oscillator generates a periodic waveform without an input. The <strong>Barkhausen criterion</strong>: a positive-feedback loop oscillates when loop gain ≥ 1 and phase shift = 0 (or 360°).</p>
      <h3>Classic topologies</h3>
      <table>
        <tr><th>Topology</th><th>Frequency</th><th>Use</th></tr>
        <tr><td>RC phase-shift</td><td>Audio</td><td>Simple sine</td></tr>
        <tr><td>Wien bridge</td><td>Audio</td><td>Low-distortion sine (test gear)</td></tr>
        <tr><td>LC (Colpitts / Hartley)</td><td>RF</td><td>Radio frequencies</td></tr>
        <tr><td>Crystal (Pierce / Colpitts)</td><td>kHz – MHz</td><td>Accurate clock reference</td></tr>
        <tr><td>Relaxation (astable)</td><td>Wide</td><td>Square / triangle wave</td></tr>
        <tr><td>555 timer</td><td>&lt; 100 kHz typ.</td><td>Square / pulse generation</td></tr>
        <tr><td>VCO</td><td>Voltage-tuned</td><td>PLL, FM, function generators</td></tr>
      </table>
      <h3>Wien bridge oscillator</h3>
      <p>Uses a non-inverting amp with positive feedback through a frequency-selective Wien network:</p>
      <div class="formula">f<sub>0</sub> = 1 / (2π·R·C)</div>
      <p>The classic gain-of-3 requirement is met with a non-inverting amp using a non-linear element (lamp, JFET, diodes) in the feedback to stabilize amplitude.</p>
      <h3>555 astable (square wave)</h3>
      <pre><code>     R1     R2
 Vcc ─/\/\/──┬──/\/\/──┐
             │          │
             │       ───┤
             │      D   │
             │  ┌──|>|──┤
             │  │       │
             │ ─┴─ C    │
             │ Dis  Thr │
             │  7   6   │
             │   \  |   │
             │    555   │
             │        3├──── Vout
             GND      8├──── Vcc
                     1├── GND</code></pre>
      <div class="formula">f = 1.44 / ((R1 + 2·R2)·C)<br/>Duty = (R1 + R2) / (R1 + 2·R2)</div>
      <h3>Crystal oscillators</h3>
      <p>A quartz crystal is a mechanical resonator with extremely high Q (10 000–100 000+). It sets a precise frequency. Pierce oscillators use two inverters (or one inverting gate) plus two small capacitors. Most microcontrollers have an internal Pierce oscillator driver — just add a crystal and load caps.</p>
      <h3>PLL (Phase-Locked Loop)</h3>
      <p>A PLL compares a reference clock to a divided-down VCO. The phase detector output drives the VCO until the phases match. PLLs are used for frequency synthesis, clock recovery, and demodulation.</p>
    </section>
"""

POWER = """
    <section id="power">
      <h2>14. Power Supplies &amp; Regulation</h2>
      <h3>Linear regulator (e.g. LM7805)</h3>
      <p>Simple, low-noise, but inefficient: excess voltage × current = heat.</p>
      <pre><code>Vin ──[LM7805]── +5V
            │
           GND</code></pre>
      <p>Dropout voltage is typically 2 V. If you need low dropout (e.g. 3.3 V from a Li-ion cell), use an <strong>LDO</strong> like the LM1117 or TPS7A47.</p>
      <h3>Key regulator specs</h3>
      <ul>
        <li><strong>Dropout voltage</strong> — minimum (V<sub>in</sub> − V<sub>out</sub>).</li>
        <li><strong>Line regulation</strong> — output change vs. input change.</li>
        <li><strong>Load regulation</strong> — output change vs. current.</li>
        <li><strong>PSRR</strong> — rejection of input ripple at a given frequency.</li>
      </ul>
      <h3>Switch-mode power supply (SMPS)</h3>
      <p>Switching regulators are 85–95% efficient. Topologies:</p>
      <ul>
        <li><strong>Buck (step-down):</strong> Output &lt; input. Most common.</li>
        <li><strong>Boost (step-up):</strong> Output &gt; input. Battery applications.</li>
        <li><strong>Buck-boost:</strong> Output can be either side of input.</li>
        <li><strong>Flyback / forward:</strong> Isolated; used for offline AC-DC.</li>
      </ul>
      <h3>Buck converter (ideal)</h3>
      <div class="formula">V<sub>out</sub> = D · V<sub>in</sub> &nbsp;&nbsp; (D = duty cycle, 0–1)</div>
      <p>Use an IC like the LM2596, TPS5430, or LT8606 for typical designs. Always include input bulk + bypass capacitors and an inductor rated for the peak current with low DCR.</p>
      <div class="callout warn"><strong>Heatsinking:</strong> Linear regulators can dissipate many watts. Calculate P = (V<sub>in</sub> − V<sub>out</sub>)·I<sub>load</sub>, and use a heatsink with R<sub>θ</sub> &lt; (T<sub>j,max</sub> − T<sub>amb</sub>)/P.</div>
      <h3>Battery basics</h3>
      <ul>
        <li><strong>Li-ion:</strong> 3.6–4.2 V/cell, 150–250 Wh/kg, needs protection circuit.</li>
        <li><strong>LiPo:</strong> Same chemistry, pouch form factor.</li>
        <li><strong>NiMH:</strong> 1.2 V/cell nominal, robust, no protection needed.</li>
        <li><strong>Lead-acid:</strong> 2.0 V/cell, heavy, but cheap and high-current.</li>
      </ul>
    </section>
"""

SIGNAL_COND = """
    <section id="signal_cond">
      <h2>15. Signal Conditioning</h2>
      <p>Sensor signals are messy. The analog front-end cleans them up before they reach an ADC.</p>
      <h3>Common tasks</h3>
      <ul>
        <li><strong>Amplification</strong> — match the sensor's range to the ADC's full scale.</li>
        <li><strong>Filtering</strong> — anti-aliasing, noise reduction, bandwidth limiting.</li>
        <li><strong>Level shifting</strong> — translate a ±10 V sensor signal to 0–3.3 V for the ADC.</li>
        <li><strong>Isolation</strong> — optocouplers, transformers, or isolation amplifiers to break ground loops.</li>
        <li><strong>Linearization</strong> — for nonlinear sensors (thermistors, RTDs).</li>
      </ul>
      <h3>Bridge amplifier (strain gauge / load cell)</h3>
      <p>A Wheatstone bridge converts a small resistance change into a differential voltage. An instrumentation amp (e.g. INA128) amplifies the difference with high CMRR.</p>
      <div class="formula">V<sub>out</sub> = V<sub>excitation</sub> · (ΔR / (4·R)) · Gain</div>
      <h3>Thermistor readout</h3>
      <p>Use a precision resistor divider with the thermistor. The output is nonlinear; linearize in software with a Steinhart-Hart fit, or use a resistor pair to linearize over a narrow range.</p>
      <h3>4–20 mA current loop</h3>
      <p>Industrial standard for analog signals over long distances. 4 mA = zero, 20 mA = full scale. The current is immune to voltage drop on the wires; you sense it with a small shunt resistor at the receiver.</p>
    </section>
"""

DESIGN = """
    <section id="design">
      <h2>16. Design Workflow</h2>
      <p>A disciplined process saves you from spaghetti circuits:</p>
      <ol>
        <li><strong>Define the spec.</strong> Gain, bandwidth, supply voltage, load, input signal range, accuracy, temperature range.</li>
        <li><strong>Choose topology.</strong> Non-inverting op-amp, instrumentation amp, Sallen-Key, etc.</li>
        <li><strong>Pick components.</strong> Op-amp with sufficient GBW and SR. Resistors with proper tolerance. Capacitors with appropriate dielectric.</li>
        <li><strong>Hand-calculate key values.</strong> Gain, cutoff frequencies, bias currents, expected power dissipation.</li>
        <li><strong>Simulate in SPICE</strong> (see next section).</li>
        <li><strong>Build and measure.</strong> Breadboard, then PCB. Compare to sim and to spec.</li>
        <li><strong>Iterate.</strong> Trim values, swap components, address EMC / thermal issues.</li>
      </ol>
      <h3>Example: design a non-inverting audio preamp</h3>
      <p><strong>Spec:</strong> Gain = 10, f<sub>c</sub> &gt; 50 kHz, single supply +5 V, input ±100 mV, output &lt; 2 V<sub>pp</sub>.</p>
      <p><strong>Pick:</strong> TL072 (GBW = 3 MHz, SR = 13 V/µs, low noise).</p>
      <p><strong>Compute:</strong> For gain = 1 + R<sub>f</sub>/R<sub>g</sub> = 10, choose R<sub>g</sub> = 10 kΩ, R<sub>f</sub> = 90 kΩ. AC-coupled input via 10 µF cap with 100 kΩ bias return to mid-rail (a buffered 2.5 V reference).</p>
      <p><strong>Check:</strong> GBW/10 = 300 kHz &gt; 50 kHz ✓. Output 1 V<sub>pp</sub> needs slew &gt; 2π·50 kHz·0.5 V = 0.16 V/µs ✓.</p>
    </section>
"""

SIMULATION = """
    <section id="simulation">
      <h2>17. Circuit Simulation with SPICE</h2>
      <p>SPICE (Simulation Program with Integrated Circuit Emphasis) is the industry-standard analog simulator. Modern free variants: <strong>LTspice</strong> (Analog Devices), <strong>ngspice</strong> (open source), <strong>QUCS-S</strong>.</p>
      <h3>A simple netlist (RC low-pass)</h3>
      <pre><code>* RC low-pass filter
V1 in 0 SIN(0 1 1k)        ; 1 kHz sine, 1 V amplitude
R1 in out 1k
C1 out 0 100n
.TRAN 10us 5ms
.PROBE
.END</code></pre>
      <h3>Useful analyses</h3>
      <table>
        <tr><th>Analysis</th><th>Command</th><th>Use</th></tr>
        <tr><td>DC operating point</td><td>.OP</td><td>Bias voltages and currents</td></tr>
        <tr><td>DC sweep</td><td>.DC</td><td>Transfer curves, I-V</td></tr>
        <tr><td>AC analysis</td><td>.AC</td><td>Bode plot (gain/phase vs. freq)</td></tr>
        <tr><td>Transient</td><td>.TRAN</td><td>Time-domain waveform</td></tr>
        <tr><td>Noise</td><td>.NOISE</td><td>Output noise spectral density</td></tr>
        <tr><td>Monte Carlo</td><td>.MC</td><td>Effect of component tolerances</td></tr>
      </table>
      <h3>Convergence tips</h3>
      <ul>
        <li>Add <code>.OPTIONS RELTOL=0.001 ABSTOL=1p VNTOL=1u</code>.</li>
        <li>Use <code>UIC</code> on the <code>.TRAN</code> line for switching circuits with ideal switches.</li>
        <li>Always double-check simulation results against hand calculations.</li>
      </ul>
    </section>
"""

TROUBLESHOOT = """
    <section id="troubleshoot">
      <h2>18. Troubleshooting</h2>
      <p>When the circuit doesn't work, be a detective. Follow the signal path and check DC bias first, then AC behavior.</p>
      <h3>Systematic procedure</h3>
      <ol>
        <li><strong>Power.</strong> Measure supply rails. Are they where you expect? Check for shorts (low ohms across the rail with the board unpowered).</li>
        <li><strong>Bench setup.</strong> Verify function generator, scope probes (ground clip!), power supply current limit.</li>
        <li><strong>DC bias.</strong> Probe each node with a multimeter. Compare to your hand-calculated voltages.</li>
        <li><strong>AC path.</strong> Inject a small sine at the input. Trace with the scope from input → output.</li>
        <li><strong>Look for oscillation or noise.</strong> If you see HF garbage on a "DC" node, you may have an uncompensated op-amp or a power-supply resonance.</li>
        <li><strong>Replace suspect parts.</strong> Electrolytic caps dry out; tantalums can fail short; solder joints crack.</li>
      </ol>
      <h3>Common gotchas</h3>
      <div class="callout danger"><strong>Gotcha #1 — floating input.</strong> An op-amp input with no DC path to either rail will drift to a rail and saturate. Always provide a bias return (high-value resistor to mid-rail or to ground).</div>
      <div class="callout warn"><strong>Gotcha #2 — scope probe ground lead.</strong> The 6-inch clip lead adds ~10 nH of inductance — enough to create ringing on fast edges. Use a ground spring or probe tip adapter for HF.</div>
      <div class="callout"><strong>Gotcha #3 — bypass capacitors.</strong> Every IC needs a 100 nF ceramic close to its supply pin. Decoupling is not optional.</div>
      <div class="callout warn"><strong>Gotcha #4 — loading the divider.</strong> Your "1.65 V reference" becomes "0.8 V" the moment you connect a 10 kΩ load. Buffer it!</div>
      <div class="callout"><strong>Gotcha #5 — ground loops.</strong> When interfacing separate instruments, use a star ground or differential measurement. Otherwise 50 Hz hum appears out of nowhere.</div>
    </section>
"""

NOISE = """
    <section id="noise">
      <h2>19. Noise &amp; Thermal Effects</h2>
      <p>Every resistor, transistor, and wire generates noise. In low-level analog design, noise — not bandwidth — often limits performance.</p>
      <h3>Sources of noise</h3>
      <ul>
        <li><strong>Thermal (Johnson) noise:</strong> Every resistor has a noise voltage independent of current.</li>
        <li><strong>Shot noise:</strong> Discrete electrons crossing a junction.</li>
        <li><strong>Flicker (1/f) noise:</strong> Dominates at low frequencies. Worse in transistors and some op-amps.</li>
        <li><strong>Popcorn noise:</strong> Random step changes; a manufacturing defect.</li>
      </ul>
      <h3>Johnson noise formula</h3>
      <div class="formula">V<sub>n,rms</sub> = √(4·k·T·R·Δf)</div>
      <p>Where k = 1.38·10⁻²³ J/K, T in K, R in Ω, Δf in Hz. At room temperature, 1 kΩ produces ~4 nV/√Hz.</p>
      <h3>Signal-to-noise ratio (SNR)</h3>
      <div class="formula">SNR (dB) = 20·log<sub>10</sub>(V<sub>signal</sub> / V<sub>noise</sub>)</div>
      <p>An N-bit ADC has theoretical SNR ≈ 6.02·N + 1.76 dB. A 16-bit ADC tops out around 98 dB SNR.</p>
      <h3>Noise figure (cascaded stages)</h3>
      <p>Friis' formula: the noise figure of the first stage dominates. Put a low-noise amp (LNA) with low noise figure <em>first</em> in the chain.</p>
    </section>
"""

GLOSSARY = """
    <section id="glossary">
      <h2>20. Glossary</h2>
      <dl>
        <dt><span class="glossary-term">Bandwidth</span></dt><dd>The frequency range over which a circuit meets its spec, usually the −3 dB points.</dd>
        <dt><span class="glossary-term">Bias</span></dt><dd>DC operating point of an active device.</dd>
        <dt><span class="glossary-term">CMRR</span></dt><dd>Common-mode rejection ratio. How well a differential amp rejects signals common to both inputs.</dd>
        <dt><span class="glossary-term">DCR</span></dt><dd>DC resistance of an inductor's winding.</dd>
        <dt><span class="glossary-term">ESR</span></dt><dd>Equivalent series resistance of a capacitor (loss).</dd>
        <dt><span class="glossary-term">Headroom</span></dt><dd>Margin between signal peak and supply rail.</dd>
        <dt><span class="glossary-term">LDO</span></dt><dd>Low-dropout linear regulator.</dd>
        <dt><span class="glossary-term">PSRR</span></dt><dd>Power-supply rejection ratio. How much supply noise leaks into the output.</dd>
        <dt><span class="glossary-term">Q (quality factor)</span></dt><dd>Ratio of stored energy to dissipated energy per cycle. High-Q filters are narrow and peaky.</dd>
        <dt><span class="glossary-term">SRF</span></dt><dd>Self-resonant frequency of a capacitor or inductor — where parasitics take over.</dd>
        <dt><span class="glossary-term">Transconductance (g<sub>m</sub>)</span></dt><dd>Change in output current per change in input voltage. Units: siemens (S) or A/V.</dd>
      </dl>
    </section>
"""

CHEATSHEET = """
    <section id="cheatsheet">
      <h2>21. Cheat Sheet</h2>
      <table>
        <tr><th>Topic</th><th>Key formula</th></tr>
        <tr><td>Resistors in series</td><td>R<sub>tot</sub> = R<sub>1</sub> + R<sub>2</sub> + …</td></tr>
        <tr><td>Resistors in parallel (2)</td><td>R<sub>eq</sub> = R<sub>1</sub>R<sub>2</sub> / (R<sub>1</sub> + R<sub>2</sub>)</td></tr>
        <tr><td>Capacitor energy</td><td>E = ½·C·V²</td></tr>
        <tr><td>Inductor energy</td><td>E = ½·L·I²</td></tr>
        <tr><td>RC time constant</td><td>τ = R·C</td></tr>
        <tr><td>Capacitive reactance</td><td>X<sub>C</sub> = 1 / (2πfC)</td></tr>
        <tr><td>Inductive reactance</td><td>X<sub>L</sub> = 2πfL</td></tr>
        <tr><td>Thermal noise</td><td>V<sub>n</sub> = √(4·k·T·R·Δf)</td></tr>
        <tr><td>BJT transconductance</td><td>g<sub>m</sub> = I<sub>C</sub> / V<sub>T</sub></td></tr>
        <tr><td>MOSFET transconductance</td><td>g<sub>m</sub> = 2·I<sub>D</sub> / (V<sub>GS</sub> − V<sub>th</sub>)</td></tr>
        <tr><td>Non-inverting gain</td><td>A = 1 + R<sub>f</sub>/R<sub>g</sub></td></tr>
        <tr><td>Inverting gain</td><td>A = −R<sub>f</sub>/R<sub>in</sub></td></tr>
        <tr><td>RMS of sine</td><td>V<sub>rms</sub> = V<sub>pk</sub>/√2</td></tr>
        <tr><td>Skin depth (copper)</td><td>δ ≈ 66 mm · √(1/f)</td></tr>
        <tr><td>ADC SNR</td><td>≈ 6.02·N + 1.76 dB</td></tr>
        <tr><td>dB ↔ ratio (voltage)</td><td>dB = 20·log<sub>10</sub>(A)</td></tr>
      </table>
    </section>
"""

QUIZ = """
    <section id="quiz">
      <h2>22. Self-Test Quiz</h2>
      <p>Test what you've learned. Click an answer, then "Check".</p>

      <div class="quiz" data-correct="b">
        <h4>Q1. In a common-emitter BJT amplifier, the voltage gain is approximately:</h4>
        <div class="options">
          <label><input type="radio" name="q1" value="a"> (A) +R<sub>C</sub>/r<sub>e</sub> (in-phase)</label>
          <label><input type="radio" name="q1" value="b"> (B) −R<sub>C</sub>/r<sub>e</sub> (inverted)</label>
          <label><input type="radio" name="q1" value="c"> (C) β·R<sub>C</sub></label>
          <label><input type="radio" name="q1" value="d"> (D) 1 + R<sub>C</sub>/R<sub>E</sub></label>
        </div>
        <button onclick="checkAnswer(this)">Check</button>
        <div class="feedback"></div>
      </div>

      <div class="quiz" data-correct="c">
        <h4>Q2. A non-inverting op-amp with R<sub>f</sub> = 90 kΩ and R<sub>g</sub> = 10 kΩ has a closed-loop gain of:</h4>
        <div class="options">
          <label><input type="radio" name="q2" value="a"> (A) 1</label>
          <label><input type="radio" name="q2" value="b"> (B) 9</label>
          <label><input type="radio" name="q2" value="c"> (C) 10</label>
          <label><input type="radio" name="q2" value="d"> (D) 90</label>
        </div>
        <button onclick="checkAnswer(this)">Check</button>
        <div class="feedback"></div>
      </div>

      <div class="quiz" data-correct="a">
        <h4>Q3. An RC low-pass filter with R = 10 kΩ and C = 10 nF has a −3 dB cutoff frequency of approximately:</h4>
        <div class="options">
          <label><input type="radio" name="q3" value="a"> (A) 1.59 kHz</label>
          <label><input type="radio" name="q3" value="b"> (B) 15.9 kHz</label>
          <label><input type="radio" name="q3" value="c"> (C) 159 kHz</label>
          <label><input type="radio" name="q3" value="d"> (D) 1.59 MHz</label>
        </div>
        <button onclick="checkAnswer(this)">Check</button>
        <div class="feedback"></div>
      </div>

      <div class="quiz" data-correct="d">
        <h4>Q4. Which topology has the highest theoretical efficiency for audio amplification?</h4>
        <div class="options">
          <label><input type="radio" name="q4" value="a"> (A) Class A</label>
          <label><input type="radio" name="q4" value="b"> (B) Class AB</label>
          <label><input type="radio" name="q4" value="c"> (C) Class B</label>
          <label><input type="radio" name="q4" value="d"> (D) Class D</label>
        </div>
        <button onclick="checkAnswer(this)">Check</button>
        <div class="feedback"></div>
      </div>

      <div class="quiz" data-correct="b">
        <h4>Q5. In an ideal op-amp with negative feedback:</h4>
        <div class="options">
          <label><input type="radio" name="q5" value="a"> (A) The two inputs have very different voltages</label>
          <label><input type="radio" name="q5" value="b"> (B) V+ ≈ V− and no current flows into the inputs</label>
          <label><input type="radio" name="q5" value="c"> (C) The output is always saturated</label>
          <label><input type="radio" name="q5" value="d"> (D) Current flows freely into both inputs</label>
        </div>
        <button onclick="checkAnswer(this)">Check</button>
        <div class="feedback"></div>
      </div>

      <div class="quiz" data-correct="c">
        <h4>Q6. A voltage divider with R1 = R2 across 5 V produces:</h4>
        <div class="options">
          <label><input type="radio" name="q6" value="a"> (A) 1.25 V</label>
          <label><input type="radio" name="q6" value="b"> (B) 2.5 V</label>
          <label><input type="radio" name="q6" value="c"> (C) 5 V</label>
          <label><input type="radio" name="q6" value="d"> (D) 0 V</label>
        </div>
        <button onclick="checkAnswer(this)">Check</button>
        <div class="feedback"></div>
      </div>
    </section>
"""

FOOTER = """
    <footer style="margin-top: 60px; color: var(--muted); font-size: 0.85rem; text-align: center;">
      <p>Analog Electronics — A Comprehensive Guide. Built as a single-file HTML reference. No external dependencies.</p>
    </footer>
  </main>
</div>

<button class="to-top" id="toTop" onclick="window.scrollTo({top:0, behavior:'smooth'})" title="Back to top">↑</button>

<script>
  // -------- Smooth scroll with active section highlighting --------
  const tocLinks = document.querySelectorAll('nav.toc a');
  const sections = Array.from(tocLinks).map(a => document.querySelector(a.getAttribute('href')));
  function setActive() {
    const y = window.scrollY + 100;
    let current = sections[0];
    for (const s of sections) {
      if (s && s.offsetTop <= y) current = s;
    }
    tocLinks.forEach(a => a.classList.remove('active'));
    if (current) {
      const id = current.id;
      const link = document.querySelector('nav.toc a[href="#' + id + '"]');
      if (link) link.classList.add('active');
    }
  }
  const progress = document.getElementById('progress');
  function setProgress() {
    const h = document.documentElement.scrollHeight - window.innerHeight;
    const p = h > 0 ? window.scrollY / h : 0;
    progress.style.transform = 'scaleX(' + p + ')';
  }
  const toTop = document.getElementById('toTop');
  function setToTop() {
    if (window.scrollY > 400) toTop.classList.add('visible');
    else toTop.classList.remove('visible');
  }
  window.addEventListener('scroll', () => { setActive(); setProgress(); setToTop(); });
  window.addEventListener('load', () => { setActive(); setProgress(); });
  const search = document.getElementById('search');
  search.addEventListener('input', e => {
    const q = e.target.value.toLowerCase();
    document.querySelectorAll('nav.toc li').forEach(li => {
      const text = li.textContent.toLowerCase();
      li.style.display = text.includes(q) || q === '' ? '' : 'none';
    });
    document.querySelectorAll('nav.toc .group').forEach(g => {
      let ul = g.nextElementSibling;
      if (!ul) return;
      const anyVisible = Array.from(ul.querySelectorAll('li')).some(li => li.style.display !== 'none');
      g.style.display = anyVisible ? '' : 'none';
    });
  });
  function checkAnswer(btn) {
    const quiz = btn.closest('.quiz');
    const correct = quiz.dataset.correct;
    const selected = quiz.querySelector('input[type=radio]:checked');
    const feedback = quiz.querySelector('.feedback');
    if (!selected) {
      feedback.textContent = 'Please select an option.';
      feedback.className = 'feedback';
      return;
    }
    if (selected.value === correct) {
      feedback.textContent = '✓ Correct!';
      feedback.className = 'feedback correct';
    } else {
      feedback.textContent = '✗ Not quite. The correct answer is (' + correct.toUpperCase() + ').';
      feedback.className = 'feedback incorrect';
    }
  }
</script>
</body>
</html>
"""

PAGE += SIDEBAR + HERO + INTRO + BASICS + LAWS + COMPONENTS + UNITS + DIODES + BJT + FET + THYRISTORS
PAGE += AMPLIFIERS + OPAMPS + FILTERS + OSCILLATORS + POWER + SIGNAL_COND
PAGE += DESIGN + SIMULATION + TROUBLESHOOT + NOISE + GLOSSARY + CHEATSHEET + QUIZ + FOOTER

with open('/Users/michal/analog-electronics-guide/index.html', 'w') as f:
    f.write(PAGE)

print(f"Generated: {len(PAGE):,} chars, {PAGE.count(chr(10)):,} lines")
