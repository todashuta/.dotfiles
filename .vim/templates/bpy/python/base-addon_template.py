bl_info = {
    "name": "My Addon Template",
    "author": "foo",
    "version": (0, 0, 1),
    "blender": (3, 6, 0),
    "location": "---",
    "description": "My Addon Template Description",
    "warning": "",
    "wiki_url": "",
    "tracker_url": "",
    "category": "Object"
}


import bpy


def get_addon_prefs(context):
    addon_prefs = context.preferences.addons[__name__].preferences
    return addon_prefs


class ExampleOperator(bpy.types.Operator):
    """Tooltip"""
    bl_idname = "object.example_operator"
    bl_label = "Example Operator"
    bl_options = {'REGISTER', 'UNDO'}

    prop1: bpy.props.StringProperty(name="prop1", default="hoge")

    @classmethod
    def poll(cls, context):
        return context.active_object is not None

    @classmethod
    def description(cls, context, properties) -> str:
        desc = f"example description - {properties.prop1}"
        return desc

    def __init__(self, *args, **kwargs):
        super().__init__(*args, **kwargs)
        self._shift_key_down = False
        #print("[debug] __init__ called")

    def invoke(self, context, event):
        self._shift_key_down = event.shift
        return self.execute(context)

    def execute(self, context):
        prefs = get_addon_prefs(context)
        self.report({'INFO'}, f"{context.active_object.name} {self.prop1} {self._shift_key_down} {prefs.option1}")
        return {'FINISHED'}


class EXAMPLE_ADDON_PT_panel(bpy.types.Panel):
    bl_label = "Example Addon Panel"
    bl_space_type = "VIEW_3D"
    bl_region_type = "UI"
    bl_category = "Tool"
    #bl_context = "objectmode"

    @classmethod
    def poll(cls, context):
        return True

    def draw_header(self, context):
        layout = self.layout

    def draw(self, context):
        prefs = get_addon_prefs(context)
        layout = self.layout
        layout.label(text="Example:")
        layout.label(text=f"option1: {prefs.option1}")

        op = layout.operator(ExampleOperator.bl_idname,
                             icon="PLUGIN", text=ExampleOperator.bl_label + ": foo")
        op.prop1 = "foo"

        op = layout.operator(ExampleOperator.bl_idname,
                             icon="PLUGIN", text=ExampleOperator.bl_label + ": bar")
        op.prop1 = "bar"


class ExampleAddonPreferences(bpy.types.AddonPreferences):
    bl_idname = __name__

    option1: bpy.props.EnumProperty(
        name='Addon Option 1', default='FOO',
        items=[('FOO', 'Foo', 'foo'),
               ('BAR', 'Bar', 'bar')])

    def draw(self, context):
        layout = self.layout
        layout.prop(self, "option1")


classes = (
    ExampleOperator,
    EXAMPLE_ADDON_PT_panel,
    ExampleAddonPreferences,
)


def menu_func(self, context):
    layout = self.layout
    layout.separator()
    layout.label(icon="PLUGIN", text="Example Addon:")
    layout.operator(ExampleOperator.bl_idname)


def register():
    #print("[debug] register called")
    for cls in classes:
        bpy.utils.register_class(cls)
    bpy.types.VIEW3D_MT_object_context_menu.append(menu_func)


def unregister():
    #print("[debug] unregister called")
    bpy.types.VIEW3D_MT_object_context_menu.remove(menu_func)
    for cls in reversed(classes):
        bpy.utils.unregister_class(cls)


if __name__ == "__main__":
    register()
