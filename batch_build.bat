::calls the build commands for the editor, the debug template, the
::release template and the android template in succession.
::At completion, all the good stuff will be in the bin/ folder
::I have very little knowledge of batch scripting but... it works!
::Each line that starts with "CALL scons" is a compilation command- I usually comment out 
::all of them except the debug template after making a change to the code just to see if
::it compiles (and runs) without error (I think there's a way to exit the script early if
::a command exits with error but I've been too lazy to look into it).

@echo off
set /p num_cores="Number of cores to use: "

REM echo. Compiling editor...
REM CALL scons -j %num_cores% platform=windows target=release_debug use_mingw=yes
REM echo Finished batch build!

::add use_static_cpp=yes for production build (https://github.com/godotengine/godot/pull/45679)

REM This chunk of arguments gets appended to all the export template compilation commands
REM Here is where you decide what modules you don't need
set batch_args= tools=no xml=no disable_3d=yes ^
     disable_advanced_gui=yes module_bullet_enabled=no builtin_bullet=no builtin_enet=no ^
     builtin_libtheora=no builtin_libvpx=no builtin_libwebp=no  builtin_recast=no ^
	 builtin_thekla_atlas=no builtin_pcre2=no builtin_opus=no builtin_openssl=no ^
	 module_bmp_enabled=no module_openssl_enabled=no ^
	 module_csg_enabled=no module_cvtt_enabled=no module_dds_enabled=no ^
	 module_enet_enabled=no module_gridmap_enabled=no module_hdr_enabled=no ^
	 module_jpg_enabled=no module_mbedtls_enabled=no module_mobile_vr_enabled=no ^
	 module_mono_enabled=no module_opus_enabled=no module_pvr_enabled=no module_recast_enabled=no ^
	 module_regex_enabled=no module_squish_enabled=no module_tga_enabled=no ^
	 module_thekla_unwrap_enabled=no module_theora_enabled=no module_tinyexr_enabled=no ^
	 module_upnp_enabled=no module_visual_script_enabled=no module_webm_enabled=no ^
	 module_webp_enabled=no module_websocket_enabled=no deprecated=no minizip=no ^
	 module_svg_enabled=no module_gdnative_enabled=no
 ::module_vorbis_enabled=no module_stb_vorbis_enabled=no
	 
	



REM echo Compiling debug template...
REM CALL scons -j %num_cores% platform=windows target=release_debug tools=no %batch_args%
REM echo.	
 
REM echo Compiling release template...
REM CALL scons -j %num_cores% platform=windows target=release tools=no %batch_args%
REM echo.

REM echo Compiling android debug template...
REM echo.   - armv7
REM CALL scons -j %num_cores% platform=android target=release_debug android_arch=armv7 %%batch_args%%
REM echo.   - armv8
REM CALL scons -j %num_cores% platform=android target=release_debug android_arch=arm64v8 %%batch_args%%
REM echo.   - x86
REM CALL scons -j %num_cores% platform=android target=release_debug android_arch=x86 %%batch_args%%
REM echo.   - x86_64
REM CALL scons -j %num_cores% platform=android target=release_debug android_arch=x86_64 %%batch_args%%
REM cd platform/android/java
REM CALL .\gradlew generateGodotTemplates
REM cd ..
REM cd ..
REM cd ..
REM echo.

echo Compiling android release template...
echo.   - armv7
CALL scons -j %num_cores% platform=android target=release use_static_cpp=yes android_arch=armv7 %%batch_args%%
echo.   - armv8
CALL scons -j %num_cores% platform=android target=release use_static_cpp=yes android_arch=arm64v8 %%batch_args%% 
echo.   - x86
CALL scons -j %num_cores% platform=android target=release android_arch=x86 %%batch_args%%
echo.   - x86_64
CALL scons -j %num_cores% platform=android target=release android_arch=x86_64 %%batch_args%%
cd platform/android/java
CALL .\gradlew generateGodotTemplates
cd ..
cd ..
cd ..
echo Finished batch build!