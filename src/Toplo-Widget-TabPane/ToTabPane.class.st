Class {
	#name : #ToTabPane,
	#superclass : #ToPane,
	#instVars : [
		'rebuildPaneOnSelect',
		'header',
		'body',
		'resizablePanes'
	],
	#category : #'Toplo-Widget-TabPane'
}

{ #category : #'adding-removing' }
ToTabPane >> addTab: aTab [

	aTab header: self header.
	header addTab: aTab.
	self tabs size = 1 ifTrue: [ aTab selected: true ]
]

{ #category : #'adding-removing' }
ToTabPane >> addTabWithText: aText [ 

	| but |
	but := ToTab new labelText: aText asString.
	self addTab: but
]

{ #category : #'adding-removing' }
ToTabPane >> addTabWithText: aText builder: aValuable [

	| but |
	but := ToTab new labelText: aText asString.
	but paneBuilder: aValuable.
	self addTab: but
]

{ #category : #'configuration - private' }
ToTabPane >> applyHeaderPositioning [

	self header applyPositioning
]

{ #category : #'configuration - private' }
ToTabPane >> applyResizablePanesConfiguration [

	self body removeDividers.
	self resizablePanes ifTrue: [ self body addDividers ]
]

{ #category : #accessing }
ToTabPane >> body [

	^ body
]

{ #category : #configuration }
ToTabPane >> checkingStrategy [

	^ self header checkingStrategy
]

{ #category : #configuration }
ToTabPane >> checkingStrategy: aCheckingStrategy [

	self header checkingStrategy: aCheckingStrategy
]

{ #category : #accessing }
ToTabPane >> group [ 

	^ self header group
]

{ #category : #accessing }
ToTabPane >> header [

	^ header
]

{ #category : #configuration }
ToTabPane >> headerPositioning: aPositioningStategy [

	self header positioningStrategy: aPositioningStategy
]

{ #category : #initialization }
ToTabPane >> initialize [

	super initialize.
	rebuildPaneOnSelect := false.
	resizablePanes := false.
	self matchParent.
	header := ToTabPaneHeader new.
	header tabsPane: self.
	header applyPositioning.
	body := ToPane vertical matchParent.
	self addChild: body as: #body.
	self addChild: header as: #header.
	self withVerticalBody.
	self checkingStrategy: ToCheckableGroupStrictStrategy new

]

{ #category : #accessing }
ToTabPane >> lastTab [

	^ self tabs last
]

{ #category : #'instance creation' }
ToTabPane >> newRawSkin [

	^ ToTabPaneSkin new
]

{ #category : #'adding-removing - private' }
ToTabPane >> onTabRemoved: aTab [


]

{ #category : #configuration }
ToTabPane >> preservePaneOnSelect [

	^ self rebuildPaneOnSelect not
]

{ #category : #configuration }
ToTabPane >> preservePaneOnSelect: aBoolean [

	self rebuildPaneOnSelect: aBoolean not
]

{ #category : #configuration }
ToTabPane >> rebuildPaneOnSelect [

	^ rebuildPaneOnSelect
]

{ #category : #configuration }
ToTabPane >> rebuildPaneOnSelect: aBoolean [

	rebuildPaneOnSelect := aBoolean
]

{ #category : #configuration }
ToTabPane >> resizablePanes [

	^ resizablePanes
]

{ #category : #configuration }
ToTabPane >> resizablePanes: aBoolean [

	resizablePanes := aBoolean.
	self applyResizablePanesConfiguration
]

{ #category : #'accessing - private' }
ToTabPane >> tabGeometry [

	^ self header positioningStrategy tabGeometry
]

{ #category : #accessing }
ToTabPane >> tabs [ 

	^ self header tabs
]

{ #category : #configuration }
ToTabPane >> withHeaderOnBottomCenter [

	self headerPositioning: ToTabPaneHeaderOnBottomCenter new
]

{ #category : #configuration }
ToTabPane >> withHeaderOnBottomLeft [

	self headerPositioning: ToTabPaneHeaderOnBottomLeft new
]

{ #category : #configuration }
ToTabPane >> withHeaderOnBottomRight [

	self headerPositioning: ToTabPaneHeaderOnBottomRight new
]

{ #category : #configuration }
ToTabPane >> withHeaderOnLeftBottom [

	self headerPositioning: ToTabPaneHeaderOnLeftBottom new
]

{ #category : #configuration }
ToTabPane >> withHeaderOnLeftCenter [

	self headerPositioning: ToTabPaneHeaderOnLeftCenter new
]

{ #category : #configuration }
ToTabPane >> withHeaderOnLeftTop [

	self headerPositioning: ToTabPaneHeaderOnLeftTop new
]

{ #category : #configuration }
ToTabPane >> withHeaderOnRightBottom [

	self headerPositioning: ToTabPaneHeaderOnRightBottom new
]

{ #category : #configuration }
ToTabPane >> withHeaderOnRightCenter [

	self headerPositioning: ToTabPaneHeaderOnRightCenter new
]

{ #category : #configuration }
ToTabPane >> withHeaderOnRightTop [

	self headerPositioning: ToTabPaneHeaderOnRightTop new
]

{ #category : #configuration }
ToTabPane >> withHeaderOnTopCenter [

	self headerPositioning: ToTabPaneHeaderOnTopCenter new
]

{ #category : #configuration }
ToTabPane >> withHeaderOnTopLeft [

	self headerPositioning: ToTabPaneHeaderOnTopLeft new
]

{ #category : #configuration }
ToTabPane >> withHeaderOnTopRight [

	self headerPositioning: ToTabPaneHeaderOnTopRight new
]

{ #category : #configuration }
ToTabPane >> withHorizontalBody [

	self body beHorizontal
]

{ #category : #configuration }
ToTabPane >> withResizablePanes [

	self resizablePanes ifTrue: [ ^ self ].
	self resizablePanes: true
]

{ #category : #configuration }
ToTabPane >> withStrictCheckingStrategy [

	self group withStrictCheckingStrategy
]

{ #category : #configuration }
ToTabPane >> withUncheckingStrategy [

	self group withUncheckingStrategy
]

{ #category : #configuration }
ToTabPane >> withVerticalBody [

	self body beVertical
]

{ #category : #configuration }
ToTabPane >> withoutCheckingStrategy [

	self group withoutCheckingStrategy
]

{ #category : #configuration }
ToTabPane >> withoutResizablePanes [

	self resizablePanes ifFalse: [ ^ self ].
	self resizablePanes: false
]
