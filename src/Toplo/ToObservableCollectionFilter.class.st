Class {
	#name : #ToObservableCollectionFilter,
	#superclass : #Object,
	#instVars : [
		'previousPattern',
		'pattern',
		'semaphore',
		'process',
		'dataFilter',
		'delay',
		'collectionHandler'
	],
	#category : #'Toplo-Core-Collection'
}

{ #category : #'private filtering' }
ToObservableCollectionFilter >> applyPatternIn: anObservableCollection [

	| selectedIndexes |
	
	previousPattern = pattern ifTrue: [ ^ self ].
	previousPattern := pattern.

	selectedIndexes := self pattern ifEmpty: [ #(  ) ] ifNotEmpty: [
		                   Array streamContents: [ :stream |
			                   anObservableCollection withIndexDo: [ :d :idx |
				                   (self dataFilter value: d value: self pattern)
					                   ifTrue: [ stream nextPut: idx ] ] ] ].
	self notifySelectedIndexes: selectedIndexes in: anObservableCollection 
]

{ #category : #accessing }
ToObservableCollectionFilter >> dataFilter [

	^ dataFilter ifNil: [ dataFilter := self defaultDataFilter ]
]

{ #category : #accessing }
ToObservableCollectionFilter >> dataFilter: aValuable [
	" filter takes a data and a pattern as argument "

	dataFilter := aValuable
]

{ #category : #accessing }
ToObservableCollectionFilter >> defaultDataFilter [

	"^ [ :data :p | data includesSubstring: p caseSensitive: false ]"
	^ [ :aData :aPattern | aData asString beginsWith: aPattern caseSensitive: true ]
]

{ #category : #accessing }
ToObservableCollectionFilter >> defaultDelay [

	^ 100 milliSeconds
]

{ #category : #accessing }
ToObservableCollectionFilter >> delay [

	^ delay
]

{ #category : #'private filtering' }
ToObservableCollectionFilter >> newProcessIn: anObservableCollection [
	"Used the solution implemented in FastTable. see FTFieldFunction>>#spawnFilterUpdateThread.
	Runs in background, thank to Henrik Johansen for this"

	semaphore := Semaphore new.
	^ [
		  [
			  semaphore wait.
			  pattern ifNotEmpty: [ self delay wait ].
			  self applyPatternIn: anObservableCollection ] repeat ]
		  forkAt: Processor lowIOPriority
		  named: self class name , ' filter process'
]

{ #category : #'private filtering' }
ToObservableCollectionFilter >> notifySelectedIndexes: anIntegerArray in: anObservableCollection [

	anObservableCollection dispatchEvent:
		(ToObservableCollectionFilterAppliedEvent new
			 pattern: self pattern;
			 selectedIndexes: anIntegerArray;
			 yourself)
]

{ #category : #'api - hooks' }
ToObservableCollectionFilter >> onInstalledIn: anObservableCollection [

	collectionHandler ifNotNil: [ BlImmutableObjectChangeError signal ].
	delay := self defaultDelay.
	process := self newProcessIn: anObservableCollection.
	collectionHandler := anObservableCollection
		                     addEventHandlerOn: ToCollectionChangedEvent
		                     do: [ :event | previousPattern := nil ]
]

{ #category : #'api - hooks' }
ToObservableCollectionFilter >> onUninstalledIn: anObservableCollection [

	anObservableCollection removeEventHandler: collectionHandler.
	collectionHandler := nil.
	process terminate.
	pattern := ''.
	semaphore := nil
]

{ #category : #accessing }
ToObservableCollectionFilter >> pattern [

	^ pattern ifNil: [ pattern := '' ]
]

{ #category : #'private filtering' }
ToObservableCollectionFilter >> pattern: aString [

	pattern := aString asString trimBoth.
	previousPattern = pattern ifTrue: [ ^ self ].
	semaphore signal
]

{ #category : #accessing }
ToObservableCollectionFilter >> process [ 

	^ process
]

{ #category : #accessing }
ToObservableCollectionFilter >> semaphore [

	^ semaphore 
]
