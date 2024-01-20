Class {
	#name : #ToListElementSelector,
	#superclass : #Object,
	#instVars : [
		'pattern',
		'semaphore',
		'process',
		'delayBeforeFilter',
		'filterResultTask',
		'taskQueueHolder',
		'previousPattern',
		'dataFilter',
		'selectionModel',
		'originalData'
	],
	#category : #'Toplo-Widget-List-Filter'
}

{ #category : #accessing }
ToListElementSelector >> dataFilter [

	^ dataFilter ifNil: [ dataFilter := self defaultFilter ]
]

{ #category : #accessing }
ToListElementSelector >> dataFilter: aValuable [
	" filter takes a data and a pattern as argument "

	dataFilter := aValuable
]

{ #category : #accessing }
ToListElementSelector >> defaultDelay [

	^ 250 milliSeconds
]

{ #category : #accessing }
ToListElementSelector >> defaultFilter [

	"^ [ :data :p | data includesSubstring: p caseSensitive: false ]"
	^ [ :aData :aPattern | aData asString beginsWith: aPattern caseSensitive: true ]
]

{ #category : #accessing }
ToListElementSelector >> delayBeforeFilter [

	^ delayBeforeFilter
]

{ #category : #'private filtering' }
ToListElementSelector >> filterDataIn: anElement [

	| event taskTarget |
	anElement dispatchEvent: (ToFilteredListPatternChangedEvent new
			 pattern: self pattern;
			 yourself).

	taskTarget := taskQueueHolder ifNil: [ anElement ].
	self pattern
		ifEmpty: [ self selectionModel deselectAll ]
		ifNotEmpty: [
			self originalData withIndexDo: [ :d :idx |
				(self dataFilter value: d value: self pattern) ifTrue: [
					self selectionModel selectIndex: idx ] ] ].

	"A task must be used here because the filtering is runned asynchronously. The task allows to re-synchronise the element response 
	( and then to be runned in the UI thread ).
	As an example, it can avoid the children updating during layouting (because during layouting children are temporarily detached)
	(which leads to errors related to children adding and which are difficult to understand)"

	filterResultTask ifNotNil: [
		taskTarget dequeueTask: filterResultTask ].
	filterResultTask := BlTaskAction new.
	filterResultTask action: [
		event := ToListSelectorResultEvent new.
		event
			pattern: self pattern;
			selectionModel: self selectionModel.
		anElement dispatchEvent: event.
		filterResultTask := nil ].
	taskTarget enqueueTask: filterResultTask
]

{ #category : #'private filtering' }
ToListElementSelector >> newProcessIn: anElement [
	"Used the solution implemented in FastTable. see FTFieldFunction>>#spawnFilterUpdateThread.
	Runs in background, thank to Henrik Johansen for this"

	semaphore := Semaphore new.
	^ [
	  [
	  self semaphore wait.

	  pattern ifNotEmpty: [ self delayBeforeFilter wait ].

	  previousPattern = pattern ifFalse: [
		  previousPattern := pattern.
		  self filterDataIn: anElement ] ] repeat ]
		  forkAt: Processor userBackgroundPriority
		  named: self class name , ' filter process'
]

{ #category : #'api - hooks' }
ToListElementSelector >> onInstalledIn: aListElement [

	originalData := aListElement data.
	delayBeforeFilter := self defaultDelay.
	process := self newProcessIn: aListElement
]

{ #category : #'api - hooks' }
ToListElementSelector >> onUninstalledIn: aListElement [

	process terminate.
	pattern := ''.
	semaphore := nil
]

{ #category : #accessing }
ToListElementSelector >> originalData [ 

	^ originalData 
]

{ #category : #accessing }
ToListElementSelector >> pattern [

	^ pattern ifNil: [ pattern := '' ]
]

{ #category : #'private filtering' }
ToListElementSelector >> pattern: aString [

	pattern = aString ifTrue: [ ^ self ].
	pattern := aString asString trimBoth.
	previousPattern = pattern ifTrue: [ ^ self ].
	self semaphore signal
]

{ #category : #accessing }
ToListElementSelector >> selectionModel [

	^ selectionModel ifNil: [ selectionModel := BlCompositeSelection new ]
]

{ #category : #accessing }
ToListElementSelector >> selectionModel: aSelectionModel [

	selectionModel := aSelectionModel
]

{ #category : #accessing }
ToListElementSelector >> semaphore [

	^ semaphore 
]

{ #category : #accessing }
ToListElementSelector >> taskQueueHolder [

	^ taskQueueHolder 
]

{ #category : #accessing }
ToListElementSelector >> taskQueueHolder: aTaskQueueHolder [

	taskQueueHolder := aTaskQueueHolder
]
