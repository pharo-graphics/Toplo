Class {
	#name : #ToWaitingAnimatedIcon,
	#superclass : #ToIconicButton,
	#instVars : [
		'sectorBackground',
		'sectorHeight'
	],
	#category : #'Toplo-Widget-Button-Iconic'
}

{ #category : #initialization }
ToWaitingAnimatedIcon >> initialize [ 

	super initialize.
	self addEventHandlerOn: BlElementExtentChangedEvent do: [ self innerImage: self newAnimatedImage ].
	sectorBackground := Color lightGray.
	sectorHeight := 6.
	self extent: 40 asPoint.
	self innerImage: self newAnimatedImage 
	
]

{ #category : #'instance creation' }
ToWaitingAnimatedIcon >> installSector: aSector [ 

	| startAngle radius width idx angleGap sectorHGap |
	idx := aSector parent childIndexOf: aSector.
	sectorHGap := aSector height.
	angleGap := 360 / aSector parent  children size.
	startAngle := idx * angleGap.

	radius := aSector parent extent min / 2.
	width := radius - sectorHGap.

	aSector width: width.

	" position the sector at center "
	aSector constraintsDo: [ :c |
			c ignoreByLayout.
			c anchors add: (c anchors verticalCenterAnchor on:
					 c anchors parent verticalCenterAnchor).
			c anchors add: (c anchors leftAnchor on:
					 c anchors parent horizontalCenterAnchor + sectorHGap) ].

	aSector transformDo: [ :t |
			t origin: (BlAffineTransformationPositionOrigin position:
					 sectorHGap negated @ (aSector height / 2)).
			t rotateBy: startAngle ]
]

{ #category : #'instance creation' }
ToWaitingAnimatedIcon >> newAnimatedImage [

	| innerImage animation |
	innerImage := BlElement new.
	innerImage matchParent.
	innerImage visibility: BlVisibility hidden.

	8 timesRepeat: [
			| sector |
			sector := BlElement new
				          geometry: BlStadiumGeometry new;
				          background: sectorBackground;
				          height: sectorHeight;
				          yourself.
			innerImage addChild: sector ].

	" the element rotation animation animation "
	animation := BlNumberTransition new
		             loops: 10;
		             from: 0;
		             to: 360;
		             duration: 2 seconds;
		             yourself.
	"beInfinite;"
	animation onStepDo: [ :number :anElement |
			innerImage transformDo: [ :t |
					t origin:
						(BlAffineTransformationPositionOrigin position: self extent / 2).
					t rotateBy: number ] ].

	" terminate the sectors installation: calculate their width and their rotation transformation "
	innerImage whenLayoutedDoOnce: [
			innerImage addAnimation: animation.
			innerImage childrenDo: [ :sector | self installSector: sector ].
			innerImage whenLayoutedDoOnce: [
				innerImage visibility: BlVisibility visible ] ].

	^ innerImage
]

{ #category : #accessing }
ToWaitingAnimatedIcon >> sectorBackground [

	^ sectorBackground
]

{ #category : #accessing }
ToWaitingAnimatedIcon >> sectorBackground: aBackground [

	sectorBackground := aBackground.
	self image ifNil: [ ^ self ].
	self image childrenDo: [ :child | child background: aBackground ]
]

{ #category : #accessing }
ToWaitingAnimatedIcon >> sectorHeight [

	^ sectorHeight
]

{ #category : #accessing }
ToWaitingAnimatedIcon >> sectorHeight: aNumber [

	sectorHeight := aNumber.
	self image ifNil: [ ^ self ].
	self image childrenDo: [ :child | child height: aNumber ]
]
