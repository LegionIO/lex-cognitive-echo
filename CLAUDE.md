# lex-cognitive-echo

**Level 3 Documentation**
- **Parent**: `/Users/miverso2/rubymine/legion/extensions-agentic/CLAUDE.md`
- **Grandparent**: `/Users/miverso2/rubymine/legion/CLAUDE.md`

## Purpose

Models residual cognitive activation from previous processing. Recent thoughts leave echoes that decay over time but influence current processing through priming and interference effects. Provides a background activation layer — the cognitive afterimage of prior thinking that shapes new processing without conscious attention.

## Gem Info

- **Gem name**: `lex-cognitive-echo`
- **Version**: `0.1.0`
- **Module**: `Legion::Extensions::CognitiveEcho`
- **Ruby**: `>= 3.4`
- **License**: MIT

## File Structure

```
lib/legion/extensions/cognitive_echo/
  cognitive_echo.rb
  version.rb
  client.rb
  helpers/
    constants.rb
    echo_engine.rb
    echo.rb
  runners/
    cognitive_echo.rb
```

## Key Constants

From `helpers/constants.rb`:

- `ECHO_TYPES` — `%i[thought emotion decision observation prediction error success failure]`
- `MAX_ECHOES` = `300`, `MAX_INTERACTIONS` = `500`
- `DEFAULT_INTENSITY` = `0.8`, `ECHO_DECAY` = `0.1`, `REINFORCEMENT` = `0.15`
- `INTERFERENCE_THRESHOLD` = `0.4`, `PRIMING_THRESHOLD` = `0.3`, `SILENT_THRESHOLD` = `0.05`
- `INTENSITY_LABELS` — `0.8+` = `:reverberating`, `0.6` = `:strong`, `0.4` = `:moderate`, `0.2` = `:fading`, below = `:whisper`
- `EFFECT_LABELS` — `0.6+` = `:dominant`, `0.3` = `:influential`, `0.1` = `:subtle`, below = `:negligible`
- `CHAMBER_LABELS` — `0.8+` = `:echo_chamber`, `0.6` = `:resonant`, `0.4` = `:balanced`, `0.2` = `:diverse`, below = `:scattered`

## Runners

All methods in `Runners::CognitiveEcho`:

- `create_echo(content:, echo_type: :thought, domain: :general, intensity: 0.8)` — registers a new echo from a just-processed cognitive event
- `reinforce_echo(echo_id:, amount: 0.15)` — increases echo intensity; models repeated exposure reinforcing residual activation
- `decay_all` — applies `ECHO_DECAY` to all echoes; removes echoes below `SILENT_THRESHOLD`
- `active_echoes` — echoes above `SILENT_THRESHOLD`
- `priming_echoes` — echoes above `PRIMING_THRESHOLD` (influencing current processing)
- `interfering_echoes` — echoes above `INTERFERENCE_THRESHOLD` (strong enough to distort)
- `echoes_by_domain(domain:)` — filter by domain
- `strongest_echoes(limit: 5)` — top echoes by intensity
- `priming_effect(domain:)` — aggregate priming effect for a domain (sum of priming echo intensities)
- `echo_status` — full report: totals, decay stats, chamber resonance, domain distribution

## Helpers

- `EchoEngine` — manages echoes. `decay_all!` removes silent echoes. `priming_effect_for(domain:)` sums intensities of priming echoes in the domain.
- `Echo` — has `content`, `echo_type`, `domain`, `intensity`. `decay!` reduces by `ECHO_DECAY`. `reinforce!(amount)` increases intensity. `priming?`, `interfering?`, `silent?` predicates.

## Integration Points

- `lex-cognitive-echo-chamber` is the multi-echo, self-amplifying version — echo models single residual activations; echo chamber models self-reinforcing belief loops.
- `lex-cognitive-dwell` models active foreground attention; echo models passive background residual. They complement each other.
- `priming_effect(domain:)` can be called from `lex-tick` before prediction or memory retrieval phases — high priming in a domain biases retrieval toward domain-consistent content.

## Development Notes

- Echo decay is rapid (`ECHO_DECAY = 0.1` per cycle) — echoes are transient by design. Only reinforced echoes persist.
- `SILENT_THRESHOLD = 0.05` is the removal floor — echoes below this are pruned on `decay_all`.
- `CHAMBER_LABELS` keyed on the ratio of echoes above `INTERFERENCE_THRESHOLD` to total echoes — a high ratio indicates an echo chamber is forming.
- `priming_effect_for` returns a sum, not a ratio — high echo counts amplify domain priming linearly.
