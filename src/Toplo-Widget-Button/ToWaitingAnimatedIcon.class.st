Class {
	#name : #ToWaitingAnimatedIcon,
	#superclass : #ToIconicButton,
	#traits : 'TObservable',
	#classTraits : 'TObservable classTrait',
	#instVars : [
		'#sectorBackground => ObservableSlot',
		'#sectorHeight => ObservableSlot'
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

{ #category : #accessing }
ToWaitingAnimatedIcon >> duration [
		^ 2 seconds
]

{ #category : #initialization }
ToWaitingAnimatedIcon >> initialize [

	super initialize.
	self class initializeSlots: self.

	sectorBackground := self defaultSectorBackground.
	sectorHeight := self defaultSectorHeight.
	self
		addEventHandlerOn: BlElementExtentChangedEvent
		do: [ self renewInnerImage ].
	self extent: self defaultSize asPoint.

	#( #sectorBackground #sectorHeight ) do: [ :prop |
		self property: prop whenChangedDo: [ self renewInnerImage ] ]
]

{ #category : #private }
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

{ #category : #accessing }
ToWaitingAnimatedIcon >> loops [

	^ 10
]

{ #category : #'instance creation' }
ToWaitingAnimatedIcon >> newAnimatedImage [

	| sectors innerImage |
	innerImage := BlElement new.
	innerImage matchParent.
	innerImage visibility: BlVisibility hidden.

	sectors := Array
		           new: self numberOfSectors
		           streamContents: [ :stream |
			           self numberOfSectors timesRepeat: [
				           stream nextPut: self newSector ] ].
	innerImage addChildren: sectors.

	" terminate the sectors installation: calculate their width and their rotation transformation "
	innerImage whenLayoutedDoOnce: [
			innerImage childrenDo: [ :sector | self installSector: sector ].
			innerImage addAnimation: self newAnimation.
			innerImage whenLayoutedDoOnce: [
				innerImage visibility: BlVisibility visible ] ].

	^ innerImage
]

{ #category : #'instance creation' }
ToWaitingAnimatedIcon >> newAnimation [

	| animation |
	animation := BlNumberTransition new
		             loops: self loops;
		             from: 0;
		             to: 360;
		             duration: self duration;
		             yourself.
	"beInfinite;"
	animation onStepDo: [ :number :anElement |
			self image transformDo: [ :t |
					t origin:
						(BlAffineTransformationPositionOrigin position: self extent / 2).
					t rotateBy: number ] ].
	^ animation
]

{ #category : #'instance creation' }
ToWaitingAnimatedIcon >> newSector [

	^ BlElement new
		  geometry: self sectorGeometry;
		  background: sectorBackground;
		  height: sectorHeight;
		  yourself
]

{ #category : #accessing }
ToWaitingAnimatedIcon >> numberOfSectors [

	^ 8 
]

{ #category : #private }
ToWaitingAnimatedIcon >> renewInnerImage [

	self innerImage: self newAnimatedImage
]

{ #category : #accessing }
ToWaitingAnimatedIcon >> sectorBackground [

	^ sectorBackground
]

{ #category : #accessing }
ToWaitingAnimatedIcon >> sectorBackground: aBackground [

	sectorBackground = aBackground ifTrue: [ ^ self ].
	sectorBackground := aBackground
]

{ #category : #accessing }
ToWaitingAnimatedIcon >> sectorGeometry [

	^ BlStadiumGeometry new
]

{ #category : #accessing }
ToWaitingAnimatedIcon >> sectorHeight [

	^ sectorHeight
]

{ #category : #accessing }
ToWaitingAnimatedIcon >> sectorHeight: aNumber [

	sectorHeight = aNumber ifTrue: [ ^ self ].
	sectorHeight := aNumber
]
