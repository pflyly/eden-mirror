# SPDX-FileCopyrightText: 2018 yuzu Emulator Project
# SPDX-License-Identifier: GPL-2.0-or-later

add_subdirectory(host_shaders)

if(LIBVA_FOUND)
    set_source_files_properties(host1x/ffmpeg/ffmpeg.cpp
        PROPERTIES COMPILE_DEFINITIONS LIBVA_FOUND=1)
    list(APPEND FFmpeg_LIBRARIES ${LIBVA_LIBRARIES})
endif()

add_library(video_core STATIC
    buffer_cache/buffer_base.h
    buffer_cache/buffer_cache_base.h
    buffer_cache/buffer_cache.cpp
    buffer_cache/buffer_cache.h
    buffer_cache/memory_tracker_base.h
    buffer_cache/usage_tracker.h
    buffer_cache/word_manager.h
    cache_types.h
    capture.h
    cdma_pusher.cpp
    cdma_pusher.h
    compatible_formats.cpp
    compatible_formats.h
    control/channel_state.cpp
    control/channel_state.h
    control/channel_state_cache.cpp
    control/channel_state_cache.h
    control/scheduler.cpp
    control/scheduler.h
    delayed_destruction_ring.h
    dirty_flags.cpp
    dirty_flags.h
    dma_pusher.cpp
    dma_pusher.h
    engines/sw_blitter/blitter.cpp
    engines/sw_blitter/blitter.h
    engines/sw_blitter/converter.cpp
    engines/sw_blitter/converter.h
    engines/const_buffer_info.h
    engines/draw_manager.cpp
    engines/draw_manager.h
    engines/engine_interface.h
    engines/engine_upload.cpp
    engines/engine_upload.h
    engines/fermi_2d.cpp
    engines/fermi_2d.h
    engines/kepler_compute.cpp
    engines/kepler_compute.h
    engines/kepler_memory.cpp
    engines/kepler_memory.h
    engines/maxwell_3d.cpp
    engines/maxwell_3d.h
    engines/maxwell_dma.cpp
    engines/maxwell_dma.h
    engines/puller.cpp
    engines/puller.h
    framebuffer_config.cpp
    framebuffer_config.h
    fsr.cpp
    fsr.h
    host1x/codecs/decoder.cpp
    host1x/codecs/decoder.h
    host1x/codecs/h264.cpp
    host1x/codecs/h264.h
    host1x/codecs/vp8.cpp
    host1x/codecs/vp8.h
    host1x/codecs/vp9.cpp
    host1x/codecs/vp9.h
    host1x/codecs/vp9_types.h
    host1x/ffmpeg/ffmpeg.cpp
    host1x/ffmpeg/ffmpeg.h
    host1x/control.cpp
    host1x/control.h
    host1x/gpu_device_memory_manager.cpp
    host1x/gpu_device_memory_manager.h
    host1x/host1x.cpp
    host1x/host1x.h
    host1x/nvdec.cpp
    host1x/nvdec.h
    host1x/nvdec_common.h
    host1x/syncpoint_manager.cpp
    host1x/syncpoint_manager.h
    host1x/vic.cpp
    host1x/vic.h
    macro/macro.cpp
    macro/macro.h
    macro/macro_hle.cpp
    macro/macro_hle.h
    macro/macro_interpreter.cpp
    macro/macro_interpreter.h
    fence_manager.h
    gpu.cpp
    gpu.h
    gpu_thread.cpp
    gpu_thread.h
    guest_memory.h
    invalidation_accumulator.h
    memory_manager.cpp
    memory_manager.h
    precompiled_headers.h
    present.h
    pte_kind.h
    query_cache/bank_base.h
    query_cache/query_base.h
    query_cache/query_cache_base.h
    query_cache/query_cache.h
    query_cache/query_stream.h
    query_cache/types.h
    query_cache.h
    rasterizer_interface.h
    renderer_base.cpp
    renderer_base.h
    renderer_null/null_rasterizer.cpp
    renderer_null/null_rasterizer.h
    renderer_null/renderer_null.cpp
    renderer_null/renderer_null.h
    renderer_opengl/present/filters.cpp
    renderer_opengl/present/filters.h
    renderer_opengl/present/fsr.cpp
    renderer_opengl/present/fsr.h
    renderer_opengl/present/fxaa.cpp
    renderer_opengl/present/fxaa.h
    renderer_opengl/present/layer.cpp
    renderer_opengl/present/layer.h
    renderer_opengl/present/present_uniforms.h
    renderer_opengl/present/smaa.cpp
    renderer_opengl/present/smaa.h
    renderer_opengl/present/util.h
    renderer_opengl/present/window_adapt_pass.cpp
    renderer_opengl/present/window_adapt_pass.h
    renderer_opengl/blit_image.cpp
    renderer_opengl/blit_image.h
    renderer_opengl/gl_blit_screen.cpp
    renderer_opengl/gl_blit_screen.h
    renderer_opengl/gl_buffer_cache_base.cpp
    renderer_opengl/gl_buffer_cache.cpp
    renderer_opengl/gl_buffer_cache.h
    renderer_opengl/gl_compute_pipeline.cpp
    renderer_opengl/gl_compute_pipeline.h
    renderer_opengl/gl_device.cpp
    renderer_opengl/gl_device.h
    renderer_opengl/gl_fence_manager.cpp
    renderer_opengl/gl_fence_manager.h
    renderer_opengl/gl_graphics_pipeline.cpp
    renderer_opengl/gl_graphics_pipeline.h
    renderer_opengl/gl_rasterizer.cpp
    renderer_opengl/gl_rasterizer.h
    renderer_opengl/gl_resource_manager.cpp
    renderer_opengl/gl_resource_manager.h
    renderer_opengl/gl_shader_cache.cpp
    renderer_opengl/gl_shader_cache.h
    renderer_opengl/gl_shader_manager.cpp
    renderer_opengl/gl_shader_manager.h
    renderer_opengl/gl_shader_context.h
    renderer_opengl/gl_shader_util.cpp
    renderer_opengl/gl_shader_util.h
    renderer_opengl/gl_state_tracker.cpp
    renderer_opengl/gl_state_tracker.h
    renderer_opengl/gl_staging_buffer_pool.cpp
    renderer_opengl/gl_staging_buffer_pool.h
    renderer_opengl/gl_texture_cache.cpp
    renderer_opengl/gl_texture_cache.h
    renderer_opengl/gl_texture_cache_base.cpp
    renderer_opengl/gl_query_cache.cpp
    renderer_opengl/gl_query_cache.h
    renderer_opengl/maxwell_to_gl.h
    renderer_opengl/renderer_opengl.cpp
    renderer_opengl/renderer_opengl.h
    renderer_opengl/util_shaders.cpp
    renderer_opengl/util_shaders.h
    renderer_vulkan/present/anti_alias_pass.h
    renderer_vulkan/present/filters.cpp
    renderer_vulkan/present/filters.h
    renderer_vulkan/present/fsr.cpp
    renderer_vulkan/present/fsr.h
    renderer_vulkan/present/fxaa.cpp
    renderer_vulkan/present/fxaa.h
    renderer_vulkan/present/layer.cpp
    renderer_vulkan/present/layer.h
    renderer_vulkan/present/present_push_constants.h
    renderer_vulkan/present/smaa.cpp
    renderer_vulkan/present/smaa.h
    renderer_vulkan/present/util.cpp
    renderer_vulkan/present/util.h
    renderer_vulkan/present/window_adapt_pass.cpp
    renderer_vulkan/present/window_adapt_pass.h
    renderer_vulkan/blit_image.cpp
    renderer_vulkan/blit_image.h
    renderer_vulkan/fixed_pipeline_state.cpp
    renderer_vulkan/fixed_pipeline_state.h
    renderer_vulkan/maxwell_to_vk.cpp
    renderer_vulkan/maxwell_to_vk.h
    renderer_vulkan/pipeline_helper.h
    renderer_vulkan/pipeline_statistics.cpp
    renderer_vulkan/pipeline_statistics.h
    renderer_vulkan/renderer_vulkan.h
    renderer_vulkan/renderer_vulkan.cpp
    renderer_vulkan/vk_blit_screen.cpp
    renderer_vulkan/vk_blit_screen.h
    renderer_vulkan/vk_buffer_cache_base.cpp
    renderer_vulkan/vk_buffer_cache.cpp
    renderer_vulkan/vk_buffer_cache.h
    renderer_vulkan/vk_command_pool.cpp
    renderer_vulkan/vk_command_pool.h
    renderer_vulkan/vk_compute_pass.cpp
    renderer_vulkan/vk_compute_pass.h
    renderer_vulkan/vk_compute_pipeline.cpp
    renderer_vulkan/vk_compute_pipeline.h
    renderer_vulkan/vk_descriptor_pool.cpp
    renderer_vulkan/vk_descriptor_pool.h
    renderer_vulkan/vk_fence_manager.cpp
    renderer_vulkan/vk_fence_manager.h
    renderer_vulkan/vk_graphics_pipeline.cpp
    renderer_vulkan/vk_graphics_pipeline.h
    renderer_vulkan/vk_master_semaphore.cpp
    renderer_vulkan/vk_master_semaphore.h
    renderer_vulkan/vk_pipeline_cache.cpp
    renderer_vulkan/vk_pipeline_cache.h
    renderer_vulkan/vk_present_manager.cpp
    renderer_vulkan/vk_present_manager.h
    renderer_vulkan/vk_query_cache.cpp
    renderer_vulkan/vk_query_cache.h
    renderer_vulkan/vk_rasterizer.cpp
    renderer_vulkan/vk_rasterizer.h
    renderer_vulkan/vk_render_pass_cache.cpp
    renderer_vulkan/vk_render_pass_cache.h
    renderer_vulkan/vk_resource_pool.cpp
    renderer_vulkan/vk_resource_pool.h
    renderer_vulkan/vk_scheduler.cpp
    renderer_vulkan/vk_scheduler.h
    renderer_vulkan/vk_shader_util.cpp
    renderer_vulkan/vk_shader_util.h
    renderer_vulkan/vk_staging_buffer_pool.cpp
    renderer_vulkan/vk_staging_buffer_pool.h
    renderer_vulkan/vk_state_tracker.cpp
    renderer_vulkan/vk_state_tracker.h
    renderer_vulkan/vk_swapchain.cpp
    renderer_vulkan/vk_swapchain.h
    renderer_vulkan/vk_texture_cache.cpp
    renderer_vulkan/vk_texture_cache.h
    renderer_vulkan/vk_texture_cache_base.cpp
    renderer_vulkan/vk_turbo_mode.cpp
    renderer_vulkan/vk_turbo_mode.h
    renderer_vulkan/vk_update_descriptor.cpp
    renderer_vulkan/vk_update_descriptor.h
    shader_cache.cpp
    shader_cache.h
    shader_environment.cpp
    shader_environment.h
    shader_notify.cpp
    shader_notify.h
    smaa_area_tex.h
    smaa_search_tex.h
    surface.cpp
    surface.h
    texture_cache/accelerated_swizzle.cpp
    texture_cache/accelerated_swizzle.h
    texture_cache/decode_bc.cpp
    texture_cache/decode_bc.h
    texture_cache/descriptor_table.h
    texture_cache/formatter.cpp
    texture_cache/formatter.h
    texture_cache/format_lookup_table.cpp
    texture_cache/format_lookup_table.h
    texture_cache/image_base.cpp
    texture_cache/image_base.h
    texture_cache/image_info.cpp
    texture_cache/image_info.h
    texture_cache/image_view_base.cpp
    texture_cache/image_view_base.h
    texture_cache/image_view_info.cpp
    texture_cache/image_view_info.h
    texture_cache/render_targets.h
    texture_cache/samples_helper.h
    texture_cache/texture_cache.cpp
    texture_cache/texture_cache.h
    texture_cache/texture_cache_base.h
    texture_cache/types.h
    texture_cache/util.cpp
    texture_cache/util.h
    textures/astc.h
    textures/astc.cpp
    textures/bcn.cpp
    textures/bcn.h
    textures/decoders.cpp
    textures/decoders.h
    textures/texture.cpp
    textures/texture.h
    textures/workers.cpp
    textures/workers.h
    transform_feedback.cpp
    transform_feedback.h
    video_core.cpp
    video_core.h
    vulkan_common/vulkan_debug_callback.cpp
    vulkan_common/vulkan_debug_callback.h
    vulkan_common/vulkan_device.cpp
    vulkan_common/vulkan_device.h
    vulkan_common/vulkan_instance.cpp
    vulkan_common/vulkan_instance.h
    vulkan_common/vulkan_library.cpp
    vulkan_common/vulkan_library.h
    vulkan_common/vulkan_memory_allocator.cpp
    vulkan_common/vulkan_memory_allocator.h
    vulkan_common/vulkan_surface.cpp
    vulkan_common/vulkan_surface.h
    vulkan_common/vulkan_wrapper.cpp
    vulkan_common/vulkan_wrapper.h
    vulkan_common/nsight_aftermath_tracker.cpp
    vulkan_common/nsight_aftermath_tracker.h
    vulkan_common/vma.cpp
    vulkan_common/vma.h
    vulkan_common/vulkan.h
)

target_link_libraries(video_core PUBLIC common core)
target_link_libraries(video_core PUBLIC glad shader_recompiler stb bc_decoder)

if (YUZU_USE_BUNDLED_FFMPEG AND NOT (WIN32 OR ANDROID))
    add_dependencies(video_core ffmpeg-build)
endif()

target_include_directories(video_core PRIVATE ${FFmpeg_INCLUDE_DIR})
target_link_libraries(video_core PRIVATE ${FFmpeg_LIBRARIES})
target_link_options(video_core PRIVATE ${FFmpeg_LDFLAGS})

add_dependencies(video_core host_shaders)
target_include_directories(video_core PRIVATE ${HOST_SHADERS_INCLUDE})
target_link_libraries(video_core PRIVATE sirit Vulkan::Headers Vulkan::UtilityHeaders GPUOpen::VulkanMemoryAllocator)

if (ENABLE_NSIGHT_AFTERMATH)
    if (NOT DEFINED ENV{NSIGHT_AFTERMATH_SDK})
        message(FATAL_ERROR "Environment variable NSIGHT_AFTERMATH_SDK has to be provided")
    endif()
    if (NOT WIN32)
        message(FATAL_ERROR "Nsight Aftermath doesn't support non-Windows platforms")
    endif()
    target_compile_definitions(video_core PRIVATE HAS_NSIGHT_AFTERMATH)
    target_include_directories(video_core PRIVATE "$ENV{NSIGHT_AFTERMATH_SDK}/include")
endif()

if (MSVC)
    target_compile_options(video_core PRIVATE
        /we4242 # 'identifier': conversion from 'type1' to 'type2', possible loss of data
        /we4244 # 'conversion': conversion from 'type1' to 'type2', possible loss of data
    )
else()
    if (APPLE)
        # error: declaration shadows a typedef in 'interval_base_set<SubType, DomainT, Compare, Interval, Alloc>'
        # error: implicit conversion loses integer precision: 'int' to 'boost::icl::bound_type' (aka 'unsigned char')
        target_compile_options(video_core PRIVATE -Wno-shadow -Wno-unused-local-typedef)
    else()
        target_compile_options(video_core PRIVATE -Werror=conversion)
    endif()

    target_compile_options(video_core PRIVATE
        -Wno-sign-conversion
    )

    # xbyak
    set_source_files_properties(macro/macro_jit_x64.cpp PROPERTIES COMPILE_OPTIONS "-Wno-conversion;-Wno-shadow")

    # VMA
    set_source_files_properties(vulkan_common/vma.cpp PROPERTIES COMPILE_OPTIONS "-Wno-conversion;-Wno-unused-variable;-Wno-unused-parameter;-Wno-missing-field-initializers")

    # Get around GCC failing with intrinsics in Debug
    if (CMAKE_CXX_COMPILER_ID STREQUAL "GNU" AND CMAKE_BUILD_TYPE MATCHES "Debug")
        set_source_files_properties(host1x/vic.cpp PROPERTIES COMPILE_OPTIONS "-O2")
    endif()
endif()

if (ARCHITECTURE_x86_64)
    target_sources(video_core PRIVATE
        macro/macro_jit_x64.cpp
        macro/macro_jit_x64.h
    )
    target_link_libraries(video_core PUBLIC xbyak::xbyak)

    if (NOT MSVC)
        target_compile_options(video_core PRIVATE -msse4.1)
    endif()
endif()

if (ARCHITECTURE_x86_64 OR ARCHITECTURE_arm64)
    target_link_libraries(video_core PRIVATE dynarmic::dynarmic)
endif()

if (YUZU_USE_PRECOMPILED_HEADERS)
    target_precompile_headers(video_core PRIVATE precompiled_headers.h)
endif()

if (YUZU_ENABLE_LTO)
  set_property(TARGET video_core PROPERTY INTERPROCEDURAL_OPTIMIZATION TRUE)
endif()

if (ANDROID AND ARCHITECTURE_arm64)
    target_link_libraries(video_core PRIVATE adrenotools)
endif()

if (ARCHITECTURE_arm64)
    target_link_libraries(video_core PRIVATE sse2neon)
endif()

create_target_directory_groups(video_core)
