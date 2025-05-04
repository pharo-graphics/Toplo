Class {
	#name : #ToTooltipWindow,
	#superclass : #ToAnchoredWindow,
	#category : #'Toplo-Core-Tooltip'
}

{ #category : #'t - inline window element - accessing' }
ToTooltipWindow >> correctedPositionWithinAnchorRoot [

	| t rect rootRect |
	rect := (self measuredBounds inSpace inChild: self anchorRoot) bounds asRectangle.
	rootRect := 0 @ 0 extent: self anchorRoot extent.
	" just translate the position to remain (if possible) within the root bounds "
	t := rect amountToTranslateWithin: rootRect.
	^ self measuredPosition + t
]

{ #category : #accessing }
ToTooltipWindow >> defaultElevation [

	^ BlRelativeElevation elevation: (SmallInteger maxVal - 300)
]

{ #category : #skin }
ToTooltipWindow >> newRawSkin [

	^ ToTooltipWindowSkin new
]
