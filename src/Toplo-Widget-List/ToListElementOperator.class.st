Class {
	#name : #ToListElementOperator,
	#superclass : #Object,
	#instVars : [
		'command',
		'dispatchChanges'
	],
	#category : #'Toplo-Widget-List-Selection-Selecter'
}

{ #category : #accessing }
ToListElementOperator >> addCommand: aCommand [

	command ifNil: [ command := aCommand ] ifNotNil: [
		| tail |
		tail := command.
		[ tail next isNil ] whileFalse: [ tail := tail next ].
		tail next: aCommand ]
]

{ #category : #'event dispatching' }
ToListElementOperator >> applyOn: anEventTarget [

	command ifNil: [ ^ self ].
	[ self dispatchEventForCommandOn: anEventTarget ] ensure: [
		command := nil ]
]

{ #category : #'event dispatching' }
ToListElementOperator >> beSilentWhile: aBlock [

	| prev |
	prev := dispatchChanges.
	dispatchChanges := false.
	aBlock ensure: [ dispatchChanges := prev ]
]

{ #category : #accessing }
ToListElementOperator >> command [

	^ command
]

{ #category : #accessing }
ToListElementOperator >> command: anObject [

	command := anObject
]

{ #category : #'event dispatching' }
ToListElementOperator >> dispatchEventForCommandOn: anEventTarget [

	self subclassResponsibility 
]

{ #category : #initialization }
ToListElementOperator >> initialize [ 

	super initialize.
	dispatchChanges := true
]
