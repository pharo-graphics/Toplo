Class {
	#name : 'ToLabeledIcon',
	#superclass : 'ToElement',
	#traits : 'TToOrientable',
	#classTraits : 'TToOrientable classTrait',
	#instVars : [
		'iconHolder',
		'labelHolder',
		'icon',
		'filler',
		'label'
	],
	#category : 'Toplo-Core',
	#package : 'Toplo',
	#tag : 'Core'
}

{ #category : 'configurating' }
ToLabeledIcon >> beIconFirst [

	self isIconFirst ifTrue: [ ^ self ].
	self leftToRight: true.
	self requestLayout
]

{ #category : 'configurating' }
ToLabeledIcon >> beLabelFirst [

	self isLabelFirst ifTrue: [ ^ self ].
	self leftToRight: false.
	self requestLayout
]

{ #category : 'initialization' }
ToLabeledIcon >> defaultEventHandler [

	^ ToLabeledIconEventHandler new
]

{ #category : 'initialization' }
ToLabeledIcon >> defaultLayout [ 

	^ BlLinearLayout horizontal.

]

{ #category : 'accessing' }
ToLabeledIcon >> filler [

	^ filler
]

{ #category : 'configurating' }
ToLabeledIcon >> flexible [

	^ self filler constraints horizontal resizer isMatchParent
]

{ #category : 'configurating' }
ToLabeledIcon >> flexible: aBoolean [

	self isFlexible = aBoolean ifTrue: [ ^ self ].
	aBoolean
		ifTrue: [
			self addStamp: #flexible.
			self filler matchParent ]
		ifFalse: [
			self removeStamp: #flexible.
			self filler fitContent ]
]

{ #category : 'testing' }
ToLabeledIcon >> hasIcon [

	^ self icon notNil
]

{ #category : 'testing' }
ToLabeledIcon >> hasLabel [

	^ self label notNil
]

{ #category : 'accessing' }
ToLabeledIcon >> icon [

	^ icon
]

{ #category : 'accessing' }
ToLabeledIcon >> icon: anElement [

	anElement = self icon ifTrue: [ ^ self ].
	self icon ifNotNil: [ :s | self icon removeFromParent ].
	icon := anElement.
	anElement ifNil: [ ^ self ].
	self iconHolder addChild: anElement
]

{ #category : 'configurating' }
ToLabeledIcon >> iconFirst: aBoolean [

	aBoolean
		ifTrue: [ self beIconFirst ]
		ifFalse: [ self beLabelFirst ]
]

{ #category : 'accessing' }
ToLabeledIcon >> iconHolder [

	^ iconHolder
]

{ #category : 'accessing' }
ToLabeledIcon >> iconHolderHeight [

	^ self iconHolder requestedHeight
]

{ #category : 'accessing' }
ToLabeledIcon >> iconHolderHeight: anInteger [

	self iconHolder height: anInteger
]

{ #category : 'accessing' }
ToLabeledIcon >> iconHolderWidth [

	^ self iconHolder requestedWidth
]

{ #category : 'accessing' }
ToLabeledIcon >> iconHolderWidth: anInteger [

	self iconHolder width: anInteger
]

{ #category : 'accessing' }
ToLabeledIcon >> iconImage [

	^ self icon innerImage
]

{ #category : 'accessing' }
ToLabeledIcon >> iconImage: anElement [

	self icon: (ToImage inner: anElement)
]

{ #category : 'initialization' }
ToLabeledIcon >> initialize [

	self class initializeSlots: self.
	super initialize.

	filler := ToElement new
		          size: 0 @ 0;
		          id: #filler;
		          layout: BlFrameLayout new;
		          fitContent;
		          yourself.
	iconHolder := ToElement new
		              fitContent;
		              id: #iconHolder;
		              layout: BlFrameLayout new;
		              yourself.
	labelHolder := ToElement new
		               fitContent;
		               id: #labelHolder;
		               layout: BlFrameLayout new;
		               yourself.
	iconHolder withoutSkin.
	filler withoutSkin.
	labelHolder withoutSkin.

	self addChild: iconHolder.
	self addChild: filler.
	self addChild: labelHolder.
	self beIconFirst.
	self fitContent.
	self addEventHandler: self defaultEventHandler
]

{ #category : 'skin' }
ToLabeledIcon >> installRawStyle [

	super installRawStyle.
	self childrenDo: [ :child |
		child constraintsDo: [ :c |
			c linear vertical alignCenter.
			c linear horizontal alignCenter ] ].

	
]

{ #category : 'accessing' }
ToLabeledIcon >> interspace [

	| fc |
	fc := self filler constraints.
	^ fc minWidth @ fc minHeight
]

{ #category : 'accessing' }
ToLabeledIcon >> interspace: aPoint [

	| size |
	size := aPoint asPoint.
	self interspace = size ifTrue: [ ^ self ].
	self filler constraints
		minWidth: size x;
		minHeight: size y.
	self filler requestLayout
]

{ #category : 'testing' }
ToLabeledIcon >> isExact [

	^ self constraints vertical resizer isExact and: [
		  self constraints horizontal resizer isExact ]
]

{ #category : 'testing' }
ToLabeledIcon >> isFlexible [

	^ self flexible
]

{ #category : 'testing' }
ToLabeledIcon >> isIconFirst [

	^ self isLeftToRight
]

{ #category : 'testing' }
ToLabeledIcon >> isLabelFirst [

	^ self isIconFirst not
]

{ #category : 'accessing' }
ToLabeledIcon >> label [

	^ label
]

{ #category : 'accessing' }
ToLabeledIcon >> label: anElement [

	anElement = self label ifTrue: [ ^ self ].
	self label ifNotNil: [ :s | s removeFromParent].
	label := anElement.
	anElement ifNil: [ ^ self ].
	self labelHolder addChild: anElement
]

{ #category : 'configurating' }
ToLabeledIcon >> labelFirst: aBoolean [

	self iconFirst: aBoolean not
]

{ #category : 'accessing' }
ToLabeledIcon >> labelHolder [

	^ labelHolder
]

{ #category : 'accessing' }
ToLabeledIcon >> labelText: aText [

	self label: (ToLabel text: aText asRopedText)
]

{ #category : 't - orientable - accessing' }
ToLabeledIcon >> layoutStrategy [

	^ self layout
]

{ #category : 'accessing' }
ToLabeledIcon >> rightLabelAlignment: anInteger [

	self iconHolderWidth: anInteger
]
