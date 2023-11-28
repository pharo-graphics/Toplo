Class {
	#name : 'ToTabPane',
	#superclass : 'ToPane',
	#instVars : [
		'rebuildPaneOnSelect',
		'header',
		'headerPositioning',
		'body',
		'resizablePanes'
	],
	#category : 'Toplo-Incubator',
	#package : 'Toplo-Incubator'
}

{ #category : 'adding-removing' }
ToTabPane >> addTab: aButton [

	header addChild: aButton.
	self tabs size = 1 ifTrue: [ aButton selected: true ]
]

{ #category : 'adding-removing' }
ToTabPane >> addTabWithText: aText [ 

	| but |
	but := ToTab new labelText: aText asString.
	self addTab: but
]

{ #category : 'adding-removing' }
ToTabPane >> addTabWithText: aText builder: aValuable [

	| but |
	but := ToTab new labelText: aText asString.
	but paneBuilder: aValuable.
	self addTab: but
]

{ #category : 'configuration - private' }
ToTabPane >> applyHeaderPositioning [

	self headerPositioning applyOn: self
]

{ #category : 'configuration - private' }
ToTabPane >> applyResizablePanesConfiguration [

	self body removeDividers.
	self resizablePanes ifTrue: [ self body addDividers ]
]

{ #category : 'accessing' }
ToTabPane >> body [

	^ body
]

{ #category : 'configuration' }
ToTabPane >> checkingStrategy [

	^ self header checkingStrategy
]

{ #category : 'configuration' }
ToTabPane >> checkingStrategy: aCheckingStrategy [

	self header checkingStrategy: aCheckingStrategy
]

{ #category : 'initialization' }
ToTabPane >> defaultHeaderPositioning [

	^ ToTabPaneHeaderOnTop new
]

{ #category : 'accessing' }
ToTabPane >> group [ 

	^ self header group
]

{ #category : 'accessing' }
ToTabPane >> header [

	^ header
]

{ #category : 'configuration' }
ToTabPane >> headerPositioning [

	^ headerPositioning
]

{ #category : 'configuration' }
ToTabPane >> headerPositioning: aPositioningStategy [

	headerPositioning := aPositioningStategy.
	self headerPositioning applyOn: self
]

{ #category : 'initialization' }
ToTabPane >> initialize [

	super initialize.
	rebuildPaneOnSelect := false.
	resizablePanes := false.
	self matchParent.
	header := ToTabPaneHeader new.
	body := ToPane vertical matchParent.
	self headerPositioning: self defaultHeaderPositioning.
	self addChild: header as: #header.
	self addChild: body as: #body.
	self withVerticalBody.
	self checkingStrategy: ToCheckableGroupStrictStrategy new

]

{ #category : 'accessing' }
ToTabPane >> lastTab [

	^ self tabs last
]

{ #category : 'adding-removing - private' }
ToTabPane >> onTabRemoved: aTab [


]

{ #category : 'configuration' }
ToTabPane >> preservePaneOnSelect [

	^ self rebuildPaneOnSelect not
]

{ #category : 'configuration' }
ToTabPane >> preservePaneOnSelect: aBoolean [

	self rebuildPaneOnSelect: aBoolean not
]

{ #category : 'configuration' }
ToTabPane >> rebuildPaneOnSelect [

	^ rebuildPaneOnSelect
]

{ #category : 'configuration' }
ToTabPane >> rebuildPaneOnSelect: aBoolean [

	rebuildPaneOnSelect := aBoolean
]

{ #category : 'configuration' }
ToTabPane >> resizablePanes [

	^ resizablePanes
]

{ #category : 'configuration' }
ToTabPane >> resizablePanes: aBoolean [

	resizablePanes := aBoolean.
	self applyResizablePanesConfiguration
]

{ #category : 'accessing - private' }
ToTabPane >> tabGeometry [

	^ self headerPositioning tabGeometry
]

{ #category : 'accessing' }
ToTabPane >> tabs [ 

	^ self header tabs
]

{ #category : 'configuration' }
ToTabPane >> withHeaderOnBottom [

	self headerPositioning: ToPabPaneHeaderOnBottom new
]

{ #category : 'configuration' }
ToTabPane >> withHeaderOnLeft [

	self headerPositioning: ToTabPaneHeaderOnLeft new
]

{ #category : 'configuration' }
ToTabPane >> withHeaderOnRight [

	self headerPositioning: ToTabPaneHeaderOnRight new
]

{ #category : 'configuration' }
ToTabPane >> withHeaderOnTop [

	self headerPositioning: ToTabPaneHeaderOnTop new
]

{ #category : 'configuration' }
ToTabPane >> withHorizontalBody [

	self body beHorizontal
]

{ #category : 'configuration' }
ToTabPane >> withResizablePanes [

	self resizablePanes ifTrue: [ ^ self ].
	self resizablePanes: true
]

{ #category : 'configuration' }
ToTabPane >> withStrictCheckingStrategy [

	self group withStrictCheckingStrategy
]

{ #category : 'configuration' }
ToTabPane >> withUncheckingStrategy [

	self group withUncheckingStrategy
]

{ #category : 'configuration' }
ToTabPane >> withVerticalBody [

	self body beVertical
]

{ #category : 'configuration' }
ToTabPane >> withoutCheckingStrategy [

	self group withoutCheckingStrategy
]

{ #category : 'configuration' }
ToTabPane >> withoutResizablePanes [

	self resizablePanes ifFalse: [ ^ self ].
	self resizablePanes: false
]
