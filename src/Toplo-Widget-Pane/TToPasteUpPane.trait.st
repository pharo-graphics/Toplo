Trait {
	#name : #TToPasteUpPane,
	#category : #'Toplo-Widget-Pane-Utils'
}

{ #category : #'t - paste-up pane' }
TToPasteUpPane >> draggedElement [

	^ self pasteUpField ifNotNil: [ :field |
		  field hasChildren
			  ifTrue: [ field firstChild ]
			  ifFalse: [  ] ]
]

{ #category : #'t - paste-up pane' }
TToPasteUpPane >> initialGap [

	^ self userData at: #initialGap ifAbsent: [ 0 ]
]

{ #category : #'t - paste-up pane' }
TToPasteUpPane >> initialGap: anInteger [

	self userData at: #initialGap put: anInteger
]

{ #category : #'t - paste-up pane' }
TToPasteUpPane >> pasteUpField [

	^ self userData at: #pasteUpField
]

{ #category : #'t - paste-up pane' }
TToPasteUpPane >> pasteUpField: aLayer [

	self userData at: #pasteUpField put: aLayer
]

{ #category : #'t - paste-up pane' }
TToPasteUpPane >> setUpAsPasteUp [

	| field |
	field := ToPlaceholderLayer new.
	field layout: BlBasicLayout new.
	field preventMeAndChildrenMouseEvents.
	self pasteUpField: field.
	field attachTo: self.
	self addChild: field.
	self addEventHandlerOn: BlDragStartEvent do: [ :event |
		| dragged |
		event consume.
		dragged := self findMouseEventTargetAt: event position.
		(dragged notNil and: [ dragged ~= self ]) ifTrue: [
			self initialGap: event position - dragged position.
			self removeChild: dragged.
			field addChild: dragged ] ].
	self addEventHandlerOn: BlDragEvent do: [ :event |
		event consume.
		self draggedElement ifNotNil: [ :dragged |
			dragged position: event position - self initialGap ] ].
	self addEventHandlerOn: BlDragEndEvent do: [ :event |
		event consume.
		self draggedElement ifNotNil: [ :dragged |
			dragged position: event position - self initialGap.
			field removeChild: dragged.
			self addChild: dragged ] ]
]
