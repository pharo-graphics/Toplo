Class {
	#name : #ToTripletNode,
	#superclass : #ToTripletElement,
	#traits : 'TToClickable + TToNode',
	#classTraits : 'TToClickable classTrait + TToNode classTrait',
	#category : #'Toplo-Widget-List-node'
}

{ #category : #'t - clickable - click behavior' }
ToTripletNode >> client [

	^ self holder infiniteElement client
]

{ #category : #'t - list node - initialization' }
ToTripletNode >> defaultEventHandler [

	^ ToNodeEventHandler new
]
