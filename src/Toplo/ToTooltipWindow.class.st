Class {
	#name : #ToTooltipWindow,
	#superclass : #ToPopupWindow,
	#category : #'Toplo-Core-Tooltip'
}

{ #category : #'api - displaying' }
ToTooltipWindow >> correctedPositionWithinAnchorRoot [

	| t rect rootRect |
	rect := self bounds inSpace bounds asRectangle.
	rootRect := 0 @ 0 extent: self anchorRoot extent.
	" just translate the position to remain (if possible) within the root bounds "
	t := rect amountToTranslateWithin: rootRect.
	^ self position + t
]

{ #category : #accessing }
ToTooltipWindow >> defaultElevation [

	^ BlRelativeElevation elevation: (SmallInteger maxVal - 300)
]

{ #category : #skin }
ToTooltipWindow >> newRawSkin [

	^ ToTooltipWindowSkin new
]
