Class {
	#name : #ToTagNodeSkin,
	#superclass : #ToBarNodeSkin,
	#category : #'Toplo-Widget-Tag-Tag'
}

{ #category : #'event handling' }
ToTagNodeSkin >> installSkinEvent: anEvent [

	super installSkinEvent: anEvent.
	anEvent elementDo: [ :e |
		e constraintsDo: [ :c | c linear vertical alignCenter ].
		e geometry:
			(BlRoundedRectangleGeometry cornerRadius: (e valueOfTokenNamed: 'border-radius')).
		e padding: (BlInsets
				 horizontal: (e valueOfTokenNamed: #'bar-node-padding-H')
				 vertical: (e valueOfTokenNamed: #'bar-node-padding-V')).
		" the tagModel can be nil in case of the default fakeDataItem "
		e holder tagModel ifNotNil: [ :tm |
			tm isComposite ifTrue: [
				e tooltipBuilder: [ :win :theElement |
					| pane |
					pane := ToPane vertical.
					e holder tagModel items do: [ :item |
						pane addChild: (ToLabel text: item data asString) ].
					win root addChild: pane ] ] ] ]
]
