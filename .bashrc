cd() {
    builtin cd "$@" && ls --color=auto
}
