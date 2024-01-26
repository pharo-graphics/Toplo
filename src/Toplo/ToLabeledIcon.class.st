Class {
	#name : #ToLabeledIcon,
	#superclass : #ToElement,
	#traits : 'TToOrientable',
	#classTraits : 'TToOrientable classTrait',
	#instVars : [
		'icon',
		'filler',
		'label',
		'iconContainer',
		'labelContainer'
	],
	#category : #'Toplo-Core'
}

{ #category : #configurating }
ToLabeledIcon >> beIconFirst [

	self isIconFirst ifTrue: [ ^ self ].
	self leftToRight: true.
	self requestLayout
]

{ #category : #configurating }
ToLabeledIcon >> beLabelFirst [

	self isLabelFirst ifTrue: [ ^ self ].
	self leftToRight: false.
	self requestLayout
]

{ #category : #initialization }
ToLabeledIcon >> defaultEventHandler [

	^ ToLabeledIconEventHandler new
]

{ #category : #initialization }
ToLabeledIcon >> defaultLayout [ 

	^ BlLinearLayout horizontal.

]

{ #category : #accessing }
ToLabeledIcon >> filler [

	^ filler
]

{ #category : #configurating }
ToLabeledIcon >> flexible [

	^ self filler constraints horizontal resizer isMatchParent
]

{ #category : #configurating }
ToLabeledIcon >> flexible: aBoolean [

	self isFlexible = aBoolean ifTrue: [ ^ self ].
	aBoolean
		ifTrue: [
			self addStamp: #flexible.
			self filler constraintsDo:  [ :c | c vertical matchParent. c horizontal matchParent ] ]
		ifFalse: [
			self removeStamp: #flexible.
			self filler constraintsDo:  [ :c | c vertical fitContent. c horizontal fitContent ] ]
]

{ #category : #testing }
ToLabeledIcon >> hasIcon [

	^ self icon notNil
]

{ #category : #testing }
ToLabeledIcon >> hasLabel [

	^ self label notNil
]

{ #category : #accessing }
ToLabeledIcon >> icon [

	^ icon
]

{ #category : #accessing }
ToLabeledIcon >> icon: anElement [

	anElement = self icon ifTrue: [ ^ self ].
	self icon ifNotNil: [ :s | self icon removeFromParent ].
	icon := anElement.
	anElement ifNil: [ ^ self ].
	self iconContainer addChild: anElement
]

{ #category : #accessing }
ToLabeledIcon >> iconContainer [

	^ iconContainer
]

{ #category : #accessing }
ToLabeledIcon >> iconContainerHeight [

	^ self iconContainer requestedHeight
]

{ #category : #accessing }
ToLabeledIcon >> iconContainerHeight: anInteger [

	self iconContainer height: anInteger
]

{ #category : #accessing }
ToLabeledIcon >> iconContainerWidth [

	^ self iconContainer requestedWidth
]

{ #category : #accessing }
ToLabeledIcon >> iconContainerWidth: anInteger [

	self iconContainer width: anInteger
]

{ #category : #configurating }
ToLabeledIcon >> iconFirst: aBoolean [

	aBoolean
		ifTrue: [ self beIconFirst ]
		ifFalse: [ self beLabelFirst ]
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

	super initialize.

	filler := BlElement new
		          size: 0 @ 0;
		          id: #filler;
		          layout: BlFrameLayout new;
		          constraintsDo: [ :c |
			          c horizontal fitContent.
			          c vertical fitContent ];
		          yourself.
	iconContainer := BlElement new
		                 constraintsDo: [ :c |
			                 c horizontal fitContent.
			                 c vertical fitContent ];
		                 id: #iconContainer;
		                 layout: BlFrameLayout new;
		                 yourself.
	labelContainer := BlElement new
		                  constraintsDo: [ :c |
			                  c horizontal fitContent.
			                  c vertical fitContent ];
		                  id: #labelContainer;
		                  layout: BlFrameLayout new;
		                  yourself.
	self addChild: iconContainer.
	self addChild: filler.
	self addChild: labelContainer.
	self beIconFirst.
	self fitContent.
	self addEventHandler: self defaultEventHandler
]

{ #category : #skin }
ToLabeledIcon >> installRawStyle [

	super installRawStyle.
	self childrenDo: [ :child |
		child constraintsDo: [ :c |
			c linear vertical alignCenter.
			c linear horizontal alignCenter ] ].

	
]

{ #category : #accessing }
ToLabeledIcon >> interspace [

	| fc |
	fc := self filler constraints.
	^ fc minWidth @ fc minHeight
]

{ #category : #accessing }
ToLabeledIcon >> interspace: aPoint [

	| size |
	size := aPoint asPoint.
	self interspace = size ifTrue: [ ^ self ].
	self filler constraints
		minWidth: size x;
		minHeight: size y.
	self filler requestLayout
]

{ #category : #testing }
ToLabeledIcon >> isExact [

	^ self constraints vertical resizer isExact and: [
		  self constraints horizontal resizer isExact ]
]

{ #category : #testing }
ToLabeledIcon >> isFlexible [

	^ self flexible
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
	self label ifNotNil: [ :s | s removeFromParent].
	label := anElement.
	anElement ifNil: [ ^ self ].
	self labelContainer addChild: anElement
]

{ #category : #accessing }
ToLabeledIcon >> labelContainer [

	^ labelContainer
]

{ #category : #configurating }
ToLabeledIcon >> labelFirst: aBoolean [

	self iconFirst: aBoolean not
]

{ #category : #accessing }
ToLabeledIcon >> labelText [

	self hasLabel ifFalse: [ ^ nil ].
	^ self label text asString
]

{ #category : #accessing }
ToLabeledIcon >> labelText: aText [

	aText ifNil: [
		self label: nil.
		^ self ].
	self label: (ToLabel text: aText asRopedText).
]

{ #category : #'t - orientable - accessing' }
ToLabeledIcon >> layoutStrategy [

	^ self layout
]

{ #category : #accessing }
ToLabeledIcon >> rightLabelAlignment: anInteger [

	self iconContainerWidth: anInteger
]
