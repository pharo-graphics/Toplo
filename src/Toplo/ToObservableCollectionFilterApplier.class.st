Class {
	#name : #ToObservableCollectionFilterApplier,
	#superclass : #Object,
	#instVars : [
		'previousPattern',
		'pattern',
		'semaphore',
		'process',
		'collectionHandler',
		'filter'
	],
	#category : #'Toplo-Core-Collection'
}

{ #category : #'private filtering' }
ToObservableCollectionFilterApplier >> applyPatternIn: anObservableCollection [

	| selectedIndexes |
	
	previousPattern = pattern ifTrue: [ ^ self ].
	previousPattern := pattern.

	selectedIndexes := self pattern ifEmpty: [ #(  ) ] ifNotEmpty: [
		                   Array streamContents: [ :stream |
			                   anObservableCollection withIndexDo: [ :d :idx |
				                   (self filter value: d value: self pattern)
					                   ifTrue: [ stream nextPut: idx ] ] ] ].
	self notifySelectedIndexes: selectedIndexes in: anObservableCollection 
]

{ #category : #accessing }
ToObservableCollectionFilterApplier >> defaultDataFilter [

	"^ [ :data :p | data includesSubstring: p caseSensitive: false ]"
	^ [ :aData :aPattern | aData asString beginsWith: aPattern caseSensitive: true ]
]

{ #category : #accessing }
ToObservableCollectionFilterApplier >> defaultDelay [

	^ 100 milliSeconds
]

{ #category : #accessing }
ToObservableCollectionFilterApplier >> delay [

	^ self defaultDelay
]

{ #category : #accessing }
ToObservableCollectionFilterApplier >> filter [

	^ filter ifNil: [ filter := self defaultDataFilter ]
]

{ #category : #accessing }
ToObservableCollectionFilterApplier >> filter: aValuable [
	" filter takes a data and a pattern as argument "

	filter := aValuable
]

{ #category : #'private filtering' }
ToObservableCollectionFilterApplier >> newProcessIn: anObservableCollection [
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
ToObservableCollectionFilterApplier >> notifySelectedIndexes: anIntegerArray in: anObservableCollection [

	anObservableCollection dispatchEvent:
		(ToObservableCollectionFilterApplierEvent new
			 pattern: self pattern;
			 selectedIndexes: anIntegerArray;
			 yourself)
]

{ #category : #'api - hooks' }
ToObservableCollectionFilterApplier >> onInstalledIn: anObservableCollection [

	collectionHandler ifNotNil: [ BlImmutableObjectChangeError signal ].
	process := self newProcessIn: anObservableCollection.
	collectionHandler := anObservableCollection
		                     addEventHandlerOn: ToCollectionChangedEvent
		                     do: [ :event | previousPattern := nil ]
]

{ #category : #'api - hooks' }
ToObservableCollectionFilterApplier >> onUninstalledIn: anObservableCollection [

	anObservableCollection removeEventHandler: collectionHandler.
	collectionHandler := nil.
	process terminate.
	pattern := ''.
	semaphore := nil
]

{ #category : #accessing }
ToObservableCollectionFilterApplier >> pattern [

	^ pattern ifNil: [ pattern := '' ]
]

{ #category : #'private filtering' }
ToObservableCollectionFilterApplier >> pattern: aString [

	pattern := aString asString trimBoth.
	previousPattern = pattern ifTrue: [ ^ self ].
	semaphore signal
]

{ #category : #accessing }
ToObservableCollectionFilterApplier >> process [ 

	^ process
]

{ #category : #accessing }
ToObservableCollectionFilterApplier >> semaphore [

	^ semaphore 
]
