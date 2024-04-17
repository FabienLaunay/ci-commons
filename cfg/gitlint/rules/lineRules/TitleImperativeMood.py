from gitlint.rules import LineRule, RuleViolation, CommitMessageTitle

class TitleImperativeMood(LineRule):
    name = "title-imperative-mood"
    id = "Z1"
    target = CommitMessageTitle

    def validate(self, line, commit):
        words = line.split(': ', 1)[-1].split()
        first_word = words[0].lower()
        verbs = open('cfg/gitlint/gitlintUserDefinedRules/Verbs.txt', 'r')
        verbsList = verbs.read().splitlines()
        verbs.close()
        found = False
        for verb in verbsList:
            if first_word == verb:
                found = True
                break

        if not found:
            return [RuleViolation(self.id,'Word after first ": " occurrence in title is not a verb in imperative mood.')]