const std = @import("std");

const data = @embedFile("../data/day03.txt");

pub fn main() anyerror!void {
    try partOne();
}

fn partOne() anyerror!void {
    var arena = std.heap.ArenaAllocator.init(std.heap.page_allocator);
    defer arena.deinit();

    var it = std.mem.tokenize(u8, data, "\r\n");

    var ones: [12]std.ArrayList(u8) = undefined;
    var zeros: [12]std.ArrayList(u8) = undefined;

    var index: usize = 0;
    while (index < 12) {
        ones[index] = std.ArrayList(u8).init(arena.allocator());
        zeros[index] = std.ArrayList(u8).init(arena.allocator());

        index += 1;
    }

    while (it.next()) |line| {
        index = 0;

        for (line) |bit| {
            if (bit == '0') {
                try zeros[index].append(bit);
            } else {
                try ones[index].append(bit);
            }

            index += 1;
        }
    }

    var gamma_string = std.ArrayList(u8).init(arena.allocator());
    var epsilon_string = std.ArrayList(u8).init(arena.allocator());

    index = 0;
    while (index < 12) {
        if (ones[index].items.len > zeros[index].items.len) {
            try gamma_string.append('1');
            try epsilon_string.append('0');
        } else {
            try gamma_string.append('0');
            try epsilon_string.append('1');
        }

        index += 1;
    }

    const gamma = try std.fmt.parseInt(i32, gamma_string.items, 2);
    const epsilon = try std.fmt.parseInt(i32, epsilon_string.items, 2);

    const result = gamma * epsilon;

    std.log.info("{}", .{result});
}
