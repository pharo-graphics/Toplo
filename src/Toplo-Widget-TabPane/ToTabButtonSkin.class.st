Class {
	#name : #ToTabButtonSkin,
	#superclass : #ToTabItemElementSkin,
	#category : #'Toplo-Widget-TabPane-TabList'
}

{ #category : #'event handling' }
ToTabButtonSkin >> enabledSkinEvent: anEvent [

	super enabledSkinEvent: anEvent.

]

{ #category : #'event handling' }
ToTabButtonSkin >> installSkinEvent: anEvent [

	super installSkinEvent: anEvent.

	anEvent elementDo: [ :e | "setup the selection color for the ShrinkFeedbackLayer of the TabButton "
			e holder listElement isFlowable ifFalse: [
					e
						addTokenNamed: #'color-list-primary-selection-focused'
						withValue: (e valueOfTokenNamed: #'color-bg-container') ] ]
]

{ #category : #'event handling' }
ToTabButtonSkin >> uninstallSkinEvent: anEvent [

	super uninstallSkinEvent: anEvent.

	anEvent elementDo: [ :e |
		"setup the selection color for the ShrinkFeedbackLayer of the TabButton "
		e removeTokenNamed: #'color-list-primary-selection-focused' ]
]
