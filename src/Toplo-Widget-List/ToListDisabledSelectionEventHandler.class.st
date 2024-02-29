Class {
	#name : #ToListDisabledSelectionEventHandler,
	#superclass : #BlCustomEventHandler,
	#category : #'Toplo-Widget-List-Core'
}

{ #category : #'api - accessing' }
ToListDisabledSelectionEventHandler >> eventsToHandle [

	^ { ToListDisabledSelectionChangedEvent }
]

{ #category : #'element handlers' }
ToListDisabledSelectionEventHandler >> listDisabledSelectionChangedEvent: anEvent [

	self updateSelectionFromEvent: anEvent
]

{ #category : #'element handlers' }
ToListDisabledSelectionEventHandler >> updateSelectionFromEvent: anEvent [

	| target nodesArray selectionModel |
	target := anEvent currentTarget.
	target isAttachedToSceneGraph ifFalse: [ ^ self ].

	nodesArray := target infinite children asArray.
	selectionModel := target disabledSelectionModel.

	nodesArray do: [ :node |
		(selectionModel containsIndex: node holder position)
			ifTrue: [ node disabled: true ]
			ifFalse: [ node disabled: false ] ].
	target requestLayout
]
