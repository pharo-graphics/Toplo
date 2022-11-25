Class {
	#name : #ToTooltip,
	#superclass : #BlElement,
	#traits : 'TToWidget',
	#classTraits : 'TToWidget classTrait',
	#instVars : [
		'#content => ObservableSlot',
		'#popupAnimation',
		'#deleteAnimation',
		'#eventHandler',
		'#label',
		'#animate'
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

{ #category : #initialization }
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

	^ deleteAnimation
]

{ #category : #accessing }
ToTooltip >> deleteAnimation: anAnimationStencyl [

	deleteAnimation := anAnimationStencyl
]

{ #category : #initialization }
ToTooltip >> initialize [

	self class initializeSlots: self.
	super initialize.
	eventHandler := ToTooltipEventHandler new.
	self addEventHandler: eventHandler.

	self animate: true.
	deleteAnimation := [ 
	                   BlOpacityAnimation new
		                   duration: 400 milliSeconds;
		                   opacity: 0;
		                   yourself ].
	popupAnimation := [ 
	                  BlOpacityAnimation new
		                  duration: 500 milliSeconds;
		                  opacity: 1;
		                  yourself ].
	self whenContentChangedDo: [ self label text: self content ].
	self dresser: self defaultDresser 
]

{ #category : #accessing }
ToTooltip >> label [

	^ label ifNil: [ 
		  self label: self defaultLabel.
		  label ]
]

{ #category : #accessing }
ToTooltip >> label: aLabel [

	label ifNotNil: [ label removeFromParent ].
	label := aLabel.
	self addChild: label.

]

{ #category : #accessing }
ToTooltip >> popupAnimation [

	^ popupAnimation
]

{ #category : #accessing }
ToTooltip >> popupAnimation: anAnimationStencyl [

	popupAnimation := anAnimationStencyl
]

{ #category : #'showing / hiding' }
ToTooltip >> popupFor: aWidget [

	self flag: 'TODO : polish tooltip placement'.

	self relocate: aWidget bounds bottomRight.
	self animate ifFalse: [ 
		aWidget topMostParent addChild: aWidget tooltip.
		^ self ].
	self opacity: 0.0.
	aWidget topMostParent addChild: aWidget tooltip.
	self addAnimation: self popupAnimation value
]

{ #category : #'showing / hiding' }
ToTooltip >> removePopup [

	animate ifTrue: [ 
		| anim |
		anim := deleteAnimation value.
		anim onFinishedDo: [ self parentDo: [ :p | self removeFromParent ] ].
		self addAnimation: anim.
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

{ #category : #initialization }
ToTooltip >> withAnimation [

	self animate: true
]

{ #category : #initialization }
ToTooltip >> withoutAnimation [

	self animate: false
]
