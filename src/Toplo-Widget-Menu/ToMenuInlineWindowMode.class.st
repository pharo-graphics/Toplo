Class {
	#name : #ToMenuInlineWindowMode,
	#superclass : #ToInlineWindowMode,
	#category : #'Toplo-Widget-Menu-Window'
}

{ #category : #'api - displaying' }
ToMenuInlineWindowMode >> measureWindow: aWindow onEvent: anEvent [

	"| winWidth nodesWidth |
	winWidth := aWindow measuredWidth.
	nodesWidth := 0.0.
	aWindow collectedNodesDo: [ :node |
		nodesWidth := nodesWidth max: node measuredWidth ].
	winWidth < nodesWidth ifTrue: [
		aWindow measuredExtent: nodesWidth @ aWindow measuredHeight ].
	aWindow collectedNodesDo: [ :node |
		node measuredWidth < nodesWidth ifTrue: [ node width: nodesWidth ] ]"
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
