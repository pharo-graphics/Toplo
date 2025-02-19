Class {
	#name : #ToMenuInlineWindowMode,
	#superclass : #ToInlineWindowMode,
	#category : #'Toplo-Widget-Menu-Window'
}

{ #category : #accessing }
ToMenuInlineWindowMode >> menuBarOwner [

	^ self anchorElement menuBarOwner
]

{ #category : #'api - displaying' }
ToMenuInlineWindowMode >> onMeasure: anExtentMeasurementSpec element: aWindow onEvent: anEvent [

	| w |
	" self anchor element is the inline ToMenu which open the inline window"
	w := self anchorElement measuredWidth.
	aWindow collectedNodesDo: [ :node | w := w max: node measuredWidth ].
	" change the window width "
	anExtentMeasurementSpec widthSpec beExact: w
]

{ #category : #'window handling' }
ToMenuInlineWindowMode >> startWindow: aWindow [
	" the manager element is a ToMenu. 
	The window is added after the ToMenu in its barOwner"

	self menuBarOwner
		addItem: aWindow
		afterIndex: self anchorElement positionInList.
	self anchorElement requestNewSkin
]

{ #category : #'window handling' }
ToMenuInlineWindowMode >> stopWindow: aWindow [
	" the manager element is a ToMenu. 
	remove the window from the ToMenu barOwner ( see startWindow: ) "

	self menuBarOwner removeItem: aWindow.
	self anchorElement requestNewSkin
]
