# Toplo
A widget framework on top of Bloc.

```Smalltalk
EpMonitor disableDuring: [
  Author useAuthor: 'Load' during: [
    [	Metacello new
        baseline: 'Toplo';
        repository: 'github://plantec/Toplo/src';
        onConflictUseIncoming;
        ignoreImage;
        load.
    ]	on: MCMergeOrLoadWarning
      do: [ :warning | warning load ] ] ]
```

