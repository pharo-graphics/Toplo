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
ToWaitingAnimatedIcon >> defaultSectorBackground [ 

	^ Color lightGray
]

{ #category : #initialization }
ToWaitingAnimatedIcon >> defaultSectorHeight [

	^ 6 
]

{ #category : #initialization }
ToWaitingAnimatedIcon >> defaultSize [

	^ 40 
]

{ #category : #'instance creation' }
ToWaitingAnimatedIcon >> duration [
		^ 2 seconds
]

{ #category : #initialization }
ToWaitingAnimatedIcon >> initialize [

	super initialize.
	sectorBackground := self defaultSectorBackground.
	sectorHeight := self defaultSectorHeight.
	self
		addEventHandlerOn: BlElementExtentChangedEvent
		do: [ self innerImage: self newAnimatedImage ].
	self extent: self defaultSize asPoint.

]

{ #category : #'instance creation' }
ToWaitingAnimatedIcon >> installSector: aSector [ 

	| startAngle radius width idx angleGap sectorHGap |
	idx := aSector parent childIndexOf: aSector.
	sectorHGap := aSector height.
	angleGap := 360 / aSector parent children size.
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
ToWaitingAnimatedIcon >> loops [

	^ 10
]

{ #category : #'instance creation' }
ToWaitingAnimatedIcon >> newAnimatedImage [

	| innerImage animation |
	innerImage := BlElement new.
	innerImage matchParent.
	innerImage visibility: BlVisibility hidden.

	self numberOfSectors timesRepeat: [
			| sector |
			sector := BlElement new
				          geometry: self newSectorGeometry;
				          background: sectorBackground;
				          height: sectorHeight;
				          yourself.
			innerImage addChild: sector ].

	" the element rotation animation animation "
	animation := BlNumberTransition new
		             loops: self loops;
		             from: 0;
		             to: 360;
		             duration: self duration;
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

{ #category : #'instance creation' }
ToWaitingAnimatedIcon >> newSectorGeometry [

	^ BlStadiumGeometry new
]

{ #category : #'instance creation' }
ToWaitingAnimatedIcon >> numberOfSectors [

	^ 8 
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
