define foo {
}

define foo {
    $cat = 'meow'
    $dog = 'woof'
}

define foo ($animal) {
}

define foo ($animal, $sound) {
}

define foo ($animal, $sound="meow") {
}

define foo (
    $animal,
    $sound,
) {
}

define foo () {}
