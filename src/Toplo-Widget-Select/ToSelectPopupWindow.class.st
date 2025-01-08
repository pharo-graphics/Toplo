Class {
	#name : #ToSelectPopupWindow,
	#superclass : #ToPopupWindow,
	#category : #'Toplo-Widget-Select-List'
}

{ #category : #'t - inline window element - accessing' }
ToSelectPopupWindow >> defaultElevation [

	^ BlRelativeElevation elevation: (SmallInteger maxVal - 300)
]

{ #category : #skin }
ToSelectPopupWindow >> installRawStyle [

	super installRawStyle.
	(self valueOfTokenNamed: #'animation-window-opening') value: self.
	self border: BlBorder empty.
	"self flag: 'Optimization point'."
	" the effet makes the drawing much too slow for now for a ToSelectElement 
	because scrolling and moving the mouse inside trigger a lot of redrawing"
	"self effect: (self valueOfTokenNamed: #'effect-window')"
]
