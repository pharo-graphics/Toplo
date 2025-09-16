Class {
	#name : #ToTooltipWindow,
	#superclass : #ToAnchoredWindow,
	#category : #'Toplo-Core-Tooltip'
}

{ #category : #'t - anchored window element - accessing' }
ToTooltipWindow >> correctedPositionWithinAnchorRoot [

	| t rect rootRect bndsInSpace |
	bndsInSpace := self measuredBounds inSpace.
	rect := (bndsInSpace inChild: self anchorRoot) bounds asRectangle.
	rootRect := 0 @ 0 extent: self anchorRoot extent.
	" just translate the position to remain (if possible) within the root bounds "
	t := rect amountToTranslateWithin: rootRect.
	" now try to avoid the popup to be over the mouse position 
	https://github.com/pharo-graphics/Toplo/issues/269"
	self spaceDo: [ :sp |
			sp mouseProcessor lastMouseMoveEvent ifNotNil: [ :lastMouseMove |
					| fixedBounds |
					fixedBounds := BlBounds
						               origin: bndsInSpace position + t
						               extent: bndsInSpace extent.
					(fixedBounds containsPoint: lastMouseMove position) ifTrue: [
						t := t - (bndsInSpace position - lastMouseMove position) + 10
						     @ 10 ] ] ].
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
