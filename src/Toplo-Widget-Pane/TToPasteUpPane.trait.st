Trait {
	#name : 'TToPasteUpPane',
	#category : 'Toplo-Widget-Pane',
	#package : 'Toplo-Widget-Pane'
}

{ #category : 't - paste-up pane' }
TToPasteUpPane >> draggedElement [

	^ self pasteUpField ifNotNil: [ :field |
		  field hasChildren
			  ifTrue: [ field firstChild ]
			  ifFalse: [  ] ]
]

{ #category : 't - paste-up pane' }
TToPasteUpPane >> initialGap [

	^ self userData at: #initialGap ifAbsent: [ 0 ]
]

{ #category : 't - paste-up pane' }
TToPasteUpPane >> initialGap: anInteger [

	self userData at: #initialGap put: anInteger
]

{ #category : 't - paste-up pane' }
TToPasteUpPane >> pasteUpField [

	^ self userData at: #pasteUpField
]

{ #category : 't - paste-up pane' }
TToPasteUpPane >> pasteUpField: aLayer [

	self userData at: #pasteUpField put: aLayer
]

{ #category : 't - paste-up pane' }
TToPasteUpPane >> setUpAsPasteUp [

	| field |
	field := ToPlaceholderLayer new.
	field layout: BlBasicLayout new.
	field preventMeAndChildrenMouseEvents.
	self pasteUpField: field.
	field attachTo: self.
	self addChild: field.
	self when: BlDragStartEvent do: [ :event |
		| dragged |
		event consumed: true.
		dragged := self findMouseEventTargetAt: event position.
		(dragged notNil and: [ dragged ~= self ]) ifTrue: [
			self initialGap: event position - dragged position.
			self removeChild: dragged.
			field addChild: dragged ] ].
	self when: BlDragEvent do: [ :event |
		event consumed: true.
		self draggedElement ifNotNil: [ :dragged |
			dragged position: event position - self initialGap ] ].
	self when: BlDragEndEvent do: [ :event |
		event consumed: true.
		self draggedElement ifNotNil: [ :dragged |
			dragged position: event position - self initialGap.
			field removeChild: dragged.
			self addChild: dragged ] ]
]
