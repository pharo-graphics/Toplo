Class {
	#name : #ToSelectPopupWindow,
	#superclass : #ToAnchoredWindow,
	#category : #'Toplo-Widget-Select-manager'
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
	(self valueOfTokenNamed: #'window-opening-animation') value: self.
	self border: BlBorder empty
]

{ #category : #'t - anchored window element - private layout' }
ToSelectPopupWindow >> newStartLayoutStep [

	^ ToSelectPopupWindowOpeningStartStep new
		  maxHeightPolicy: self manager maxHeightPolicy;
		  yourself
]
