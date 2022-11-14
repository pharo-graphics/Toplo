Class {
	#name : #ToButtonAutomatonDresser,
	#superclass : #ToElementCompanion,
	#instVars : [
		'handler'
	],
	#category : #'Toplo-Widget-Buttons'
}

{ #category : #'mouse handlers' }
ToButtonAutomatonDresser >> clickCandidateEvent: anEvent [

	self escaped: anEvent target
]

{ #category : #'api - state transitions' }
ToButtonAutomatonDresser >> clicked: anElement [

	self subclassResponsibility 

]

{ #category : #'api - state transitions' }
ToButtonAutomatonDresser >> escaped: anElement [

	self subclassResponsibility 

]

{ #category : #accessing }
ToButtonAutomatonDresser >> handler [

	^ handler
]

{ #category : #accessing }
ToButtonAutomatonDresser >> handler: anEventHandler [

	handler := anEventHandler
]

{ #category : #'api - state transitions' }
ToButtonAutomatonDresser >> hover: anElement [

	self subclassResponsibility 

]

{ #category : #'api - state transitions' }
ToButtonAutomatonDresser >> initialState: anElement [

	self subclassResponsibility 

]

{ #category : #'api - state transitions' }
ToButtonAutomatonDresser >> leaved: anElement [

	self subclassResponsibility 

]

{ #category : #'mouse handlers' }
ToButtonAutomatonDresser >> mouseDownEvent: anEvent [

	self pressed: anEvent target
]

{ #category : #'mouse handlers' }
ToButtonAutomatonDresser >> mouseEnterEvent: anEvent [

	self hover: anEvent target
]

{ #category : #'mouse handlers' }
ToButtonAutomatonDresser >> mouseLeaveEvent: anEvent [

	self leaved: anEvent target
]

{ #category : #'mouse handlers' }
ToButtonAutomatonDresser >> mouseUpEvent: anEvent [

	self clicked: anEvent target
]

{ #category : #'api - hooks' }
ToButtonAutomatonDresser >> newAutomatonEventHandler [

	^ self subclassResponsibility 
]

{ #category : #'api - hooks' }
ToButtonAutomatonDresser >> onInstalledIn: anElement [

	super onInstalledIn: anElement.
	self initialState: anElement.
	handler := self newAutomatonEventHandler dresser: self; button: anElement; yourself.
	anElement addEventHandler: handler
]

{ #category : #'api - hooks' }
ToButtonAutomatonDresser >> onUninstalledIn: anElement [

	super onUninstalledIn: anElement.
	anElement removeEventHandler: handler
]

{ #category : #'api - state transitions' }
ToButtonAutomatonDresser >> pressed: anElement [

	self subclassResponsibility 

]
