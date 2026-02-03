Class {
	#name : #ToEmptySkin,
	#superclass : #ToRawSkin,
	#category : #'Toplo-Widget-Empty'
}

{ #category : #accessing }
ToEmptySkin >> installSector: aSector in: anElement withGap: anHorizontalGap [

	| startAngle radius width idx angleGap |
	idx := anElement children indexOf: aSector.
	angleGap := 360 / anElement children size.
	startAngle := idx * angleGap.

	radius := anElement extent min / 2.
	width := radius - anHorizontalGap.

	aSector width: width.
	aSector transformDo: [ :t |
			t origin: (BlAffineTransformationPositionOrigin position:
					 anHorizontalGap negated @ (aSector height / 2)).
			t rotateBy: startAngle ]
]

{ #category : #'event handling' }
ToEmptySkin >> installSkinEvent: anEvent [

	super installSkinEvent: anEvent.
	anEvent elementDo: [ :e |
			e layout alignCenter.
			(e hasStamp: #waiting) ifTrue: [
				e installInnerImage: (self waitingAnimatedImageIn: e) ].
			(e hasStamp: #box) ifTrue: [
					e installInnerImage: (e valueOfTokenNamed: #empty_box).
					e image
						extent: (e valueOfTokenNamed: #'empty-image-size') asPoint;
						innerImageColor:
							(e valueOfTokenNamed: #'color-text-placeholder') ] ]
]

{ #category : #accessing }
ToEmptySkin >> waitingAnimatedImageIn: anEmpty [

	| container animation extent background center sectorHeight sectorGap |
	extent := (anEmpty valueOfTokenNamed: #'empty-image-size') asPoint.
	center := extent / 2.
	sectorHeight := 6.
	sectorGap := 6.
	background := anEmpty valueOfTokenNamed: #'color-text-placeholder'.
	container := BlElement new.
	container extent: extent.

	8 timesRepeat: [
			| sector |
			sector := BlElement new
				          geometry: BlStadiumGeometry new;
				          background: background;
				          height: sectorHeight;
				          width: 0;
				          yourself.
			sector visibility: BlVisibility hidden.
			container addChild: sector.
			" position the sector at center "
			sector constraintsDo: [ :c |
					c ignoreByLayout.
					c anchors add: (c anchors verticalCenterAnchor on:
							 c anchors parent verticalCenterAnchor).
					c anchors add: (c anchors leftAnchor on:
							 c anchors parent horizontalCenterAnchor + sectorGap) ] ].

	" the element rotation animation animation "
	animation := BlNumberTransition new
		             beInfinite;
		             from: 0;
		             to: 360;
		             duration: 2 seconds;
		             yourself.
	animation onStepDo: [ :number :anElement |
			container transformDo: [ :t |
					t origin: (BlAffineTransformationPositionOrigin position: center).
					t rotateBy: number ] ].

	" terminate the sectors installation: calculate their width and their rotation transformation "
	container whenLayoutedDoOnce: [
			container addAnimation: animation.
			container childrenDo: [ :sector |
				self installSector: sector in: container withGap: sectorGap.
				sector visibility: BlVisibility visible. ] ].

	^ container
]
