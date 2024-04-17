#  This material contains trade secrets or otherwise confidential information owned by
#  Siemens Industry Software Inc. or its affiliates (collectively, "SISW"), or its licensors.
#  Access to and use of this information is strictly limited as set forth in the Customer's
#  applicable agreements with SISW.
#
#  Copyright 2024 Siemens

from gitlint.rules import LineRule, RuleViolation, CommitMessageTitle

class TitleImperativeMood(LineRule):
    name = "title-imperative-mood"
    id = "Z1"
    target = CommitMessageTitle

    def validate(self, line, commit):
        words = line.split(': ', 1)[-1].split()
        first_word = words[0].lower()
        verbs = open('cfg/gitlint/txt/Verbs.txt', 'r')
        verbsList = verbs.read().splitlines()
        verbs.close()
        found = False
        for verb in verbsList:
            if first_word == verb:
                found = True
                break

        if not found:
            return [RuleViolation(self.id,'Word after first ": " occurrence in title is not a verb in imperative mood.')]