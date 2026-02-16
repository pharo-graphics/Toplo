Class {
	#name : #ToWaitingAnimatedIcon,
	#superclass : #ToAnimatedIcon,
	#instVars : [
		'#sectorGeometryClass => ObservableSlot',
		'#sectorBackground => ObservableSlot',
		'#outerRadius => ObservableSlot',
		'#innerRadius => ObservableSlot',
		'#sectorThickness => ObservableSlot',
		'#numberOfSectors => ObservableSlot'
	],
	#category : #'Toplo-Widget-Button-Iconic'
}

{ #category : #accessing }
ToWaitingAnimatedIcon >> animatedImage [ 

	^ self image firstChild
]

{ #category : #initialization }
ToWaitingAnimatedIcon >> defaultAnimationFactory [

	^ [
		  | colors gap |
		  " alpha increment "
		  gap := ((1 / numberOfSectors) ) asFloat.
		  " build a color ramp "
		  colors := (self sectors asArray copyWithoutFirst
			             withIndexCollect: [ :sec :idx |
			             sectorBackground alpha: gap * idx ])
		            , { sectorBackground }.
		  BlTransition new
			  onStepDo: [ :number :anElement |
					  | pos |
					  pos := (number * 100) asInteger \\ numberOfSectors + 1.
					  " apply the ramp on sectors "
					  self sectors withIndexDo: [ :child :idx |
								  | bg |
								  bg := colors at: idx - pos \\ numberOfSectors + 1.
								  child background: bg ] ];
			  onFinishedDo: [
					  colors := nil.
					  currentAnimation := nil ];
			  yourself ]
]

{ #category : #initialization }
ToWaitingAnimatedIcon >> defaultDuration [

	^ 12 seconds
]

{ #category : #initialization }
ToWaitingAnimatedIcon >> defaultInnerRadius [

	^ 0.30
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

	^ 5
]

{ #category : #initialization }
ToWaitingAnimatedIcon >> initialize [

	super initialize.

	innerRadius := self defaultInnerRadius.
	outerRadius := self defaultOuterRadius.
	sectorBackground := self defaultSectorBackground.
	sectorThickness := self defaultSectorThickness.
	numberOfSectors := self defaultNumberOfSectors.
	sectorGeometryClass := self defaultSectorGeometryClass.

	#( #sectorBackground #sectorThickness #innerRadius #outerRadius
	   #numberOfSectors #sectorGeometryClass ) do: [ :prop |
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

{ #category : #accessing }
ToWaitingAnimatedIcon >> sectors [ 

	^ self animatedImage children
]
