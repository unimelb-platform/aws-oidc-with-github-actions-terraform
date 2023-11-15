.PHONY: validate
validate:
	pre-commit run --all-files --color always --show-diff-on-failure

.PHONY: install
install:
	pre-commit install \
		--hook-type pre-commit \
		--hook-type commit-msg
