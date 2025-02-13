Class {
	#name : #ToMenuInlineWindowMode,
	#superclass : #ToInlineWindowMode,
	#category : #'Toplo-Widget-Menu-Window'
}

{ #category : #accessing }
ToMenuInlineWindowMode >> menuBarOwner [ 

	^ self element menuBarOwner
]

{ #category : #'api - displaying' }
ToMenuInlineWindowMode >> onMeasure: anExtentMeasurementSpec window: aWindow onEvent: anEvent [

	| w |
	" self element is the inline ToMenu "
	w := self element measuredWidth.
	aWindow collectedNodesDo: [ :node | w := w max: node measuredWidth ].
	" change the window width if necessary "
	anExtentMeasurementSpec widthSpec size < w ifFalse: [ ^ self ].
	anExtentMeasurementSpec widthSpec size: w.
	"aWindow collectedNodesDo: [ :node | node item width < w ifTrue: [node item width: w ] ]."

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
