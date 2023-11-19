Class {
	#name : #ToNotebook,
	#superclass : #ToPane,
	#instVars : [
		'rebuildPaneOnSelect',
		'header',
		'headerPositioning',
		'body',
		'resizablePanes'
	],
	#category : 'Toplo-Incubator'
}

{ #category : #'adding-removing' }
ToNotebook >> addButton: aButton [

	header addChild: aButton
]

{ #category : #'adding-removing' }
ToNotebook >> addButtonWithText: aText withPaneBuilder: aValuable [

	| but |
	but := ToNotebookButton new labelText: aText asString.
	but paneBuilder: aValuable.
	self addButton: but
]

{ #category : #'configuration - private' }
ToNotebook >> applyHeaderPositioning [

	self headerPositioning applyOn: self
]

{ #category : #'configuration - private' }
ToNotebook >> applyResizablePanesConfiguration [

	self body removeDividers.
	self resizablePanes ifTrue: [ self body addDividers ]
]

{ #category : #accessing }
ToNotebook >> body [

	^ body
]

{ #category : #'accessing - private' }
ToNotebook >> buttonGeometry [

	^ self headerPositioning buttonGeometry
]

{ #category : #accessing }
ToNotebook >> buttons [ 

	^ self header buttons
]

{ #category : #configuration }
ToNotebook >> checkingStrategy [

	^ self header checkingStrategy
]

{ #category : #configuration }
ToNotebook >> checkingStrategy: aCheckingStrategy [

	self header checkingStrategy: aCheckingStrategy
]

{ #category : #initialization }
ToNotebook >> defaultHeaderPositioning [

	^ ToNotebookHeaderOnTop new
]

{ #category : #accessing }
ToNotebook >> group [ 

	^ self header group
]

{ #category : #accessing }
ToNotebook >> header [

	^ header
]

{ #category : #configuration }
ToNotebook >> headerPositioning [

	^ headerPositioning
]

{ #category : #configuration }
ToNotebook >> headerPositioning: aPositioningStategy [

	headerPositioning := aPositioningStategy.
	self headerPositioning applyOn: self
]

{ #category : #initialization }
ToNotebook >> initialize [

	super initialize.
	rebuildPaneOnSelect := false.
	resizablePanes := false.
	self matchParent.
	header := ToNotebookHeader new.
	body := ToPane vertical matchParent.
	self headerPositioning: self defaultHeaderPositioning.
	self addChild: header as: #header.
	self addChild: body as: #body.
	self withVerticalBody.
	self checkingStrategy: ToCheckableGroupStrictStrategy new

]

{ #category : #'adding-removing - private' }
ToNotebook >> onButtonRemoved: aButton [


]

{ #category : #configuration }
ToNotebook >> preservePaneOnSelect [

	^ self rebuildPaneOnSelect not
]

{ #category : #configuration }
ToNotebook >> preservePaneOnSelect: aBoolean [

	self rebuildPaneOnSelect: aBoolean not
]

{ #category : #configuration }
ToNotebook >> rebuildPaneOnSelect [

	^ rebuildPaneOnSelect
]

{ #category : #configuration }
ToNotebook >> rebuildPaneOnSelect: aBoolean [

	rebuildPaneOnSelect := aBoolean
]

{ #category : #configuration }
ToNotebook >> resizablePanes [

	^ resizablePanes
]

{ #category : #configuration }
ToNotebook >> resizablePanes: aBoolean [

	resizablePanes := aBoolean.
	self applyResizablePanesConfiguration
]

{ #category : #configuration }
ToNotebook >> withHeaderOnBottom [

	self headerPositioning: ToNotebookHeaderOnBottom new
]

{ #category : #configuration }
ToNotebook >> withHeaderOnLeft [

	self headerPositioning: ToNotebookHeaderOnLeft new
]

{ #category : #configuration }
ToNotebook >> withHeaderOnRight [

	self headerPositioning: ToNotebookHeaderOnRight new
]

{ #category : #configuration }
ToNotebook >> withHeaderOnTop [

	self headerPositioning: ToNotebookHeaderOnTop new
]

{ #category : #configuration }
ToNotebook >> withHorizontalBody [

	self body beHorizontal
]

{ #category : #configuration }
ToNotebook >> withResizablePanes [

	self resizablePanes ifTrue: [ ^ self ].
	self resizablePanes: true
]

{ #category : #configuration }
ToNotebook >> withStrictCheckingStrategy [

	self group withStrictCheckingStrategy
]

{ #category : #configuration }
ToNotebook >> withUncheckingStrategy [

	self group withUncheckingStrategy
]

{ #category : #configuration }
ToNotebook >> withVerticalBody [

	self body beVertical
]

{ #category : #configuration }
ToNotebook >> withoutCheckingStrategy [

	self group withoutCheckingStrategy
]

{ #category : #configuration }
ToNotebook >> withoutResizablePanes [

	self resizablePanes ifFalse: [ ^ self ].
	self resizablePanes: false
]
