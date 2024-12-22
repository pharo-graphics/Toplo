Class {
	#name : #ToMenuInlineWindowMode,
	#superclass : #ToInlineWindowMode,
	#category : #'Toplo-Widget-Menu-Basic'
}

{ #category : #'window handling' }
ToMenuInlineWindowMode >> startWindow: aWindow [

	manager element  addChild: aWindow.
	manager element requestNewSkin
]
