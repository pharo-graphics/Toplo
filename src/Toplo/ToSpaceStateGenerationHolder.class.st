Class {
	#name : #ToSpaceStateGenerationHolder,
	#superclass : #Object,
	#instVars : [
		'generations',
		'hasDraggedState'
	],
	#category : #'Toplo-Core-SpaceFrame'
}

{ #category : #adding }
ToSpaceStateGenerationHolder >> addDraggedSkinStateGeneration: aValuable [ 

	hasDraggedState ifTrue: [ ^ self ].
	hasDraggedState := true.
	self addGeneration: aValuable
]

{ #category : #adding }
ToSpaceStateGenerationHolder >> addGeneration: aValuable [

	self generations add: aValuable
]

{ #category : #accessing }
ToSpaceStateGenerationHolder >> generations [

	^ generations
]

{ #category : #initialization }
ToSpaceStateGenerationHolder >> initialize [ 

	super initialize.
	hasDraggedState := false.
	generations := OrderedCollection new
]

{ #category : #running }
ToSpaceStateGenerationHolder >> run [

	self generations do: [:g | g value].
	self generations reset.
	hasDraggedState := false
]
