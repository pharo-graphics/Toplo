Class {
	#name : #ToProgressCircle,
	#superclass : #ToElement,
	#traits : 'TToProgress',
	#classTraits : 'TToProgress classTrait',
	#instVars : [
		'icon',
		'label',
		'infiniteAnimation'
	],
	#category : #'Toplo-Widget-ProgressBar'
}

{ #category : #example }
ToProgressCircle class >> example_CircleProgressBarFinite [

	| p |
	p := ToProgressCircle new.
	p extent: 125 asPoint.
	p valueInPercentage: 0.75.
	p openInSpace.

	^ p
]

{ #category : #example }
ToProgressCircle class >> example_CircleProgressBarFiniteWithIcon [

	| p |
	p := ToProgressCircle new.
	p extent: 200 asPoint.
	p icon: (ToImage new innerImage: (self iconNamed: #glamorousAccept)).
	p valueInPercentage: 0.75.
	p openInSpace.
	^ p
]

{ #category : #example }
ToProgressCircle class >> example_CircleProgressBarFiniteWithLabel [

	| p |
	p := ToProgressCircle new.
	p extent: 500 asPoint.
	p label: (ToLabel text: '75%').
	p valueInPercentage: 0.75.
	p openInSpace.
	^ p
]

{ #category : #example }
ToProgressCircle class >> example_CircleProgressBarInfinite [

	| p |
	p := ToProgressCircle new.
	p extent: 125 asPoint.
	p valueInPercentage: 0.6.
	p isInfinite: true.
	p openInSpace.

	^ p
]

{ #category : #initialization }
ToProgressCircle >> defaultLayout [

	^ BlFrameLayout new 
]

{ #category : #testing }
ToProgressCircle >> hasIcon [

	^ self icon notNil
]

{ #category : #testing }
ToProgressCircle >> hasLabel [

	^ self label notNil
]

{ #category : #accessing }
ToProgressCircle >> icon [

	^ icon
]

{ #category : #accessing }
ToProgressCircle >> icon: anElement [

	anElement = icon ifTrue: [ ^ self ].
	self label: nil.
	icon ifNotNil: [ :s | s removeFromParent].
	icon := anElement.
	anElement ifNil: [ ^ self ].
	self addChild: anElement.
	anElement constraintsDo: [ :c |
		c frame horizontal alignCenter.
		c frame vertical alignCenter].
	
]

{ #category : #accessing }
ToProgressCircle >> infiniteAnimation [

	^infiniteAnimation

]

{ #category : #initialization }
ToProgressCircle >> initialize [

	super initialize.
	
	progressBar := ToElement new matchParent.
	remainingBar := ToElement new matchParent.
	
	progressBar geometry: BlCircleGeometry new.
	remainingBar geometry: BlCircleGeometry new.
	
	progressBar constraintsDo: [ :c |
		c frame horizontal alignCenter.
		c frame vertical alignCenter].
	remainingBar constraintsDo: [ :c |
		c frame horizontal alignCenter.
		c frame vertical alignCenter].
	
	self addChild: progressBar.
	self addChild: remainingBar.
	
	progressBar
		addEventHandlerOn: BlElementExtentChangedEvent
		do: [ :e | self resizeProgressBar ]
]

{ #category : #'t - accessing' }
ToProgressCircle >> isInfinite: aBoolean [

	aBoolean ifTrue:[
		infiniteAnimation := BlNumberTransition new
                   duration: 5000 milliSeconds;
                   from: 0;
                   to: 60;
                   onStepDo: [ :number :anElement | 
							anElement transformDo: [:t | t centerOrigin. t rotateBy: (6*number) ]  
						].
		self infiniteAnimation beInfinite.
		self progressBar addAnimation: self infiniteAnimation.
	] ifFalse:[
		self infiniteAnimation ifNotNil:[self infiniteAnimation stop].
		infiniteAnimation := nil
	].
]

{ #category : #accessing }
ToProgressCircle >> label [

	^ label
]

{ #category : #accessing }
ToProgressCircle >> label: anElement [

	anElement = label ifTrue: [ ^ self ].
	self icon: nil.
	label ifNotNil: [ :s | s removeFromParent].
	label := anElement.
	anElement ifNil: [ ^ self ].
	self addChild: anElement.
	anElement constraintsDo: [ :c |
		c frame horizontal alignCenter.
		c frame vertical alignCenter].
]

{ #category : #skin }
ToProgressCircle >> newRawSkin [

	^ ToProgressCircleSkin new
]

{ #category : #'t - resizeable' }
ToProgressCircle >> resizeProgressBar [

	| lineWidth circleWidth perimeter dashLength |
	self valueInPercentage ifNil: [ ^ self ].
	lineWidth := 4.
	circleWidth := remainingBar extent x.
	circleWidth = 0 ifTrue: [ ^ self ].

	perimeter := circleWidth * Float pi.
	dashLength := perimeter * self valueInPercentage.
	
	remainingBar border: (BlBorder builder
		 width: lineWidth;
		 paint: (self valueOfTokenNamed: #progressCircleRemainingBarBackground);
		 build).


	progressBar geometry: BlCircleGeometry new.
	progressBar border: (BlBorder builder
			 dashArray: {
					 dashLength.
					 perimeter };
			 paint: (self valueOfTokenNamed: #'color-primary');
			 width: lineWidth;
			 capRound;
			 paint: (self valueOfTokenNamed: #progressCircleProgressBarBackground);
			 build) 
]
