Class {
	#name : #ToCheckableButtonDresser,
	#superclass : #ToWidgetDresser,
	#instVars : [
		'checkableHandler'
	],
	#category : #'Toplo-Widget-Button'
}

{ #category : #'api - install/uninstall  hook' }
ToCheckableButtonDresser >> checkEvent: anEvent in: anElement [

	"checkEvent:in: can be send either because of a click or because the checkable as been checked programmatically"
	anElement dispatchLookEvent: ToClickLookEvent new
]

{ #category : #'events handling' }
ToCheckableButtonDresser >> clicked: anElement [

	anElement switchToNextState.
	super clicked: anElement.

	

]

{ #category : #'api - install/uninstall  hook' }
ToCheckableButtonDresser >> onInstalledIn: anElement [

	super onInstalledIn: anElement.
	checkableHandler := BlEventHandler
		                    on: ToCheckableCheckEvent
		                    do: [ :event | self checkEvent: event in: anElement ].
	anElement addEventHandler: checkableHandler
]

{ #category : #'api - install/uninstall  hook' }
ToCheckableButtonDresser >> onUninstalledIn: anElement [

	super onUninstalledIn: anElement.
	anElement removeEventHandler: checkableHandler
]
