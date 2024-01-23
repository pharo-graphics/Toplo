Class {
	#name : #ToObservableCollectionQueryRunner,
	#superclass : #Object,
	#instVars : [
		'pattern',
		'semaphore',
		'process',
		'delayBeforeFilter',
		'previousPattern',
		'dataFilter',
		'selectedIndexes'
	],
	#category : #'Toplo-Core-CollectionQuery'
}

{ #category : #'private filtering' }
ToObservableCollectionQueryRunner >> applyDataFilterIn: anObservableCollection [

	| event |
	anObservableCollection dispatchEvent:
		(ToObservableCollectionQueryPatternChangedEvent new
			 selector: self;
			 yourself).
	self pattern
		ifEmpty: [ selectedIndexes := OrderedCollection new ]
		ifNotEmpty: [
			selectedIndexes := Array streamContents: [ :stream |
				                   anObservableCollection withIndexDo: [ :d :idx |
					                   (self dataFilter value: d value: self pattern)
						                   ifTrue: [ stream nextPut: idx ] ] ] ].
	event := ToObservableCollectionQueryResultEvent new.
	event selector: self.
	anObservableCollection dispatchEvent: event
]

{ #category : #accessing }
ToObservableCollectionQueryRunner >> dataFilter [

	^ dataFilter ifNil: [ dataFilter := self defaultFilter ]
]

{ #category : #accessing }
ToObservableCollectionQueryRunner >> dataFilter: aValuable [
	" filter takes a data and a pattern as argument "

	dataFilter := aValuable
]

{ #category : #accessing }
ToObservableCollectionQueryRunner >> defaultDelay [

	^ 250 milliSeconds
]

{ #category : #accessing }
ToObservableCollectionQueryRunner >> defaultFilter [

	"^ [ :data :p | data includesSubstring: p caseSensitive: false ]"
	^ [ :aData :aPattern | aData asString beginsWith: aPattern caseSensitive: true ]
]

{ #category : #accessing }
ToObservableCollectionQueryRunner >> delayBeforeFilter [

	^ delayBeforeFilter
]

{ #category : #'private filtering' }
ToObservableCollectionQueryRunner >> newProcessIn: anObservableCollection [
	"Used the solution implemented in FastTable. see FTFieldFunction>>#spawnFilterUpdateThread.
	Runs in background, thank to Henrik Johansen for this"

	semaphore := Semaphore new.
	^ [
	  [
	  self semaphore wait.	
	  pattern ifNotEmpty: [ self delayBeforeFilter wait ].
	  previousPattern = pattern ifFalse: [
		  previousPattern := pattern.
		  self applyDataFilterIn: anObservableCollection ] ] repeat ]
		  forkAt: Processor userBackgroundPriority
		  named: self class name , ' filter process'
]

{ #category : #'api - hooks' }
ToObservableCollectionQueryRunner >> onInstalledIn: anObservableCollection [

	delayBeforeFilter := self defaultDelay.
	process := self newProcessIn: anObservableCollection
]

{ #category : #'api - hooks' }
ToObservableCollectionQueryRunner >> onUninstalledIn: anObservableCollection [

	process terminate.
	pattern := ''.
	semaphore := nil
]

{ #category : #accessing }
ToObservableCollectionQueryRunner >> pattern [

	^ pattern ifNil: [ pattern := '' ]
]

{ #category : #'private filtering' }
ToObservableCollectionQueryRunner >> pattern: aString [

	pattern = aString ifTrue: [ ^ self ].
	pattern := aString asString trimBoth.
	previousPattern = pattern ifTrue: [ ^ self ].
	self semaphore signal
]

{ #category : #accessing }
ToObservableCollectionQueryRunner >> selectedIndexes [

	^ selectedIndexes
]

{ #category : #accessing }
ToObservableCollectionQueryRunner >> semaphore [

	^ semaphore 
]
