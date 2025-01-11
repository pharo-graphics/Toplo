Class {
	#name : #ToMenuInlineWindowMode,
	#superclass : #ToInlineWindowMode,
	#category : #'Toplo-Widget-Menu-Window'
}

{ #category : #'window handling' }
ToMenuInlineWindowMode >> startWindow: aWindow [

	manager element parent item itemList
		addItem: aWindow
		afterIndex: manager element nodeHolder position.
	manager element requestNewSkin
]

{ #category : #'window handling' }
ToMenuInlineWindowMode >> stopWindow: aWindow [

	manager element parent item barParent
		removeItem: aWindow.
	manager element requestNewSkin
]
