Class {
	#name : 'ToSwitchButton',
	#superclass : 'ToGeneralButton',
	#traits : 'TToCheckable',
	#classTraits : 'TToCheckable classTrait',
	#instVars : [
		'track',
		'handle',
		'offContainer',
		'onContainer',
		'checked',
		'group',
		'onSide',
		'offSide'
	],
	#category : 'Toplo-Widget-Button-Switch',
	#package : 'Toplo-Widget-Button',
	#tag : 'Switch'
}

{ #category : 'initialization' }
ToSwitchButton >> applySize: aPoint [

	self size: aPoint.
	self geometry: (BlRoundedRectangleGeometry cornerRadius: aPoint y / 2).
	self handle size: (aPoint y - (self defaultHandleMarginWidth * 2)) asPoint.
	onSide size: (aPoint x / 2) @ aPoint y.
	offSide size: (aPoint x / 2) @ aPoint y.
]

{ #category : 'initialization' }
ToSwitchButton >> defaultHandleMarginWidth [

	^ 2
]

{ #category : 'initialization' }
ToSwitchButton >> defaultHeight [ 

	^ 16
]

{ #category : 'initialization' }
ToSwitchButton >> defaultSideWidth [

	^ 35
]

{ #category : 'accessing' }
ToSwitchButton >> handle [

	^ handle
]

{ #category : 'initialization' }
ToSwitchButton >> initialize [

	super initialize.
	self layout: BlBasicLayout new.
	track := ToElement new
		         layout: BlLinearLayout horizontal;
		         constraintsDo: [ :c | c frame vertical alignCenter ];
		         fitContent;
		         yourself.
	self addChild: track.
	handle := ToElement new
		          geometry: BlCircleGeometry new;
		          layout: BlFrameLayout new;
		          background: Color white;
		          yourself.
	onContainer := ToElement new
		               layout: BlFrameLayout new;
		               fitContent.
	offContainer := ToElement new
		                layout: BlFrameLayout new;
		                fitContent.
	onSide := ToElement new layout: BlFrameLayout new; border: Color black.
	offSide := ToElement new layout: BlFrameLayout new; border: Color black.
	onSide addChild: onContainer.
	offSide addChild: offContainer.

	track addChildren: {
			onSide.
			handle.
			offSide }.

	track childrenDo: [ :child |
		child constraintsDo: [ :c | c linear vertical alignCenter ] ].
	
	onSide childrenDo: [ :child |
		child constraintsDo: [ :c |
			c frame vertical alignCenter.
			c frame horizontal alignCenter ] ].
	
	offSide childrenDo: [ :child |
		child constraintsDo: [ :c |
			c frame vertical alignCenter.
			c frame horizontal alignCenter ] ].
	
	self applySize: self defaultSideWidth + self defaultHeight
		+ (self defaultHandleMarginWidth * 2)
		@ (self defaultHeight + (self defaultHandleMarginWidth * 2)).
	self whenLayoutedDoOnce: [
		self isChecked
			ifTrue: [ self switchOn ]
			ifFalse: [ self switchOff ] ]
]

{ #category : 'skin' }
ToSwitchButton >> newRawSkin [ 

	^ ToSwitchButtonSkin new
]

{ #category : 'accessing' }
ToSwitchButton >> offContainer [

	^ offContainer
]

{ #category : 'accessing' }
ToSwitchButton >> onContainer [

	^ onContainer
]

{ #category : 't - checkable - accessing' }
ToSwitchButton >> rawChecked [

	^ checked ifNil: [ checked := false ]
]

{ #category : 't - checkable - accessing' }
ToSwitchButton >> rawChecked: anObject [

	checked := anObject
]

{ #category : 't - checkable - group' }
ToSwitchButton >> rawGroup [

	^ group
]

{ #category : 't - checkable - group' }
ToSwitchButton >> rawGroup: aGroup [

	group = aGroup ifNil: [ ^ self ].
	group := aGroup
]

{ #category : 'initialization' }
ToSwitchButton >> switchOff [

	"self track position: (((self width - self handle width) - (self width - (self handle width + self onContainer width))) negated + self defaultHandleMarginWidth) @ 0"
	self track position: onSide width negated + self defaultHandleMarginWidth @ 0
]

{ #category : 'initialization' }
ToSwitchButton >> switchOn [

	self track position: self width - self handle width - onSide width - self defaultHandleMarginWidth @ 0
]

{ #category : 'accessing' }
ToSwitchButton >> track [

	^ track
]

{ #category : 't - checkable  - protocol' }
ToSwitchButton >> withIndeterminate [

	^ false
]

{ #category : 't - checkable  - protocol' }
ToSwitchButton >> withIndeterminate: aBoolean [

	self shouldNotImplement 
]
