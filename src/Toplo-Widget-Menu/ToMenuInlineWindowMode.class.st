Class {
	#name : #ToMenuInlineWindowMode,
	#superclass : #ToInlineWindowMode,
	#category : #'Toplo-Widget-Menu-Window'
}

{ #category : #'api - displaying' }
ToMenuInlineWindowMode >> measureWindow: aWindow onEvent: anEvent [

	| w |
	" self element is the inline ToMenu "
	w := 0.0.
	aWindow collectedNodesDo: [ :node | w := w max: node measuredWidth ].
	w := w max: self element measuredWidth.
	" change the window width if necessary "
	aWindow measuredWidth < w ifFalse: [ ^ self ].
	aWindow measuredExtent: w @ aWindow measuredHeight.
	aWindow collectedNodesDo: [ :node | node width: w]
]

{ #category : #accessing }
ToMenuInlineWindowMode >> menuBarOwner [ 

	^ self element menuBarOwner
]

{ #category : #'window handling' }
ToMenuInlineWindowMode >> startWindow: aWindow [

	" the manager element is a ToMenu. 
	The window is added after the ToMenu in its barOwner"
	self menuBarOwner 
		addItem: aWindow
		afterIndex: self element positionInBar.
	self element requestNewSkin
]

{ #category : #'window handling' }
ToMenuInlineWindowMode >> stopWindow: aWindow [

	" the manager element is a ToMenu. 
	remove the window from the ToMenu barOwner ( see startWindow: ) "

	self menuBarOwner
		removeItem: aWindow.
	self element requestNewSkin
]
