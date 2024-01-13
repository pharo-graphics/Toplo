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
		'indexedData',
		'taskQueueHolder',
		'previousPattern',
		'originalIndexedData',
		'dataFilter',
		'filterListElementHandler',
		'selectionModel'
	],
	#category : #'Toplo-Widget-List-Filter'
}

{ #category : #'private filtering' }
ToListElementFilter >> buildOriginalIndexedData [

	originalIndexedData := originalData withIndexCollect: [ :d :i |
		               ToFilterData new
			               data: d;
			               dataSourcePos: i;
			               yourself ]
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
ToListElementFilter >> filterDataIn: anElement withPattern: aPattern [

	| event taskTarget |
	previousPattern = aPattern ifTrue: [ ^ self ].
	previousPattern := aPattern.
	anElement dispatchEvent: (ToFilteredListPatternChangedEvent new
			 pattern: aPattern;
			 yourself).

	taskTarget := taskQueueHolder ifNil: [ anElement ].
	originalIndexedData ifNil: [ self buildOriginalIndexedData ].
	aPattern
		ifEmpty: [ indexedData := originalIndexedData ]
		ifNotEmpty: [
			indexedData := Array streamContents: [ :str |
				               originalIndexedData do: [ :d |
					               (self dataFilter value: d data value: aPattern)
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
			pattern: aPattern;
			indexedData: indexedData.
		anElement dispatchEvent: event.
		filterResultTask := nil ].
	taskTarget enqueueTask: filterResultTask
]

{ #category : #'private filtering' }
ToListElementFilter >> filterProcessIn: anElement [
	"Runs in background, thank to Henrik Johansen for this"

	semaphore := Semaphore new.
	^ [
	  [
	  self semaphore wait.
	  self delayBeforeFilter wait.
	  self filterDataIn: anElement withPattern: self pattern ] repeat ]
		  forkAt: Processor userBackgroundPriority
		  named: self class name , ' filter process'
]

{ #category : #accessing }
ToListElementFilter >> indexedData [

	^ indexedData
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
	process := self filterProcessIn: aListElement.
	self pattern: ''
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

	originalData := anObservableCollection
]

{ #category : #accessing }
ToListElementFilter >> pattern [

	^ pattern ifNil: [ pattern := '' ]
]

{ #category : #'private filtering' }
ToListElementFilter >> pattern: aString [

	pattern = aString ifTrue: [ ^ self ].
	pattern := aString asString trimBoth.
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
