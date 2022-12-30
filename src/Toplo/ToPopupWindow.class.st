Class {
	#name : #ToPopupWindow,
	#superclass : #ToWindow,
	#traits : 'TToWidget',
	#classTraits : 'TToWidget classTrait',
	#instVars : [
		'#animate',
		'#deleteAnimation',
		'#widget => ObservableSlot',
		'#deleteAnimationFactory',
		'#popupAnimationFactory'
	],
	#category : #'Toplo-Widget-Window'
}

{ #category : #accessing }
ToPopupWindow >> animate [

	^ animate
]

{ #category : #accessing }
ToPopupWindow >> animate: aBoolean [

	animate := aBoolean
]

{ #category : #'api - displaying' }
ToPopupWindow >> checkBeforePopupIn: aWidget [

	| gap rect |
	" layout is done, my bounds are now up-to-date"
	" I have to check if my position is ok according to my extent and the space extent"
	rect := self bounds inSpace asRectangle.
	gap := rect amountToTranslateWithin: (0 asPoint extent: self space extent).
	self relocate: self position + gap.
	" my bounds are up-to-date, I can be visible "
	self visibility: BlVisibility visible.
	self animate ifFalse: [ ^ self ].
	self addAnimation: self popupAnimationFactory value
	
"<kept for the record>
	"" layout is done, my bounds are now up-to-date""
	boundsInSpace := widget bounds inSpace bounds.
	(boundsInSpace closestEdgeTo: pointer) traceCr.
	proj := (boundsInSpace outsideNormalCloseTo: pointer).
	self relocate: proj point.
"
]

{ #category : #'api - displaying' }
ToPopupWindow >> cleanUp [

	self flag: 'keeping track of the delete animation is required but why exactly ?'.
	" need to remove the delate animation to avoid premature popup remove (don't know exactly why)"
	deleteAnimation ifNotNil: [ 
		self dequeueTask: deleteAnimation.
		deleteAnimation := nil ]
]

{ #category : #'api - displaying' }
ToPopupWindow >> close [

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

{ #category : #'t - initialization dresser' }
ToPopupWindow >> defaultDresser [ 

	^ ToPopupWindowDresser new
]

{ #category : #accessing }
ToPopupWindow >> deleteAnimationFactory [

	^ deleteAnimationFactory
]

{ #category : #accessing }
ToPopupWindow >> deleteAnimationFactory: aValuable [

	deleteAnimationFactory := aValuable
]

{ #category : #initialization }
ToPopupWindow >> initialize [

	self class initializeSlots: self.
	super initialize.
	self animate: true.

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
		                         yourself ].
	
	self initializeDresser 
]

{ #category : #'api - displaying' }
ToPopupWindow >> popup [

	self relocate: (self widget bounds inSpace bounds bottomLeft).
	"I'm not ready to be visible because my bounds are not checked according to the popup layer extent"
	self visibility: BlVisibility hidden.
	self widget space popupLayer addChild: self.
	
	"I need to finalize my position as soon as my layout is up-to-date"
	self whenLayoutedDoOnce: [ self checkBeforePopupIn: self widget space popupLayer ].

	

]

{ #category : #accessing }
ToPopupWindow >> popupAnimationFactory [

	^ popupAnimationFactory
]

{ #category : #accessing }
ToPopupWindow >> popupAnimationFactory: aValuable [

	popupAnimationFactory := aValuable
]

{ #category : #'api - displaying' }
ToPopupWindow >> popupAtGlobalPosition: aPoint [

	self popupIn: self widget space popupLayer atGlobalPosition: aPoint
]

{ #category : #'api - displaying' }
ToPopupWindow >> popupIn: aWidget atGlobalPosition: aPoint [

	self cleanUp.
	
	" aWidget is already attached, thus its bounds is up-to-date "
	self relocate: (aWidget globalPointToLocal: aPoint).
	"I'm not ready to be visible because my bounds are not checked according to the popup layer extent"
	self visibility: BlVisibility hidden.
	aWidget addChild: self.
	
	"I need to finalize my position as soon as my layout is up-to-date"
	self whenLayoutedDoOnce: [ self checkBeforePopupIn: aWidget ].

]

{ #category : #'property change hook' }
ToPopupWindow >> whenWidgetChangedDo: aBlock [

	"set a block to perform after that the text has been chanbed, and its action performed"

	self property: #widget whenChangedDo: aBlock
]

{ #category : #accessing }
ToPopupWindow >> widget [

	^ widget 

]

{ #category : #accessing }
ToPopupWindow >> widget: aWidget [

	widget := aWidget.
	widget when: BlElementPositionInSpaceChangedEvent do: [ :event | 
		self relocate: self widget bounds inSpace bounds bottomLeft ]
]

{ #category : #initialization }
ToPopupWindow >> withAnimation [

	self animate: true
]

{ #category : #initialization }
ToPopupWindow >> withoutAnimation [

	self animate: false
]
