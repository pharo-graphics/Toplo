Class {
	#name : #ToMenuInlineWindowMode,
	#superclass : #ToInlineWindowMode,
	#category : #'Toplo-Widget-Menu-Window'
}

{ #category : #'window handling' }
ToMenuInlineWindowMode >> startWindow: aWindow [

	" the manager element is a ToMenu. 
	The window is added after the the ToMenu in its barOwner"
	self barOwner 
		addItem: aWindow
		afterIndex: self element positionInBar.
	self element requestNewSkin
]

{ #category : #'window handling' }
ToMenuInlineWindowMode >> stopWindow: aWindow [

	" the manager element is a ToMenu. 
	remove the window from the ToMenu barOwner ( see startWindow: ) "

	self barOwner
		removeItem: aWindow.
	self element requestNewSkin
]
