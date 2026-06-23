# Technical Reading Framework (Matheus Edition)

> Objective: transform technical reading from passive consumption into active model building.

---

# Core Principles

Before every reading session, remember:

* I am **not** trying to memorize everything.
* I am trying to build **mental models**.
* Confusion is useful — it reveals gaps.
* If I cannot explain something simply, I probably do not understand it yet.

---

# Session Workflow

Each reading session has 5 phases.

---

## Phase 1 — Define Intent (2–5 min)

Before opening the chapter, ask:

### Why am I reading this?

Choose one:

* [ ] Build foundational knowledge
* [ ] Solve a practical problem
* [ ] Understand a concept deeply
* [ ] Connect theory to work experience

Write it down.

### Session Goal

Example:

* Understand TCP slow start
* Understand how interpreters evaluate expressions
* Understand replication in distributed databases

---

## Phase 2 — Active Reading (30–60 min)

Read slowly.

While reading, keep looking for:

### A) Central Idea

Ask:

> What is the single most important idea here?

Try to compress the chapter into 1 sentence.

Example:

> TCP prioritizes reliability and congestion control, often trading throughput for stability.

---

### B) New Concepts

List unfamiliar concepts.

Example:

* congestion window
* head-of-line blocking
* abstract syntax tree
* continuation passing

Do NOT deep dive into all of them immediately.

Just mark them.

---

### C) Confusion Markers

Whenever confused, write:

## Confusion

* I don’t understand X
* Why does Y happen?
* What problem does Z solve?

Confusion is not failure.
Confusion is data.

---

## Phase 3 — Book Closed Recall (10–20 min)

IMPORTANT:
Close the book completely.

Now answer from memory.

---

### Explain it in your own words

Without looking:

> How would I explain this to another engineer?

Write 1–3 paragraphs.

No jargon unless you truly understand it.

Use simple language.

Bad:

> TCP uses congestion avoidance and flow control.

Better:

> TCP avoids overwhelming the network by starting cautiously and increasing traffic gradually.

---

### Compression Exercise

Fill these:

## 5 bullets

* What did I learn?
* What surprised me?
* What confused me?
* What seems important?
* What do I still need to revisit?

---

## Phase 4 — Reality Connection (10 min)

Ask:

> Where have I seen this in real life?

This is crucial.

Connect theory to:

* work incidents
* bugs
* architecture decisions
* production failures

Examples:

### Networking

* ECONNRESET
* timeout
* latency spike
* TLS overhead

### Backend

* race conditions
* retries
* duplicate requests
* dead letters

### Frontend

* render cycles
* event loop
* async behavior

Write:

## Real-world connections

* This reminds me of...
* I saw this when...
* This may explain...

---

## Phase 5 — Output / Artifact (Optional but Powerful)

Produce something.

Choose ONE.

---

### Option A — Notes

Minimal notes in your own words.

---

### Option B — Diagram

Example:

Browser
↓ DNS
↓ TCP
↓ TLS
↓ HTTP
Server

---

### Option C — Teach Someone (Preferred)

Explain to:

* a colleague
* ChatGPT
* imaginary student

Use:

> My current understanding is...

Then challenge it.

---

# Weekly Review (Highly Recommended)

At the end of each week:

Review all sessions.

For each chapter ask:

### Level 1

Can I recognize the concept?

### Level 2

Can I explain it?

### Level 3

Can I apply it?

Score:

* 1 = Recognize
* 2 = Explain
* 3 = Apply

Goal is not perfection.

Goal is movement toward Level 3.

---

# Anti-Patterns (Avoid)

## 1. Completion addiction

Bad mindset:

> I need to finish the book.

Better:

> I need to understand the ideas.

---

## 2. Highlighting everything

If everything is important, nothing is important.

---

## 3. Reading for speed

These are not novels.

Slow reading is acceptable.

---

## 4. Confusing familiarity with understanding

Dangerous thought:

> This sounds familiar, so I understand it.

Test by explaining.

---

# Personal Reminder

Deep technical books are recursive.

You will revisit them.

The first pass builds vocabulary.
The second pass builds understanding.
The third pass builds intuition.

Do not expect mastery in one read.

Your goal is not to know everything.

Your goal is to progressively think like a systems engineer.
