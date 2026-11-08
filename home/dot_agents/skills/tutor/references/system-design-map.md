# System design starter map

A starting graph, not an official syllabus. Revise to the learner's goal (interviews, production work, research).

Notation: `A > B` = hierarchy. `needs:` = prerequisites. `see also:` = cross-links / confusable concepts.

## Foundations
- Networking basics (TCP/UDP, latency vs bandwidth, DNS, HTTP)
- Storage basics (disk vs memory, pages, B-trees, LSM trees)
- Concurrency basics (races, locks, atomicity)
- Back-of-envelope estimation (QPS, storage, bandwidth)

## Building blocks
- Load balancing (L4 vs L7, consistent hashing) — needs: networking
- Caching (cache-aside, write-through, eviction, invalidation) — see also: consistency models
- Databases > SQL vs NoSQL, indexing, transactions (ACID, isolation levels) — needs: storage basics
- Message queues and logs (at-least-once, ordering, Kafka-style partitions) — see also: idempotency
- Object/blob storage, CDNs
- Rate limiting (token bucket, leaky bucket)

## Distributed systems
- Failure models (crash-stop, crash-recovery, Byzantine; partial failure)
- Time and order > physical clocks, Lamport clocks, vector clocks — needs: failure models
- Replication > leader-follower, multi-leader, leaderless
  - Quorums (N, R, W; sloppy quorums, hinted handoff, read repair) — needs: replication, versioning — see also: consensus
- Partitioning / sharding (range, hash, rebalancing) — see also: consistent hashing
- Consistency models (linearizability, sequential, causal, eventual, read-your-writes) — needs: time and order
- CAP and PACELC — needs: consistency models, failure models
- Consensus (Paxos, Raft; leader election, log replication) — needs: failure models, replication — see also: quorums
- Distributed transactions (2PC, sagas) — needs: transactions, consensus
- Idempotency and exactly-once effects — see also: message queues

## Design practice
- Requirements → API → data model → high-level design → bottlenecks → trade-offs
- Classic exercises: URL shortener, rate limiter, news feed, chat, distributed KV store, notification system

## Confusable pairs (good for interleaving)
- Quorum vs consensus
- Replication vs partitioning
- Linearizability vs serializability
- Consistent hashing vs range partitioning
- At-least-once delivery vs idempotent processing
- Cache-aside vs write-through
