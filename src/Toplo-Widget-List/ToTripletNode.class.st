Class {
	#name : #ToTripletNode,
	#superclass : #ToTripletElement,
	#traits : 'TToClickable + TToNode',
	#classTraits : 'TToClickable classTrait + TToNode classTrait',
	#category : #'Toplo-Widget-List-node'
}

{ #category : #'as yet unclassified' }
ToTripletNode >> client [

	^ self holder infiniteElement client
]

{ #category : #'t - list node - initialization' }
ToTripletNode >> defaultEventHandler [

	^ ToNodeEventHandler new
]
