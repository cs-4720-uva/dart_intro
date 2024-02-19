import 'package:test/test.dart';
import 'package:dart_intro/mcburney/dart_demo/haunted_wasteland.dart';

void main() {
  test("getNodeFromLine test",() {
    var node = getNodeFromLine("AAA = (BBB, CCC)");

    expect(node.name, "AAA");
    expect(node.left, "BBB");
    expect(node.right, "CCC");
  });
}

