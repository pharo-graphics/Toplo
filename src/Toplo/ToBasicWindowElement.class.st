Class {
	#name : #ToBasicWindowElement,
	#superclass : #ToWindowElement,
	#traits : 'TToWidget',
	#classTraits : 'TToWidget classTrait',
	#instVars : [
		'#animate',
		'#deleteAnimation',
		'#deleteAnimationFactory',
		'#popupAnimationFactory',
		'#hook',
		'#widget => ObservableSlot'
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
ToBasicWindowElement >> checkBeforePopupIn: aWidget [

	| anim |
	self visibility: BlVisibility visible.
	self animate ifFalse: [ ^ self ].
	anim := self popupAnimationFactory value.
	anim ifNil: [ ^ self ].
	self addAnimation: anim
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
ToBasicWindowElement >> defaultHook [

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

{ #category : #accessing }
ToBasicWindowElement >> hook [

	^ hook
]

{ #category : #accessing }
ToBasicWindowElement >> hook: aValuable [
	" takes the window as argument. Computes the window position according to the given window anchor element "
	
	hook := aValuable
]

{ #category : #initialization }
ToBasicWindowElement >> initialize [

	self class initializeSlots: self.
	super initialize.
	self animate: true.
	self hook: self defaultHook.
	
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

{ #category : #'api - displaying' }
ToBasicWindowElement >> popup [

	self popupEvent: nil
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

	"I'm not ready to be visible because my bounds are not checked according to the popup layer extent"
	self visibility: BlVisibility hidden.

	" I have to set the position here "
	self position: (self hook value: self value: anEvent).
	self spaceLayer addChild: self.
	
	"I need to finalize my position as soon as my layout is up-to-date"
	self whenLayoutedDoOnce: [
		self checkBeforePopupIn: self spaceLayer ]
]

{ #category : #'api - displaying' }
ToBasicWindowElement >> spaceLayer [ 

	^ self widget space overlayLayer.

]

{ #category : #'property change hook' }
ToBasicWindowElement >> whenWidgetChangedDo: aBlock [

	"set a block to perform after that the text has been chanbed, and its action performed"

	self property: #widget whenChangedDo: aBlock
]

{ #category : #accessing }
ToBasicWindowElement >> widget [

	^ widget 

]

{ #category : #accessing }
ToBasicWindowElement >> widget: aWidget [

	aWidget = widget ifTrue: [ ^ self ].
	widget := aWidget
]

{ #category : #initialization }
ToBasicWindowElement >> withAnimation [

	self animate: true
]

{ #category : #initialization }
ToBasicWindowElement >> withoutAnimation [

	self animate: false
]
