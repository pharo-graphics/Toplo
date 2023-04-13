Class {
	#name : #ToBasicWindowElement,
	#superclass : #ToWindowElement,
	#traits : 'TToWidget',
	#classTraits : 'TToWidget classTrait',
	#instVars : [
		'animate',
		'deleteAnimation',
		'deleteAnimationFactory',
		'popupAnimationFactory',
		'placementStrategy'
	],
	#category : #'Toplo-Widget-Window'
}

{ #category : #accessing }
ToBasicWindowElement >> animate [

	^ animate
]

{ #category : #accessing }
ToBasicWindowElement >> animate: aBoolean [

	animate := aBoolean
]

{ #category : #'api - displaying' }
ToBasicWindowElement >> cleanUp [

	self flag: 'keeping track of the delete animation is required but why exactly ?'.
	" need to remove the delate animation to avoid premature popup remove (don't know exactly why)"
	deleteAnimation ifNotNil: [ 
		self dequeueTask: deleteAnimation.
		deleteAnimation := nil ]
]

{ #category : #'api - displaying' }
ToBasicWindowElement >> close [

	self cleanUp.

	animate ifTrue: [ 
		deleteAnimation := deleteAnimationFactory value.
		deleteAnimation onFinishedDo: [ 
			super close.
			self cleanUp ].
		self addAnimation: deleteAnimation.
		^ self ].

	super close
]

{ #category : #initialization }
ToBasicWindowElement >> defaultPlacementStrategy [

	^ self subclassResponsibility 
]

{ #category : #accessing }
ToBasicWindowElement >> deleteAnimationFactory [

	^ deleteAnimationFactory
]

{ #category : #accessing }
ToBasicWindowElement >> deleteAnimationFactory: aValuable [

	deleteAnimationFactory := aValuable
]

{ #category : #initialization }
ToBasicWindowElement >> initialize [

	super initialize.
	self animate: true.
	self placementStrategy: self defaultPlacementStrategy.

	deleteAnimationFactory := [ 
	                          BlOpacityAnimation new
		                          duration: 250 milliSeconds;
		                          opacity: 0;
		                          yourself ].
	popupAnimationFactory := [ 
	                         self opacity: 0.0.
	                         BlOpacityAnimation new
		                         duration: 200 milliSeconds;
		                         opacity: 1;
		                         yourself ]
]

{ #category : #accessing }
ToBasicWindowElement >> placementStrategy [

	^ placementStrategy
]

{ #category : #accessing }
ToBasicWindowElement >> placementStrategy: aPlacementStrategy [

	placementStrategy := aPlacementStrategy
]

{ #category : #'api - displaying' }
ToBasicWindowElement >> popup [

	self placementStrategy popup: self
]

{ #category : #accessing }
ToBasicWindowElement >> popupAnimationFactory [

	^ popupAnimationFactory
]

{ #category : #accessing }
ToBasicWindowElement >> popupAnimationFactory: aValuable [

	popupAnimationFactory := aValuable
]

{ #category : #'api - displaying' }
ToBasicWindowElement >> popupEvent: anEvent [

	self placementStrategy popup: self event: anEvent
]

{ #category : #initialization }
ToBasicWindowElement >> withAnimation [

	self animate: true
]

{ #category : #initialization }
ToBasicWindowElement >> withoutAnimation [

	self animate: false
]
