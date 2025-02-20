Class {
	#name : #ToElementCustomPlacement,
	#superclass : #Object,
	#category : #'Toplo-Core-Support'
}

{ #category : #'api - displaying' }
ToElementCustomPlacement >> positionElement: anElement context: aBlElementBoundsUpdateContext [

	self
		positionElement: anElement
		onEvent: nil
		context: aBlElementBoundsUpdateContext
]

{ #category : #'api - displaying' }
ToElementCustomPlacement >> positionElement: anElement onEvent: anEvent context: aBlElementBoundsUpdateContext [

	self subclassResponsibility 
]
