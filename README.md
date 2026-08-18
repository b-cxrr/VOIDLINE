# VOID//LINE

**A neon-noir 2D endless runner for Android, built in Godot 4 using GDScript.**

VOID//LINE is a mobile endless runner built around simple input, responsive movement and progressively more intense visual feedback.

The player automatically moves through the world and must time jumps to avoid obstacles while the game gradually increases in speed and difficulty.

What began as a relatively simple runner prototype became a broader development project focused on movement feel, visual polish, mobile deployment, save systems and structured game logic.

---

## Gameplay

The controls are intentionally minimal:

* The player runs automatically.
* Tap to jump.
* Avoid obstacles.
* Survive as long as possible.
* Distance increases continuously.
* The game becomes progressively faster over time.

The simplicity of the input puts more emphasis on timing, responsiveness and the feel of the player controller.

---

## Technical Overview

**Engine:** Godot 4.7
**Language:** GDScript
**Platform:** Android
**Version control:** Git / GitHub

The project has been used to develop experience with:

* `CharacterBody2D` movement
* Gravity and jumping
* Jump buffering
* State transitions
* Autoload singletons
* Signals
* Persistent save data
* Responsive UI
* Mobile input
* Audio implementation
* Particle effects
* Camera feedback
* Parallax backgrounds
* Animation
* Android exporting
* ADB device testing
* Debugging and iteration

---

## Player Controller

The player is implemented using `CharacterBody2D`.

The movement system handles:

* Gravity
* Jumping
* Jump buffering
* Landing detection
* Animation states
* Input gating
* Game-over behaviour
* Landing feedback

The player does not move horizontally. Instead, the environment scrolls past the player while game speed increases over time.

This helped keep the control scheme simple while allowing difficulty to be adjusted through world speed and obstacle placement.

---

## Game Management

A global `GameManager` handles the overall run state.

Responsibilities include:

* Starting a run
* Ending a run
* Tracking distance
* Increasing game speed
* Managing game-over state
* Providing shared state to other systems

Keeping this logic separate from the player controller made it easier to manage communication between gameplay systems.

---

## Save System

VOID//LINE includes a dedicated save system for persistent data.

The `SaveManager` stores information such as:

* Best distance
* High score data
* Persistent player progress

Save data is kept separate from core gameplay logic to reduce coupling between systems.

---

## Player Feedback

A major focus during development has been making movement feel more responsive and less static.

Current feedback systems include:

* Landing particles
* Landing audio
* Camera landing bump
* Squash and stretch
* Jump animation
* Run animation
* Glitch-style visual effects
* Game-over feedback

These systems were developed independently from the core movement logic so that visual polish could be added without altering gameplay behaviour.

---

## Glitch Effects

One of the main visual directions for VOID//LINE is digital instability.

The project includes experimental glitch-style effects such as:

* Brief player distortion
* Scale manipulation
* Flickering
* Position offsets
* Colour shifts
* Compression and stretch
* Glitch-style death animation

The goal is to make the character and world feel increasingly unstable without making gameplay unfair or difficult to read.

---

## Parallax Background

The game uses a multi-layer neon-noir background.

Layers move at different speeds to create depth while maintaining the illusion of continuous movement.

The background system includes:

* Near layer
* Mid layer
* Far layer
* Infinite horizontal looping
* Perspective-based motion

This allowed the game to create more visual depth without requiring a large scrolling level.

---

## Mobile UI

VOID//LINE has been developed with Android as its primary target.

The UI has been iterated on to behave correctly across desktop and mobile testing.

This has involved work with:

* `Control` nodes
* Containers
* Anchors
* Size flags
* Responsive positioning
* Game-over overlays
* Pause UI
* Restart controls
* Mobile-safe layout behaviour

---

## Android Development

The project has been exported and tested directly on Android devices.

Development has included:

* APK exporting
* Android configuration
* ADB
* `scrcpy`
* Mobile input testing
* Device debugging
* Responsive UI fixes
* Performance testing

This has been useful for identifying issues that are not always visible when testing only inside the Godot editor.

---

## AI-Assisted Development

AI tools have been used as part of the development workflow.

I primarily use AI to:

* Discuss implementation approaches
* Understand unfamiliar Godot systems
* Debug unexpected behaviour
* Review scripts
* Explain errors
* Break larger systems into smaller tasks
* Compare alternative implementations
* Refactor code
* Accelerate iteration

AI suggestions are tested and adapted manually rather than being treated as automatically correct.

Working this way has helped me become more comfortable identifying why something works, why it fails and how different systems interact.

---

## Development Approach

My typical workflow on VOID//LINE has been:

1. Identify a mechanic or problem.
2. Break it into smaller systems.
3. Implement the core behaviour.
4. Test inside Godot.
5. Deploy to Android where appropriate.
6. Identify problems with feel, layout or logic.
7. Refine the implementation.
8. Commit working changes using Git.

The project has been particularly useful for learning how a seemingly simple game can become much more complex once mobile deployment, polish, persistence and UI are introduced.

---

## Future Direction

Planned ideas include further development of the visual instability concept.

One concept being explored is a **Reality Instability** system where visual corruption gradually increases as the player survives longer.

A possible later mechanic would temporarily stabilise the world before the corruption begins building again.

The intention is for these systems to affect atmosphere and presentation rather than gameplay fairness.

---

## What I Learned

VOID//LINE has helped me develop practical experience with:

* Player movement
* Game feel
* State management
* Persistence
* Signals
* Responsive UI
* Animation
* Visual feedback
* Mobile debugging
* Project organisation
* Iterative development
* Version control

It has also helped reinforce the importance of separating gameplay logic from visual effects and interface systems.

---

## Developer

**Ben Carr**

GitHub: [b-cxrr](https://github.com/b-cxrr)

Independent developer building experience in software engineering, Godot, GDScript and AI-assisted development.
