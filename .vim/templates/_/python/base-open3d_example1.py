import open3d as o3d

#mesh = o3d.io.read_triangle_mesh("./cube.ply")

bunny = o3d.data.BunnyMesh()
mesh = o3d.io.read_triangle_mesh(bunny.path)

mesh.compute_vertex_normals()
o3d.visualization.draw_geometries([mesh],
        window_name="Mesh",
        width=1280,
        height=720,
        #mesh_show_wireframe=True,
        mesh_show_back_face=True,
        #point_show_normal=True,
        )

#pcd = mesh.sample_points_uniformly(number_of_points=10000)
pcd = mesh.sample_points_poisson_disk(number_of_points=10000, init_factor=5)
o3d.visualization.draw_geometries([pcd],
        window_name="Point Cloud",
        width=1280,
        height=720,
        #point_show_normal=True,
        )

#print(pcd)
