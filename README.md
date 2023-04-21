# FinalExam


# Third Party 


# Lava Shader
![cbab4c25da537495b016d5b2a3c940c0](https://user-images.githubusercontent.com/96841021/233696973-c259e305-c9d4-4c9c-a4cd-8f8f3a01ecb1.png)
![75918dfd4334e0f5e7a1bd0be626d2bb](https://user-images.githubusercontent.com/96841021/233696976-51232a87-8599-404e-a959-f4eb08592e19.png)

The Lava Shader is a basic sine wave shader where we displace the y of each vertex based on the sine wave and the given parameters (Amplitube, Speed).

![5196a1df1cec5c9afd9521258a0c704b](https://user-images.githubusercontent.com/96841021/233697021-12d3ba93-dd30-4afc-97eb-a69be609fd78.png)

In the vertex function, we start by calculating the phase which is Time * Speed. The phase will give us how often the sine wave should move, so in other words the speed of the wave. After that, we need to calculate the world position so the waves will tile nicely, because if the vertex offsets were happening in local space and if we put two tiles next to eachother, they wouldn't line up because they're in their own local space.

Finally, we can calculate the sin wave supplying in all the necassary information and set that to the y of the world position variable we calculated above. The reason we only set the y of this offset is because sin waves are 2D, you supply them an x value and it'll give you back a y value. To do 3d waves, where x,y,z all move, you would have to implement Gertsner Waves however that is out of the scope of this project.

Now that we are done with the vertex function, we can move onto the fragment shader.

![d93fb04c9f041298dda0c154d1ccf010](https://user-images.githubusercontent.com/96841021/233697643-25263518-0331-4767-8340-042c8a44072b.png)

The fragment shader is pretty simple, we're calculating a UV offset to scroll the normal maps to add a little bit more detail to our lava. After that, we can set the normal by unpacking the normal map and supplying the uv's we just calculated.


![b5eb93f314a3c4fab9626ec2e39e0491](https://user-images.githubusercontent.com/96841021/233697990-cbefa118-19ca-4a18-8bf2-a46cd80600a9.png)

Finally, we have a C# script to handle lerping between different states, and scrolling the normal map. To switch between states, you can press 'Tab' and it'll toggle between the list of states. The states have values for the shaders amplitude and speed, and update them depending on the current state.

# Bloom
![bloom_off](https://user-images.githubusercontent.com/96841021/233698619-72ede19b-9abe-4683-a8f7-e6145fb598be.png)
![bloom on](https://user-images.githubusercontent.com/96841021/233698640-84b11b75-a539-4952-b393-c862cc4f782c.png)

Bloom works by doing a downsampling of the screen resolution to create a blur effect and enhance the lighting of the scene.
