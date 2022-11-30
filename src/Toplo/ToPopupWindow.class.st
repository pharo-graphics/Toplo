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
		'#widget => ObservableSlot'
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

{ #category : #'showing / hiding' }
ToPopupWindow >> cleanUp [

	self flag: 'keeping track of the delete animation is required but why exactly ?'.
	" need to remove the delate animation to avoid premature popup remove (don't know exactly why)"
	deleteAnimation ifNotNil: [ 
		self dequeueTask: deleteAnimation.
		deleteAnimation := nil ]
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

{ #category : #accessing }
ToPopupWindow >> popupAnimationStencil [

	^ popupAnimationStencil
]

{ #category : #accessing }
ToPopupWindow >> popupAnimationStencyl: anAnimationStencyl [

	popupAnimationStencil := anAnimationStencyl
]

{ #category : #'showing / hiding' }
ToPopupWindow >> popupAtPosition: aPoint [

	self popupIn: self widget topMostParent atPosition: aPoint
]

{ #category : #'showing / hiding' }
ToPopupWindow >> popupIn: aWidget atPosition: aPoint [

	self cleanUp.
	" aWidget is already attached, thus its bounds is up-to-date "
	self relocate: aPoint.
	aWidget addChild: self.
	self animate ifFalse: [ ^ self ].
	" enqueue task in myself to adapt my bounds to the space one, it it runned just after i'm attached "

	self enqueueTask: (BlTaskAction new action: [
			 self relocate: (self geometryBoundsInSpace translatedToBeWithin:
					  aWidget bounds asRectangle) origin ]).
	self addAnimation: self popupAnimationStencil value
]

{ #category : #'showing / hiding' }
ToPopupWindow >> removePopup [

	self cleanUp.
	animate ifTrue: [ 
		deleteAnimation := deleteAnimationStencil value.
		deleteAnimation onFinishedDo: [ 
			self parentDo: [ :p | 
				self removeFromParent.
				self cleanUp ] ].
		self addAnimation: deleteAnimation.
		^ self ].

	self parentDo: [ :p | self removeFromParent ]
]

{ #category : #'property change hook' }
ToPopupWindow >> whenWidgetChangedDo: aBlock [

	"set a block to perform after that the text has been chanbed, and its action performed"

	self property: #widget whenChangedDo: aBlock
]

{ #category : #'api - install/uninstall  hook' }
ToPopupWindow >> widget [

	^ widget 

]

{ #category : #'api - install/uninstall  hook' }
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
