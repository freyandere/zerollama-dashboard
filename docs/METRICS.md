# Notes: Dashboard Metrics & Server Idle Behavior

This document explains dashboard metric calculations and answers common questions regarding server idle states and speed differences.

## 1. Why do metrics stay filled when the server is idle?

If you notice that **Generation tok/s** and **Prompt tok/s** show active values (e.g. `131 tok/s` and `7.07k tok/s`) even when the server console states `all slots are idle`, this is normal server behavior:

* **Speed Metrics are Latching Gauges**:
  In the Llama server (`llama-server` / `zerollama`), the Prometheus metrics `llamacpp:predicted_tokens_seconds` and `llamacpp:prompt_tokens_seconds` behave as **latches**. They hold the speed/throughput value of the **most recent active task**. The server does not reset these rate values to zero when the slots transition to idle. They will stay flat until a new task triggers a recalculation.
* **Instantaneous Active Load**:
  To confirm if the server is actively processing tasks, refer to the **Processing** (`Обработка`) and **Deferred** (`Отложено`) cards. These metrics correctly drop to `0` when there are no active requests in flight.
* **Cumulative Counters**:
  Metrics like *Prompt total*, *Predicted total*, *Decode calls*, and *Time totals* are cumulative values representing overall engine statistics since the server started. They naturally stay at their accumulated values and do not reset to 0.

## 2. Why does the dashboard display different speeds than the console log?

You may notice minor speed differences between slot logs in the terminal (`tg = 121.48 t/s`) and the dashboard dashboard metrics (`133 tok/s`):

* **Instantaneous vs. Sliding Average**:
  The console log prints the **instantaneous raw processing speed** of the GPU/CPU for that specific batch/request.
  The dashboard retrieves stats from `/metrics` (Prometheus), which are computed by the server as a **smoothed sliding window average** over a rolling time window (e.g., last 5–10 seconds).
* **Ingestion Overhead**:
  For prompt processing, the raw batch ingestion speed in the console log (e.g. `7459 t/s`) represents the pure inference rate, whereas the Prometheus rate (e.g. `7.07k t/s`) includes network payload latency, tokenization parsing, and initial request setup overheads.
