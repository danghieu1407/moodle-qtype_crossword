<?php
// This file is part of Moodle - http://moodle.org/
//
// Moodle is free software: you can redistribute it and/or modify
// it under the terms of the GNU General Public License as published by
// the Free Software Foundation, either version 3 of the License, or
// (at your option) any later version.
//
// Moodle is distributed in the hope that it will be useful,
// but WITHOUT ANY WARRANTY; without even the implied warranty of
// MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
// GNU General Public License for more details.
//
// You should have received a copy of the GNU General Public License
// along with Moodle.  If not, see <http://www.gnu.org/licenses/>.

namespace qtype_crossword;

defined('MOODLE_INTERNAL') || die();

global $CFG;
require_once($CFG->dirroot . '/question/engine/tests/helpers.php');

/**
 * Unit tests for qtype_crossword answer.
 *
 * @package qtype_crossword
 * @copyright 2022 The Open University
 * @license http://www.gnu.org/copyleft/gpl.html GNU GPL v3 or later
 */
final class answer_test extends \advanced_testcase {

    /**
     * Test is_correct function.
     *
     * @dataProvider is_correct_test_provider
     * @covers \qtype_crossword_question::is_correct
     */
    public function test_is_correct(array $answerdata): void {
        // Create a normal crossword question.
        $q = \test_question_maker::make_question('crossword', 'normal_with_hyphen_space_and_apostrophes');
        foreach ($q->answers as $key => $answer) {
            $this->assertTrue($answer->is_correct($answerdata[$key]));
        }
    }

    /**
     * Data provider for test_is_correct() test cases.
     *
     * @return array List of data sets (test cases)
     */
    public static function is_correct_test_provider(): array {
        return [
            'Normal case' => [
                ['TIM BERNERS-LEE', 'GORDON BROWN', 'DAVID ATTENBOROUGH', "ALBERT EINSTEIN'S THEORY"],
            ],
            'With Underscore' => [
                ['TIM_BERNERS-LEE', 'GORDON_BROWN', 'DAVID_ATTENBOROUGH', "ALBERT_EINSTEIN'S_THEORY"],
            ],
        ];
    }

    /**
     * Test generate_answer_hint function.
     *
     * @covers \qtype_crossword_question::generate_answer_hint
     */
    public function test_generate_answer_hint(): void {
        // Create a normal crossword question.
        $q = \test_question_maker::make_question('crossword', 'normal_with_hyphen_space_and_apostrophes');
        $expecteddata = [
            ['3, 7-3', ['space' => [3], 'hyphen' => [11]]],
            ['6, 5', ['space' => [6]]],
            ['5, 12', ['space' => [5]]],
            ['6, 8\'1, 6', ['space' => [6, 17], 'straightsinglequote' => [15]]],
        ];
        foreach ($q->answers as $key => $answer) {
            $this->assertEquals($expecteddata[$key], $answer->generate_answer_hint());
        }
    }
}
