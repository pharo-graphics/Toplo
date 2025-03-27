Class {
	#name : #ToTreeNodeConfiguration,
	#superclass : #ToListNodeConfiguration,
	#traits : 'TToTripletElementConfiguration',
	#classTraits : 'TToTripletElementConfiguration classTrait',
	#category : #'Toplo-Widget-Tree-Core'
}

{ #category : #hook }
ToTreeNodeConfiguration >> applyOn: anElement [

	"'applyOn: ' trace. anElement traceCr."
	super applyOn: anElement.
	self applyTripletElementConfigurationOn: anElement.

]

{ #category : #initialization }
ToTreeNodeConfiguration >> initialize [ 

	super initialize.
	self initializeAsTripletElementConfiguration
]
