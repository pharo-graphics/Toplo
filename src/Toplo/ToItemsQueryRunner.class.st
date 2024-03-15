Class {
	#name : #ToItemsQueryRunner,
	#superclass : #Object,
	#instVars : [
		'pattern',
		'process',
		'fetcher',
		'queryRequestEventHandler',
		'items',
		'delay'
	],
	#category : #'Toplo-Core-QueryRunner'
}

{ #category : #'private filtering' }
ToItemsQueryRunner >> applyFetcherIn: anEventTarget withPattern: aPattern [

	| event |
	items := fetcher value: anEventTarget value: aPattern.
	event := ToItemsQueryResultEvent new
		         queryRunner: self;
		         yourself.
	anEventTarget dispatchEvent: event
]

{ #category : #accessing }
ToItemsQueryRunner >> defaultDelay [

	^ 70 milliSeconds
]

{ #category : #accessing }
ToItemsQueryRunner >> delay [

	^ delay
]

{ #category : #accessing }
ToItemsQueryRunner >> fetcher [
	" filter takes the target as first argument and the pattern as second argument "

	^ fetcher
]

{ #category : #accessing }
ToItemsQueryRunner >> fetcher: aValuable [
	" filter takes the target as first argument and the pattern as second argument "

	self terminateProcess.
	fetcher := aValuable
]

{ #category : #accessing }
ToItemsQueryRunner >> items [

	^ items
]

{ #category : #accessing }
ToItemsQueryRunner >> itemsQueryRequestEvent: anEvent [

	self processPattern: anEvent pattern for: anEvent currentTarget
]

{ #category : #'private filtering' }
ToItemsQueryRunner >> newProcessIn: anEventTarget [

	self terminateProcess.
	^ process := [
	             | pat |
	             pat := pattern copy.
	             self delay wait.
	             pat = pattern ifFalse: [ ^ self ].
	             self applyFetcherIn: anEventTarget withPattern: pat.
	             process := nil ]
		             forkAt: Processor systemBackgroundPriority
		             named: self class name
]

{ #category : #'api - hooks' }
ToItemsQueryRunner >> onInstalledIn: anEventTarget [

	delay := self defaultDelay.
	items := #(  ).
	fetcher := [ :theEventTarget :thePattern | #(  ) ].
	queryRequestEventHandler := anEventTarget
		addEventHandlerOn: ToItemsQueryRequestEvent
		do: [ :event | event sendTo: self ]
]

{ #category : #'api - hooks' }
ToItemsQueryRunner >> onUninstalledIn: anEventTarget [

	process ifNotNil: [:p | p terminate].
	process := nil.
	pattern := nil.
	fetcher := nil.
	items := #().
	anEventTarget removeEventHandler: queryRequestEventHandler.
	queryRequestEventHandler := nil
]

{ #category : #accessing }
ToItemsQueryRunner >> pattern [

	^ pattern 
]

{ #category : #'private filtering' }
ToItemsQueryRunner >> pattern: anObject [

	pattern := anObject
]

{ #category : #accessing }
ToItemsQueryRunner >> process [

	^ process
]

{ #category : #accessing }
ToItemsQueryRunner >> processPattern: aPattern for: aTarget [


	self pattern: aPattern.
	process := self newProcessIn: aTarget.
	^ process

	
]

{ #category : #'private filtering' }
ToItemsQueryRunner >> terminateProcess [

	process ifNotNil: [:p | p terminate].
	process := nil
]
