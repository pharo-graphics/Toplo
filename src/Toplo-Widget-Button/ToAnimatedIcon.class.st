Class {
	#name : #ToAnimatedIcon,
	#superclass : #ToIconicButton,
	#traits : 'TObservable',
	#classTraits : 'TObservable classTrait',
	#instVars : [
		'#loops => ObservableSlot',
		'#duration => ObservableSlot',
		'#animationFactory => ObservableSlot',
		'#currentAnimation'
	],
	#category : #'Toplo-Widget-Button-Iconic'
}

{ #category : #accessing }
ToAnimatedIcon >> animationFactory [

	^ animationFactory
]

{ #category : #accessing }
ToAnimatedIcon >> animationFactory: aValuable [

	" nil means no animation "
	animationFactory := aValuable
]

{ #category : #accessing }
ToAnimatedIcon >> beInfinite [

	"nil min an infinite animation"
	self loops: nil
]

{ #category : #initialization }
ToAnimatedIcon >> defaultAnimationFactory [

	^ self rotationAnimationFactory
]

{ #category : #initialization }
ToAnimatedIcon >> defaultDuration [

	^ 2 seconds
]

{ #category : #initialization }
ToAnimatedIcon >> defaultLoops [

	^ 10
]

{ #category : #initialization }
ToAnimatedIcon >> defaultSize [

	^ 40 
]

{ #category : #accessing }
ToAnimatedIcon >> duration [

	^ duration
]

{ #category : #accessing }
ToAnimatedIcon >> duration: anObject [

	duration := anObject
]

{ #category : #initialization }
ToAnimatedIcon >> initialize [

	super initialize.
	self class initializeSlots: self.

	loops := self defaultLoops.
	duration := self defaultDuration.
	animationFactory := self defaultAnimationFactory.
	
	self
		addEventHandlerOn: BlElementExtentChangedEvent
		do: [ self renewInnerImage ].
	self extent: self defaultSize asPoint.

	#( #loops #duration #animationFactory) do: [ :prop |
		self property: prop whenChangedDo: [ self renewInnerImage ] ]
]

{ #category : #accessing }
ToAnimatedIcon >> loops [

	^ loops
]

{ #category : #accessing }
ToAnimatedIcon >> loops: anInteger [

	"nil min an infinite animation"
	loops := anInteger 
]

{ #category : #'instance creation' }
ToAnimatedIcon >> newAnimatedImage [

	^ self subclassResponsibility 
]

{ #category : #private }
ToAnimatedIcon >> renewInnerImage [

	currentAnimation ifNotNil: [ :ca |
			ca stop.
			self image transformDo: [ :t |
				t origin: (BlAffineTransformationPositionOrigin position: 0 @ 0) ] ].
	currentAnimation := nil.
	self innerImage: self newAnimatedImage
]

{ #category : #initialization }
ToAnimatedIcon >> rotationAnimationFactory [

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
