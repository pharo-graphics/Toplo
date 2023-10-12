Class {
	#name : #ToLabeledIcon,
	#superclass : #ToElement,
	#traits : 'TToOrientable',
	#classTraits : 'TToOrientable classTrait',
	#instVars : [
		'#iconHolder',
		'#icon => ToSkinnableSlot',
		'#filler => ToSkinnableSlot',
		'#label => ToSkinnableSlot',
		'#labelOffset'
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

{ #category : #'t - skinable - initialization' }
ToLabeledIcon >> defaultStyleStamps [

	^ #( #'labeled-icon' )
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
	self icon ifNotNil: [ :s |
		self icon removeFromParent.
		s removeStyleStampNamed: #icon ].
	anElement ifNil: [ ^ self ].
	self iconHolder addChild: anElement.
	anElement withStamp: #icon.
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
ToLabeledIcon >> iconImage: anElement [

	self icon: (ToImage inner: anElement)
]

{ #category : #initialization }
ToLabeledIcon >> initialize [

	self class initializeSlots: self.
	super initialize.
	self withStamp: #'labeled-icon'.
	self layout: BlLinearLayout horizontal.
	self fitContent.
	filler := ToElement new
		          id: #filler;
		          withStamp: #'labeled-icon-filler';
		          size: 0 @ 0;
		          yourself.
	iconHolder := ToElement new
		              fitContent;
		              layout: BlFrameLayout new;
		              yourself.
	iconHolder id: #'icon-holder'.
	self addChild: iconHolder.
	self addChild: filler.
	labelOffset := 0.
	self beIconFirst
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
ToLabeledIcon >> isIconFirst [

	^ self hasStamp: #'icon-first'
]

{ #category : #configurating }
ToLabeledIcon >> isLabelFirst [

	^ self hasStamp: #'label-first'
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

	labelOffset isZero ifFalse: [ 	Error signal: 'Configurated with a label offset which is incompatible with label first configuration' ].
	self iconFirst: aBoolean not
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
