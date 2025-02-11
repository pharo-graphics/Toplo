Class {
	#name : #ToMenuInlineWindowMode,
	#superclass : #ToInlineWindowMode,
	#category : #'Toplo-Widget-Menu-Window'
}

{ #category : #'api - displaying' }
ToMenuInlineWindowMode >> arrangeWindow: aWindow onEvent: anEvent [

	| w |
	w := 0.
	manager element parentMenuDo: [ :pm |
		pm menuWindow collectedNodesDo: [ :node |
			w := w max: node measuredWidth ] ].
	manager element parentMenuDo: [ :pm |
		pm menuWindow collectedNodesDo: [ :node |
			node measuredExtent: w @ node measuredHeight ] ]
]

{ #category : #accessing }
ToMenuInlineWindowMode >> menuBarOwner [ 

	^ self element menuBarOwner
]

{ #category : #'window handling' }
ToMenuInlineWindowMode >> startWindow: aWindow [

	" the manager element is a ToMenu. 
	The window is added after the the ToMenu in its barOwner"
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
