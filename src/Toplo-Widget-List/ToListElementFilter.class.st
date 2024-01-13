Class {
	#name : #ToListElementFilter,
	#superclass : #Object,
	#instVars : [
		'pattern',
		'semaphore',
		'process',
		'filter',
		'originalData',
		'delayBeforeFilter',
		'filterResultTask',
		'indexedData',
		'taskQueueHolder',
		'previousPattern',
		'dataAfterChangeHandler',
		'originalIndexedData'
	],
	#category : #'Toplo-Widget-List-Filter'
}

{ #category : #'private filtering' }
ToListElementFilter >> buildOriginalIndexedData [

	originalIndexedData := originalData withIndexCollect: [ :d :i |
		               ToListElementFilteredData new
			               data: d;
			               dataSourcePos: i;
			               yourself ]
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

{ #category : #accessing }
ToListElementFilter >> filter [

	^ filter ifNil: [ filter := self defaultFilter ]
]

{ #category : #accessing }
ToListElementFilter >> filter: aValuable [
	" filter takes a data and a pattern as argument "

	filter := aValuable
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
					               (self filter value: d data value: aPattern)
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

	delayBeforeFilter := self defaultDelay.
	process := self filterProcessIn: aListElement.
	originalData ifNil: [ ^ self ].
	aListElement data updateAllWith: originalData
]

{ #category : #'api - hooks' }
ToListElementFilter >> onUninstalledIn: anElement [

	process terminate.
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
	originalData ifNotNil: [
		originalData removeEventHandler: dataAfterChangeHandler ].
	originalData := anObservableCollection.
	dataAfterChangeHandler := BlEventHandler
		                          on: ToCollectionAfterChangeEvent
		                          do: [ self pattern: '' ].
	originalData addEventHandler: dataAfterChangeHandler.
	"self buildOriginalIndexedData"
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
ToListElementFilter >> semaphore [

	^ semaphore 
]

{ #category : #accessing }
ToListElementFilter >> taskQueueHolder: aTaskQueueHolder [

	taskQueueHolder := aTaskQueueHolder
]
