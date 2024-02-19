import 'dart:collection';
import 'dart:io';

/// From https://adventofcode.com/2023/day/8 - Part 1 only

class Node {
  final String name;
  final String left;
  final String right;

  Node(this.name, this.left, this.right);

  @override
  String toString() {
    return "$name $left $right";
  }
}


/// Line format: AAA = (BBB, CCC)
Node getNodeFromLine(String line) {
  String name = line.substring(0, 3);
  String left = line.substring(7, 10);
  String right = line.substring(12, 15);
  return Node(name, left, right);
}

void main(List<String> args) {
  String filename = args[0];
  List<String> lines = File(filename).readAsLinesSync();
  String directions = lines[0].trim();
  List<Node> nodes = lines.sublist(2)
      .map((e) => getNodeFromLine(e))
      .toList(growable: false);

  Map<String, Node> nameToNode = getNameToNodeMap(nodes);

  int stepsTaken = getTotalSteps(nameToNode, directions);
  print(stepsTaken);
}

int getTotalSteps(Map<String, Node> nameToNode, String directions) {
  Node currentNode = nameToNode["AAA"]!;
  int stepsTaken = 0;

  while (currentNode.name != "ZZZ") {
    String nextDirection = directions[stepsTaken % directions.length];
    if (nextDirection == "L") {
      currentNode = nameToNode[currentNode.left]!;
    } else if (nextDirection == "R") {
      currentNode = nameToNode[currentNode.right]!;
    } else {
      throw StateError("Illegal direction - $nextDirection at index ${stepsTaken % directions.length}");
    }
    stepsTaken++;
  }
  return stepsTaken;
}

Map<String, Node> getNameToNodeMap(List<Node> nodes) {
  Map<String, Node> nameToNode = HashMap();
  for (var node in nodes) {
    nameToNode[node.name] = node;
  }
  return nameToNode;
}

