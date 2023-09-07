Class {
	#name : #ToSinglePropertyLook,
	#superclass : #ToElementLook,
	#instVars : [
		'animation',
		'disabledValue',
		'hoverValue',
		'initialValue',
		'pressedvalue',
		'selectedValue'
	],
	#category : #'Toplo-Theme-Look'
}

{ #category : #private }
ToSinglePropertyLook >> cleanUpIn: anElement [

	animation ifNotNil: [
		animation isRunning ifTrue: [ animation stop ].
		anElement dequeueTask: animation.
		animation := nil ]
]

{ #category : #'event handling' }
ToSinglePropertyLook >> clickLookEvent: anEvent [

	super clickLookEvent: anEvent.
	anEvent elementDo: [ :e |
		self cleanUpIn: e.
		self hoverStateValue ifNotNil: [ :bg |
			self switchToNewValue: bg in: e ] ]
]

{ #category : #initialization }
ToSinglePropertyLook >> defaultInitialValue [

	^ self subclassResponsibility 
]

{ #category : #'event handling' }
ToSinglePropertyLook >> disabledLookEvent: anEvent [

	super disabledLookEvent: anEvent.
	anEvent elementDo: [ :e |
		self cleanUpIn: e.
		self disabledStateValue ifNotNil: [ :bg |
			self switchToNewValue: bg in: e ] ]
]

{ #category : #accessing }
ToSinglePropertyLook >> disabledStateValue [

	^ disabledValue
]

{ #category : #accessing }
ToSinglePropertyLook >> disabledStateValue: anObject [

	disabledValue := anObject asStateValue 
]

{ #category : #accessing }
ToSinglePropertyLook >> hoverStateValue [

	^ hoverValue 
]

{ #category : #accessing }
ToSinglePropertyLook >> hoverStateValue: anObject [

	hoverValue := anObject asStateValue
]

{ #category : #'event handling' }
ToSinglePropertyLook >> hoveredLookEvent: anEvent [

	super hoveredLookEvent: anEvent.
	anEvent elementDo: [ :e |
		self cleanUpIn: e.
		self hoverStateValue ifNotNil: [ :bg | self switchToNewValue: bg in: e ] ]
]

{ #category : #'event handling' }
ToSinglePropertyLook >> initialLookEvent: anEvent [

	super initialLookEvent: anEvent.
	anEvent elementDo: [ :e |
		self cleanUpIn: e.
		self initialStateValue ifNotNil: [ :bg |
			self switchToNewValue: bg in: e ] ]
]

{ #category : #accessing }
ToSinglePropertyLook >> initialStateValue [

	^ initialValue ifNil: [ initialValue := self defaultInitialValue ]
]

{ #category : #accessing }
ToSinglePropertyLook >> initialStateValue: anObject [

	initialValue := anObject asStateValue
]

{ #category : #'event handling' }
ToSinglePropertyLook >> pressedLookEvent: anEvent [

	super pressedLookEvent: anEvent.
	anEvent elementDo: [ :e |
		self cleanUpIn: e.
		self pressedStateValue ifNotNil: [ :bg | self switchToNewValue: bg in: e ] ]
]

{ #category : #accessing }
ToSinglePropertyLook >> pressedStateValue [

	^ pressedvalue
]

{ #category : #accessing }
ToSinglePropertyLook >> pressedStateValue: anObject [ 

	pressedvalue := anObject asStateValue
]

{ #category : #'event handling' }
ToSinglePropertyLook >> selectedLookEvent: anEvent [

	super selectedLookEvent: anEvent.
	anEvent elementDo: [ :e |
		self cleanUpIn: e.
		self selectedStateValue ifNotNil: [ :bg | self switchToNewValue: bg in: e] ]
]

{ #category : #accessing }
ToSinglePropertyLook >> selectedStateValue [

	^ selectedValue
]

{ #category : #accessing }
ToSinglePropertyLook >> selectedStateValue: anObject [

	selectedValue := anObject asStateValue
]

{ #category : #'property value change' }
ToSinglePropertyLook >> stateValueChangeLookEvent: anEvent [

	self switchToNewValue: anEvent stateValue in: anEvent currentTarget
]

{ #category : #private }
ToSinglePropertyLook >> switchToNewValue: aStateValue in: anElement [

	self subclassResponsibility 
]
