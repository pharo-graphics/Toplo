Class {
	#name : #ToLookDep,
	#superclass : #ToElementLook,
	#instVars : [
		'updaterIndex',
		'applyBlock'
	],
	#category : #'Toplo-Theme-Look-Dep'
}

{ #category : #'instance creation' }
ToLookDep class >> forBackground [

	^ self new applyWith: [ :e :b | e background: b ]; yourself
]

{ #category : #'instance creation' }
ToLookDep class >> forBorder [

	^ self new applyWith: [ :e :b | e border: b ]; yourself
]

{ #category : #'instance creation' }
ToLookDep class >> forTextAttributes [

	^ self new 
			 applyWith: [ :e :v |
				 e text attributes: v attributes.
				 e textChanged ]
]

{ #category : #'instance creation' }
ToLookDep class >> forTextForegroundWithBuilder: aTextAttributesBuilder [

	^ self new applyWith: [ :e :v |
		  aTextAttributesBuilder foreground: v.
		  e text attributes: aTextAttributesBuilder attributes.
		  e textChanged ]
]

{ #category : #private }
ToLookDep >> apply: aStateValue on: anElement [

	aStateValue applyOn: anElement fromLook: self
]

{ #category : #accessing }
ToLookDep >> applyBlock [

	" applyBlock takes 2 args: the element and the property value "
	^ applyBlock
]

{ #category : #accessing }
ToLookDep >> applyWith: aBlock [

	" aBlock takes 2 args: the element and the property value "
	applyBlock := aBlock
]

{ #category : #'event handling' }
ToLookDep >> clickedLookEvent: anEvent [

	super clickedLookEvent: anEvent.
	anEvent elementDo: [ :e |
		self clickedValue ifNotNil: [ :bg |
			self apply: bg on: e ] ]
]

{ #category : #accessing }
ToLookDep >> clickedValue [

	^ updaterIndex at: ToClickedLookEvent ifAbsent: [  ]
]

{ #category : #accessing }
ToLookDep >> clickedValue: anObject [

	updaterIndex at: ToClickedLookEvent put: anObject asStateValue 
]

{ #category : #'event handling' }
ToLookDep >> disabledLookEvent: anEvent [

	super disabledLookEvent: anEvent.
	anEvent elementDo: [ :e |
		self disabledValue ifNotNil: [ :bg |
			self apply: bg on: e ] ]
]

{ #category : #accessing }
ToLookDep >> disabledValue [

	^ updaterIndex at: ToDisabledLookEvent ifAbsent: [  ]
]

{ #category : #accessing }
ToLookDep >> disabledValue: anObject [

	updaterIndex at: ToDisabledLookEvent put: anObject asStateValue 
]

{ #category : #'event handling' }
ToLookDep >> hoveredLookEvent: anEvent [

	super hoveredLookEvent: anEvent.
	anEvent elementDo: [ :e |
		self hoveredValue ifNotNil: [ :bg | self apply: bg on: e ] ]
]

{ #category : #accessing }
ToLookDep >> hoveredValue [

	^ updaterIndex at: ToHoveredLookEvent ifAbsent: [  ]
]

{ #category : #accessing }
ToLookDep >> hoveredValue: anObject [

	updaterIndex at: ToHoveredLookEvent put: anObject asStateValue 
]

{ #category : #'event handling' }
ToLookDep >> initialLookEvent: anEvent [

	super initialLookEvent: anEvent.
	anEvent elementDo: [ :e |
		self initialValue ifNotNil: [ :bg |
			self apply: bg on: e ] ]
]

{ #category : #accessing }
ToLookDep >> initialValue [

	^ updaterIndex at: ToInitialLookEvent ifAbsent: [  ]
]

{ #category : #accessing }
ToLookDep >> initialValue: anObject [

	updaterIndex at: ToInitialLookEvent put: anObject asStateValue 
]

{ #category : #initialization }
ToLookDep >> initialize [ 

	super initialize.
	updaterIndex := IdentityDictionary new
]

{ #category : #'event handling' }
ToLookDep >> installLookEvent: anEvent [

	super installLookEvent: anEvent.
	anEvent elementDo: [ :e |
		self installValue ifNotNil: [ :bg |
			self apply: bg on: e ] ]
]

{ #category : #accessing }
ToLookDep >> installValue [

	^ updaterIndex at: ToInstallLookEvent ifAbsent: [  ]
]

{ #category : #accessing }
ToLookDep >> installValue: anObject [

	updaterIndex at: ToInstallLookEvent put: anObject asStateValue 
]

{ #category : #'event handling' }
ToLookDep >> leavedLookEvent: anEvent [

	super leavedLookEvent: anEvent.
	anEvent elementDo: [ :e |
		self leavedValue ifNotNil: [ :bg |
			self apply: bg on: e ] ]
]

{ #category : #accessing }
ToLookDep >> leavedValue [

	^ updaterIndex at: ToLeavedLookEvent ifAbsent: [  ]
]

{ #category : #accessing }
ToLookDep >> leavedValue: anObject [

	updaterIndex at: ToLeavedLookEvent put: anObject asStateValue 
]

{ #category : #'event handling' }
ToLookDep >> pressedLookEvent: anEvent [

	super pressedLookEvent: anEvent.
	anEvent elementDo: [ :e |
		self pressedValue ifNotNil: [ :bg | self apply: bg on: e ] ]
]

{ #category : #accessing }
ToLookDep >> pressedValue [

	^ updaterIndex at: ToPressedLookEvent ifAbsent: [  ]
]

{ #category : #accessing }
ToLookDep >> pressedValue: anObject [

	updaterIndex at: ToPressedLookEvent put: anObject asStateValue 
]

{ #category : #'event handling' }
ToLookDep >> selectedLookEvent: anEvent [

	super selectedLookEvent: anEvent.
	anEvent elementDo: [ :e |
		self cleanUpIn: e.
		self selectedValue ifNotNil: [ :bg | self apply: bg on: e] ]
]

{ #category : #accessing }
ToLookDep >> selectedValue [

	^ updaterIndex at: ToSelectedLookEvent ifAbsent: [  ]
]

{ #category : #accessing }
ToLookDep >> selectedValue: anObject [

	updaterIndex at: ToSelectedLookEvent put: anObject asStateValue 
]

{ #category : #accessing }
ToLookDep >> whenClicked: anObject [

	updaterIndex at: ToClickedLookEvent put: anObject asStateUpdater  
]

{ #category : #accessing }
ToLookDep >> whenDisabled: anObject [

	updaterIndex at: ToDisabledLookEvent put: anObject asStateUpdater
]

{ #category : #accessing }
ToLookDep >> whenHovered: anObject [

	updaterIndex at: ToHoveredLookEvent put: anObject asStateUpdater
]

{ #category : #accessing }
ToLookDep >> whenInitialized: anObject [

	updaterIndex at: ToInitialLookEvent put: anObject asStateUpdater
]

{ #category : #accessing }
ToLookDep >> whenInstalled: anObject [

	updaterIndex at: ToInstallLookEvent put: anObject asStateUpdater
]

{ #category : #accessing }
ToLookDep >> whenLeaved: anObject [

	updaterIndex at: ToLeavedLookEvent put: anObject asStateUpdater
]

{ #category : #accessing }
ToLookDep >> whenPressed: anObject [

	updaterIndex at: ToPressedLookEvent put: anObject asStateUpdater
]

{ #category : #accessing }
ToLookDep >> whenSelected: anObject [

	updaterIndex at: ToSelectedLookEvent put: anObject asStateUpdater
]
