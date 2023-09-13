Class {
	#name : #ToMultiStateLook,
	#superclass : #ToElementLook,
	#instVars : [
		'animation',
		'disabledValue',
		'leavedValue',
		'installValue',
		'initialValue',
		'pressedvalue',
		'selectedValue',
		'clickedValue',
		'hoveredValue'
	],
	#category : #'Toplo-Theme-Look-Dep'
}

{ #category : #testing }
ToMultiStateLook class >> isDeprecated [ 

	^ true
]

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
ToMultiStateLook >> clickedLookEvent: anEvent [

	super clickedLookEvent: anEvent.
	anEvent elementDo: [ :e |
		self cleanUpIn: e.
		self clickedValue ifNotNil: [ :bg |
			self apply: bg on: e ] ]
]

{ #category : #accessing }
ToMultiStateLook >> clickedValue [

	^ clickedValue
]

{ #category : #'event handling' }
ToMultiStateLook >> disabledLookEvent: anEvent [

	super disabledLookEvent: anEvent.
	anEvent elementDo: [ :e |
		self cleanUpIn: e.
		self disabledValue ifNotNil: [ :bg |
			self apply: bg on: e ] ]
]

{ #category : #accessing }
ToMultiStateLook >> disabledValue [

	^ disabledValue
]

{ #category : #'event handling' }
ToMultiStateLook >> hoveredLookEvent: anEvent [

	super hoveredLookEvent: anEvent.
	anEvent elementDo: [ :e |
		self cleanUpIn: e.
		self hoveredValue ifNotNil: [ :bg | self apply: bg on: e ] ]
]

{ #category : #accessing }
ToMultiStateLook >> hoveredValue [

	^ hoveredValue 
]

{ #category : #'event handling' }
ToMultiStateLook >> initialLookEvent: anEvent [

	super initialLookEvent: anEvent.
	anEvent elementDo: [ :e |
		self cleanUpIn: e.
		self initialValue ifNotNil: [ :bg |
			self apply: bg on: e ] ]
]

{ #category : #accessing }
ToMultiStateLook >> initialValue [

	^ initialValue 
]

{ #category : #'event handling' }
ToMultiStateLook >> installLookEvent: anEvent [

	super installLookEvent: anEvent.
	anEvent elementDo: [ :e |
		self cleanUpIn: e.
		self installValue ifNotNil: [ :bg |
			self apply: bg on: e ] ]
]

{ #category : #accessing }
ToMultiStateLook >> installValue [

	^ installValue 
]

{ #category : #'event handling' }
ToMultiStateLook >> leavedLookEvent: anEvent [

	super leavedLookEvent: anEvent.
	anEvent elementDo: [ :e |
		self cleanUpIn: e.
		self leavedValue ifNotNil: [ :bg |
			self apply: bg on: e ] ]
]

{ #category : #accessing }
ToMultiStateLook >> leavedValue [

	^ leavedValue
]

{ #category : #'event handling' }
ToMultiStateLook >> pressedLookEvent: anEvent [

	super pressedLookEvent: anEvent.
	anEvent elementDo: [ :e |
		self cleanUpIn: e.
		self pressedValue ifNotNil: [ :bg | self apply: bg on: e ] ]
]

{ #category : #accessing }
ToMultiStateLook >> pressedValue [

	^ pressedvalue
]

{ #category : #'event handling' }
ToMultiStateLook >> selectedLookEvent: anEvent [

	super selectedLookEvent: anEvent.
	anEvent elementDo: [ :e |
		self cleanUpIn: e.
		self selectedValue ifNotNil: [ :bg | self apply: bg on: e] ]
]

{ #category : #accessing }
ToMultiStateLook >> selectedValue [

	^ selectedValue
]

{ #category : #accessing }
ToMultiStateLook >> whenClicked: anObject [

	clickedValue := anObject  
]

{ #category : #accessing }
ToMultiStateLook >> whenDisabled: anObject [

	disabledValue := anObject  
]

{ #category : #accessing }
ToMultiStateLook >> whenHovered: anObject [

	hoveredValue := anObject 
]

{ #category : #accessing }
ToMultiStateLook >> whenInitialized: anObject [

	initialValue := anObject 
]

{ #category : #accessing }
ToMultiStateLook >> whenInstalled: anObject [

	installValue := anObject 
]

{ #category : #accessing }
ToMultiStateLook >> whenLeaved: anObject [ 

	leavedValue := anObject 
]

{ #category : #accessing }
ToMultiStateLook >> whenPressed: anObject [ 

	pressedvalue := anObject 
]

{ #category : #accessing }
ToMultiStateLook >> whenSelected: anObject [

	selectedValue := anObject 
]
