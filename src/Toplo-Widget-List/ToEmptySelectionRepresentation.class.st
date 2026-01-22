Class {
	#name : #ToEmptySelectionRepresentation,
	#superclass : #ToSelectionRepresentation,
	#category : #'Toplo-Widget-List-Selection-Mode'
}

{ #category : #testing }
ToEmptySelectionRepresentation >> isEmpty [ 

	^ true
]

{ #category : #accessing }
ToEmptySelectionRepresentation >> nodeContainers [

	^ #(  )
]

{ #category : #'private - selection element' }
ToEmptySelectionRepresentation >> refreshSelectionElementIn: aListElement option: aListSelectionRepresentationOption [

	
]

{ #category : #accessing }
ToEmptySelectionRepresentation >> selectionBounds [

	^ nil
]

{ #category : #accessing }
ToEmptySelectionRepresentation >> selectionElements [

	^ #(  )
]
