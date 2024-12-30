Class {
	#name : #ToMenuInlineWindowMode,
	#superclass : #ToInlineWindowMode,
	#category : #'Toplo-Widget-Menu-Window'
}

{ #category : #'window handling' }
ToMenuInlineWindowMode >> startWindow: aWindow [

	manager element parent item parentMenu
		addItem: aWindow
		afterIndex: manager element parent holder position.
	manager element requestNewSkin
]

{ #category : #'window handling' }
ToMenuInlineWindowMode >> stopWindow: aWindow [

	manager element parent item parentMenu
		removeItem: aWindow.
	manager element requestNewSkin
]
