Class {
	#name : #ToNodeHolderForSkinEventTest,
	#superclass : #ToNodeHolder,
	#category : #'Toplo-Widget-List-Tests-Core-ListElement'
}

{ #category : #selection }
ToNodeHolderForSkinEventTest >> notifyNodeSelectedEvent: anEvent [

	anEvent selectionOption selectionMode isPrimary ifTrue: [
		self node userData at: #testAction ifPresent: [ :v | v value ] ].
	super notifyNodeSelectedEvent: anEvent
]
