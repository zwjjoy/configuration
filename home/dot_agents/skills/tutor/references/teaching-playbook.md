# Teaching playbook

Load when choosing difficulty, writing hints, designing questions, or running review.

## Hint ladder

Climb one rung per failed attempt. Stop as soon as the learner moves.

1. **Re-point**: restate the question, highlight the condition they skipped ("What happens if the write is still in flight?").
2. **Narrow**: shrink the scenario (3 replicas → 2, concurrent writes → one write).
3. **Contrast**: show a near case where their assumption *does* hold, ask what differs.
4. **Partial worked step**: do the first step, ask them to finish.
5. **Reveal**: full answer with the causal chain, then a fresh isomorphic question to confirm.

Skip straight to 5 if the learner asks, or after two rungs with no movement and visible frustration.

## Question design

Prefer questions whose answer exposes the learner's model, not their recall.

| Type | Shape | Good for |
|---|---|---|
| Predict | "Given this state table, what does the read return?" | can apply |
| Explain | "Why does R + W > N matter? What breaks if it doesn't hold?" | can explain |
| Counterexample | "Construct a history where W=2, R=2, N=3 still returns stale data." | can reason |
| Discriminate | "This system needs X. Quorum or consensus? Why?" | interleaving, transfer |
| Debug | "Users report lost updates under load. Here's the config. Where do you look?" | can transfer |
| Design | "Pick N/R/W for a read-heavy cache that tolerates 1 failure." | can transfer |

Rules:
- One question per turn. No compound "and also" questions.
- State assumptions in the question (failure model, timing, concurrency) so a wrong answer reveals a wrong model, not an ambiguous prompt.
- Avoid multiple choice unless testing a fine discrimination between two confusable ideas.
- Don't telegraph the answer with the question wording.

## Difficulty calibration

- Two correct answers with good reasoning → jump a level (skip to boundaries or transfer).
- Correct answer, weak reasoning → mark `provisional`, ask a contrasting question.
- Wrong answer → diagnose (below), drop one level of abstraction, keep the same example.
- Repeated wrong on the same point → change representation (state table ↔ timeline ↔ code ↔ analogy).

## Error correction

1. Name the specific wrong assumption, not "not quite". Example: "You're assuming the read sees writes that haven't been acked yet."
2. Show the minimal case where that assumption fails.
3. Ask a revised question that only passes if the assumption is fixed.

Common misconception patterns:
- Treating a sufficient condition as necessary (or vice versa).
- Ignoring in-flight / concurrent operations.
- Confusing a guarantee with a typical behaviour.
- Conflating the analogy with the mechanism.
- Applying a technique outside its assumptions (e.g. strict quorum reasoning on a sloppy quorum).

## Review logic

Order for `/tutor review`:
1. Concepts marked `provisional` or with a recorded misconception.
2. Oldest concepts not reviewed recently.
3. Confusable pairs, interleaved (ask the learner to pick which applies).
4. Recently learned material, last.

Always retrieval first: ask before explaining. If they recall correctly, push one level higher instead of re-teaching.

Spacing is illustrative: roughly 1 day, 3 days, 1 week, 2 weeks, widening on success, resetting on failure. Adjust to the learner's actual schedule.

## Scaffolding fade

Worked example → same example with one step blanked → same structure, new numbers → new scenario, no hint about which technique applies.

## Response examples

**New topic opener** (`/tutor System Design > Replication > Quorums`):

> **You are here:** System Design > Distributed Systems > Replication > Quorums
> **Why it matters:** How can a replicated store stay available when nodes fail, yet still return recent writes?
> **Prerequisites:** replication basics, what "acknowledged write" means.
> **Core idea:** Write to W of N replicas, read from R. If R + W > N, every read set overlaps every write set in at least one replica, so a completed write is visible to later reads.
> Example: N=3, W=2, R=2. Write v2 lands on A, B. Read hits B, C. B has v2, versions resolve to v2.
> **Your turn:** With N=3, W=1, R=1, describe a sequence where a read misses a completed write.

**Why question** (`/tutor why do we need R + W > N?`): answer directly with the overlap argument and one counterexample where it fails. No quiz unless it clearly helps.

**Wrong answer handling:**

> You said the read returns v2. That assumes the read set includes a replica that has v2. With W=1, only A has it, and the read hit C. What's the smallest change to W or R that forces overlap?
