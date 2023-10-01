Class {
	#name : #ToLabeledIcon,
	#superclass : #ToElement,
	#traits : 'TToOrientable',
	#classTraits : 'TToOrientable classTrait',
	#instVars : [
		'#icon => ToSkinnableSlot',
		'#filler',
		'#label => ToSkinnableSlot'
	],
	#category : #'Toplo-Core'
}

{ #category : #configurating }
ToLabeledIcon >> beIconFirst [

	(self hasStamp: #'icon-first') ifTrue: [ ^ self ].
	self withStamp: #'icon-first'.
	self layout direction: BlLayoutDirection leftToRight.
	self withoutStamp: #'label-first'.
	self updateSkin.
	self requestLayout
]

{ #category : #configurating }
ToLabeledIcon >> beLabelFirst [

	(self hasStamp: #'label-first') ifTrue: [ ^ self ].
	self withoutStamp: #'icon-first'.
	self layout direction: BlLayoutDirection rightToLeft.
	self withStamp: #'label-first'.
	self updateSkin.
	self requestLayout
]

{ #category : #accessing }
ToLabeledIcon >> filler [

	^ filler
]

{ #category : #accessing }
ToLabeledIcon >> icon [

	^ icon
]

{ #category : #accessing }
ToLabeledIcon >> icon: anElement [

	anElement = self icon ifTrue: [ ^ self ].
	self icon ifNotNil: [ :s | self icon removeFromParent. s removeStyleStampNamed: #'icon'].
	anElement ifNil: [ ^ self ].
	self addChild: anElement before: filler.
	anElement withStamp: #'icon'.
	icon := anElement
	
]

{ #category : #configurating }
ToLabeledIcon >> iconFirst: aBoolean [

	aBoolean
		ifTrue: [ self beIconFirst ]
		ifFalse: [ self beLabelFirst ]
]

{ #category : #initialization }
ToLabeledIcon >> initialize [

	self class initializeSlots: self.
	super initialize.
	self layout: BlLinearLayout horizontal.
	self fitContent.
	filler := ToElement new
		           id: #filler;
		           withStamp: #'labeled-icon-filler';
		           size: 0 @ 0;
		           yourself.
	self addChild: filler
]

{ #category : #configurating }
ToLabeledIcon >> interspace: aPointOrSymbol [

	aPointOrSymbol = #'flexible'
		ifTrue: [
			self withoutStamp: #'exact-interspace'.
			self withStamp: #'flexible'.
			self filler matchParent ]
		ifFalse: [
			self withStamp: #'exact-interspace'.
			self withoutStamp: #'flexible'.
			self filler size: aPointOrSymbol asPoint ]
]

{ #category : #accessing }
ToLabeledIcon >> label [

	^ label
]

{ #category : #accessing }
ToLabeledIcon >> label: anElement [

	anElement = self label ifTrue: [ ^ self ].
	self label ifNotNil: [ :s | self label removeFromParent. s removeStyleStampNamed: #'label'].
	anElement ifNil: [ ^ self ].
	self addChild: anElement after: filler.
	anElement withStamp: #'label'.
	label := anElement
	
]

{ #category : #configurating }
ToLabeledIcon >> labelFirst: aBoolean [

	self iconFirst: aBoolean not
]

{ #category : #'t - orientable - accessing' }
ToLabeledIcon >> layoutStrategy [

	^ self layout
]
