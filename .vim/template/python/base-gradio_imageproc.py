import gradio as gr
import numpy as np


def func(img, n):
    R = img[:,:,0]
    G = img[:,:,1]
    B = img[:,:,2]

    R = np.where(R <= n,   0, R)
    G = np.where(G <= n, 255, G)
    B = np.where(B <= n,   0, B)

    #breakpoint()

    img[:,:,0] = R
    img[:,:,1] = G
    img[:,:,2] = B

    return img


demo = gr.Interface(
        fn=func,
        inputs=[gr.Image(), gr.Slider(0, 255)],
        outputs=["image"]
)
demo.launch()
