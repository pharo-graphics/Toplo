Class {
	#name : #ToAbstractButtonDresser,
	#superclass : #ToMouseHandlingDresser,
	#instVars : [
		'clickCandidateHandler',
		'clickActionLauncher'
	],
	#category : #'Toplo-Widget-Button'
}

{ #category : #'event handlers' }
ToAbstractButtonDresser >> clickActionLauncher [

	^ ToButtonClickHandler new
]

{ #category : #'event handlers' }
ToAbstractButtonDresser >> clickCandidateHandlerIn: anElement [

	^ BlEventHandler on: BlClickCandidateEvent do: [ self escaped: anElement ]
]

{ #category : #'events handling' }
ToAbstractButtonDresser >> doubleClicked: anElement event: anEvent [

	super doubleClicked: anElement event: anEvent.
	self clicked: anElement event: anEvent

]

{ #category : #'events handling' }
ToAbstractButtonDresser >> escaped: anElement [

	self subclassResponsibility 

]

{ #category : #'api - install/uninstall  hook' }
ToAbstractButtonDresser >> installEventListenersIn: anElement [

	super installEventListenersIn: anElement.
	clickActionLauncher := self clickActionLauncher button: anElement.
	clickCandidateHandler := self clickCandidateHandlerIn: anElement.
	
	anElement addEventHandler: clickCandidateHandler.
	anElement addEventHandler: clickActionLauncher.


]

{ #category : #'events handling' }
ToAbstractButtonDresser >> leaved: anElement [

	self subclassResponsibility 

]

{ #category : #'events handling' }
ToAbstractButtonDresser >> leaved: anElement event: anEvent [

	super leaved: anElement event: anEvent.
	self leaved: anElement

]

{ #category : #'events handling' }
ToAbstractButtonDresser >> leftClicked: anElement [

	anElement fireEvent: ToButtonClickedEvent new
]

{ #category : #'events handling' }
ToAbstractButtonDresser >> leftClicked: anElement event: anEvent [

	super leftClicked: anElement event: anEvent.
	self leftClicked: anElement
]

{ #category : #'api - install/uninstall  hook' }
ToAbstractButtonDresser >> onInstalledIn: anElement [

	super onInstalledIn: anElement
]

{ #category : #'api - install/uninstall  hook' }
ToAbstractButtonDresser >> onUninstalledIn: anElement [

	super onUninstalledIn: anElement.

]

{ #category : #'api - install/uninstall  hook' }
ToAbstractButtonDresser >> uninstallEventListenersIn: anElement [

	super uninstallEventListenersIn: anElement.
	anElement removeEventHandler: clickCandidateHandler.
	anElement removeEventHandler: clickActionLauncher
]
