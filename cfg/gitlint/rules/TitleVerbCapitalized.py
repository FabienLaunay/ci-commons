from gitlint.rules import LineRule, RuleViolation, CommitMessageTitle


class VerbCapitalized(LineRule):
    name = "title-verb-capitalized"
    id = "UC2"
    target = CommitMessageTitle

    def validate(self, line, commit):
        words = line.split(': ', 1)[-1].split()
        first_word = words[0]
        first_letter = first_word[0]
        if not first_letter.isupper():
            return [RuleViolation(self.id,
                                  'Word after first ": " occurrence in title is not capitalized.')]
