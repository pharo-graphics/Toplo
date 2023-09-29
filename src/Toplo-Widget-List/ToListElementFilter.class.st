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
	#category : #'Toplo-Widget-List-filter'
}

{ #category : #'filter events handling' }
ToListElementFilter >> collectionAddEvent: anEvent [

	self dataChangedIn: anEvent currentTarget
]

{ #category : #'filter events handling' }
ToListElementFilter >> collectionRemoveEvent: anEvent [ 

	self dataChangedIn: anEvent currentTarget
]

{ #category : #'filter events handling' }
ToListElementFilter >> collectionUpdateEvent: anEvent [ 

	self dataChangedIn: anEvent currentTarget
]

{ #category : #'filter events handling' }
ToListElementFilter >> dataChangedIn: anElement [

	originalData := originalDataProvider value.
	self filterDataIn: anElement
]

{ #category : #'private filtering' }
ToListElementFilter >> dataFilterPattern: aString [

	pattern := aString asString trimBoth.
	self semaphore signal
]

{ #category : #'private filtering' }
ToListElementFilter >> dataFilterRequest: anEvent [

	self dataFilterPattern: anEvent pattern
]

{ #category : #'filter events handling' }
ToListElementFilter >> defaultFilter [

	"^ [ :data :p | data includesSubstring: p caseSensitive: false ]"
	^ [ :data :p | data asString beginsWith: p caseSensitive: false ]
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
ToListElementFilter >> filterDataIn: anElement [

	| filtered indexes |
	self pattern ifNil: [ ^ self ].

	self pattern
		ifEmpty: [
			filtered := originalData.
			indexes := 1 to: 0 ]
		ifNotEmpty: [
			filtered := Array streamContents: [ :filteredStream |
				            indexes := Array streamContents: [ :indexesStream |
					                       originalData withIndexDo: [ :d :idx |
						                       (self filter value: d value: self pattern) ifTrue: [
							                       filteredStream nextPut: d.
							                       indexesStream nextPut: idx ] ] ] ] ].

	"A task must be used here because the filtering is runned asynchronously. The task allows to re-synchronise the element response.
	As an example, it can avoid the children updating during layouting (because during layouting children are temporarily detached)
	(which leads to errors related to children adding and which are difficult to understand)"

	filterResultTask ifNotNil: [ anElement dequeueTask: filterResultTask ].
	filterResultTask := BlTaskAction new action: [ 
		anElement dispatchEvent: (ToDataFilterResultEvent new
			 data: filtered;
			 indexes: indexes;
			 yourself).
		filterResultTask := nil].
	anElement enqueueTask: filterResultTask
]

{ #category : #'private filtering' }
ToListElementFilter >> filterProcessIn: anElement [
	"Runs in background, thank to Henrik Johansen for this"

	semaphore := Semaphore new.
	^ [
	  | oldPattern |
	  oldPattern := nil.
	  [
	  self semaphore wait.
	  "If pattern has changed, see if we need to filter.
	If not, it's probably an extraneous signal received while we were waiting for x seconds, 
	and we discard then till we end up waiting for filterChangeSemaphore again"
	  oldPattern ~= self pattern ifTrue: [
		  oldPattern := self pattern.
		  self delayBeforeFilter wait.
		  "Pattern still the same? If not, just loop again and end up waiting for another x secs"
		  oldPattern = self pattern ifTrue: [ self filterDataIn: anElement ] ] ]
		  repeat ]
		  forkAt: Processor userBackgroundPriority
		  named: self class name, ' filter process'
]

{ #category : #'private filtering' }
ToListElementFilter >> filterRequestEvent: anEvent in: anElement [

	pattern := anEvent pattern asString trimBoth.
	self semaphore signal
]

{ #category : #'filter events handling' }
ToListElementFilter >> onInstalledIn: anElement [

	originalDataProvider ifNil: [ originalDataProvider := [ anElement data asArray ] ].
	originalData :=  originalDataProvider value.
	delayBeforeFilter := 150 milliSeconds.
	process := self filterProcessIn: anElement
]

{ #category : #'filter events handling' }
ToListElementFilter >> onUninstalledIn: anElement [

	process terminate.
	originalData := nil.
	pattern := nil.
	semaphore := nil.
	super onUninstalledIn: anElement.

]

{ #category : #accessing }
ToListElementFilter >> originalDataProvider: aBlock [

	" returns an array "
	originalDataProvider := aBlock
]

{ #category : #accessing }
ToListElementFilter >> pattern [

	^ pattern
]

{ #category : #accessing }
ToListElementFilter >> semaphore [

	^ semaphore 
]
