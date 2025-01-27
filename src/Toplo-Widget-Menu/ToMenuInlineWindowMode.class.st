Class {
	#name : #ToMenuInlineWindowMode,
	#superclass : #ToInlineWindowMode,
	#category : #'Toplo-Widget-Menu-Window'
}

{ #category : #'window handling' }
ToMenuInlineWindowMode >> startWindow: aWindow [

	" the manager element is a ToMenu. 
	The window is added after the the ToMenu in its barOwner"
	manager element barOwner 
		addItem: aWindow
		afterIndex: manager element positionInBar.
	manager element requestNewSkin
]

{ #category : #'window handling' }
ToMenuInlineWindowMode >> stopWindow: aWindow [

	" the manager element is a ToMenu. 
	remove the window from the ToMenu barOwner ( see startWindow: ) "

	manager element barOwner
		removeItem: aWindow.
	manager element requestNewSkin
]
