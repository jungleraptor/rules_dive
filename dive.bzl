def _dive_tar_impl(ctx):
    tarball = ctx.file.src
    dive_bin = ctx.file.dive_bin

    exe = ctx.actions.declare_file(ctx.label.name + ".sh")

    ctx.actions.expand_template(
        template = ctx.file._run_template,
        output = exe,
        substitutions = {
            "{{dive_bin}}": dive_bin.path,
            "{{tarball}}": tarball.short_path,
        },
        is_executable = True,
    )

    runfiles = [tarball, dive_bin]

    return [
        DefaultInfo(files = depset([exe]), runfiles = ctx.runfiles(files = runfiles), executable = exe),
    ]

dive_tar = rule(
    implementation = _dive_tar_impl,
    attrs = {
        "src": attr.label(
            mandatory = True,
            allow_single_file = [".tar"]
        ),
        "dive_bin": attr.label(
            default = "@dive_x86_64",
            allow_single_file = True,
        ),
        "_run_template": attr.label(
            default = Label("//:dive.sh"),
            allow_single_file = True,
        ),
    },
    executable = True,
)

