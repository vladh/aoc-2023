use ascii;
use fmt;
use io;
use os;
use strconv;
use strings;

export fn get_digit(iter: strings::iterator, line: str, reverse: bool) int = {
	let next_idx = 0z;
	for (true) {
		const next = strings::next(&iter);
		next_idx += 1;
		match (next) {
		case void =>
			return 0;
		case let r: rune =>
			if (ascii::isdigit(r)) {
				const s = strings::fromrunes([r]);
				return strconv::stoi(s)!;
			};
			const sub = if (reverse) {
				yield strings::sub(line, len(line) - next_idx - 1, strings::end);
			} else {
				yield strings::sub(line, next_idx - 1, strings::end);
			};
			if (strings::hasprefix(sub, "one")) { return 1; };
			if (strings::hasprefix(sub, "two")) { return 2; };
			if (strings::hasprefix(sub, "three")) { return 3; };
			if (strings::hasprefix(sub, "four")) { return 4; };
			if (strings::hasprefix(sub, "five")) { return 5; };
			if (strings::hasprefix(sub, "six")) { return 6; };
			if (strings::hasprefix(sub, "seven")) { return 7; };
			if (strings::hasprefix(sub, "eight")) { return 8; };
			if (strings::hasprefix(sub, "nine")) { return 9; };
		};
	};
};

export fn get_line_value(line: str) int = {
	let iter = strings::iter(line);
	let first_digit = get_digit(iter, line, false);
	let riter = strings::riter(line);
	let second_digit = get_digit(riter, line, true);
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