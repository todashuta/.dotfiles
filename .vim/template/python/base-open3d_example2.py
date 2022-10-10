import numpy as np
import open3d as o3d

N = 10000
bunny = o3d.data.BunnyMesh()
mesh = o3d.io.read_triangle_mesh(bunny.path)
mesh.compute_vertex_normals()
pcd = mesh.sample_points_poisson_disk(N)

# visualizer
def visualize(geometry, name, mesh_color_option=o3d.visualization.MeshColorOption.Color):
    vis = o3d.visualization.Visualizer()
    vis.create_window(
            visible=True,
            window_name=name,
            width=1280,
            height=720,
            )

    opt = vis.get_render_option()
    opt.mesh_color_option = mesh_color_option
    vis.add_geometry(geometry)
    vis.run()
    vis.destroy_window()

# mesh
def vis_mesh():
    mesh.compute_vertex_normals()
    visualize(mesh, "Mesh", o3d.visualization.MeshColorOption.Normal)

# point cloud
def vis_point_cloud():
    visualize(pcd, "Point Cloud")

# octree
def vis_octree():
    octree = o3d.geometry.Octree(max_depth=6)
    pcd.scale(1 / np.max(pcd.get_max_bound() - pcd.get_min_bound()), center=pcd.get_center())
    pcd.colors = o3d.utility.Vector3dVector(np.random.uniform(0, 1, size=(N, 3)))
    octree.convert_from_point_cloud(pcd, size_expand=0.01)
    visualize(octree, "Octree")

# voxel
def vis_voxel():
    voxel = o3d.geometry.VoxelGrid.create_from_point_cloud(pcd, 0.03)
    visualize(voxel, "Voxel")

if __name__ == "__main__":
    vis_mesh()
    vis_point_cloud()
    vis_octree()
    vis_voxel()
