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

	" self anchor element is the inline ToMenu which open the inline window"
	"| w |
	w := self anchorElement measuredWidth.
	aWindow collectedNodesDo: [ :node | w := w max: node measuredWidth ]."
	" change the window width "
	"anExtentMeasurementSpec widthSpec beExact: w"
]

{ #category : #'window handling' }
ToMenuInlineWindowMode >> startWindow: aWindow [
	" the manager element is a ToMenu. 
	The window is added after the ToMenu in its barOwner"

	" an inline window works correctly only with wrapping (need for the flow layout)"
	aWindow itemBar isWrapping: true.
	self menuBarOwner
		addItem: aWindow
		afterIndex: self anchorElement positionInList.
	" need to install a new skin to change the icon (from closed to opened) "
	self anchorElement requestNewSkin
]

{ #category : #'window handling' }
ToMenuInlineWindowMode >> stopWindow: aWindow [
	" the manager element is a ToMenu. 
	remove the window from the ToMenu barOwner ( see startWindow: ) "

	self menuBarOwner removeItem: aWindow.
	self anchorElement requestNewSkin
]
