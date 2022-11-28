FROM haskell:9.2-slim
RUN apt-get update
RUN apt install libpq-dev -y
RUN cabal update
EXPOSE 8080
COPY todo.cabal .
COPY CHANGELOG.md .
RUN cabal build --dependencies-only
COPY app ./app
COPY src ./src
RUN cabal install exe:todo-exe
ENTRYPOINT [ "todo-exe" ]
