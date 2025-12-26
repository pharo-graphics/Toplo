Class {
	#name : #ToTabPaneNodeSkin,
	#superclass : #ToTabNodeSkin,
	#category : #'Toplo-Widget-TabPane-TabList'
}

{ #category : #'event handling' }
ToTabPaneNodeSkin >> configureSelectionTokensIn: anItemElement [

	anItemElement holder listElement isFlowable
		ifTrue: [
				anItemElement removeTokenNamed: #'selected-focused-foreground'.
				anItemElement removeTokenNamed: #'selected-unfocused-foreground' ]
		ifFalse: [
				anItemElement
					addTokenNamed: #'selected-focused-foreground'
					withValue:
					(anItemElement valueOfTokenNamed: #'color-primary-checked').
				anItemElement
					addTokenNamed: #'selected-unfocused-foreground'
					withValue:
					(anItemElement valueOfTokenNamed: #'color-primary-checked') ]
]

{ #category : #'event handling' }
ToTabPaneNodeSkin >> installSkinEvent: anEvent [

	super installSkinEvent: anEvent.
	anEvent elementDo: [ :e | self configureSelectionTokensIn: e ]
]
