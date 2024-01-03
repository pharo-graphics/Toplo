Class {
	#name : #ToSpaceSkinStateGenerator,
	#superclass : #Object,
	#instVars : [
		'generations',
		'hasDraggedState'
	],
	#category : #'Toplo-Core-SpaceFrame'
}

{ #category : #adding }
ToSpaceSkinStateGenerator >> addDraggedSkinStateGeneration: aValuable [ 

	hasDraggedState ifTrue: [ ^ self ].
	hasDraggedState := true.
	self generations add: aValuable
]

{ #category : #adding }
ToSpaceSkinStateGenerator >> addGeneration: aValuable [

	self generations add: aValuable
]

{ #category : #accessing }
ToSpaceSkinStateGenerator >> generations [

	^ generations
]

{ #category : #initialization }
ToSpaceSkinStateGenerator >> initialize [ 

	super initialize.
	hasDraggedState := false.
	generations := OrderedCollection new
]

{ #category : #running }
ToSpaceSkinStateGenerator >> run [

	self generations do: [:g | g value].
	self generations reset.
	hasDraggedState := false
]
