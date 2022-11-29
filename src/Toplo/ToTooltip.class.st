Class {
	#name : #ToTooltip,
	#superclass : #BlElement,
	#traits : 'TToWidget',
	#classTraits : 'TToWidget classTrait',
	#instVars : [
		'#content => ObservableSlot',
		'#widgetEventHandler',
		'#eventHandler',
		'#label',
		'#animate',
		'#deleteAnimationStencil',
		'#popupAnimationStencil',
		'#deleteAnimation'
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

{ #category : #'t - initialization' }
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

{ #category : #initialization }
ToTooltip >> defaultViewModel [

	^ ToTooltipModel new
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

	widgetEventHandler := ToWidgetWithTooltipEventHandler new.
	aWidget addEventFilter: widgetEventHandler 
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
ToTooltip >> popupFor: aWidget [

	self flag: 'TODO : polish tooltip placement'.

	self cleanUp.
	self relocate: (aWidget localPointToGlobal: aWidget bounds bottomRight).
	self animate ifFalse: [ 
		aWidget topMostParent addChild: aWidget tooltip.
		^ self ].
	self opacity: 0.0.
	aWidget topMostParent addChild: aWidget tooltip.
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

	^ widgetEventHandler
]

{ #category : #accessing }
ToTooltip >> widgetEventHandler: anObject [

	widgetEventHandler := anObject
]

{ #category : #initialization }
ToTooltip >> withAnimation [

	self animate: true
]

{ #category : #initialization }
ToTooltip >> withoutAnimation [

	self animate: false
]
