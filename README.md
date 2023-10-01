# Arktoon-Shaders by synqark


# Features
 - Configurable toonlike shader.
 - Includes Opaque/Fade/AlphaCutout variations.
 - All variations are supported Lightprobe and Point lights(both PixelLight and Per-vertex Light!)
 - Customizable Shade color (or use other texture for shade)
 - Additional features (These are switchable and be optimized in shader code.)
   - Gloss
   - Outline (Opaque and Cutout only)
   - MatCap
   - Reflection (Scene ReflectionProbe or other Cubemap texture.)
   - Rim (additive color/texture)
   - Shade Cap ( Darker version of MatCap. can use for shading!)
   - Vertex Color (usually for MagicaVoxel, etc.)

# Inspector Window

### Default
This is default settings, You can use Toon such simple options.
![image](Media/default_inspector.png)

### Expanded
...and You can also customize all these properties.
![image](Media/expanded_inspector.png)


Arktoon-Shaders how to use![](Media/expanded_inspector.png)

(Supported version: 1.0.0.0)

You do not need to use all of each category.

Support for all ForwardRendering lights (including VRChat mirrors)
-----------------------------------------

Supports the following light elements in Forward Lighting
Directional Light
Directional Light is a parallel light source that mainly represents sunlight.
Realtime Spot/Point Light (PixelLight, VertexLight, SH)
Real-time Spot/Point Light (PixelLight, VertexLight, SH)
There are several patterns, but all variations are supported.
LightProbe(SH)
Light probes are supported.

Surprisingly few homebrew shaders support all of these elements (especially VertexLight).
For example, in VRChat, there are a few shaders that cause poor reflection on the other side of the mirror,
This shader supports all of them, allowing for a consistent representation of the scene without losing the atmosphere of the scene.

Extensive customization elements
-----------

The following elements are supported

Adjustable shadows (thin and wide, or tight and celluloid-like)
Use of shade textures or HSV (hue/saturation/vibrancy) shift for shade settings.
Gloss (gloss) for light
Outline
MatCap (compare (light) / add / screen composite)
Reflection (reflection probes / cube map support)
RimLight (light on the edges of the model)
ShadeCap (compare (dark) / multiply composite / light mask) (reverse of MatCap)

Stencil (includes several ways to achieve semi-transparent stencils)

Vertex Color

Parallax emission texture
Other detailed settings (point light shade intensity, Cubed style light sampling, etc.)
(point light shade strength, cubed style light sampling, etc.)


Most of these can be set in degrees of application and also support mask textures to be applied to portions of the mesh.

A detailed description of each feature is provided in the next section.

Use it for now.
-------


Setup for now in avatar
----------------

Prepare your materials and textures and set them up like this

![](https://lh3.googleusercontent.com/hj6BMcs3gqm9-MyWd7ZM1QKABOPO2rMjedd5rO2cs50n98UKvKUc6zKbGaGRWzyxUVpBgmLm9NcSYctgpQ7dcW3KORvgqXNfioJRKvvDg1YColqscJVueI3-m_XMwQOnaz3WpDHwhHEIhOmu)

Uploaded by!
-------

If you're using VRChat, VRChat -> Build & Publish!

Shader Variations
-------------

arktoon/Opaque
--------------

For opaque materials, set here.
(I heard it's read as "O(u)pek.)
![](https://lh5.googleusercontent.com/XrpseLWZz-8w6ihn7tF69OCw3J2pyedibmYkcx8tzzo20_U6oEQF89AQojNglenkq1NsXGrJq4S5SvWwL6DWvaRMdPoKjiTybFWSR_PvoCeNk_StWvM6aVVcpxEMpQcZMjjH4PmZuCmQ-PHz)

arktoon/AlphaCutout
-------------------

If you want to represent an object that is clearly divided between opaque and transparent, specify here.
The cutout will be made with the transparency of the Main Texture.
Shadows are also projected with the cutout shape.
![](https://lh4.googleusercontent.com/ZDt4f46ZFvfCFaGk4fwfKteABCp6IIpWs9ktXnhuD9fxEDqtA02V0lu8-BakNuwwGxLkcs9Sz7jOYGFYNS_6Fv9WBI-yqIDg5XINMHfwaPUl-6rfX-1MK9svphCb_stSWR6diIrI-H9Przda)

arktoon/Fade
------------

If the object contains semi-transparency, specify here.
![](https://lh6.googleusercontent.com/1NnhVH4W6ld2Pp8BGqbGDOmAv43gSnEA1mXegQKZGPJaW6BugVXxLvr3siIfi4WQBASMR1svJ9o3CL7Snc2Ucc0ckkN_Dl-DHMPMhHmlzhACNopyGW64QznSmAfPM8cL605yat_hupVYmkWF)
The shadow cast will also be dithered according to transparency.

### arktoon/FadeRefracted

If the object contains translucency and you want to refract the image at the back, specify this option.
(If you do not need refraction, use Fade because it adds one more pass.)

![](https://lh5.googleusercontent.com/oC7qIq9ctv0h_ctUBN9Wam7QCOPQXdZc6uWXPQVnH-pF35yIvtGFaR1WquUgaWQ6YhQapdHMKoToBtxJeCXQv_Lta52A_G0Z0RbNBEDF6yqTI-5vPt285oNwx4w7fHFjR940qbIBMrAn4ut2)

arktoon/Stencil/Writer/Cutout and arktoon/Stencil/Reader/Cutout
-----------------------------------------------------------

Writes the stencil buffer (Writer) at the same time as drawing
and reads, compares and controls the display (Reader) at the same time as drawing.
Other functions are equivalent to Cutout. [](https://lh6.googleusercontent.com/kYpZ6pOo7KtZ3UIZLgh1oDKigJryz1lc0G11yXjVXuSDniREoM3p7zOwpZKgp-4sVPYjBLcw62V2ignhZCg9YqqzJDnS2sewILS3N9BYmoXxSt2RDzZfpRuNOZw_4dbq3Jhk0XrrHNHLwnY7)
![](https://lh3.googleusercontent.com/j5O1lb4nxIO3BCZ7vh89r77cnUbQ5i6tq9aRFTCSIKhaGYq2_9XERBl7A4ANrgkO_dTgDC91cr5G8lL-S9af_fWOw9Bw5y5El6VCLU78SL4uQI5mmS8dshcgTY6bPJmKQOAMZ7BzmNIavCDa)

arktoon/Stencil/WriterMask/Cutout
---------------------------------

This is a variation of the above "arktoon/Stencil/Writer/Cutout" with an additional mask texture for stencil buffers only.

arktoon/Stencil/Reader/Fade
---------------------------

This is a Fade variation of the above "arktoon/Stencil/Reader/Cutout".

arktoon/Stencil/Reader/Double/FadeFade
--------------------------------------

Draws two Fade fades for each stencil. Each is divided into Primary and Secondary.

Main Texture", "Color", "Normal Map" and "Emission" can be defined separately.

By specifying "NotEqual" for Primary and making the Secondary's Color translucent and specifying "Equal", you can make the target area of the stencil translucent and transparent.

![](https://lh3.googleusercontent.com/ZjeFLn_6_DeoTm1jouHgq6xfb-fUp-HadiG2nO-Nke6qItN9BJcHH3lm-KS8hUfGE-jS1eLdKaqV3TYr9VA6np93XE0kzTaMtt2IXfUL3KhYcq1_BPiXJr0hkKaQWbX6cCEgXZvbgwhMtUih)

The function of each category
------------

Common
------

### What you can do

You can set the base color of the material![](https://lh4.googleusercontent.com/lsbJPtKMHu0R16FOjYTLcjqCoK7XyuWjBGrwPiXdMN2E8DbGYtqP_pyJyfO1bHj9RMzcghfse7GvZ8DAFtvjVHwc4SkghxIBIvoKaGdKjtuVeHs0oX8vbYLsSJJ7JgQr1aZ_KNgdeVVnhxf2)

### About each item

#### Main Texture

Specifies the basic color of the material in texture x color.

The color set here is affected by shadows and surrounding colors.

#### Normal Map

Specifies the texture that represents the unevenness of the material.

The intensity of the texture can be set with the slider.

#### Emission

Sets the color of the material's emission as texture x color.

The color specified here is not affected by shadows or surrounding colors.

#### Is Double Sided

Sets whether or not the back side of the image will be drawn.
(Not Cull Off, but an additional side is created for the back side.)

#### Flip backface normal

  Flip the normal of the backface. If the mesh to be set on both sides is impervious to light (e.g., steel), this will set the proper light reception.

#### Backface Light intensity

  Specifies the amount of light received on the backside by a multiplier. For areas that are necessarily dark, such as the backside of a skirt, the multiplier can be lowered to create a natural expression.

#### ZWrite (displayed when arktoon/Fade is specified)

This is a setting related to transparency. Basically, there is no need to touch it with ON,
However, if you want to consider the load, or if ON is not the intended transparency expression, try changing it.

AlphaMask （appears when a variation of the Fade series is specified)
-------------------------------

### What you can do

You can specify the transparency of the material with an additional grayscale texture.

### About each item

#### Alpha Mask

When a black and white texture is specified, it is multiplied by the transparency specified in the Common category.

If the transparency in the Common category is 1, the black and white texture will be the transparency as it is![](https://lh5.googleusercontent.com/p4e-8PdObKeN6yoa6QA4FkASQyV_HgbtZneilh-dOSGet2bY6RoAacEJe6DZqAKgr0a9Cszabc-jdLUO3_YMatCnw3Tq7UWkSFst1Ym1IL4WDam2voRxHRlqtK8y6yA-RKhEEGnnoVn3oac-)

AlphaCutout (appears when arktoon/AlphaCutout is specified)
-----------------------------------------

### What you can do.

You can set the cutout threshold (a value that determines how much of the transparency set in the Main Texture is opaque and how much is translucent) !!![](https://lh4.googleusercontent.com/tVLS761NfDD7Z6bDrkfiq0o3Jc96vF5lhMq2QXJ7gamrAjs2DQuQvmdUX5jwrjtHzLmmt_SM5xGzkqW0X5U5qQDJcgkubPmCwEBTDnUgM3yZRLdfnjFW-_s_3N8Ow8q-dicj19XDl0lrIPLf)

### About each item

#### Cutoff Adjust

Slider to set the alpha opacity/transparency threshold of the main texture.

Example: if 0.5 is specified, the texture's alpha value of 0-127 will be treated as transparent and 128-255 as opaque. [](https://lh5.googleusercontent.com/5groSmZM5NhNAcPxZBbL3GmunOPrDDdG-JRFh8l7tPdcxq_VvgVyA1P9u5Wvtn4ryUbuhkDvHa9AbLELfU5ku98jdDStUaM1lfiJh5v-AxIO8VoBQjZyF6mhnVoDMY7xf7EU4wW35iNbRilJ)

Shadow
------

### What you can do.

You can adjust material shadows.

You can specify not only the strength of the shade, but also the gradation of the shade and the color of the texture in the shade.
In addition, there is a "2nd shade" function that allows you to specify two shade colors as an experimental feature. [](https://lh3.googleusercontent.com/yoyHNYa7CiTOrxX46wF_YMn8OTY11p0UfRxKjJ78V_SXA70QFfufrZZpo63_RFkknzSCr2pm6pDNS_fWlct3emN3XbF4uCLCNsX29fQWBmwHeDTKt12_MaQnES9bf6WJdcFNbzU9pj9f7vB7)![](https://lh5.googleusercontent.com/N92hrD49FPabtUVmOb_w5wtHUyMNu4cEDv1BsogPDNqOa4C2M0Tw1do1C_JSGASvem1_3Qes7_ShVNKs2sssZX3UwhcQeb7vLqzPlXN2LE0cDln0x9PtspYs7g-g3OdwAEbkstADTCsM1bEM)

### For each item.

#### Border pos

 Specify the border point of the shadow.

#### Border blur / Border blur Mask

 Specifies how much the border of the shadow will be gradated. 0 makes the border blurrier, and Border blur Mask allows you to set the spacing of the shadows within the same mesh, as shown in the following image![](https://lh6.googleusercontent.com/LK1_b2n2Sp7nhQqHxW6Jxd7MMVl_Mif5mFwWIbOsiAedY17J0Cmjuu39iCgaX8RgfG_5aFYtU8AoQhiRR7LRVV66CvX9vN76KFEvfe67VcDQe9jg9cfcRIgLcJSeFFWuAwmhWmasCSirWpnm)

#### Strength / Strength Mask

 Specifies the darkness of the shading with a slider.

 You can also use a mask texture to multiply the Strength value as needed.
(This is the same as the general mask found in the Draw tool.)

 If you want to shade the entire image except for the face, you can use a texture that fills only the face with black and the rest of the image with white.
(This is the same as a general mask in Dorotools.

#### Use Steps

 Check this box if you want to posterize the shadow gradient specified in Shadow border. The colors will be divided by the number specified by the slider (decimal points are rounded down).

#### Use Custom Shade

 Check this box if you want to specify your own color or texture for the shaded areas without leaving it to the shader. Strength is not editable during this setting.

#### Mix Default Shadow

        Specifies the ratio of the shader's "original shadow color" to the color set below.

#### Use Shade Texture → Shade Texture

If you want to use a texture to represent the shaded areas, set this option. (We are looking for better sample videos...)

![](https://lh5.googleusercontent.com/tZrzQbC-cU0xtDUoeeky3qqqaxiiM1CUpjoK-3J2knpAdEbQOkeRK0_2Tk4A0k2jP4amrOtHpmQhMlbxJ_5mI7-LWedMc4rUndFmRtE-6KquNOTGUGao5Ay2ZOC7h6frwSwfuyMuwbDdzCfC)

#### Hue Shift / Saturation / Value

If you want to set the shaded area by changing the "Hue / Saturation / Value", use the slider without checking the Shade Texture![](https://lh3.googleusercontent.com/WUFD-_gDUqGus0RMHGInXG6lLTNjjzbX4n5xG-xtPcxdOHY8dWPvr8IvbY7OL-CauabEj9C4QoUpqNccEmoCrz9U8oySMQoj03XGSsCI8tqhx4p7nOjxrCyLg39ErmtcrEmpjZepypVyydnY)

#### 2nd shade (experimental feature)

The color specified with respect to the darker shade can be set in the same way![](https://lh3.googleusercontent.com/4vZhH5QGIyrM-aM5CZxn_d9uMiFxITKQUiecp9UQANzdr6TvxqgMh-A0Sf2oKn-Qf6S9HH-09MLRe7COz7o_3SMaCkzybms0S5vqvQoeqvGLhU0vyqrYTMTB1W02kQM7oIDXrNtEEQY1Lnwj)

Gloss
-----

### What you can do.

You can express "gloss" for real-time light![](https://lh4.googleusercontent.com/Goru4IRNdfTZQWh7VxaEdC_0y2ptOHowtB3E2_yJPvzmt5bmSp6CIWSpYZ4N6gjB3FklBweOQm5O2BOm6f24JsUMa8mzk_zOLmzsTOws613sQ5qzVMIMXFkAc2VMg3ZBtG85kQMMIlpBG9UK)

### About each item.

#### Smoothness / Smoothness Mask

Sets the "smoothness" of the surface. The higher the value, the more light is concentrated and the stronger the reflection.
Mask can be set for a specific part of the mesh.

#### Metallic

Sets the metallic effect. The higher the value, the more the color of the mesh blends with the light.

#### Color

Affects the color of the reflected light.

Outline
-------

### What you can do

You can outline your mesh![](https://lh3.googleusercontent.com/8HHsXnVkhvkUNXbrEB1f0gR3TybugX9XtGhGtCm-yr6CjhTuB5ZzwNqqRvM0WyBmfY2x7DtFH0uvSpHrhfJNVLut0CzN4Osp2Kx1vorc1YqQ8n5KNgHjRMSNmwkftFfCsfPtYSO8ly7ozJHT)

### About each item.

#### Width

Sets the width of the outline.

#### Cutoff Mask / Cutoff Range

Specify the areas of the outline that are not to be drawn by using a mask texture.
The Cutoff Range can be used to adjust the areas not to be drawn.

#### Use Width Mask / Width Mask

You can apply a mask to the "thickness" of the outline. White: 100% to Black: 0%.
(Note that the effect of thickness depends on the number of polygons.)
![](https://lh6.googleusercontent.com/LTbDkY9_lY9Vz7aiPlBBS9cDS26Ludm4l12hyK_2KlTmKjZc_Lqgpil7EicjHnPJ7wjNZoTdHIJemmqzSzXZMHBFVY5cqFV8qV0BoE-0aIpcBV8bebYBGvezwB6KVMY4gGmNIIDc7ujIWYMm)

#### Color

You can set the color of the outline.

#### Shadow mix

Use the slider to specify how much shadow to apply.

#### Base Color Mix

The color specified in Main Color is mixed with the base color.

MatCap
------

### What you can do

You can set a pre-lit "light source" (=MaterialCapture, MatCap) texture for a mesh![](https://lh3.googleusercontent.com/JNmu_lz3bh4gP5a9RUzay80TWgqQmSugKgbVJlwtDoIFKI0ISkxfUomXbWbEz8_XSfjBmtZZSHRGwDDcYE4zBhUZb8m5BxCFC9tEmPmckWZQxbAvz-ADAk_jT8acns1YkKJ-Gt-C8JtKeJOh)

### For each item.

#### Blend Mode (Add:Add, Lighten:Compare(Lighten), Screen:Screen Composite)

Sets how MatCap colors are blended.

#### Blend / Blend Mask

Sets how much to blend using the method set in Blend Mode. Mask textures can be used to control the blending of different parts of the mesh

(Black: 0 to White: Blend value)

#### Normal Map mix

Use the slider to specify how much the Normal map is taken into account when coloring MatCap.

#### Shadow mix

Use the slider to specify how much MatCap is "not" applied to the shaded areas.

#### Texture / Color

Specify MatCap texture and color.

Reflection
----------

### What you can do

Set specular reflection for a mesh![](https://lh3.googleusercontent.com/KswxiZ-69YAbPAY5bc7CC-tffCd8Q2XDt8HeROdUPH3C6L3FXYRtGud1k6Hpb8wJ5NeRBEaxWDr_6f_Tgf6FuZZVocECZ-zz9nz6S-Ixwe6LqP8qIqSmltkgEzJMOGZpfpe3xJUdwRT-aWCD)

### For each item.

#### Use Reflection Probe

Check this box if you want to use a reflection probe in the scene.
If not checked, or if checked but not present in the scene, Cubemap will be used.

#### Smoothness / Smoothness Mask

Sets the "smoothness" of the surface. The higher the value, the more light is concentrated and the stronger the reflection.

Mask can be set for a specific part of the mesh.

#### Normal Map mix

Use the slider to specify how much of the Normal map is taken into account when coloring reflections.

#### Shadow mix

Use the slider to specify how much Reflection is "not" applied to the shaded areas.

#### Suppress Base Color

This slider sets how much to "suppress" the original color of the mesh (≈ Main Color) according to the Reflection coloring.

#### Cubemap (Fallback)

Sets the cubemap texture that will be the reflection source.
If Use Reflection Probe is on, it will be set automatically if it does not exist in the scene.

Rim
---Rim

### What you can do

You can specify the light on the rim of the mesh (called rim light)![](https://lh6.googleusercontent.com/rLHuLNvr0GzL0nuGEUgEIjPqcET7mLVfvcemA6eEV3j12Gtr1YmvGALS8F4jsuQHNIffxuprSsVOtkmjBYeTPCmA2aa8uV8d_mwgtCr3w25LHnN1hzJtCYNFnoUtZUx_uBgXp3XNld7U_DZd)

### For each item.

#### Blend / Blend Mask

Sets how much to color the rim. Mask textures can be used to control the blending of different parts of the mesh

(black: 0 to white: Blend value)

#### Shadow mix

Use the slider to specify how much Rim is "not" applied to the shadow areas.

#### Fresnel Power

Sets the fresnel strength. The higher the value, the more coloring will be applied to the outside of the image.

#### Upper side width

Sets the rim light edge width. By increasing this value and FresnelPower
This value and FresnelPower can be used to express outlines inside the mesh.

#### Use Base Color

Use the color set in the Main Texture.

#### Color / Texture

Sets the color of the rim in Color and Texture.
If \[Use Base Color\ is set, multiply with the color in Main Texture.

ShadeCap
--------

### What you can do.

Allows you to set a pre-lit "shadow" texture for your mesh.
It is a darker version of MatCap. Coined term![](https://lh4.googleusercontent.com/OQZFFRES5UVSi-1gSNF22hEtadgSuaBHHkIA-4kF3814SZfwykduxsIajGQ0taqpRg-5knpj8Xy0kQUi3hGjwYsDrvBYbeEHY_4Ekn4uIt_NxNwKTMZywb4atW2RWsuI6q54vDM3Iw3Oh1z6)

### For each item

#### Blend Mode (Darken:Comparison(Dark), Multiply:Multiply, Light Shutter:Receive Light Masking)

Determines how the ShadeCap is blended

#### Blend / Blend Mask

Sets how much to blend using the method set in Blend Mode. Using a mask texture allows you to control the blending of different parts of the mesh

(Black: 0 to White: Blend value)

#### Normal Map mix

Use the slider to specify how much the Normal map is taken into account when coloring the ShadeCap.

#### Texture / Color

Specify MatCap texture and color.
Color is currently meaningless.

Parallaxed Emission
-------------------

### What you can do

Parallaxed Emission textures can be pasted !!![](https://lh3.googleusercontent.com/3xGEZW8p1Ike85Uf19gNAXSUAtBIww7xvPqI7xHuJFevWjbDs6pXyAVPWsTYDS8FFJYagY1CfKtIk5Swa_IdqxStxp320gsIZjHtk4jVcaVzrBh7yY2zMWRzt_sJ9dYnxr3v-3bxRmU8_yWd)

![](https://lh5.googleusercontent.com/d6aNKdNb15X_nuhlQu2C5OaKUBVosopMO8GdTl4tY0MoGixnZkVpd-cQPef65wqXJnpEpgIDGUmr9fsPXTeJflEg4JygEbvgDMkpC3CjNEsGN42NQd42jJn5DMyiLV_TKXC7U_5OYZq3Bw7t)

### For each item.

#### Texture / Color

Specifies the texture to be displayed, which can be multiplied by setting Color.

#### Mask

Specify where to apply Parallaxed Emission with a black and white texture.

#### Parallax Depth / Parallax Depth Mask

Sets the parallax of what you want to apply.

Positive values bring the object to the foreground, while negative values bring it to the background.

Specifying Parallax Depth Mask multiplies the Depth value specified by the slider.

#### Invert Depth Mask

Invert Depth Mask. Multiplies the Depth value as black=1 to white=0.

Advanced
--------

### What is this?

I'm hiding some settings here that are troublesome to explain, not usually used, or experimental!!![](https://lh5.googleusercontent.com/AYaRs0FYmoD1_3vEFY5IqGyvB2nCX_6Gzcm85VYBswNvHMORqRolVIVAPN2a7iHUh2FuyQNwbZbGoVoL5EM9Zd3rnuQhPytGA8A7taP6oYfbnSjY0ThBY4LBCmTnHZY_8sm5woGxX8nJ0LkY)

### About each item

#### Lights → Sampling Style (default: Arktoon)

You can select the indirect light acquisition condition from Original (Arktoon) and Cubed-Unity-Shader (Cubed).

#### Directional Shadow → Indirect face Intensity (default: 0.25)

Fine-tune the brightness of the "shadow color".

Similar to Shadow Strength, but determines the "shadow color" itself rather than the intensity of the "shadow color".

#### Vertex Colors → Color blend to \[diffuse, emissive\] (default: 0)

If your mesh has a vertex color, you can raise the slider here,
Diffuse (≒Main Texture) / Emissive by increasing this slider.

#### PointLight

Sets the intensity, boundary, etc. of light shading from "non-collimated real-time light.

#### PointLight Shadows → Use Per-vertex Light (default: on)

Sets whether to receive light from point lights in "Per-vertex Lighting" mode.

Basically, it can be on, but turn it off if you want to match the light exposure with other shaders such as Cubed-Shader, or if you are concerned about contour blinking at the back of a mirror.

#### Shade from other meshes

This is a calculation material to consider as "shadows from other meshes".
Basically ignore it.

#### MatCap / ShadeCap

Switches the formula used in MatCap and ShadeCap.
