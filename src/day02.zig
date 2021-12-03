const std = @import("std");

const data = @embedFile("../data/day02.txt");

pub fn main() anyerror!void {
    try partOne();
    try partTwo();
}

fn partOne() anyerror!void {
    var horizontal: i32 = 0;
    var depth: i32 = 0;
    var it = std.mem.tokenize(u8, data, "\r\n");

    while (it.next()) |line| {
        var line_it = std.mem.tokenize(u8, line, " ");

        const direction = line_it.next().?;
        const amount = try std.fmt.parseInt(i32, line_it.next().?, 10);

        if (std.mem.eql(u8, direction, "forward")) {
            horizontal += amount;
        } else if (std.mem.eql(u8, direction, "down")) {
            depth += amount;
        } else {
            depth -= amount;
        }
    }

    const result = horizontal * depth;

    std.log.info("{}", .{result});
}

fn partTwo() anyerror!void {
    var horizontal: i32 = 0;
    var depth: i32 = 0;
    var aim: i32 = 0;
    var it = std.mem.tokenize(u8, data, "\r\n");

    while (it.next()) |line| {
        var line_it = std.mem.tokenize(u8, line, " ");

        const direction = line_it.next().?;
        const amount = try std.fmt.parseInt(i32, line_it.next().?, 10);

        if (std.mem.eql(u8, direction, "forward")) {
            horizontal += amount;
            depth += aim * amount;
        } else if (std.mem.eql(u8, direction, "down")) {
            aim += amount;
        } else {
            aim -= amount;
        }
    }

    const result = horizontal * depth;

    std.log.info("{}", .{result});
}
