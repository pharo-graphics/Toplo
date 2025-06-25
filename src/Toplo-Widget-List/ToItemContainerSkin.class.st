Class {
	#name : #ToItemContainerSkin,
	#superclass : #ToRawSkin,
	#category : #'Toplo-Widget-List-Core-Item'
}

{ #category : #'event handling' }
ToItemContainerSkin >> installSkinEvent: anEvent [

	super installSkinEvent: anEvent.
	anEvent elementDo: [ :e |
		| listElement |
		e item ifNotNil: [ :item |
			listElement := item holder listElement.
			listElement isFlowable ifFalse: [
				e
					addTokenNamed: #'color-list-primary-selection-focused'
					withValue: (e valueOfTokenNamed: #'color-bg-container') ] ] ]
]

{ #category : #'event handling' }
ToItemContainerSkin >> uninstallSkinEvent: anEvent [

	super uninstallSkinEvent: anEvent.
	anEvent elementDo: [ :e |
		"setup the selection color for the ShrinkFeedbackLayer of the TabButton "
		e removeTokenNamed: #'color-list-primary-selection-focused' ]
]
