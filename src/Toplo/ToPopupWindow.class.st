Class {
	#name : #ToPopupWindow,
	#superclass : #ToWindow,
	#traits : 'TToWidget',
	#classTraits : 'TToWidget classTrait',
	#instVars : [
		'#animate',
		'#deleteAnimationStencil',
		'#popupAnimationStencil',
		'#deleteAnimation',
		'#widget => ObservableSlot',
		'#checkPositionOnLayout'
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
		deleteAnimation := deleteAnimationStencil value.
		deleteAnimation onFinishedDo: [ 
			super close.
			self cleanUp ].
		self addAnimation: deleteAnimation.
		^ self ].

	super close
]

{ #category : #accessing }
ToPopupWindow >> deleteAnimationStencil [

	^ deleteAnimationStencil
]

{ #category : #accessing }
ToPopupWindow >> deleteAnimationStencil: anAnimationStencyl [

	deleteAnimationStencil := anAnimationStencyl
]

{ #category : #initialization }
ToPopupWindow >> initialize [

	self class initializeSlots: self.
	super initialize.
	self fitContent.
	self root fitContent.
	self animate: true.
	checkPositionOnLayout := false.
	deleteAnimationStencil := [ 
	                          BlOpacityAnimation new
		                          duration: 400 milliSeconds;
		                          opacity: 0;
		                          yourself ].
	popupAnimationStencil := [ 
	                         self opacity: 0.0.
	                         BlOpacityAnimation new
		                         duration: 400 milliSeconds;
		                         opacity: 1;
		                         yourself ]
]

{ #category : #'hooks - layout' }
ToPopupWindow >> onLayoutDone [

	" layout is done, my bounds are now up-to-date"

	checkPositionOnLayout ifFalse: [ ^ self ].
	checkPositionOnLayout := false.

	self isFullyVisibleInSpace ifFalse: [ 
		| gap rect |
		rect := self bounds inSpace asRectangle.
		gap := rect amountToTranslateWithin: (0 @ 0 extent: self space extent).
		self relocate: self position + gap ].

	self animate ifFalse: [ ^ self ].
	self addAnimation: self popupAnimationStencil value
]

{ #category : #accessing }
ToPopupWindow >> popupAnimationStencil [

	^ popupAnimationStencil
]

{ #category : #accessing }
ToPopupWindow >> popupAnimationStencyl: anAnimationStencyl [

	popupAnimationStencil := anAnimationStencyl
]

{ #category : #'api - displaying' }
ToPopupWindow >> popupAtPosition: aPoint [

	self popupIn: self widget space popupLayer atPosition: aPoint
]

{ #category : #'api - displaying' }
ToPopupWindow >> popupIn: aWidget atPosition: aPoint [

	self cleanUp.
	" aWidget is already attached, thus its bounds is up-to-date "
	self relocate: (aWidget globalPointToLocal: aPoint).
	aWidget addChild: self.
	"flag checked in #layoutDone to finalize my position"
	checkPositionOnLayout := true.

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

]

{ #category : #initialization }
ToPopupWindow >> withAnimation [

	self animate: true
]

{ #category : #initialization }
ToPopupWindow >> withoutAnimation [

	self animate: false
]
