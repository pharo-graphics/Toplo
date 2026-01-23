Class {
	#name : #ToEmptySelectionRepresentation,
	#superclass : #ToSelectionRepresentation,
	#category : #'Toplo-Widget-List-Selection-Mode'
}

{ #category : #testing }
ToEmptySelectionRepresentation >> isEmpty [ 

	^ true
]

{ #category : #'private - selection updating' }
ToEmptySelectionRepresentation >> newSelectionElementIn: aListElement option: aSelectionRepresentationOption [

	^ #( )
]

{ #category : #accessing }
ToEmptySelectionRepresentation >> nodeContainers [

	^ #(  )
]
