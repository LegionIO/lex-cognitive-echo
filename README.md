# lex-cognitive-echo

Residual cognitive activation modeling for the LegionIO cognitive architecture. Recent thoughts leave echoes that decay over time but continue to influence current processing through priming and interference effects.

## What It Does

Cognitive echo models the afterimage of prior thinking — the background activation that persists after an active thought has passed. An echo is created when a cognitive event (thought, emotion, decision, observation, prediction, error, success, or failure) finishes processing. It starts at a configurable intensity, decays each cycle, and gets pruned once it falls below the silent threshold (0.05).

Echoes serve two roles: **priming** (echoes above 0.3 bias new retrieval and processing toward their domain) and **interference** (echoes above 0.4 are strong enough to distort new processing). The extension also tracks chamber resonance — the ratio of interfering echoes to total echoes — as an early signal that an echo chamber is forming.

## Usage

```ruby
client = Legion::Extensions::CognitiveEcho::Client.new

# Register a new echo from a just-processed event
result = client.create_echo(
  content: 'recursive planning loop detected',
  echo_type: :thought,
  domain: :planning,
  intensity: 0.8
)
echo_id = result[:echo][:id]

# Reinforce an echo (e.g., it was encountered again)
client.reinforce_echo(echo_id: echo_id, amount: 0.15)

# Periodic maintenance — decay all echoes, prune silent ones
client.decay_all

# Query by role
client.active_echoes
client.priming_echoes       # intensity > 0.3 — influencing current processing
client.interfering_echoes   # intensity > 0.4 — strong enough to distort

# Domain-focused queries
client.echoes_by_domain(domain: :planning)
client.priming_effect(domain: :planning)  # aggregate priming for a domain

# Status
client.echo_status
```

## Development

```bash
bundle install
bundle exec rspec
bundle exec rubocop
```

## License

MIT
