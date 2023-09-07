Class {
	#name : #ToMultiStateLook,
	#superclass : #ToElementLook,
	#instVars : [
		'animation',
		'disabledValue',
		'hoverValue',
		'leavedValue',
		'initialValue',
		'pressedvalue',
		'selectedValue'
	],
	#category : #'Toplo-Theme-Look'
}

{ #category : #private }
ToMultiStateLook >> apply: aStateValue on: anElement [

	self subclassResponsibility 
]

{ #category : #private }
ToMultiStateLook >> cleanUpIn: anElement [

	animation ifNotNil: [
		animation isRunning ifTrue: [ animation stop ].
		anElement dequeueTask: animation.
		animation := nil ]
]

{ #category : #'event handling' }
ToMultiStateLook >> clickLookEvent: anEvent [

	super clickLookEvent: anEvent.
	anEvent elementDo: [ :e |
		self cleanUpIn: e.
		self hoveredStateValue ifNotNil: [ :bg |
			self apply: bg on: e ] ]
]

{ #category : #initialization }
ToMultiStateLook >> defaultInitialValue [

	^ self subclassResponsibility 
]

{ #category : #'event handling' }
ToMultiStateLook >> disabledLookEvent: anEvent [

	super disabledLookEvent: anEvent.
	anEvent elementDo: [ :e |
		self cleanUpIn: e.
		self disabledStateValue ifNotNil: [ :bg |
			self apply: bg on: e ] ]
]

{ #category : #accessing }
ToMultiStateLook >> disabledStateValue [

	^ disabledValue
]

{ #category : #accessing }
ToMultiStateLook >> disabledStateValue: anObject [

	disabledValue := anObject asStateValue 
]

{ #category : #'event handling' }
ToMultiStateLook >> hoveredLookEvent: anEvent [

	super hoveredLookEvent: anEvent.
	anEvent elementDo: [ :e |
		self cleanUpIn: e.
		self hoveredStateValue ifNotNil: [ :bg | self apply: bg on: e ] ]
]

{ #category : #accessing }
ToMultiStateLook >> hoveredStateValue [

	^ hoverValue 
]

{ #category : #accessing }
ToMultiStateLook >> hoveredStateValue: anObject [

	hoverValue := anObject asStateValue
]

{ #category : #'event handling' }
ToMultiStateLook >> initialLookEvent: anEvent [

	super initialLookEvent: anEvent.
	anEvent elementDo: [ :e |
		self cleanUpIn: e.
		self initialStateValue ifNotNil: [ :bg |
			self apply: bg on: e ] ]
]

{ #category : #accessing }
ToMultiStateLook >> initialStateValue [

	^ initialValue ifNil: [ initialValue := self defaultInitialValue ]
]

{ #category : #accessing }
ToMultiStateLook >> initialStateValue: anObject [

	initialValue := anObject asStateValue
]

{ #category : #'event handling' }
ToMultiStateLook >> leavedLookEvent: anEvent [

	super leavedLookEvent: anEvent.
	anEvent elementDo: [ :e |
		self cleanUpIn: e.
		self leavedStateValue ifNotNil: [ :bg |
			self apply: bg on: e ] ]
]

{ #category : #accessing }
ToMultiStateLook >> leavedStateValue [

	^ leavedValue
]

{ #category : #accessing }
ToMultiStateLook >> leavedStateValue: anObject [ 

	leavedValue := anObject asStateValue
]

{ #category : #'event handling' }
ToMultiStateLook >> pressedLookEvent: anEvent [

	super pressedLookEvent: anEvent.
	anEvent elementDo: [ :e |
		self cleanUpIn: e.
		self pressedStateValue ifNotNil: [ :bg | self apply: bg on: e ] ]
]

{ #category : #accessing }
ToMultiStateLook >> pressedStateValue [

	^ pressedvalue
]

{ #category : #accessing }
ToMultiStateLook >> pressedStateValue: anObject [ 

	pressedvalue := anObject asStateValue
]

{ #category : #'event handling' }
ToMultiStateLook >> selectedLookEvent: anEvent [

	super selectedLookEvent: anEvent.
	anEvent elementDo: [ :e |
		self cleanUpIn: e.
		self selectedStateValue ifNotNil: [ :bg | self apply: bg on: e] ]
]

{ #category : #accessing }
ToMultiStateLook >> selectedStateValue [

	^ selectedValue
]

{ #category : #accessing }
ToMultiStateLook >> selectedStateValue: anObject [

	selectedValue := anObject asStateValue
]

{ #category : #'property value change' }
ToMultiStateLook >> stateValueChangeLookEvent: anEvent [

	self apply: anEvent stateValue on: anEvent currentTarget
]
