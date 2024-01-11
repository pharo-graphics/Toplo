Class {
	#name : #ToListElementFilter,
	#superclass : #Object,
	#instVars : [
		'pattern',
		'semaphore',
		'process',
		'filter',
		'originalDataProvider',
		'originalData',
		'delayBeforeFilter',
		'filterResultTask'
	],
	#category : #'Toplo-Widget-List-Filter'
}

{ #category : #'private filtering' }
ToListElementFilter >> dataFilterPattern: aString [

	pattern := aString asString trimBoth.
	self semaphore signal
]

{ #category : #'api - hooks' }
ToListElementFilter >> defaultDelay [

	^ 200 milliSeconds
]

{ #category : #accessing }
ToListElementFilter >> defaultFilter [

	"^ [ :data :p | data includesSubstring: p caseSensitive: false ]"
	^ [ :data :p | data asString beginsWith: p caseSensitive: true ]
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

	| filtered indexes event |

	aPattern
		ifEmpty: [
			filtered := originalData.
			indexes := 1 to: originalData size ]
		ifNotEmpty: [
			filtered := Array streamContents: [ :filteredStream |
				            indexes := Array streamContents: [ :indexesStream |
					                       originalData withIndexDo: [ :d :idx |
						                       (self filter value: d value: aPattern)
							                       ifTrue: [
								                       filteredStream nextPut: d.
								                       indexesStream nextPut: idx ] ] ] ] ].

	"A task must be used here because the filtering is runned asynchronously. The task allows to re-synchronise the element response.
	As an example, it can avoid the children updating during layouting (because during layouting children are temporarily detached)
	(which leads to errors related to children adding and which are difficult to understand)"

	filterResultTask ifNotNil: [ anElement dequeueTask: filterResultTask ].
	filterResultTask := BlTaskAction new.
	filterResultTask action: [
		event := ToDataFilterResultEvent new.
		event
			pattern: aPattern;
			data: filtered;
			indexes: indexes;
			yourself.
		anElement dispatchEvent: event.
		filterResultTask := nil ].
	anElement enqueueTask: filterResultTask
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

{ #category : #'private filtering' }
ToListElementFilter >> initializeOriginalData [

	originalData :=  originalDataProvider value asArray
]

{ #category : #'api - hooks' }
ToListElementFilter >> onInstalledIn: anElement [

	originalDataProvider ifNil: [ originalDataProvider := [ anElement data ] ].
	self initializeOriginalData.
	delayBeforeFilter := self defaultDelay.
	process := self filterProcessIn: anElement
]

{ #category : #'api - hooks' }
ToListElementFilter >> onUninstalledIn: anElement [

	process terminate.
	originalData := nil.
	pattern := ''.
	semaphore := nil.
]

{ #category : #accessing }
ToListElementFilter >> originalDataProvider: aBlock [

	originalDataProvider := aBlock.
	self initializeOriginalData 
]

{ #category : #accessing }
ToListElementFilter >> pattern [

	^ pattern ifNil: [ pattern := '' ]
]

{ #category : #accessing }
ToListElementFilter >> semaphore [

	^ semaphore 
]
