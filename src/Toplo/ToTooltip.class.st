Class {
	#name : #ToTooltip,
	#superclass : #BlElement,
	#traits : 'TToWidget + TToWidgetWithDresser',
	#classTraits : 'TToWidget classTrait + TToWidgetWithDresser classTrait',
	#instVars : [
		'#content => ObservableSlot',
		'#eventHandler',
		'#label',
		'#animate',
		'#deleteAnimationStencil',
		'#popupAnimationStencil',
		'#deleteAnimation',
		'#widget',
		'#widgetWithTooltipEventHandler'
	],
	#category : #'Toplo-Widget-Tooltip'
}

{ #category : #accessing }
ToTooltip >> animate [

	^ animate
]

{ #category : #accessing }
ToTooltip >> animate: aBoolean [

	animate := aBoolean
]

{ #category : #'showing / hiding' }
ToTooltip >> cleanUp [

	deleteAnimation ifNotNil: [ 
		self dequeueTask: deleteAnimation.
		deleteAnimation := nil ]
]

{ #category : #accessing }
ToTooltip >> content [

	^ content
]

{ #category : #accessing }
ToTooltip >> content: aText [

	content := aText
]

{ #category : #accessing }
ToTooltip >> contentString: aString [

	self content: aString asRopedText
]

{ #category : #'t - accessing - dresser' }
ToTooltip >> defaultDresser [

	^ ToTooltipDresser new

]

{ #category : #accessing }
ToTooltip >> defaultLabel [

	^ ToLabel new
		  beMultiLine;
		  text: self content;
		  preventMouseEvents;
		  yourself
]

{ #category : #accessing }
ToTooltip >> deleteAnimation [

	^ deleteAnimationStencil
]

{ #category : #accessing }
ToTooltip >> deleteAnimation: anAnimationStencyl [

	deleteAnimationStencil := anAnimationStencyl
]

{ #category : #initialization }
ToTooltip >> initialize [

	self class initializeSlots: self.
	super initialize.
	self elevation: (BlRelativeElevation elevation: SmallInteger maxVal).
	eventHandler := ToTooltipEventHandler new.
	self addEventHandler: eventHandler.
	self animate: true.
	deleteAnimationStencil := [ 
	                          BlOpacityAnimation new
		                          duration: 400 milliSeconds;
		                          opacity: 0;
		                          yourself ].
	popupAnimationStencil := [ 
	                         self opacity: 0.0.
	                         BlOpacityAnimation new
		                         duration: 500 milliSeconds;
		                         opacity: 1;
		                         yourself ].
	self label: self defaultLabel.
	self whenContentChangedDo: [ self label text: self content ].
	self dresser: self defaultDresser
]

{ #category : #accessing }
ToTooltip >> label [

	^ label
]

{ #category : #accessing }
ToTooltip >> label: aLabel [

	label ifNotNil: [ label removeFromParent ].
	label := aLabel.
	self addChild: label.

]

{ #category : #initialization }
ToTooltip >> onInstalledIn: aWidget [

	widget := aWidget.
	widgetWithTooltipEventHandler := ToWidgetWithTooltipEventHandler new.
	aWidget addEventFilter: widgetWithTooltipEventHandler 
]

{ #category : #initialization }
ToTooltip >> onUninstalledIn: aWidget [

	aWidget removeEventFilter: widgetWithTooltipEventHandler.
	widgetWithTooltipEventHandler := nil
]

{ #category : #accessing }
ToTooltip >> popupAnimation [

	^ popupAnimationStencil
]

{ #category : #accessing }
ToTooltip >> popupAnimation: anAnimationStencyl [

	popupAnimationStencil := anAnimationStencyl
]

{ #category : #'showing / hiding' }
ToTooltip >> popupFor: aWidget fromPosition: aPoint [

	self cleanUp.
	" aWidget is already attached, thus its bounds is up-to-date"
	self relocate: aPoint x @ (aWidget localPointToGlobal: 0 @ aWidget bounds bottom) y.
	aWidget topMostParent addChild: self.
	self animate ifFalse: [ ^ self ].
	"enqueue task in myself to adapt my bounds to the space one, it it runned just after i'm attached "
	self enqueueTask: (BlTaskAction new action: [ 
			 self relocate: (self geometryBoundsInSpace translatedToBeWithin:
					  aWidget topMostParent bounds asRectangle) origin ]).
	self addAnimation: self popupAnimation value
]

{ #category : #'showing / hiding' }
ToTooltip >> removePopup [

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

{ #category : #'api - properties change hook' }
ToTooltip >> whenAnimateChangedDo: aBlock [
	"Inform when animate property has changed. 
	 `aBlock` has three optional arguments: 
	 - new value
	 - old value
	 - the announcement triggering this action"

	self property: #animate whenChangedDo: aBlock
]

{ #category : #'api - properties change hook' }
ToTooltip >> whenContentChangedDo: aBlock [
	"Inform when content property has changed. 
	 `aBlock` has three optional arguments: 
	 - new value
	 - old value
	 - the announcement triggering this action"

	self property: #content whenChangedDo: aBlock
]

{ #category : #accessing }
ToTooltip >> widgetEventHandler [

	^ widgetWithTooltipEventHandler
]

{ #category : #accessing }
ToTooltip >> widgetEventHandler: anObject [

	widgetWithTooltipEventHandler := anObject
]

{ #category : #initialization }
ToTooltip >> withAnimation [

	self animate: true
]

{ #category : #initialization }
ToTooltip >> withoutAnimation [

	self animate: false
]
