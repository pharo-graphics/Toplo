Class {
	#name : #ToBasicAnimatedWindow,
	#superclass : #ToWindow,
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
ToBasicAnimatedWindow >> animate [

	^ animate
]

{ #category : #accessing }
ToBasicAnimatedWindow >> animate: aBoolean [

	animate := aBoolean
]

{ #category : #'api - displaying' }
ToBasicAnimatedWindow >> checkBeforePopupIn: aWidget [

	" my bounds are up-to-date, I can be visible "
	| anim |
	self visibility: BlVisibility visible.
	self animate ifFalse: [ ^ self ].
	anim := self popupAnimationFactory value.
	anim ifNil: [ ^ self ].
	self addAnimation: anim
]

{ #category : #'api - displaying' }
ToBasicAnimatedWindow >> cleanUp [

	self flag: 'keeping track of the delete animation is required but why exactly ?'.
	" need to remove the delate animation to avoid premature popup remove (don't know exactly why)"
	deleteAnimation ifNotNil: [ 
		self dequeueTask: deleteAnimation.
		deleteAnimation := nil ]
]

{ #category : #'api - displaying' }
ToBasicAnimatedWindow >> close [

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
ToBasicAnimatedWindow >> defaultPlacementStrategy [

	^ self subclassResponsibility 
]

{ #category : #accessing }
ToBasicAnimatedWindow >> deleteAnimationFactory [

	^ deleteAnimationFactory
]

{ #category : #accessing }
ToBasicAnimatedWindow >> deleteAnimationFactory: aValuable [

	deleteAnimationFactory := aValuable
]

{ #category : #initialization }
ToBasicAnimatedWindow >> initialize [

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
ToBasicAnimatedWindow >> placementStrategy [

	^ placementStrategy
]

{ #category : #accessing }
ToBasicAnimatedWindow >> placementStrategy: aPlacementStrategy [

	placementStrategy := aPlacementStrategy
]

{ #category : #'api - displaying' }
ToBasicAnimatedWindow >> popup [

	self placementStrategy popup: self
]

{ #category : #accessing }
ToBasicAnimatedWindow >> popupAnimationFactory [

	^ popupAnimationFactory
]

{ #category : #accessing }
ToBasicAnimatedWindow >> popupAnimationFactory: aValuable [

	popupAnimationFactory := aValuable
]

{ #category : #initialization }
ToBasicAnimatedWindow >> withAnimation [

	self animate: true
]

{ #category : #initialization }
ToBasicAnimatedWindow >> withoutAnimation [

	self animate: false
]
