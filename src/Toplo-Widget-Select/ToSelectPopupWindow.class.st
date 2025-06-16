Class {
	#name : #ToSelectPopupWindow,
	#superclass : #ToAnchoredWindow,
	#category : #'Toplo-Widget-Select-List'
}

{ #category : #'t - inline window element - accessing' }
ToSelectPopupWindow >> defaultElevation [

	^ BlRelativeElevation elevation: (SmallInteger maxVal - 300)
]

{ #category : #initialization }
ToSelectPopupWindow >> initialize [

	super initialize.
	self hMatchParent.
	self vFitContent
]

{ #category : #skin }
ToSelectPopupWindow >> installRawStyle [

	super installRawStyle.
	(self valueOfTokenNamed: #'animation-window-opening') value: self.
	self border: BlBorder empty
]

{ #category : #'t - anchored window element - private layout' }
ToSelectPopupWindow >> newStartLayoutStep [ 

	^ ToSelectPopupWindowOpeningStartStep new
]
