Class {
	#name : #ToDataFilterDresser,
	#superclass : #ToDresser,
	#instVars : [
		'pattern',
		'semaphore',
		'requestHandler',
		'delay',
		'process',
		'filter',
		'dataStack'
	],
	#category : #'Toplo-Widget-List'
}

{ #category : #'api - install/uninstall  hook' }
ToDataFilterDresser >> dataChangedIn: anElement [

	| originalData |
	self semaphore isSignaled ifTrue: [ ^ self ].
	originalData := dataStack first copy.
	dataStack := Stack new.
	dataStack push: originalData.
	process terminate.
	process := self filterProcessIn: anElement.
	self semaphore signal
	
]

{ #category : #'api - install/uninstall  hook' }
ToDataFilterDresser >> defaultFilter [

	^ [ :data | data includesSubstring: self pattern caseSensitive: false ]
]

{ #category : #accessing }
ToDataFilterDresser >> filter [

	^ filter ifNil: [ filter := self defaultFilter ]
]

{ #category : #accessing }
ToDataFilterDresser >> filter: aValuable [
	" filter takes a data as argument "
	filter := aValuable
]

{ #category : #'private filtering' }
ToDataFilterDresser >> filterDataIn: anElement [

	| filtered |
	self pattern ifNil: [ ^ self ].
	filtered := self pattern
		            ifEmpty: [ dataStack top ]
		            ifNotEmpty: [ dataStack top select: self filter ].
	anElement dispatchEvent: (ToDataFilteredEvent new data: filtered)
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
		  delay wait.
		  "Pattern still the same? If not, just loop again and end up waiting for another x secs"
		  oldPattern = self pattern ifTrue: [ self filterDataIn: anElement ] ] ]
		  repeat ]
		  forkAt: Processor userBackgroundPriority
		  named: 'Toplo filter engine update'
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

	"anElement data 	whenAddChangeDo: [ :ann | self dataChangedIn: anElement ]."
	"anElement data whenRemoveChangeDo: [ :ann | self dataChangedIn: anElement ].
	anElement data  whenUpdateChangeDo: [ :ann | self dataChangedIn: anElement ]."
	
	anElement addEventHandler: requestHandler
]

{ #category : #'api - install/uninstall  hook' }
ToDataFilterDresser >> onInstalledIn: anElement [

	super onInstalledIn: anElement.
	dataStack := Stack new.
	dataStack push: anElement data asArray.
	delay := 0.1 seconds.
	process := self filterProcessIn: anElement
]

{ #category : #'api - install/uninstall  hook' }
ToDataFilterDresser >> onUninstalledIn: anElement [

	process terminate.
	anElement data removeAll.
	anElement data addAll: dataStack pop.
	dataStack := nil.
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
