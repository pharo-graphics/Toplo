Class {
	#name : #ToTagNodeSkin,
	#superclass : #ToFiniteListNodeSkin,
	#category : #'Toplo-Widget-Tag-Tag'
}

{ #category : #'event handling' }
ToTagNodeSkin >> disabledSkinEvent: anEvent [

	super disabledSkinEvent: anEvent.
	anEvent elementDo: [ :e | ]
]

{ #category : #'event handling' }
ToTagNodeSkin >> installSkinEvent: anEvent [

	super installSkinEvent: anEvent.
	anEvent elementDo: [ :e |
		e constraintsDo: [ :c | c linear vertical alignCenter ].
		e geometry: (BlRoundedRectangleGeometry cornerRadius:
				 (e valueOfTokenNamed: 'border-radius')).
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
