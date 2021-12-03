const std = @import("std");

const data = @embedFile("../data/day01.txt");

pub fn main() anyerror!void {
    try partOne();
    try partTwo();
}

fn partOne() anyerror!void {
    var it = std.mem.tokenize(u8, data, "\r\n");

    // Get the first line. We know for sure something is there
    // and that it is an int.
    const first = it.next() orelse unreachable;
    var prev: i32 = try std.fmt.parseInt(i32, first, 10);

    var count: i32 = 0;

    while (it.next()) |line| {
        // This is definitely an int.
        const current = try std.fmt.parseInt(i32, line, 10);

        if (current > prev) {
            count += 1;
        }

        prev = current;
    }

    std.log.info("{}", .{count});
}

fn partTwo() anyerror!void {
    var it = std.mem.tokenize(u8, data, "\r\n");

    const line_one = it.next() orelse unreachable;
    const line_two = it.next() orelse unreachable;
    const line_three = it.next() orelse unreachable;

    var one = try std.fmt.parseInt(i32, line_one, 10);
    var two = try std.fmt.parseInt(i32, line_two, 10);
    var three = try std.fmt.parseInt(i32, line_three, 10);

    var prev_sum = one + two + three;

    var count: i32 = 0;

    while (it.next()) |line| {
        one = two;
        two = three;

        three = try std.fmt.parseInt(i32, line, 10);

        const current_sum = one + two + three;

        if ((current_sum - prev_sum) > 0) {
            count += 1;
        }

        prev_sum = current_sum;
    }

    std.log.info("{}", .{count});
}
