Class {
	#name : #ToLook,
	#superclass : #ToElementLook,
	#instVars : [
		'applyBlock',
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
	#category : #'Toplo-Theme-Look'
}

{ #category : #private }
ToLook >> apply: aStateValue on: anElement [

	applyBlock value: anElement value: (aStateValue valueIn: anElement)
]

{ #category : #accessing }
ToLook >> applyWith: aBlock [

	" aBlock takes 2 args: the element and the property value "
	applyBlock := aBlock
]

{ #category : #private }
ToLook >> cleanUpIn: anElement [

	animation ifNotNil: [
		animation isRunning ifTrue: [ animation stop ].
		anElement dequeueTask: animation.
		animation := nil ]
]

{ #category : #'event handling' }
ToLook >> clickedLookEvent: anEvent [

	super clickedLookEvent: anEvent.
	anEvent elementDo: [ :e |
		self cleanUpIn: e.
		self clickedValue ifNotNil: [ :bg |
			self apply: bg on: e ] ]
]

{ #category : #accessing }
ToLook >> clickedValue [

	^ clickedValue
]

{ #category : #accessing }
ToLook >> clickedValue: anObject [

	clickedValue := anObject asStateValue 
]

{ #category : #'event handling' }
ToLook >> disabledLookEvent: anEvent [

	super disabledLookEvent: anEvent.
	anEvent elementDo: [ :e |
		self cleanUpIn: e.
		self disabledValue ifNotNil: [ :bg |
			self apply: bg on: e ] ]
]

{ #category : #accessing }
ToLook >> disabledValue [

	^ disabledValue
]

{ #category : #accessing }
ToLook >> disabledValue: anObject [

	disabledValue := anObject asStateValue 
]

{ #category : #'event handling' }
ToLook >> hoveredLookEvent: anEvent [

	super hoveredLookEvent: anEvent.
	anEvent elementDo: [ :e |
		self cleanUpIn: e.
		self hoveredValue ifNotNil: [ :bg | self apply: bg on: e ] ]
]

{ #category : #accessing }
ToLook >> hoveredValue [

	^ hoveredValue 
]

{ #category : #accessing }
ToLook >> hoveredValue: anObject [

	hoveredValue := anObject asStateValue
]

{ #category : #'event handling' }
ToLook >> initialLookEvent: anEvent [

	super initialLookEvent: anEvent.
	anEvent elementDo: [ :e |
		self cleanUpIn: e.
		self initialValue ifNotNil: [ :bg |
			self apply: bg on: e ] ]
]

{ #category : #accessing }
ToLook >> initialValue [

	^ initialValue 
]

{ #category : #accessing }
ToLook >> initialValue: anObject [

	initialValue := anObject asStateValue
]

{ #category : #'event handling' }
ToLook >> installLookEvent: anEvent [

	super installLookEvent: anEvent.
	anEvent elementDo: [ :e |
		self cleanUpIn: e.
		self installValue ifNotNil: [ :bg |
			self apply: bg on: e ] ]
]

{ #category : #accessing }
ToLook >> installValue [

	^ installValue 
]

{ #category : #accessing }
ToLook >> installValue: anObject [

	installValue := anObject asStateValue
]

{ #category : #'event handling' }
ToLook >> leavedLookEvent: anEvent [

	super leavedLookEvent: anEvent.
	anEvent elementDo: [ :e |
		self cleanUpIn: e.
		self leavedValue ifNotNil: [ :bg |
			self apply: bg on: e ] ]
]

{ #category : #accessing }
ToLook >> leavedValue [

	^ leavedValue
]

{ #category : #accessing }
ToLook >> leavedValue: anObject [ 

	leavedValue := anObject asStateValue
]

{ #category : #'event handling' }
ToLook >> pressedLookEvent: anEvent [

	super pressedLookEvent: anEvent.
	anEvent elementDo: [ :e |
		self cleanUpIn: e.
		self pressedValue ifNotNil: [ :bg | self apply: bg on: e ] ]
]

{ #category : #accessing }
ToLook >> pressedValue [

	^ pressedvalue
]

{ #category : #accessing }
ToLook >> pressedValue: anObject [ 

	pressedvalue := anObject asStateValue
]

{ #category : #'event handling' }
ToLook >> selectedLookEvent: anEvent [

	super selectedLookEvent: anEvent.
	anEvent elementDo: [ :e |
		self cleanUpIn: e.
		self selectedValue ifNotNil: [ :bg | self apply: bg on: e] ]
]

{ #category : #accessing }
ToLook >> selectedValue [

	^ selectedValue
]

{ #category : #accessing }
ToLook >> selectedValue: anObject [

	selectedValue := anObject asStateValue
]
