Class {
	#name : #ToEmptySelectionRepresentation,
	#superclass : #ToSelectionRepresentation,
	#category : #'Toplo-Widget-List'
}

{ #category : #testing }
ToEmptySelectionRepresentation >> isEmpty [ 

	^ true
]

{ #category : #accessing }
ToEmptySelectionRepresentation >> nodeContainers [

	^ #(  )
]

{ #category : #'private - selection updating' }
ToEmptySelectionRepresentation >> stream: aStream withNewSelectionElementIn: aListElement option: aSelectionOption [

	
]
