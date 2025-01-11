import bpy

objects = bpy.data.objects

BODIES = [ objects[ob] for ob in ("body-01", "body-02", "body-03") ]
WHEELS = [ objects[ob] for ob in ("wheel-01", "wheel-02", "wheel-03") ]
WINGS  = [ objects[ob] for ob in ("wing-01", "wing-02", "wing-03") ]

ALL = BODIES + WHEELS + WINGS

import itertools
for body,wheel,wing in itertools.product(BODIES, WHEELS, WINGS):
    for o in ALL:
        o.hide_render = True

    body.hide_render  = False
    wheel.hide_render = False
    wing.hide_render  = False

    f = f"//render/{body.name}_{wheel.name}_{wing.name}"
    bpy.context.scene.render.filepath = f
    bpy.ops.render.render(write_still=True)
    print(f)
{{_cursor_}}
