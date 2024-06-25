Class {
	#name : #ToSwitchIcon,
	#superclass : #ToGeneralButton,
	#classTraits : 'TToCheckable classTrait',
	#instVars : [
		'track',
		'handle',
		'checked',
		'handleUncheckedBuilder',
		'handleCheckedBuilder',
		'checkedContainer',
		'uncheckedContainer',
		'checkedSide',
		'uncheckedSide',
		'handleDisabledBuilder',
		'firstMeasureDone',
		'handleWidth',
		'wishedSize'
	],
	#category : #'Toplo-Widget-Button-Switch'
}

{ #category : #layout }
ToSwitchIcon >> applySize: aPoint [
	" given my expected size, adapt the size of my handle and of onSide and offSide "

	self geometry: (BlRoundedRectangleGeometry cornerRadius: aPoint y / 2).
	handleWidth := aPoint y - (self defaultHandleMarginWidth * 2).
	self handle size: handleWidth asPoint
]

{ #category : #accessing }
ToSwitchIcon >> checked [

	^ checked 
]

{ #category : #accessing }
ToSwitchIcon >> checked: aBoolean [

	checked = aBoolean ifTrue: [ ^ self ].
	checked := aBoolean.
	self dispatchEvent: (ToCheckableCheckEvent current: checked previous: checked not)
]

{ #category : #accessing }
ToSwitchIcon >> checkedContainer [

	^ checkedContainer
]

{ #category : #initialization }
ToSwitchIcon >> defaultHandleMarginWidth [

	^ 2
]

{ #category : #initialization }
ToSwitchIcon >> defaultSize [

	^ 35@20.0
]

{ #category : #'private - layout' }
ToSwitchIcon >> firstMeasureDone [

	^ firstMeasureDone
]

{ #category : #accessing }
ToSwitchIcon >> firstMeasureDone: aBoolean [

	firstMeasureDone := aBoolean
]

{ #category : #accessing }
ToSwitchIcon >> handle [

	^ handle
]

{ #category : #accessing }
ToSwitchIcon >> handleCheckedBuilder [

	^ handleCheckedBuilder

	
]

{ #category : #accessing }
ToSwitchIcon >> handleCheckedBuilder: aValuable [

	handleCheckedBuilder := aValuable

	
]

{ #category : #accessing }
ToSwitchIcon >> handleDisabledBuilder [

	^ handleDisabledBuilder

	
]

{ #category : #accessing }
ToSwitchIcon >> handleDisabledBuilder: aValuable [

	handleDisabledBuilder := aValuable

	
]

{ #category : #accessing }
ToSwitchIcon >> handleUncheckedBuilder [

	^ handleUncheckedBuilder 

	
]

{ #category : #accessing }
ToSwitchIcon >> handleUncheckedBuilder: aValuable [

	handleUncheckedBuilder := aValuable

	
]

{ #category : #initialization }
ToSwitchIcon >> initialize [

	super initialize.
	self id: #'switchIcon'.
	wishedSize := self defaultSize.
	self applySkinInstallerOnFirstRequest: false.
	self layout: BlBasicLayout new.
	track := self newTrack.
	handle := self newHandle.
	checkedContainer := ToElement new
		                    layout: BlFrameLayout new;
		                    fitContent.
	uncheckedContainer := ToElement new
		                      layout: BlFrameLayout new;
		                      fitContent.
	checkedSide := ToElement new layout: BlFrameLayout new; fitContent.
	uncheckedSide := ToElement new layout: BlFrameLayout new; fitContent.
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
	
	self addChild: track.
	self size: wishedSize.
	self checked: false.
	firstMeasureDone := false.
]

{ #category : #testing }
ToSwitchIcon >> isChecked [ 

	^ self checked
]

{ #category : #initialization }
ToSwitchIcon >> newHandle [

	^ ToElement new
		  geometry: BlCircleGeometry new;
		  margin: (BlInsets all: self defaultHandleMarginWidth);
		  layout: BlFrameLayout new;
		  background: Color white;
		vMatchParent;
		  yourself
]

{ #category : #skin }
ToSwitchIcon >> newRawSkin [ 

	^ ToSwitchIconSkin new
]

{ #category : #initialization }
ToSwitchIcon >> newTrack [

	^ ToElement new
		  layout: BlLinearLayout horizontal;
		  constraintsDo: [ :c | c frame vertical alignCenter ];
		  fitContent;
		  yourself
]

{ #category : #'private - layout' }
ToSwitchIcon >> onChildAddedInSideContainer [


]

{ #category : #layout }
ToSwitchIcon >> onMeasure: anExtentMeasurementSpec [

	| finalSize sideContainerSize |
	super onMeasure: anExtentMeasurementSpec.
	sideContainerSize := (self checkedContainer measuredWidth max:
		                      self uncheckedContainer measuredWidth)
	                     @ (self checkedContainer measuredHeight max:
			                      self uncheckedContainer measuredHeight).
	finalSize := sideContainerSize x + 8 + sideContainerSize y
	             @ (sideContainerSize y + 2) max: wishedSize.
	anExtentMeasurementSpec widthSpec size:
		(finalSize x max: anExtentMeasurementSpec widthSpec size).
	anExtentMeasurementSpec heightSpec size:
		(finalSize y max: anExtentMeasurementSpec heightSpec size).
	self size = finalSize ifFalse: [
		self applySize: finalSize.
		firstMeasureDone := false.
		self requestNewSkin  ].
	super onMeasure: anExtentMeasurementSpec.
	firstMeasureDone ifTrue: [ ^ self ].
	self switch: self isChecked.
	firstMeasureDone := true
]

{ #category : #layout }
ToSwitchIcon >> showSide [

	self isChecked
		ifTrue: [
			uncheckedSide visibility: BlVisibility hidden.
			checkedSide visibility: BlVisibility visible ]
		ifFalse: [
			checkedSide visibility: BlVisibility hidden.
			uncheckedSide visibility: BlVisibility visible ]
]

{ #category : #'api - bounds' }
ToSwitchIcon >> size: aPoint [

	self wishedSize: aPoint.
	super size: aPoint
]

{ #category : #layout }
ToSwitchIcon >> switch: aBoolean [

	aBoolean
		ifTrue: [ self switchChecked ]
		ifFalse: [ self switchUnchecked ]
]

{ #category : #layout }
ToSwitchIcon >> switchChecked [

	self track position: self trackOnExpectedPosition.
	self showSide
]

{ #category : #layout }
ToSwitchIcon >> switchUnchecked [

	self track position: self trackOffExpectedPosition.
	self showSide
]

{ #category : #accessing }
ToSwitchIcon >> track [

	^ track
]

{ #category : #layout }
ToSwitchIcon >> trackOffExpectedPosition [

	^ checkedSide measuredWidth negated  @ 0
]

{ #category : #layout }
ToSwitchIcon >> trackOnExpectedPosition [

	^ self measuredWidth - handleWidth
	  - checkedSide measuredWidth - (self defaultHandleMarginWidth * 2) @ 0
]

{ #category : #accessing }
ToSwitchIcon >> uncheckedContainer [

	^ uncheckedContainer
]

{ #category : #skin }
ToSwitchIcon >> updateHandleContent [

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

{ #category : #accessing }
ToSwitchIcon >> wishedSize: aPoint [

	wishedSize := aPoint
]
