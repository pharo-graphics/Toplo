Class {
	#name : #ToListDisabledSelectionMode,
	#superclass : #ToListSubSelectionMode,
	#instVars : [
		'makesUnselectable'
	],
	#category : #'Toplo-Widget-List-Selection-Mode'
}

{ #category : #accessing }
ToListDisabledSelectionMode >> makesUnselectable [

	^ makesUnselectable
]

{ #category : #accessing }
ToListDisabledSelectionMode >> makesUnselectable: aBoolean [

	makesUnselectable := aBoolean
]

{ #category : #'instance creation' }
ToListDisabledSelectionMode >> newSelectionChangedEventHandler [

	^ ToListDisabledSelectionElementEventHandler new
]

{ #category : #'instance creation' }
ToListDisabledSelectionMode >> selectionChangedEventClass [ 

	^ ToListDisabledSelectionChangedEvent
]
