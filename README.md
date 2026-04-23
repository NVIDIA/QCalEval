# QCalEval

[![License](https://img.shields.io/badge/License-Apache%202.0-blue.svg)](LICENSE)
[![Dataset](https://img.shields.io/badge/HuggingFace-QCalEval-yellow.svg)](https://huggingface.co/datasets/nvidia/QCalEval)

Evaluation scripts for the [QCalEval](https://huggingface.co/datasets/nvidia/QCalEval) benchmark — a dataset for assessing vision-language model capabilities on quantum calibration experiment analysis. Data is loaded directly from HuggingFace. Compatible with any OpenAI-compatible API endpoint.

## Top 5 Models (Zero-Shot, April 2026)

Based on the QCalEval benchmark findings, we release [NVIDIA Ising Calibration 1](https://huggingface.co/nvidia/ising-calibration-1-35b-a3b), an open-weight 35B MoE model fine-tuned for zero-shot quantum calibration plot understanding.

![QCalEval Zero-Shot Leaderboard — Top 5 Models](leaderboard_top5.svg)

| Label | Question | Task |
|-------|----------|------|
| Tech. Desc. | Q1 | Structured JSON description of plot type, axes, and salient visual features |
| Exp. Status | Q2 | 4-way outcome classification: expected behavior, suboptimal parameters, anomalous behavior, or apparatus issue |
| Reasoning | Q3 | Experiment-specific scientific analysis: what the pattern implies, whether the sweep is sufficient, and what calibration step follows |
| Fit Rel. | Q4 | Assess whether a visible fit is trustworthy for downstream use: reliable, unreliable, or no fit |
| Param. Ext. | Q5 | Extract family-specific physical parameters into structured JSON |
| Cal. Diag. | Q6 | Assign a family-specific status code (e.g., SUCCESS, NO_SIGNAL) with corrective action |

## Zero-Shot Leaderboard (April 2026)

Scores are per-question averages (0–100), judged by GPT-5.4.

| Type | Model | Mean | Q1 | Q2 | Q3 | Q4 | Q5 | Q6 |
|------|-------|-----:|---:|---:|---:|---:|---:|---:|
| NVIDIA | **Ising-Cal-1-35B** | **74.7** | 87.8 | **67.1** | **64.7** | **90.5** | 62.5 | **75.3** |
| Closed | Gemini-3.1-Pro | 72.3 | 88.5 | 57.2 | 61.1 | 84.4 | **71.5** | 71.2 |
| Open | Gemma-4-31B-IT | 68.8 | 85.6 | 54.3 | 59.8 | 82.7 | 68.3 | 62.1 |
| Closed | Gemini-3.1-Flash-Lite | 68.2 | 89.2 | 53.5 | 59.4 | 82.7 | 63.8 | 60.9 |
| Closed | Claude Opus 4.6 | 67.8 | 90.8 | 49.0 | 65.5 | 76.1 | 64.7 | 60.5 |
| Closed | Claude Sonnet 4.6 | 66.5 | 89.7 | 48.6 | 63.4 | 76.5 | 60.4 | 60.1 |
| Closed | GPT-5.4 | 64.6 | **90.9** | 52.7 | 63.7 | 54.7 | 64.3 | 61.3 |
| Open | Qwen3.5-397B-A17B | 58.6 | 88.1 | 42.8 | 52.0 | 50.6 | 62.5 | 55.6 |
| Open | Qwen3.5-27B | 58.5 | 87.0 | 45.7 | 48.3 | 56.4 | 58.7 | 55.1 |
| Open | Qwen3.5-122B-A10B | 57.1 | 86.6 | 44.0 | 49.0 | 50.2 | 61.2 | 51.9 |
| Closed | GPT-5.4-Mini | 55.7 | 90.3 | 39.5 | 48.3 | 42.0 | 62.6 | 51.4 |
| Open | Qwen3.5-35B-A3B | 55.5 | 86.8 | 39.9 | 45.7 | 52.7 | 57.8 | 50.6 |
| Open | Qwen3.5-9B | 53.0 | 81.5 | 37.9 | 39.5 | 49.8 | 57.1 | 52.3 |
| Closed | Claude Haiku 4.5 | 50.5 | 83.4 | 36.6 | 40.8 | 48.6 | 51.0 | 42.8 |
| Open | InternVL3-78B | 48.2 | 76.3 | 37.0 | 34.1 | 42.8 | 52.9 | 45.7 |
| Open | MiniCPM-o-4.5 | 44.5 | 76.7 | 31.7 | 29.8 | 32.5 | 47.9 | 48.1 |
| Open | InternVL3-38B | 44.1 | 79.2 | 34.6 | 27.6 | 33.7 | 49.2 | 40.3 |
| Open | Kimi-VL-A3B | 38.9 | 65.0 | 34.6 | 22.1 | 35.0 | 38.9 | 37.4 |

## In-Context Learning (ICL) Leaderboard (April 2026)

In ICL mode, the model receives labeled demonstration examples from the same experiment family before the query plot — showing what a correct answer looks like for similar data. Q3 and Q6 use N-way demonstrations (multiple examples from the family), while Q5 uses a single 1-shot demonstration with the extraction schema. Delta shows change from zero-shot.

| Type | Model | Mean | Q3 | Delta | Q5 | Delta | Q6 | Delta |
|------|-------|-----:|----|------:|----|------:|----|------:|
| Closed | Gemini-3.1-Pro | **85.2** | 81.3 | +20.2 | **84.5** | +13.0 | **89.8** | +18.6 |
| Closed | Claude Opus 4.6 | 85.1 | **84.7** | +19.2 | 81.3 | +16.6 | 89.4 | +28.9 |
| Open | Gemma-4-31B-IT | 81.2 | 80.6 | +20.8 | 76.9 | +8.6 | 86.0 | +23.9 |
| Closed | GPT-5.4 | 78.4 | 81.0 | +17.3 | 72.9 | +8.6 | 81.4 | +20.1 |
| Closed | Gemini-3.1-Flash-Lite | 78.1 | 78.5 | +19.1 | 73.6 | +9.8 | 82.2 | +21.3 |
| Closed | Claude Sonnet 4.6 | 75.9 | 77.8 | +14.4 | 71.9 | +11.5 | 78.0 | +17.9 |
| Closed | GPT-5.4-Mini | 66.1 | 58.8 | +10.5 | 72.7 | +10.1 | 66.9 | +15.5 |
| Closed | Claude Haiku 4.5 | 66.0 | 66.1 | +25.3 | 58.7 | +7.7 | 73.1 | +30.3 |
| Open | InternVL3-38B | 56.9 | 56.2 | +28.6 | 59.5 | +10.3 | 55.1 | +14.8 |
| Open | Qwen3.5-27B | 53.0 | 41.8 | -6.5 | 71.5 | +12.8 | 45.8 | -9.3 |
| Open | Qwen3.5-397B-A17B | 48.0 | 37.4 | -14.6 | 64.3 | +1.8 | 42.4 | -13.2 |
| Open | InternVL3-78B | 47.0 | 50.5 | +16.4 | 46.2 | -6.7 | 44.3 | -1.4 |
| Open | Qwen3.5-122B-A10B | 44.6 | 36.1 | -12.9 | 62.5 | +1.3 | 35.2 | -16.7 |
| Open | Qwen3.5-35B-A3B | 43.9 | 33.4 | -12.3 | 64.4 | +6.6 | 33.9 | -16.7 |
| Open | Qwen3.5-9B | 43.2 | 32.8 | -6.7 | 63.0 | +5.9 | 33.9 | -18.4 |
| Open | Kimi-VL-A3B | 40.6 | 34.9 | +12.8 | 54.3 | +15.4 | 32.6 | -4.8 |
| Open | MiniCPM-o-4.5 | 33.0 | 19.3 | -10.5 | 50.5 | +2.6 | 29.2 | -18.9 |

## Setup

```bash
pip install -r requirements.txt
```

Or with Nix (flakes enabled):

```bash
nix develop                   # dev shell with all dependencies
nix run .#zeroshot -- --help  # also: .#icl, .#judge
```

## Scripts

### benchmark_zeroshot.py — Zero-shot evaluation

Sends each image + question independently (6 requests per entry).

```bash
# OpenAI API
python benchmark_zeroshot.py \
  --api-base https://api.openai.com/v1/chat/completions \
  --model-id gpt-5.4 \
  --api-key-env OPENAI_API_KEY \
  --output results_zeroshot.json

# Local vLLM / NIM endpoint
python benchmark_zeroshot.py \
  --api-base http://localhost:8000/v1/chat/completions \
  --model-id my-model \
  --api-key dummy \
  --output results_zeroshot.json

# With options
python benchmark_zeroshot.py \
  --api-base https://api.openai.com/v1/chat/completions \
  --model-id gpt-5.4 \
  --concurrency 128 \
  --limit 10 \
  --output results.json
```

### benchmark_icl.py — In-context learning (ICL) evaluation

Runs 3 questions per entry (Q3, Q5, Q6) with in-context demonstration examples.

```bash
python benchmark_icl.py \
  --api-base https://api.openai.com/v1/chat/completions \
  --model-id gpt-5.4 \
  --api-key-env OPENAI_API_KEY \
  --output results_icl.json

# For models that use thinking tokens (e.g., Qwen3.5)
python benchmark_icl.py \
  --api-base http://localhost:8000/v1/chat/completions \
  --model-id my-model \
  --api-key dummy \
  --no-think \
  --output results_icl.json
```

### benchmark_judge.py — Scoring

Scores model responses against ground truth. Uses a combination of programmatic scoring and LLM-based key point evaluation. Works with both zero-shot and ICL results.

```bash
# Score using OpenAI as judge
python benchmark_judge.py results_zeroshot.json \
  --judge-api-base https://api.openai.com/v1/chat/completions \
  --judge-model-id gpt-5.4 \
  --judge-api-key-env OPENAI_API_KEY \
  --output judged.json

# Score ICL results
python benchmark_judge.py results_icl.json \
  --judge-api-base https://api.openai.com/v1/chat/completions \
  --judge-model-id gpt-5.4 \
  --concurrency 16 \
  --output judged_icl.json
```

## Evaluation Pipeline

```
benchmark_zeroshot.py / benchmark_icl.py
        |
        v
  results.json  (model responses)
        |
        v
  benchmark_judge.py
        |
        v
  judged.json   (per-question scores + aggregates)
```

## Common Arguments

| Argument | Description |
|----------|-------------|
| `--api-base` | API endpoint URL (OpenAI-compatible `/v1/chat/completions`) |
| `--model-id` | Model identifier to send in API requests |
| `--api-key-env` | Environment variable containing API key (default: `OPENAI_API_KEY`) |
| `--api-key` | API key directly (prefer `--api-key-env`) |
| `--concurrency` | Max concurrent API requests (default: 8) |
| `--max-tokens` | Max tokens per response (default: 16384) |
| `--limit` | Max entries to evaluate (for testing) |
| `--no-think` | Disable thinking for reasoning models (e.g., Qwen3.5) |
| `--output` | Output JSON path (required) |

## Scoring

| Question | Task | Scoring Method |
|----------|------|----------------|
| Q1 | Technical Description (JSON) | 50% programmatic + 50% LLM key points |
| Q2 | Outcome Classification | Exact match (4-way) |
| Q3 | Scientific Reasoning | LLM key points (3-item checklist) |
| Q4 | Fit Reliability Assessment | Exact match (3-way) |
| Q5 | Parameter Extraction (JSON) | Per-field tolerance scoring |
| Q6 | Calibration Diagnosis | Exact match (status code) |

ICL mode scores Q3, Q5, Q6 only.

## Output Format

Inference scripts produce JSON with:
```json
{
  "mode": "zeroshot",
  "model": "gpt-5.4",
  "results": [
    {
      "id": "drag_failure_no_signal_a",
      "experiment_type": "drag_failure_no_signal",
      "responses": {
        "technical_description": {"answer": "...", "error": null},
        "experimental_conclusion": {"answer": "...", "error": null},
        ...
      }
    }
  ]
}
```

Judge produces JSON with per-question scores (0-100) and aggregates.

## Citation

```bibtex
@misc{cao2026qcaleval,
  title  = {QCalEval: Benchmarking Vision-Language Models for Quantum Calibration Plot Understanding},
  author = {Cao, Shuxiang and Zhang, Zijian and others},
  year   = {2026},
  url    = {https://research.nvidia.com/publication/2026-04_qcaleval-benchmarking-vision-language-models-quantum-calibration-plot},
}
```

## License

The evaluation scripts are licensed under [Apache 2.0](LICENSE). The QCalEval dataset is licensed under [CC BY 4.0](https://creativecommons.org/licenses/by/4.0/).
