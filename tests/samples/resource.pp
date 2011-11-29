notify { "1": }

notify { "2":
    message => "fun times"
}

notify { "3":
    name => "3",
    message => "fun times"
}

notify { "4":
    name => "4",
    message => "fun times",
}

notify {
    "5":
	message => "fun times";
    "6":
	message => "more fun times"
}

notify {
    "7":
	message => "fun times";
    "8":
	message => "more fun times";
}

notify {
    "9":;
    "10":
}
