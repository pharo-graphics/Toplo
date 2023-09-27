Class {
	#name : #ToCheckableButtonDresser,
	#superclass : #ToWidgetDresser,
	#instVars : [
		'checkableHandler'
	],
	#category : #'Toplo-Widget-Button-Checkable'
}

{ #category : #testing }
ToCheckableButtonDresser class >> isDeprecated [ 

	^ true
]

{ #category : #'api - install/uninstall  hook' }
ToCheckableButtonDresser >> checkEvent: anEvent in: anElement [
	"checkEvent:in: can be send either because of a click or because the checkable as been checked programmatically"

	| newState |
	newState := anEvent current
		       ifNil: [ ToIndeterminateState new]
		       ifNotNil: [ :v |
			       v
				       ifTrue: [ ToCheckedState new ]
				       ifFalse: [ ToUncheckedState new ] ].
	anElement switchToSkinState: newState.
	anElement dispatchLookEvent: ToClickedLookEvent new
]

{ #category : #'events handling' }
ToCheckableButtonDresser >> clicked: anElement [

	anElement switchCheckState.
	super clicked: anElement.

	

]

{ #category : #'api - install/uninstall  hook' }
ToCheckableButtonDresser >> onInstalledIn: anElement [

	super onInstalledIn: anElement.
	true ifTrue: [ ^ self ].
	checkableHandler := BlEventHandler
		                    on: ToCheckableCheckEvent
		                    do: [ :event | self checkEvent: event in: anElement ].
	anElement addEventHandler: checkableHandler.
	"anElement innerElement preventChildrenMouseEvents"
]

{ #category : #'api - install/uninstall  hook' }
ToCheckableButtonDresser >> onUninstalledIn: anElement [

	super onUninstalledIn: anElement.
	anElement removeEventHandler: checkableHandler
]
