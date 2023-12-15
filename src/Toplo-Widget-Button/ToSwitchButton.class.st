Class {
	#name : 'ToSwitchButton',
	#superclass : 'ToGeneralButton',
	#traits : 'TToCheckable',
	#classTraits : 'TToCheckable classTrait',
	#instVars : [
		'track',
		'handle',
		'checked',
		'group',
		'handleUncheckedBuilder',
		'handleCheckedBuilder',
		'checkedContainer',
		'uncheckedContainer',
		'checkedSide',
		'uncheckedSide',
		'handleDisabledBuilder'
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
	checkedSide size: sideWidth @ aPoint y.
	uncheckedSide size: sideWidth @ aPoint y
]

{ #category : 'accessing' }
ToSwitchButton >> checkedContainer [

	^ checkedContainer
]

{ #category : 'initialization' }
ToSwitchButton >> defaultHandleMarginWidth [

	^ 2
]

{ #category : 'initialization' }
ToSwitchButton >> defaultSize [

	^ 60@18
]

{ #category : 'accessing' }
ToSwitchButton >> handle [

	^ handle
]

{ #category : 'accessing' }
ToSwitchButton >> handleCheckedBuilder [

	^ handleCheckedBuilder

	
]

{ #category : 'accessing' }
ToSwitchButton >> handleCheckedBuilder: aValuable [

	handleCheckedBuilder := aValuable

	
]

{ #category : 'accessing' }
ToSwitchButton >> handleDisabledBuilder [

	^ handleDisabledBuilder

	
]

{ #category : 'accessing' }
ToSwitchButton >> handleDisabledBuilder: aValuable [

	handleDisabledBuilder := aValuable

	
]

{ #category : 'accessing' }
ToSwitchButton >> handleUncheckedBuilder [

	^ handleUncheckedBuilder 

	
]

{ #category : 'accessing' }
ToSwitchButton >> handleUncheckedBuilder: aValuable [

	handleUncheckedBuilder := aValuable

	
]

{ #category : 'initialization' }
ToSwitchButton >> initialize [

	super initialize.
	self layout: BlBasicLayout new.
	track := self newTrack.
	self addChild: track.
	handle := self newHandle.
	checkedContainer := ToElement new
		               layout: BlFrameLayout new;
		               fitContent.
	uncheckedContainer := ToElement new
		                layout: BlFrameLayout new;
		                fitContent.
	checkedSide := ToElement new layout: BlFrameLayout new.
	uncheckedSide := ToElement new layout: BlFrameLayout new.
	checkedSide addChild: checkedContainer.
	uncheckedSide addChild: uncheckedContainer.

	track addChildren: {
			checkedSide.
			handle.
			uncheckedSide }.

	track childrenDo: [ :child |
		child constraintsDo: [ :c | c linear vertical alignCenter ] ].

	checkedSide childrenDo: [ :child |
		child constraintsDo: [ :c |
			c frame vertical alignCenter.
			c frame horizontal alignCenter ] ].

	uncheckedSide childrenDo: [ :child |
		child constraintsDo: [ :c |
			c frame vertical alignCenter.
			c frame horizontal alignCenter ] ].
	
	self size: self defaultSize.
	self checked: false
]

{ #category : 'initialization' }
ToSwitchButton >> newHandle [

	^ ToElement new
		  geometry: BlCircleGeometry new;
		  layout: BlFrameLayout new;
		  background: Color white;
		  yourself
]

{ #category : 'skin' }
ToSwitchButton >> newRawSkin [ 

	^ ToSwitchButtonSkin new
]

{ #category : 'initialization' }
ToSwitchButton >> newTrack [

	^ ToElement new
		  layout: BlLinearLayout horizontal;
		  constraintsDo: [ :c | c frame vertical alignCenter ];
		  fitContent;
		  yourself
]

{ #category : 'layout' }
ToSwitchButton >> onLayout: aBounds context: aBlElementBoundsUpdateContext [

	super onLayout: aBounds context: aBlElementBoundsUpdateContext.
	"self isChecked
		ifTrue: [ self switchChecked ]
		ifFalse: [ self switchUnchecked ]"
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

	^ checked 
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
ToSwitchButton >> switch: aBoolean [

	aBoolean
		ifTrue: [ self switchChecked ]
		ifFalse: [ self switchUnchecked ]
]

{ #category : 'layout' }
ToSwitchButton >> switchChecked [

	self track position: self trackOnExpectedPosition 
]

{ #category : 'layout' }
ToSwitchButton >> switchUnchecked [

	self track position: self trackOffExpectedPosition 
]

{ #category : 'accessing' }
ToSwitchButton >> track [

	^ track
]

{ #category : 'layout' }
ToSwitchButton >> trackOffExpectedPosition [

	^ checkedSide measuredWidth negated + self defaultHandleMarginWidth @ 0
]

{ #category : 'layout' }
ToSwitchButton >> trackOnExpectedPosition [

	^ self measuredWidth - self handle measuredWidth
	  - checkedSide measuredWidth - self defaultHandleMarginWidth @ 0
]

{ #category : 'accessing' }
ToSwitchButton >> uncheckedContainer [

	^ uncheckedContainer
]

{ #category : 'skin' }
ToSwitchButton >> updateHandleContent [

	self handle childrenDo: [ :child | child removeFromParent ].
	self isDisabled
		ifTrue: [
			self handleDisabledBuilder ifNotNil: [ :b |
				b value: self handle value: self ] ]
		ifFalse: [
			self isChecked
				ifTrue: [
					self handleCheckedBuilder ifNotNil: [ :b |
						b value: self handle value: self ] ]
				ifFalse: [
					self handleUncheckedBuilder ifNotNil: [ :b |
						b value: self handle value: self ] ] ]
]

{ #category : 't - checkable  - protocol' }
ToSwitchButton >> withIndeterminate [

	^ false
]

{ #category : 't - checkable  - protocol' }
ToSwitchButton >> withIndeterminate: aBoolean [

	self shouldNotImplement 
]
