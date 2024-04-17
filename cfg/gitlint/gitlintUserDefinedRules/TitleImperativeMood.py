#  This material contains trade secrets or otherwise confidential information owned by
#  Siemens Industry Software Inc. or its affiliates (collectively, "SISW"), or its licensors.
#  Access to and use of this information is strictly limited as set forth in the Customer's
#  applicable agreements with SISW.
#
#  Copyright 2024 Siemens

from gitlint.rules import LineRule, RuleViolation, CommitMessageTitle

class ImperativeMood(LineRule):
    name = "title-imperative-mood"
    id = "Z1"
    target = CommitMessageTitle

    def validate(self, line, commit):
        words = line.split(': ', 1)[-1].split()
        first_word = words[0].lower()
        # verbs = open('C:\\Temp\\Gitlint\\gitlintUserDefinedRules\\verbs.txt', 'r')
        verbs = open('cfg/gitlint/gitlintUserDefinedRules/verbs.txt', 'r')
        verbsList = verbs.read().splitlines()
        verbs.close()
        found = False
        for verb in verbsList:
            if first_word == verb:
                found = True
                break

        if not found:
            return [RuleViolation(self.id,'Word after first ": " occurrence in title is not a verb in imperative mood.')]

class VerbCapitalized(LineRule):
    name = "title-verb-capitalized"
    id = "Z2"
    target = CommitMessageTitle

    def validate(self, line, commit):
        words = line.split(': ', 1)[-1].split()
        first_word = words[0]
        first_letter = first_word[0]
        if not first_letter.isupper():
            return [RuleViolation(self.id,'Word after first ": " occurrence in title is not capitalized.')]