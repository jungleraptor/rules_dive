def dive_tar(name, src):
    native.sh_binary(
        name = name,
        srcs = ["dive.sh"],
        args = ["$(location {})".format(src)],
        data = ["{}".format(src)],
    )
