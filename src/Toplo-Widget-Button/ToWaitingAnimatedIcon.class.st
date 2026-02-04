Class {
	#name : #ToWaitingAnimatedIcon,
	#superclass : #ToIconicButton,
	#traits : 'TObservable',
	#classTraits : 'TObservable classTrait',
	#instVars : [
		'#sectorGeometryClass => ObservableSlot',
		'#sectorBackground => ObservableSlot',
		'#outerRadius => ObservableSlot',
		'#innerRadius => ObservableSlot',
		'#sectorThickness => ObservableSlot',
		'#numberOfSectors => ObservableSlot',
		'#loops => ObservableSlot',
		'#duration => ObservableSlot',
		'#animationFactory => ObservableSlot',
		'#currentAnimation'
	],
	#category : #'Toplo-Widget-Button-Iconic'
}

{ #category : #accessing }
ToWaitingAnimatedIcon >> animationFactory [

	^ animationFactory
]

{ #category : #accessing }
ToWaitingAnimatedIcon >> animationFactory: aValuable [

	" nil means no animation "
	animationFactory := aValuable
]

{ #category : #accessing }
ToWaitingAnimatedIcon >> beInfinite [

	"nil min an infinite animation"
	self loops: nil
]

{ #category : #initialization }
ToWaitingAnimatedIcon >> defaultAnimationFactory [

	^ [
		  | default |
		  default := BlNumberTransition new
			             from: 0;
			             to: 360;
			             yourself.
		  default onStepDo: [ :number :anElement |
				  self image transformDo: [ :t |
						  t origin:
							  (BlAffineTransformationPositionOrigin position:
								   self extent / 2).
						  t rotateBy: number ] ].
		  default ]
]

{ #category : #initialization }
ToWaitingAnimatedIcon >> defaultDuration [

	^ 2 seconds
]

{ #category : #initialization }
ToWaitingAnimatedIcon >> defaultInnerRadius [

	^ 0.30
]

{ #category : #initialization }
ToWaitingAnimatedIcon >> defaultLoops [

	^ 10
]

{ #category : #initialization }
ToWaitingAnimatedIcon >> defaultNumberOfSectors [

	^ 9
]

{ #category : #initialization }
ToWaitingAnimatedIcon >> defaultOuterRadius [

	^ 1.0
]

{ #category : #initialization }
ToWaitingAnimatedIcon >> defaultSectorBackground [ 

	^ Color lightGray
]

{ #category : #initialization }
ToWaitingAnimatedIcon >> defaultSectorGeometryClass [

	^ BlStadiumGeometry 
]

{ #category : #initialization }
ToWaitingAnimatedIcon >> defaultSectorThickness [

	^ 6 
]

{ #category : #initialization }
ToWaitingAnimatedIcon >> defaultSize [

	^ 40 
]

{ #category : #accessing }
ToWaitingAnimatedIcon >> duration [

	^ duration
]

{ #category : #accessing }
ToWaitingAnimatedIcon >> duration: anObject [

	duration := anObject
]

{ #category : #initialization }
ToWaitingAnimatedIcon >> initialize [

	super initialize.
	self class initializeSlots: self.

	innerRadius := self defaultInnerRadius.
	outerRadius := self defaultOuterRadius.
	sectorBackground := self defaultSectorBackground.
	sectorThickness := self defaultSectorThickness.
	numberOfSectors := self defaultNumberOfSectors.
	sectorGeometryClass := self defaultSectorGeometryClass.
	loops := self defaultLoops.
	duration := self defaultDuration.
	animationFactory := self defaultAnimationFactory.
	
	self
		addEventHandlerOn: BlElementExtentChangedEvent
		do: [ self renewInnerImage ].
	self extent: self defaultSize asPoint.

	#( #sectorBackground #sectorThickness #innerRadius #outerRadius
	   #numberOfSectors #sectorGeometryClass #loops #duration #animationFactory) do: [ :prop |
		self property: prop whenChangedDo: [ self renewInnerImage ] ]
]

{ #category : #accessing }
ToWaitingAnimatedIcon >> innerRadius [

	^ innerRadius
]

{ #category : #accessing }
ToWaitingAnimatedIcon >> innerRadius: anObject [

	innerRadius := anObject
]

{ #category : #private }
ToWaitingAnimatedIcon >> installSector: aSector [ 

	| startAngle radius width idx angleGap inner outer |
	idx := aSector parent childIndexOf: aSector.
	angleGap := 360 / aSector parent children size.
	startAngle := idx * angleGap.

	radius := aSector parent extent min / 2.
	inner := innerRadius * radius.
	outer := radius - (outerRadius * radius).
	width := radius - inner - outer.
	
	aSector width: width.

	" position the sector at center "
	aSector constraintsDo: [ :c |
			c ignoreByLayout.
			c anchors add: (c anchors verticalCenterAnchor on:
					 c anchors parent verticalCenterAnchor).
			c anchors add: (c anchors leftAnchor on:
					 c anchors parent horizontalCenterAnchor + inner) ].

	aSector transformDo: [ :t |
			t origin: (BlAffineTransformationPositionOrigin position:
					 inner negated @ (aSector height / 2)).
			t rotateBy: startAngle ]
]

{ #category : #accessing }
ToWaitingAnimatedIcon >> loops [

	^ loops
]

{ #category : #accessing }
ToWaitingAnimatedIcon >> loops: anInteger [

	"nil min an infinite animation"
	loops := anInteger 
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
			self animationFactory ifNotNil: [ :factory |
					currentAnimation := factory value.
					currentAnimation
						loops: self loops;
						duration: self duration.
					innerImage addAnimation: currentAnimation ].
			innerImage whenLayoutedDoOnce: [
				innerImage visibility: BlVisibility visible ] ].

	^ innerImage
]

{ #category : #'instance creation' }
ToWaitingAnimatedIcon >> newSector [

	^ BlElement new
		  geometry: self sectorGeometry;
		  background: sectorBackground;
		  height: sectorThickness;
		  yourself
]

{ #category : #accessing }
ToWaitingAnimatedIcon >> numberOfSectors [

	^ numberOfSectors
]

{ #category : #accessing }
ToWaitingAnimatedIcon >> numberOfSectors: aNumber [

	numberOfSectors := aNumber
]

{ #category : #accessing }
ToWaitingAnimatedIcon >> outerRadius [

	^ outerRadius
]

{ #category : #accessing }
ToWaitingAnimatedIcon >> outerRadius: anObject [

	outerRadius := anObject
]

{ #category : #private }
ToWaitingAnimatedIcon >> renewInnerImage [

	currentAnimation ifNotNil: [ :ca |
			ca stop.
			self image transformDo: [ :t |
				t origin: (BlAffineTransformationPositionOrigin position: 0 @ 0) ] ].
	currentAnimation := nil.
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

	^ self sectorGeometryClass new
]

{ #category : #accessing }
ToWaitingAnimatedIcon >> sectorGeometryClass [

	^ sectorGeometryClass
]

{ #category : #accessing }
ToWaitingAnimatedIcon >> sectorGeometryClass: aGeometryClass [

	sectorGeometryClass := aGeometryClass
]

{ #category : #accessing }
ToWaitingAnimatedIcon >> sectorThickness [

	^ sectorThickness
]

{ #category : #accessing }
ToWaitingAnimatedIcon >> sectorThickness: aNumber [

	sectorThickness = aNumber ifTrue: [ ^ self ].
	sectorThickness := aNumber
]
