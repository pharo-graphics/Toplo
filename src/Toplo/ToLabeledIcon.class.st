Class {
	#name : #ToLabeledIcon,
	#superclass : #ToElement,
	#traits : 'TToOrientable',
	#classTraits : 'TToOrientable classTrait',
	#instVars : [
		'#iconHolder',
		'#labelHolder',
		'#icon => ToSkinnableSlot',
		'#filler => ToSkinnableSlot',
		'#label => ToSkinnableSlot',
		'#labelOffset'
	],
	#category : #'Toplo-Core'
}

{ #category : #configurating }
ToLabeledIcon >> beIconFirst [

	self isIconFirst ifTrue: [ ^ self ].
	self leftToRight: true.
	self updateSkin.
	self requestLayout
]

{ #category : #configurating }
ToLabeledIcon >> beLabelFirst [

	self isLabelFirst ifTrue: [ ^ self ].
	self leftToRight: false.
	self updateSkin.
	self requestLayout
]

{ #category : #initialization }
ToLabeledIcon >> defaultLayout [ 

	^ BlLinearLayout horizontal.

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
	self icon ifNotNil: [ :s | self icon removeFromParent ].
	anElement ifNil: [ ^ self ].
	self iconHolder addChild: anElement.
	icon := anElement
]

{ #category : #configurating }
ToLabeledIcon >> iconFirst: aBoolean [

	aBoolean
		ifTrue: [ self beIconFirst ]
		ifFalse: [ self beLabelFirst ]
]

{ #category : #accessing }
ToLabeledIcon >> iconHolder [

	^ iconHolder
]

{ #category : #accessing }
ToLabeledIcon >> iconImage [

	^ self icon innerImage
]

{ #category : #accessing }
ToLabeledIcon >> iconImage: anElement [

	self icon: (ToImage inner: anElement)
]

{ #category : #initialization }
ToLabeledIcon >> initialize [

	self class initializeSlots: self.
	super initialize.
	filler := ToElement new
		          size: 0 @ 0;
		          yourself.
	iconHolder := ToElement new
		              fitContent;
		              layout: BlFrameLayout new;
		              yourself.
	labelHolder := ToElement new
		              fitContent;
		              layout: BlFrameLayout new;
		              yourself.
	self addChild: iconHolder.
	self addChild: filler.
	self addChild: labelHolder.
	labelOffset := 0.
	self beIconFirst.
	self fitContent.

]

{ #category : #skin }
ToLabeledIcon >> installRawStyle [

	super installRawStyle.
	self childrenDo: [ :child |
		child constraintsDo: [ :c |
			c linear vertical alignCenter.
			c linear horizontal alignCenter ] ].
	(self label notNil and: [ self icon notNil ]) ifTrue: [
		(self isExact and: [ self filler requestedWidth isZero ])
			ifTrue: [ self filler width: 10 ] ]
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

{ #category : #testing }
ToLabeledIcon >> isExact [

	^ self filler constraints horizontal resizer isExact
]

{ #category : #testing }
ToLabeledIcon >> isFlexible [

	^ self isExact not
]

{ #category : #testing }
ToLabeledIcon >> isIconFirst [

	^ self isLeftToRight
]

{ #category : #testing }
ToLabeledIcon >> isLabelFirst [

	^ self isIconFirst not
]

{ #category : #accessing }
ToLabeledIcon >> label [

	^ label
]

{ #category : #accessing }
ToLabeledIcon >> label: anElement [

	anElement = self label ifTrue: [ ^ self ].
	self label ifNotNil: [ :s | self label removeFromParent].
	anElement ifNil: [ ^ self ].
	self labelHolder addChild: anElement.
	label := anElement
	
]

{ #category : #configurating }
ToLabeledIcon >> labelFirst: aBoolean [

	labelOffset isZero ifFalse: [ 	Error signal: 'Configurated with a label offset which is incompatible with label first configuration' ].
	self iconFirst: aBoolean not
]

{ #category : #accessing }
ToLabeledIcon >> labelHolder [

	^ labelHolder
]

{ #category : #accessing }
ToLabeledIcon >> labelOffset [

	^ labelOffset
]

{ #category : #accessing }
ToLabeledIcon >> labelOffset: anInteger [

	self isIconFirst ifFalse: [
		Error signal:
			'Not configurated with icon first: label offset can''t be set ' ].
	labelOffset := anInteger.
	self labelOffsetChanged
]

{ #category : #configurating }
ToLabeledIcon >> labelOffsetChanged [

	| gap |
	self labelOffset < self iconHolder width ifTrue: [
		self iconHolder fitContent.
		^ self ].
	gap := self labelOffset - self iconHolder requestedWidth.
	self iconHolder width: self iconHolder requestedWidth + gap
]

{ #category : #accessing }
ToLabeledIcon >> labelText: aText [

	self label: (ToLabel text: aText)
]

{ #category : #'t - orientable - accessing' }
ToLabeledIcon >> layoutStrategy [

	^ self layout
]

{ #category : #'t - skinable - initialization' }
ToLabeledIcon >> updateSkin [

	super updateSkin
]
