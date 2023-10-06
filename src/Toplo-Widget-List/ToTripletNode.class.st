Class {
	#name : #ToTripletNode,
	#superclass : #ToTripletElement,
	#traits : 'TToClickable + TToNode',
	#classTraits : 'TToClickable classTrait + TToNode classTrait',
	#category : #'Toplo-Widget-List-node'
}

{ #category : #'t - list node - initialization' }
ToTripletNode >> defaultEventHandler [

	^ ToNodeEventHandler new
]
