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

{ #category : 'layout' }
ToSwitchButton >> applySize: aPoint [
	" given my expected size, adapt the size of my handle and of onSide and offSide "

	| handleWidth sideWidth |
	self geometry: (BlRoundedRectangleGeometry cornerRadius: aPoint y / 2).
	handleWidth := aPoint y - (self defaultHandleMarginWidth * 2).
	sideWidth := aPoint x - handleWidth - (handleWidth / 2).
	self handle size: handleWidth asPoint.
	onSide size: sideWidth @ aPoint y.
	offSide size: sideWidth @ aPoint y
]

{ #category : 'initialization' }
ToSwitchButton >> defaultHandleMarginWidth [

	^ 2
]

{ #category : 'initialization' }
ToSwitchButton >> defaultSize [

	^ 50@20
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
	onSide := ToElement new layout: BlFrameLayout new.
	offSide := ToElement new layout: BlFrameLayout new.
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
		
	self size: self defaultSize.

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

{ #category : 'layout' }
ToSwitchButton >> onLayout: aBounds context: aBlElementBoundsUpdateContext [

	super onLayout: aBounds context: aBlElementBoundsUpdateContext.
	self isChecked
		ifTrue: [ self switchOn ]
		ifFalse: [ self switchOff ]
]

{ #category : 'layout' }
ToSwitchButton >> onMeasure: anExtentMeasurementSpec [

	| expectedSize |
	expectedSize := anExtentMeasurementSpec widthSpec size
	                @ anExtentMeasurementSpec heightSpec size.
	self size = expectedSize ifFalse: [
		self applySize: anExtentMeasurementSpec widthSpec size
			@ anExtentMeasurementSpec heightSpec size ].
	super onMeasure: anExtentMeasurementSpec
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

{ #category : 'layout' }
ToSwitchButton >> switchOff [

	| expected |
	expected := onSide measuredWidth negated
	            + self defaultHandleMarginWidth @ 0.
	self track position: expected
]

{ #category : 'layout' }
ToSwitchButton >> switchOn [

	| expected |
	expected := self measuredWidth - self handle measuredWidth
	            - onSide measuredWidth - self defaultHandleMarginWidth
	            @ 0.
	self track position: expected
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
