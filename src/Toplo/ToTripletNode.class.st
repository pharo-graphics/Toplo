Class {
	#name : #ToTripletNode,
	#superclass : #ToTripletElement,
	#traits : 'TToClickable',
	#classTraits : 'TToClickable classTrait',
	#category : #'Toplo-Core-Node'
}

{ #category : #'t - click behavior' }
ToTripletNode >> client [

	^ self holder infiniteElement client
]

{ #category : #'t - initialization dresser' }
ToTripletNode >> defaultDresser [ 

	^ ToPairedNodeDresser new
]
