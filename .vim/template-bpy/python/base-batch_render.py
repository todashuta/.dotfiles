import bpy

BODIES = ( "body-01", "body-02", "body-03" )
WHEELS = ( "wheel-01", "wheel-02", "wheel-03" )
WINGS  = ( "wing-01", "wing-02", "wing-03" )

objects = bpy.data.objects

import itertools
for body,wheel,wing in itertools.product(BODIES, WHEELS, WINGS):
    for o in (BODIES + WHEELS + WINGS):
        objects[o].hide_render = True

    objects[body].hide_render = False
    objects[wheel].hide_render = False
    objects[wing].hide_render = False

    f = f"//render/{body}_{wheel}_{wing}"
    bpy.context.scene.render.filepath = f
    bpy.ops.render.render(write_still=True)
    print(f)
{{_cursor_}}
