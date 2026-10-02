# Industrial Robotics — Visor Automation

**4-DOF Manipulator Design, MATLAB/Simscape Validation & TM Collaborative-Robot Experiments**

Academic industrial-robotics project combining the design and simulation of a custom **4-DOF Rz–Ry–Ry–Ry manipulator** for helmet-visor automation with physical laboratory experiments using a **TM collaborative robot**, machine vision, block-based robot programming and multiple manipulation tasks.

> **Status:** Completed academic team project  
> **Team size:** 3  
> **Primary tools:** MATLAB, Simulink, Simscape Multibody, SolidWorks, TM Robot programming & vision environment

---

## At a Glance

| | |
|---|---|
| **Main simulation task** | Design a 4-DOF manipulator capable of manipulating and inspecting a helmet visor |
| **Robot architecture** | 4 revolute joints: base, shoulder, elbow, wrist |
| **Joint-axis sequence** | Rz – Ry – Ry – Ry |
| **Simulation** | MATLAB + Simscape Multibody |
| **Analysis** | FK, Jacobian, IK, workspace, manipulability, dynamics, torque, payload |
| **Task trajectories** | Visor manipulation trajectory and camera-inspection trajectory |
| **Validation** | MATLAB analytical/dynamic results compared with Simscape simulation |
| **Physical robotics** | TM collaborative robot |
| **Lab tasks** | Pick-and-place, vision-guided tic-tac-toe, contact drawing, visor manipulation, hinge imaging and stamping |
| **Vision** | Pattern detection with configurable search area, score threshold, rotation and image-pyramid parameters |

---

# Project Overview

This project consisted of two connected parts:

1. **Design and simulation of a custom 4-DOF industrial manipulator**
2. **Physical manipulation experiments using a TM collaborative robot**

The main simulated task was based around a **helmet visor**.

The custom robot had to perform two task trajectories:

```text
Trajectory ABC
Visor Manipulation
        ↓
Approach Helmet
        ↓
Reach Visor
        ↓
Manipulate / Open Visor
```

and:

```text
Trajectory ADE
Inspection Motion
        ↓
Approach Helmet
        ↓
Move Around Visor
        ↓
Position Camera for Inspection
```

The project therefore required more than producing robot motion in simulation.

It included:

- mechanical design
- kinematic modelling
- workspace analysis
- inverse kinematics
- dynamic modelling
- trajectory planning
- torque calculation
- Simscape modelling
- MATLAB/Simscape comparison
- payload analysis
- motor/transmission evaluation
- physical collaborative-robot programming
- machine vision
- manipulation experiments

---

# My Contributions

This was a **three-person team project**.

The following sections describe the work I personally contributed to.

## Mechanical & CAD Work

My contributions included:

- CAD modelling of the custom manipulator links
- defining the robot geometry and link dimensions
- extracting mass and centre-of-mass information from SolidWorks
- preparing robot geometry for Simscape integration

The final manipulator used four revolute joints:

```text
q1 → Base
q2 → Shoulder
q3 → Elbow
q4 → Wrist
```

with the joint-axis structure:

```text
Rz → Ry → Ry → Ry
```

---

# Kinematic Modelling

## Forward Kinematics

I implemented the robot forward-kinematics function:

```text
robotFK(q)
```

to compute the manipulator pose from the four joint variables.

Conceptually:

```text
q = [q1 q2 q3 q4]
        ↓
Forward Kinematics
        ↓
End-Effector Position / Pose
```

---

## Position Jacobian

I implemented a position Jacobian function:

```text
robotJacobianP(q)
```

to relate joint velocities to Cartesian end-effector velocity.

Conceptually:

```text
q̇
 ↓
Jp(q)
 ↓
Cartesian Velocity
```

The Jacobian was also used in workspace/manipulability analysis.

---

# Workspace & Manipulability Analysis

The robot workspace was evaluated by sampling the full four-dimensional joint configuration space.

My analysis included:

- full `q1–q4` workspace sampling
- Cartesian forward-kinematics evaluation
- manipulability-index calculation
- 3D workspace visualisation
- workspace colouring by manipulability
- convex-hull generation
- filtering for table height
- filtering for a base keep-out region
- fixed-`q1` workspace slices
- YZ workspace analysis
- `alphaShape` boundary generation
- visualisation of an example IK posture inside the workspace

This analysis was used to understand whether the designed manipulator geometry could reach the required helmet-interaction regions before task trajectories were finalised.

<!-- Add later:
![Workspace and manipulability](media/simulation/workspace_manipulability.png)
-->

---

# Inverse Kinematics

A general inverse-kinematics solution was implemented for the custom manipulator.

The IK was written as part of the project rather than relying exclusively on a prebuilt robot model.

The objective was to determine joint configurations:

```text
q1, q2, q3, q4
```

for desired Cartesian task positions:

```text
x, y, z
```

The IK was then used during task trajectory generation for the visor-interaction and inspection motions.

---

# Dynamic Modelling

The manipulator dynamics were derived using the robot equations of motion.

The model followed the standard form:

```text
M(q) q̈ + C(q,q̇) q̇ + G(q) = τ
```

where:

- `M(q)` represents configuration-dependent inertia
- `C(q,q̇)` represents velocity-dependent effects
- `G(q)` represents gravitational effects
- `τ` represents required joint torque

The dynamic model was used to estimate torque requirements along the planned trajectories.

---

# Trajectory Generation

Joint-space trajectories were generated in MATLAB, including:

- joint position `q`
- joint velocity `q̇`
- joint acceleration `q̈`

Different trajectory-generation methods were investigated and compared to determine which was better suited to the individual task segments.

---

## Trajectory ABC — Visor Manipulation

Trajectory **ABC** represented the principal visor-interaction motion.

The robot had to:

```text
Start
  ↓
Approach Helmet
  ↓
Reach Visor
  ↓
Manipulate / Open Visor
```

A line-and-parabolic-blend style trajectory was investigated for this motion.

The trajectory was evaluated in both:

- MATLAB
- Simscape Multibody

---

## Trajectory ADE — Camera Inspection

Trajectory **ADE** represented a separate inspection path.

The manipulator moved forward and around the visor to position the camera for inspection of the helmet / hinge region.

Multiple trajectory-generation approaches were investigated and compared for this motion.

The resulting trajectory was also evaluated in both MATLAB and Simscape.

---

# MATLAB Dynamic Simulation

For the generated trajectories, MATLAB was used to compute:

```text
q(t)
q̇(t)
q̈(t)
τ(t)
```

The resulting joint-torque profiles were used to investigate actuator requirements and payload sensitivity.

---

# Simscape Multibody Model

A complete **4-DOF Simscape Multibody model** was created for the manipulator.

The model development included:

- four revolute joints
- correct `Rz–Ry–Ry–Ry` axis alignment
- rigid transforms for link offsets
- initial geometric solids for development
- SolidWorks geometry import
- motion inputs for all four joints
- joint-position sensing
- joint-torque sensing
- Simscape physical-signal conversion
- simulation output logging

The high-level model architecture was:

```text
Joint Trajectories
       │
       ▼
┌──────────────────────┐
│  4-DOF Robot Model   │
│  Simscape Multibody  │
└──────────────────────┘
       │
       ├── Joint Position
       ├── Joint Velocity
       └── Joint Torque
```

<!-- Add later:
![Simscape robot model](media/simulation/simscape_model.png)
-->

---

# MATLAB vs Simscape Validation

The same test trajectories were simulated using both:

```text
Analytical / MATLAB Model
             ↕
      Comparison
             ↕
Simscape Multibody Model
```

Joint-torque profiles were compared between the two implementations.

The objective was not to claim perfect numerical equivalence, but to use two modelling approaches to inspect whether the predicted dynamic behaviour and torque trends were consistent.

Comparisons were performed for the task trajectories as well as selected payload cases.

<!-- Add later:
![MATLAB vs Simscape torque comparison](media/results/matlab_vs_simscape_torque.png)
-->

---

# Payload Analysis

Payload sensitivity was evaluated across multiple cases, including:

- **0 kg**
- **0.5 kg**
- **0.75 kg**
- **1.0 kg**

For each case, joint-torque requirements were evaluated along the task motion.

This allowed the influence of payload on the most highly loaded joints to be visualised.

<!-- Add later:
![0 kg payload torque](media/results/torque_0kg.png)
![0.5 kg payload torque](media/results/torque_05kg.png)
![0.75 kg payload torque](media/results/torque_075kg.png)
![1 kg payload torque](media/results/torque_1kg.png)
-->

The payload study did **not** indicate that the robot fundamentally failed at the higher tested payloads.

Instead, the analysis was used as part of actuator and transmission evaluation.

---

# Motor & Transmission Analysis

The required joint torques were compared against candidate Mitsubishi servo-motor capabilities.

A belt/transmission reduction study was also performed.

The purpose was to evaluate how transmission ratios affected motor-side torque requirements and provide additional design margin.

The study included:

- joint-torque requirements
- transmission reductions
- rated motor torque
- maximum motor torque
- motor power
- worst-case task loading
- 1 kg payload case

<!-- Add later:
![Torque with transmission reduction](media/results/torque_transmission_1kg.png)

![Motor power](media/results/motor_power_1kg.png)
-->

The exact final motor part numbers and reduction ratios are not reproduced here because they have not yet been recovered from the archived project material.

---

# Physical Industrial-Robotics Laboratory

The second part of the project involved a **TM collaborative robot** equipped with interchangeable tooling and an integrated vision system.

The exact robot model is not claimed here because it has not yet been recovered from the surviving project records.

Programming was performed using the **TM Robot block-based programming and vision environment**.

The laboratory work focused on practical robot programming, manipulation, computer vision, accuracy and repeatability.

![TM collaborative robot laboratory setup](media/lab/tm_robot_setup.jpg)

---

# Block-Based Robot Programming

The physical robot was programmed using graphical/block-based logic rather than conventional text-based source code.

The programming environment provided robot-control operations including concepts such as:

- move
- repeat
- conditional logic
- branching
- sequence control
- vision operations

This allowed manipulation behaviours to be constructed as task sequences.

The block-based implementation should therefore not be interpreted as conventional Python/C++ robot programming.

---

# Pick-and-Place Task

One laboratory task involved moving objects between **six predefined source positions and six destination positions**.

The object locations were predefined rather than vision-detected.

The programmed sequence controlled:

```text
Approach Source
       ↓
Pick Object
       ↓
Move to Destination
       ↓
Place Object
       ↓
Repeat for Remaining Objects
```

I participated directly in programming and testing this task.

<!-- Add trimmed video later:
[Watch the pick-and-place demonstration](media/lab/pick_and_place.mp4)
-->

---

# Vision-Based Tic-Tac-Toe

A later exercise introduced machine vision.

The TM vision system was used for image-pattern detection.

I configured vision parameters including:

- pattern selection
- search region
- minimum matching score / confidence
- rotation handling
- image-pyramid settings

The vision interface returned information such as:

- image-space `X`
- image-space `Y`
- object rotation
- detection score

This information was used in the robot-task logic to determine the relevant object/board state and where the robot should place its next element.

<!-- Add later:
![TM vision pattern detection](media/lab/tm_vision_detection.jpg)
-->

The task demonstrated practical integration of:

```text
Camera
   ↓
Pattern Detection
   ↓
Detection Parameters
   ↓
Position / Orientation
   ↓
Robot Decision Logic
   ↓
Manipulation
```

<!-- Add trimmed video later:
[Watch the tic-tac-toe experiment](media/lab/tic_tac_toe.mp4)
-->

---

# Contact Drawing Experiment

Another task used a pencil mounted at the robot end effector to draw a helmet-related shape.

The primary challenge was maintaining appropriate contact with the drawing surface.

No dedicated force-control measurement was used.

Instead, contact was established experimentally by tuning the robot pose and end-effector depth.

This exercise therefore investigated practical issues including:

- positioning accuracy
- trajectory following
- tool orientation
- contact depth
- surface interaction

---

# Final Helmet-Visor Automation Task

The final physical laboratory exercise brought several of the earlier skills together.

The robot performed a sequence involving visor manipulation, camera inspection and stamping.

The programmed task sequence was approximately:

```text
Start Position
      ↓
Approach Helmet
      ↓
Open Visor
      ↓
Reposition / Rotate
      ↓
Close Visor
      ↓
Position Camera at Hinge
      ↓
Capture Inspection View
      ↓
Return to Start
      ↓
Repeat at Increasing Speed
      ↓
Move to Stamp
      ↓
Dip / Prepare Stamp
      ↓
Apply Stamp to Helmet
      ↓
Repeat at Different Angles
```

The visor sequence was repeated **three times at progressively higher speeds** to assess whether the programmed manipulation remained reliable.

The stamping operation was subsequently repeated with different robot orientations.

The evaluation was based primarily on **successful physical task execution and visual observation**.

No formal quantitative measurements of force, positioning error or cycle-time repeatability were recorded.

<!-- Add trimmed final video later:
[Watch the final visor-manipulation task](media/lab/helmet_visor_task.mp4)
-->

---

# Implemented vs Not Quantitatively Evaluated

| Component | Status |
|---|---|
| Custom 4-DOF robot architecture | ✅ Implemented |
| SolidWorks CAD development | ✅ Implemented |
| Forward kinematics | ✅ Implemented |
| Position Jacobian | ✅ Implemented |
| Workspace sampling | ✅ Implemented |
| Manipulability analysis | ✅ Implemented |
| Inverse kinematics | ✅ Implemented |
| Dynamic model | ✅ Implemented |
| MATLAB trajectory generation | ✅ Implemented |
| MATLAB torque calculation | ✅ Implemented |
| Simscape Multibody model | ✅ Implemented |
| CAD geometry import | ✅ Implemented |
| Position / torque sensing in Simscape | ✅ Implemented |
| MATLAB-vs-Simscape comparison | ✅ Implemented |
| Payload study up to 1 kg | ✅ Implemented |
| Motor / transmission study | ✅ Performed |
| TM robot pick-and-place | ✅ Demonstrated |
| TM machine-vision experiment | ✅ Demonstrated |
| Tic-tac-toe task | ✅ Demonstrated |
| Contact drawing | ✅ Demonstrated |
| Physical visor manipulation | ✅ Demonstrated |
| Hinge imaging | ✅ Demonstrated |
| Stamping task | ✅ Demonstrated |
| Quantitative real-robot force validation | ❌ Not performed |
| Quantitative real-robot positioning error | ❌ Not recorded |
| Formal real-robot repeatability study | ❌ Not recorded |

---

# Engineering Limitations

## Simulation Parameters

Some original project metadata has not yet been recovered, including:

- final documented joint-limit configuration
- exact final Mitsubishi motor part numbers
- exact final transmission ratios

These values are therefore intentionally not stated rather than reconstructed from memory.

## Physical Robot Identification

The laboratory hardware was a **TM collaborative robot**, but the exact model number has not yet been recovered.

## Software Identification

The physical laboratory used the TM Robot programming and vision environment.

The exact software product/version is not stated until it can be confirmed from the original course material.

## Physical Validation

The laboratory experiments were evaluated primarily through successful task completion.

The project did not record a complete quantitative dataset for:

- contact force
- absolute positioning error
- repeatability
- cycle time
- force/torque profiles on the real robot

---

# Technology Stack

## Modelling & Simulation

- MATLAB
- Simulink
- Simscape Multibody
- SolidWorks

## Robotics

- forward kinematics
- inverse kinematics
- Jacobians
- workspace analysis
- manipulability
- robot dynamics
- trajectory planning
- torque analysis
- payload analysis
- motor/transmission sizing

## Industrial Robotics

- TM collaborative robot
- block-based robot programming
- pick-and-place
- machine vision
- pattern detection
- tool interaction
- contact tasks
- inspection trajectories

---

# Repository Structure

The repository is being reconstructed from the surviving academic project files.

```text
industrial-robotics-visor-automation/
│
├── README.md
├── .gitignore
│
├── matlab/
│   ├── kinematics/
│   ├── dynamics/
│   ├── trajectory/
│   └── analysis/
│
├── simscape/
│   ├── Project_Simscape.slx
│   ├── Simscape_Values.m
│   └── Trapezoidal_signal.mat
│
├── cad/
│   └── solidworks/
│
└── media/
    ├── simulation/
    ├── results/
    └── lab/
```

Generated Simulink cache files, autosave files and temporary build artefacts are intentionally excluded from version control.

---

# What This Project Demonstrates

For robotics, simulation and industrial-automation roles, this project demonstrates experience with:

- robot kinematics
- forward and inverse kinematics
- Jacobian modelling
- manipulability analysis
- workspace analysis
- robot dynamics
- trajectory planning
- MATLAB
- Simulink
- Simscape Multibody
- SolidWorks
- simulation validation
- torque analysis
- payload analysis
- actuator / transmission evaluation
- collaborative robots
- industrial manipulation
- block-based robot programming
- machine vision
- pick-and-place
- contact tasks
- inspection tasks
- physical robot testing
- simulation-to-hardware engineering workflows

---

# Project Status

✅ **Completed academic robotics project**

The simulation, modelling and physical laboratory exercises were completed.

Some original metadata and project files are still being recovered. Missing values are intentionally left undocumented rather than inferred or reconstructed without evidence.
