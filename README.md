# Nexus VR Compatibility Tester
Nexus VR Compatibility Tester is a tool for detecting and providing
solutions for common issues that affect the experience of VR players
in games, such as:
* Crashing due to `SurfaceGui`s with buttons in `Workspace`.
* Improperly covering screens for transitions.
* `ScrollingFrame`s in `SurfaceGui`s.
* `ClickDetector`s and buttons in `SurfaceGui`s not wrapped with
  [Nexus VR Core](https://github.com/thenexusAvenger/nexus-vr-core).

The goal of the tool is to assist developers who aren't in VR
to improve the experience of VR users. The major problems introduced
by developers are pretty common and are either automatically tested
for or are mentioned in the list of tests provided by the tool.
**Not everything is tested in the tool, and this tool is not a
substitute for testing in VR. This should only be used for rapid
testing of common issues before testing VR, not as a measure of VR
compatibility.**

## Setting Up
The simplest way to set up the tool is to download the model file
from the GitHub releases and put it in either `StarterPlayerScripts`
or `StarterGui`. It can be opened from the chat by typing and entering
`:vrcheck`. If you are using [Cmdr](https://github.com/evaera/cmdr)
or system that uses Cmdr, like [Nexus Admin](https://github.com/thenexusavenger/nexus-admin),
the tool can be opened from the command prompt using `vrcheck`.

## Test Levels
The tests are presented to the user with a corresponding level.
* Manual; Grey (-): The test can only be completed manually or
  requires code analysis.
* None/Normal: Green (✓): The test does not detect a problem,
  **but should be used to conclude it found nothing, not that
  there is no problems.**
* Info: Blue (i): The test detected a problem that doesn't
  affect playability that much.
* Warning: Orange (!): The test detected a problem that can
  make the game harder to player or unplayable.
* Error/Critical: Red (!): The test detected a problem that
  result in players crashing or breaking.

## Current Supported Tests
### Automatic
* Camera animations - Checks for custom animations being done
  on the camera, which may cause motion sickness for VR users.
* Screen covers - Checks if the screen is attempted to be fully
  covered, which doesn't cover the screen in VR.
* `SurfaceGui` crashing - Checks if a `SurfaceGui` is configured
  in a way that can crash a VR player.
* `ScrollingFrame`s in `SurfaceGui`s - Checks for `ScrollingFrame`s
  in `SurfaceGui`s, which are hard to navigate for non-mouse users.
* Unwrapped `ClickDetector`s - Checks for `ClickDetector`s not
  wrapped through Nexus VR Core. They are hard to use in VR.
* Unwrapped buttons in `SurfaceGui`s - Checks for buttons in
  `SurfaceGui`s that are not wrapped through Nexus VR Core.
  While not as bad as `ClickDetector`s, they can still be hard to
  use and can't be used with a player's left hand.

### Manual
* `Camera.CFrame` reading - `Camera.CFrame` may return a different
  result compared to what is being rendered in VR. Use
  `Camera:GetRenderCFrame()` instead.
* First-Person support - Some mechanics only work well in third-person.
* Gamepad support - Keyboard-only actions may not be usable in VR.
* Input switching support - Some VR users use a keyboard while others
  use gamepads. Both inputs should work and be switchable while playing.
* Square view support - Some user interfaces scale incorrectly in
  a square shape or in portrait mode.
* Unusable buttons - User interfaces sometimes include buttons for
  actions that don't work in VR, like dancing. These take up unneeded
  space in VR.

## [Nexus VR Core](https://github.com/thenexusAvenger/nexus-vr-core)
Nexus VR Core is referenced in some cases for resolving problems.
Nexus VR Core is automatically set up in `ReplicatedStorage.NexusVRCore`
with Nexus VR Character Model and can be set up manually for other
use cases. There are docs about how to resolve issues with
[`ScreenGui`s](https://thenexusavenger.github.io/Nexus-VR-Core/usage/screenguis/),
[`SurfaceGui`s](https://thenexusavenger.github.io/Nexus-VR-Core/usage/surfaceguis/),
and [`ClickDetector`s](https://thenexusavenger.github.io/Nexus-VR-Core/usage/clickdetectors/).

## Design Limits
### Not A Replacement For VR Testing
**Do not use this tool as a replacement for VR testing.**
As covered earlier, this tool should be used as an indicator
for VR compatibility before testing in VR. You will miss
problems in VR if you don't actually test in VR.

### No Code Analysis
The tool does not perform code analysis and won't tell you
about code-level problems. Some tests are manual because of
this.

### Non-VR Runtime Only
The tool is not supported for use while in VR since it is
meant to be a helper outside of VR. If special-casing is
made for VR users, the tool will not detect it.

### Event-Heavy
A lot of events are connected by some tests since they check
for changes to every type of `GuiObject` or `GuiButton`.
Avoid using this tool outside of test games.

## Contributing
Both issues and pull requests are accepted for this project.

## License
Nexus Button is available under the terms of the MIT 
License. See [LICENSE](LICENSE) for details.