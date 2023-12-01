use ascii;
use fmt;
use io;
use os;
use strconv;
use strings;

export fn get_digit(iter: strings::iterator) int = {
	for (true) {
		const next = strings::next(&iter);
		match (next) {
		case void =>
			return 0;
		case let r: rune =>
			if (ascii::isdigit(r)) {
				const s = strings::fromrunes([r]);
				return strconv::stoi(s)!;
			};
		};
	};
};

export fn get_line_value(line: str) int = {
	let iter = strings::iter(line);
	let first_digit = get_digit(iter);
	let riter = strings::riter(line);
	let second_digit = get_digit(riter);
	return first_digit * 10 + second_digit;
};

export fn main() void = {
	const data = os::open("./data/01")!;
	const data = io::drain(data)!;
	const data = strings::fromutf8(data)!;
	const lines = strings::split(data, "\n");
	let sum = 0;
	for (let idx = 0z; idx < len(lines); idx += 1) {
		const line = lines[idx];
		if (len(line) == 0) { continue; };
		sum += get_line_value(line);
	};
	fmt::println(sum)!;
};
