#!/usr/bin/env bash
# 공개 저장소 보안 검사: 키스토어·비밀번호·앱 소스·빌드물이 올라와 있으면 빌드 실패
bad=$(git ls-files | grep -Ei '\.(jks|keystore|p12|pfx|pem|key|kt|kts|java|gradle|aab|apk|env)$|key\.properties|google-services\.json|(^|/)(apps|template|keystore|tools|ui|pc)/' || true)
if [ -n "$bad" ]; then echo "::error::공개 저장소에 금지된 파일이 있습니다:"; echo "$bad"; exit 1; fi
if git grep -nIE '(ghp_|github_pat_|AIza[0-9A-Za-z_-]{30}|sk-ant-)' -- . ':!.github/guard.sh' >/dev/null; then echo "::error::비밀키로 보이는 문자열 발견"; exit 1; fi
echo "보안 검사 통과"
