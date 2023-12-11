use ascii;
use bufio;
use fmt;
use io;
use os;
use strconv;
use strings;
use types;


export fn main() void = {
	const f = os::open("./data/03-test")!;
	const scanner = bufio::newscanner(f, types::SIZE_MAX);
	defer bufio::finish(&scanner);
	for (true) {
		const line = match (bufio::scan_line(&scanner)!) {
		case let s: const str => yield s;
		case io::EOF          => break;
		};
		if (len(line) == 0) { continue; };
		fmt::println(line)!;
	};
};
