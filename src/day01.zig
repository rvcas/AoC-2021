const std = @import("std");

const data = @embedFile("../data/day01.txt");

pub fn main() anyerror!void {
    var it = std.mem.tokenize(u8, data, "\r\n");

    // Get the first line. We know for sure something is there
    // and that it is an int.
    const first = it.next() orelse unreachable;
    var prev: i32 = std.fmt.parseInt(i32, first, 10) catch unreachable;

    var count: i32 = 0;

    while (it.next()) |line| {
        // This is definitely an int.
        const current = std.fmt.parseInt(i32, line, 10) catch unreachable;

        if ((current - prev) > 0) {
            count += 1;
        }

        prev = current;
    }

    std.log.info("{}", .{count});
}
