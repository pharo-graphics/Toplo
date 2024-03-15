Class {
	#name : #ToObservableCollectionFilter,
	#superclass : #Object,
	#instVars : [
		'pattern',
		'semaphore',
		'process',
		'previousPattern',
		'dataFilter',
		'selectedIndexes',
		'delay'
	],
	#category : #'Toplo-Core-CollectionFilter'
}

{ #category : #'private filtering' }
ToObservableCollectionFilter >> applyDataFilterIn: anObservableCollection [

	| event |
	selectedIndexes := self pattern ifEmpty: [ #(  ) ] ifNotEmpty: [
		                   Array streamContents: [ :stream |
			                   anObservableCollection withIndexDo: [ :d :idx |
				                   (self dataFilter value: d value: self pattern)
					                   ifTrue: [ stream nextPut: idx ] ] ] ].
	event := ToObservableCollectionFilterResultEvent new
		         filter: self;
		         yourself.
	anObservableCollection dispatchEvent: event
]

{ #category : #accessing }
ToObservableCollectionFilter >> dataFilter [

	^ dataFilter ifNil: [ dataFilter := self defaultFilter ]
]

{ #category : #accessing }
ToObservableCollectionFilter >> dataFilter: aValuable [
	" filter takes a data and a pattern as argument "

	dataFilter := aValuable
]

{ #category : #accessing }
ToObservableCollectionFilter >> defaultDelay [

	^ 250 milliSeconds
]

{ #category : #accessing }
ToObservableCollectionFilter >> defaultFilter [

	"^ [ :data :p | data includesSubstring: p caseSensitive: false ]"
	^ [ :aData :aPattern | aData asString beginsWith: aPattern caseSensitive: true ]
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
	  self semaphore wait.	
	  pattern ifNotEmpty: [ self delay wait ].
	  previousPattern = pattern ifFalse: [
		  previousPattern := pattern.
		  self applyDataFilterIn: anObservableCollection ] ] repeat ]
		  forkAt: Processor userBackgroundPriority
		  named: self class name , ' filter process'
]

{ #category : #'api - hooks' }
ToObservableCollectionFilter >> onInstalledIn: anObservableCollection [

	delay := self defaultDelay.
	process := self newProcessIn: anObservableCollection.
	selectedIndexes := #()
]

{ #category : #'api - hooks' }
ToObservableCollectionFilter >> onUninstalledIn: anObservableCollection [

	process terminate.
	pattern := ''.
	semaphore := nil.
	selectedIndexes := #()
]

{ #category : #accessing }
ToObservableCollectionFilter >> pattern [

	^ pattern ifNil: [ pattern := '' ]
]

{ #category : #'private filtering' }
ToObservableCollectionFilter >> pattern: aString [

	pattern = aString ifTrue: [ ^ self ].
	pattern := aString asString trimBoth.
	previousPattern = pattern ifTrue: [ ^ self ].
	self semaphore signal
]

{ #category : #accessing }
ToObservableCollectionFilter >> selectedIndexes [

	^ selectedIndexes

	
]

{ #category : #accessing }
ToObservableCollectionFilter >> semaphore [

	^ semaphore 
]
