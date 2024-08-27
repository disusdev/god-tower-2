const std = @import("std");

pub fn build(b: *std.Build) void {
    const target = b.standardTargetOptions(.{});
    const optimize = b.standardOptimizeOption(.{});
    const exe = b.addExecutable(.{
        .name = "cgame",
        .target = target,
        .optimize = optimize,
    });
    
    const flags = &.{
        "-DNDEBUG",
        "-DINITIAL_PROGRAM_MEMORY_SIZE MB(5)",
        "-DTEMPORARY_STORAGE_SIZE MB(2)",
        "-DENTRY_PROC entry",
    };
    
    exe.addIncludePath( b.path("oogabooga") );
    
    exe.addCSourceFiles(.{
        .files = &.{
            "game/game.c",
        },
        .flags = flags,
    });

    exe.addLibraryPath( .{ .cwd_relative = "C:/Program Files (x86)/Windows Kits/10/Lib/10.0.26100.0/um/x64" } );
    exe.linkSystemLibrary("runtimeobject");
    exe.linkSystemLibrary("d3dcompiler");

    exe.linkSystemLibrary("kernel32");
    exe.linkSystemLibrary("gdi32");
    exe.linkSystemLibrary("user32");
    exe.linkSystemLibrary("winmm");
    exe.linkSystemLibrary("d3d11");
    exe.linkSystemLibrary("dxguid");
    exe.linkSystemLibrary("shlwapi");
    exe.linkSystemLibrary("ole32");
    exe.linkSystemLibrary("shcore");
    exe.linkSystemLibrary("avrt");
    exe.linkSystemLibrary("ksuser");
    exe.linkSystemLibrary("dbghelp");
    
    b.installArtifact(exe);
}