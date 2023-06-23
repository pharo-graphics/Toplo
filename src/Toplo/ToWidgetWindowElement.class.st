Class {
	#name : #ToWidgetWindowElement,
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
ToWidgetWindowElement >> animate [

	^ animate
]

{ #category : #accessing }
ToWidgetWindowElement >> animate: aBoolean [

	animate := aBoolean
]

{ #category : #'api - displaying' }
ToWidgetWindowElement >> checkBeforePopupIn: aWidget [

	| anim |
	self visibility: BlVisibility visible.
	self animate ifFalse: [ ^ self ].
	anim := self popupAnimationFactory value.
	anim ifNil: [ ^ self ].
	self addAnimation: anim
]

{ #category : #'api - displaying' }
ToWidgetWindowElement >> cleanUp [

	self flag: 'keeping track of the delete animation is required but why exactly ?'.
	" need to remove the delate animation to avoid premature popup remove (don't know exactly why)"
	deleteAnimation ifNotNil: [ 
		self dequeueTask: deleteAnimation.
		deleteAnimation := nil ]
]

{ #category : #'api - displaying' }
ToWidgetWindowElement >> close [

	self cleanUp.

	(animate and: [deleteAnimationFactory notNil]) ifTrue: [ 
		deleteAnimation := deleteAnimationFactory value.
		deleteAnimation onFinishedDo: [ 
			super close.
			self dispatchClosedEvent.
			self cleanUp ].
		self addAnimation: deleteAnimation.
		^ self ].

	super close.
	self dispatchClosedEvent

]

{ #category : #initialization }
ToWidgetWindowElement >> defaultHook [

	^ self subclassResponsibility 
]

{ #category : #accessing }
ToWidgetWindowElement >> deleteAnimationFactory [

	^ deleteAnimationFactory
]

{ #category : #accessing }
ToWidgetWindowElement >> deleteAnimationFactory: aValuable [

	deleteAnimationFactory := aValuable
]

{ #category : #'api - displaying' }
ToWidgetWindowElement >> dispatchClosedEvent [

	self widget ifNotNil: [ :w |
		w dispatchEvent: (ToWidgetWindowClosedEvent new
				 window: self;
				 yourself) ]
]

{ #category : #accessing }
ToWidgetWindowElement >> hook [

	^ hook
]

{ #category : #accessing }
ToWidgetWindowElement >> hook: aValuable [
	" takes the window as argument. Computes the window position according to the given window anchor element "
	
	hook := aValuable
]

{ #category : #initialization }
ToWidgetWindowElement >> initialize [

	super initialize.
	self animate: true.
	self hook: self defaultHook.
	
	self flag: 'delete animation duration must be very very fast to ensure that sub-menu widows are always opened even if mouse is moving fast (issue #51). It is so fast that it cannot be perceived at all. So for now, no delete animation is initialize'.
	
	popupAnimationFactory := [ 
	                         self opacity: 0.0.
	                         BlOpacityAnimation new
		                         duration: 400 milliSeconds;
		                         opacity: 1;
		                         yourself ]
]

{ #category : #'api - displaying' }
ToWidgetWindowElement >> popup [

	self popupEvent: nil
]

{ #category : #accessing }
ToWidgetWindowElement >> popupAnimationFactory [

	^ popupAnimationFactory
]

{ #category : #accessing }
ToWidgetWindowElement >> popupAnimationFactory: aValuable [

	popupAnimationFactory := aValuable
]

{ #category : #'api - displaying' }
ToWidgetWindowElement >> popupEvent: anEvent [

	"I'm not ready to be visible because my bounds are not checked according to the popup layer extent"
	"self visibility: BlVisibility hidden."

	" I have to set the position here "
	self position: (self hook value: self value: anEvent).
	self hasParent ifTrue: [ ^ self ].
	self spaceLayer addChild: self.
	
	"I need to finalize my position as soon as my layout is up-to-date"
	self whenLayoutedDoOnce: [
		self spaceLayer ifNotNil: [ :l | self checkBeforePopupIn: l ] ].
	self requestLayout 
]

{ #category : #'api - displaying' }
ToWidgetWindowElement >> spaceLayer [ 

	^ self widget space overlayLayer.

]

{ #category : #'property change hook' }
ToWidgetWindowElement >> whenWidgetChangedDo: aBlock [

	"set a block to perform after that the text has been chanbed, and its action performed"

	self property: #widget whenChangedDo: aBlock
]

{ #category : #accessing }
ToWidgetWindowElement >> widget [

	^ widget 

]

{ #category : #accessing }
ToWidgetWindowElement >> widget: aWidget [

	aWidget = widget ifTrue: [ ^ self ].
	widget := aWidget
]

{ #category : #initialization }
ToWidgetWindowElement >> withAnimation [

	self animate: true
]

{ #category : #initialization }
ToWidgetWindowElement >> withoutAnimation [

	self animate: false
]
