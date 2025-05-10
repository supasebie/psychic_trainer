import 'package:flutter/material.dart' show Color;

class Course {
  final String title, description, iconSrc;
  final Color color;

  Course({
    required this.title,
    required this.description,
    required this.iconSrc,
    required this.color,
  });
}

final Course placeholderCourse = Course(
  title: "Placeholder Course Title",
  description: "This is a fake description for the placeholder course.",
  iconSrc: "assets/icons/code.svg",
  color: const Color(0xFF7553F6),
);

final List<Course> courses = [
  Course(
    title: "Body Scan Meditation",
    description:
        'Enhance your nueral connection across the body with this simple meditation',
    iconSrc: "assets/icons/ios.svg",
    color: const Color(0xFF7553F6),
  ),
  Course(
    title: "Cognition transition between senses ",
    description:
        'Enhance your nueral connection across the body with this simple meditation',
    iconSrc: "assets/icons/code.svg",
    color: const Color(0xFF80A4FF),
  ),
];

final List<Course> recentCourses = [
  Course(
    title: "State Machine",
    description:
        'Enhance your nueral connection across the body with this simple meditation',
    iconSrc: "assets/icons/ios.svg",
    color: const Color(0xFF7553F6),
  ),
  Course(
    title: "Animated Menu",
    description:
        'Enhance your nueral connection across the body with this simple meditation',
    color: const Color(0xFF9CC5FF),
    iconSrc: "assets/icons/code.svg",
  ),
  Course(
    title: "Flutter with Rive",
    description:
        'Enhance your nueral connection across the body with this simple meditation',
    iconSrc: "assets/icons/ios.svg",
    color: const Color(0xFF7553F6),
  ),
  Course(
    title: "Side Menu",
    description:
        'Enhance your nueral connection across the body with this simple meditation',
    color: const Color(0xFF9CC5FF),
    iconSrc: "assets/icons/code.svg",
  ),
];

// import 'package:flutter/material.dart' show Color;

// class Course {
//   final String title, description, iconSrc;
//   final Color color;

//   Course({
//     required this.title,
//     this.description =
//         'Enhance your nueral connection across the body with this simple meditation',
//     this.iconSrc = "assets/icons/ios.svg",
//     this.color = const Color(0xFF7553F6),
//   });
// }

// final List<Course> courses = [
//   Course(title: "Body Scan Meditation"),
//   Course(
//     title: "Cognition transition between senses ",
//     iconSrc: "assets/icons/code.svg",
//     color: const Color(0xFF80A4FF),
//   ),
// ];

// final List<Course> recentCourses = [
//   Course(title: "State Machine"),
//   Course(
//     title: "Animated Menu",
//     color: const Color(0xFF9CC5FF),
//     iconSrc: "assets/icons/code.svg",
//   ),
//   Course(title: "Flutter with Rive"),
//   Course(
//     title: "Animated Menu",
//     color: const Color(0xFF9CC5FF),
//     iconSrc: "assets/icons/code.svg",
//   ),
// ];
