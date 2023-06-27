Class {
	#name : #ToDataFilterDresser,
	#superclass : #ToDresser,
	#instVars : [
		'pattern',
		'semaphore',
		'requestHandler',
		'process',
		'filter',
		'originalData',
		'delayBeforeFilter',
		'currentIndexes',
		'filterResultTask'
	],
	#category : #'Toplo-Widget-List'
}

{ #category : #'api - install/uninstall  hook' }
ToDataFilterDresser >> dataChangedIn: anElement [

	originalData := anElement data asArray.
	currentIndexes  := 1 to: 0.
	self filterDataIn: anElement
]

{ #category : #'api - install/uninstall  hook' }
ToDataFilterDresser >> defaultFilter [

	^ [ :data :p | data includesSubstring: p caseSensitive: false ]
]

{ #category : #accessing }
ToDataFilterDresser >> delayBeforeFilter [

	^ delayBeforeFilter
]

{ #category : #accessing }
ToDataFilterDresser >> filter [

	^ filter ifNil: [ filter := self defaultFilter ]
]

{ #category : #accessing }
ToDataFilterDresser >> filter: aValuable [
	" filter takes a data and a pattern as argument "
	filter := aValuable
]

{ #category : #'private filtering' }
ToDataFilterDresser >> filterDataIn: anElement [

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
			 selectionUpdated: currentIndexes ~= indexes;
			 data: filtered;
			 indexes: indexes;
			 yourself).
		currentIndexes := indexes.
		filterResultTask := nil].
	anElement enqueueTask: filterResultTask
]

{ #category : #'private filtering' }
ToDataFilterDresser >> filterProcessIn: anElement [
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
ToDataFilterDresser >> filterRequestEvent: anEvent in: anElement [

	pattern := anEvent pattern asString trimBoth.
	self semaphore signal
]

{ #category : #'api - install/uninstall  hook' }
ToDataFilterDresser >> installEventListenersIn: anElement [

	super installEventListenersIn: anElement.

	requestHandler := BlEventHandler
		                  on: ToDataFilterRequestEvent
		                  do: [ :event | self filterRequestEvent: event in: anElement ].

	anElement data whenAddChangeDo: [ :ann | self dataChangedIn: anElement ].
	anElement data whenRemoveChangeDo: [ :ann | self dataChangedIn: anElement ].
	anElement data whenUpdateChangeDo: [ :ann | self dataChangedIn: anElement ].
	
	anElement addEventHandler: requestHandler
]

{ #category : #'api - install/uninstall  hook' }
ToDataFilterDresser >> onInstalledIn: anElement [

	super onInstalledIn: anElement.
	originalData := anElement data asArray.
	delayBeforeFilter := 150 milliSeconds.
	process := self filterProcessIn: anElement
]

{ #category : #'api - install/uninstall  hook' }
ToDataFilterDresser >> onUninstalledIn: anElement [

	process terminate.
	originalData := nil.
	pattern := nil.
	semaphore := nil.
	super onUninstalledIn: anElement.

]

{ #category : #accessing }
ToDataFilterDresser >> pattern [

	^ pattern
]

{ #category : #accessing }
ToDataFilterDresser >> semaphore [

	^ semaphore 
]

{ #category : #'api - install/uninstall  hook' }
ToDataFilterDresser >> uninstallEventListenersIn: anElement [

	anElement removeEventHandler: requestHandler.
	requestHandler := nil.
	super uninstallEventListenersIn: anElement
]
