Class {
	#name : #ToLook,
	#superclass : #ToElementLook,
	#instVars : [
		'applyBlock',
		'disabledValue',
		'leavedValue',
		'installValue',
		'initialValue',
		'pressedValue',
		'selectedValue',
		'clickedValue',
		'hoveredValue'
	],
	#category : #'Toplo-Theme-Look'
}

{ #category : #'instance creation' }
ToLook class >> forBackground [

	^ self new applyWith: [ :e :b | e background: b ]; yourself
]

{ #category : #'instance creation' }
ToLook class >> forBorder [

	^ self new applyWith: [ :e :b | e border: b ]; yourself
]

{ #category : #'instance creation' }
ToLook class >> forTextAttributes [

	^ self new 
			 applyWith: [ :e :v |
				 e text attributes: v attributes.
				 e textChanged ]
]

{ #category : #'instance creation' }
ToLook class >> forTextForegroundWithBuilder: aTextAttributesBuilder [

	^ self new applyWith: [ :e :v |
		  aTextAttributesBuilder foreground: v.
		  e text attributes: aTextAttributesBuilder attributes.
		  e textChanged ]
]

{ #category : #private }
ToLook >> apply: aStateValue on: anElement [

	aStateValue applyOn: anElement fromLook: self
]

{ #category : #accessing }
ToLook >> applyBlock [

	" applyBlock takes 2 args: the element and the property value "
	^ applyBlock
]

{ #category : #accessing }
ToLook >> applyWith: aBlock [

	" aBlock takes 2 args: the element and the property value "
	applyBlock := aBlock
]

{ #category : #'event handling' }
ToLook >> clickedLookEvent: anEvent [

	super clickedLookEvent: anEvent.
	anEvent elementDo: [ :e |
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
		self hoveredValue ifNotNil: [ :bg | self apply: bg on: e ] ]
]

{ #category : #accessing }
ToLook >> hoveredValue [

	^ hoveredValue 
]

{ #category : #accessing }
ToLook >> hoveredValue: anObject [

	hoveredValue := anObject  asStateValue
]

{ #category : #'event handling' }
ToLook >> initialLookEvent: anEvent [

	super initialLookEvent: anEvent.
	anEvent elementDo: [ :e |
		self initialValue ifNotNil: [ :bg |
			self apply: bg on: e ] ]
]

{ #category : #accessing }
ToLook >> initialValue [

	^ initialValue 
]

{ #category : #accessing }
ToLook >> initialValue: anObject [

	initialValue := anObject  asStateValue
]

{ #category : #'event handling' }
ToLook >> installLookEvent: anEvent [

	super installLookEvent: anEvent.
	anEvent elementDo: [ :e |
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
		self leavedValue ifNotNil: [ :bg |
			self apply: bg on: e ] ]
]

{ #category : #accessing }
ToLook >> leavedValue [

	^ leavedValue
]

{ #category : #accessing }
ToLook >> leavedValue: anObject [

	leavedValue := anObject  asStateValue
]

{ #category : #'event handling' }
ToLook >> pressedLookEvent: anEvent [

	super pressedLookEvent: anEvent.
	anEvent elementDo: [ :e |
		self pressedValue ifNotNil: [ :bg | self apply: bg on: e ] ]
]

{ #category : #accessing }
ToLook >> pressedValue [

	^ pressedValue
]

{ #category : #accessing }
ToLook >> pressedValue: anObject [

	pressedValue := anObject  asStateValue
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

	selectedValue := anObject  asStateValue
]

{ #category : #accessing }
ToLook >> whenClicked: anObject [

	clickedValue := anObject asStateUpdater
]

{ #category : #accessing }
ToLook >> whenDisabled: anObject [

	disabledValue := anObject asStateUpdater
]

{ #category : #accessing }
ToLook >> whenHovered: anObject [

	hoveredValue := anObject asStateUpdater
]

{ #category : #accessing }
ToLook >> whenInitialized: anObject [

	initialValue := anObject asStateUpdater
]

{ #category : #accessing }
ToLook >> whenInstalled: anObject [

	installValue := anObject asStateUpdater
]

{ #category : #accessing }
ToLook >> whenLeaved: anObject [

	leavedValue := anObject asStateUpdater
]

{ #category : #accessing }
ToLook >> whenPressed: anObject [

	pressedValue := anObject asStateUpdater
]

{ #category : #accessing }
ToLook >> whenSelected: anObject [

	selectedValue := anObject asStateUpdater
]
