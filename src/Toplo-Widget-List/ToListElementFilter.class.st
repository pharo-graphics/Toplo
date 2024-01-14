Class {
	#name : #ToListElementFilter,
	#superclass : #Object,
	#instVars : [
		'pattern',
		'semaphore',
		'process',
		'originalData',
		'delayBeforeFilter',
		'filterResultTask',
		'taskQueueHolder',
		'previousPattern',
		'originalIndexedData',
		'dataFilter',
		'filterListElementHandler',
		'selectionModel',
		'currentIndexedData'
	],
	#category : #'Toplo-Widget-List-Filter'
}

{ #category : #'private filtering' }
ToListElementFilter >> buildOriginalIndexedData [

	originalIndexedData := Array streamContents: [ :str |
		                       originalData withIndexDo: [ :d :i |
			                       str nextPut: (ToFilterData new
					                        data: d;
					                        dataSourcePos: i;
					                        yourself) ] ]
]

{ #category : #accessing }
ToListElementFilter >> currentIndexedData [

	^ currentIndexedData
]

{ #category : #accessing }
ToListElementFilter >> dataFilter [

	^ dataFilter ifNil: [ dataFilter := self defaultFilter ]
]

{ #category : #accessing }
ToListElementFilter >> dataFilter: aValuable [
	" filter takes a data and a pattern as argument "

	dataFilter := aValuable
]

{ #category : #accessing }
ToListElementFilter >> defaultDelay [

	^ 200 milliSeconds
]

{ #category : #accessing }
ToListElementFilter >> defaultFilter [

	"^ [ :data :p | data includesSubstring: p caseSensitive: false ]"
	^ [ :data :p | data asString beginsWith: p asString caseSensitive: true ]
]

{ #category : #accessing }
ToListElementFilter >> delayBeforeFilter [

	^ delayBeforeFilter
]

{ #category : #'private filtering' }
ToListElementFilter >> filterDataIn: anElement [

	| event taskTarget |
	
	anElement dispatchEvent: (ToFilteredListPatternChangedEvent new
			 pattern: self pattern;
			 yourself).	

	taskTarget := taskQueueHolder ifNil: [ anElement ].
	self pattern
		ifEmpty: [ currentIndexedData := originalIndexedData ]
		ifNotEmpty: [
			currentIndexedData := Array streamContents: [ :str |
				               originalIndexedData do: [ :d |
					               (self dataFilter value: d data value: self pattern)
						               ifTrue: [ str nextPut: d ] ] ] ].


	"A task must be used here because the filtering is runned asynchronously. The task allows to re-synchronise the element response.
	As an example, it can avoid the children updating during layouting (because during layouting children are temporarily detached)
	(which leads to errors related to children adding and which are difficult to understand)"

	filterResultTask ifNotNil: [
		taskTarget dequeueTask: filterResultTask ].
	filterResultTask := BlTaskAction new.
	filterResultTask action: [
		event := ToListFilterResultEvent new.
		event
			pattern: self pattern;
			indexedData: currentIndexedData.
		anElement dispatchEvent: event.
		filterResultTask := nil ].
	taskTarget enqueueTask: filterResultTask
]

{ #category : #'private filtering' }
ToListElementFilter >> newProcessIn: anElement [
	"Runs in background, thank to Henrik Johansen for this"

	semaphore := Semaphore new.
	^ [
	  [
	  self semaphore wait.
	  self delayBeforeFilter wait.
	  self filterDataIn: anElement ] repeat ]
		  forkAt: Processor userBackgroundPriority
		  named: self class name , ' filter process'
]

{ #category : #'api - hooks' }
ToListElementFilter >> onInstalledIn: aListElement [

	originalData ifNil: [	^ Error signal: 'A filter must have an initialData before it''s installation on a List element' ].
	delayBeforeFilter := self defaultDelay.

	filterListElementHandler := ToFilteredListElementEventHandler new
		                            selectionModel: self selectionModel;
		                            filter: self;
		                            yourself.
	aListElement addEventHandler: filterListElementHandler.
	self buildOriginalIndexedData.
	process := self newProcessIn: aListElement.
	semaphore signal
]

{ #category : #'api - hooks' }
ToListElementFilter >> onUninstalledIn: aListElement [

	process terminate.
	aListElement removeEventHandler: filterListElementHandler.
	originalData := nil.
	pattern := ''.
	semaphore := nil.
]

{ #category : #accessing }
ToListElementFilter >> originalData [

	^ originalData
]

{ #category : #accessing }
ToListElementFilter >> originalData: anObservableCollection [

	originalData = anObservableCollection ifTrue: [ ^ self ].
	originalData ifNotNil: [ ^ (BlImmutableObjectChangeError object: self) signal ].
	originalData := anObservableCollection.
	originalData addEventHandler: (BlEventHandler
			 on: ToCollectionAfterChangeEvent
			 do: [ self buildOriginalIndexedData ]).
]

{ #category : #accessing }
ToListElementFilter >> pattern [

	^ pattern ifNil: [ pattern := '' ]
]

{ #category : #'private filtering' }
ToListElementFilter >> pattern: aString [

	pattern = aString ifTrue: [ ^ self ].
	pattern := aString asString trimBoth.
	previousPattern = pattern ifTrue: [ ^ self ].
	previousPattern := pattern.
	self semaphore signal
]

{ #category : #accessing }
ToListElementFilter >> selectionModel [

	^ selectionModel ifNil: [ selectionModel := BlCompositeSelection new ]
]

{ #category : #accessing }
ToListElementFilter >> selectionModel: aSelectionModel [

	selectionModel := aSelectionModel
]

{ #category : #accessing }
ToListElementFilter >> semaphore [

	^ semaphore 
]

{ #category : #accessing }
ToListElementFilter >> taskQueueHolder [

	^ taskQueueHolder 
]

{ #category : #accessing }
ToListElementFilter >> taskQueueHolder: aTaskQueueHolder [

	taskQueueHolder := aTaskQueueHolder
]
